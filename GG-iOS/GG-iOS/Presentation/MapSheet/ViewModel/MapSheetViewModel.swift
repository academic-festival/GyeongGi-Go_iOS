//
//  MapSheetViewModel.swift
//  GG-iOS
//
//  Created by 김승원 on 10/8/25.
//

import MapKit
import SwiftUI

@MainActor
final class MapSheetViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isPlaceListLoading: Bool = true
    @Published var isPlaceDetailLoading: Bool = true
    @Published var shouldShowErrorAlert: Bool = false
    
    @Published var userAddress: String = "139‑2, Buksu‑dong, Paldal‑gu, Suwon‑si"
    @Published var cameraPosition: MapCameraPosition
    @Published var sheetState: SheetState = .list
    @Published var bottomSheetHeight: CGFloat = SheetState.defaultHeight
    @Published var mapPlaces: [MapPlace] = []
    @Published var placeDetail: PlaceDetail = PlaceDetail.skeletonData
    @Published var cachedPlaceDetail: [Int: PlaceDetail] = [:]
    
    @Published var shouldDisplaySplash: Bool = true
    
    private let placeListService: PlaceListAPI
    private let placeDetailService: PlaceDetailAPI
    private var fetchPlaceDetailTask: Task<Void, Never>?
    
    private let initialLocation = CLLocationCoordinate2D(latitude: 37.28757, longitude: 127.01500)
    private var currentLocation = CLLocationCoordinate2D(latitude: 37.28757, longitude: 127.01500)
    private var defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    private let defaultSpanRate: Double = 0.405
    private let zoomSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    private let zoomSpanRate: Double = 0.225
    
    var alertErrorMessage: String = ""
    
    // MARK: - Action
    
    enum Action {
        case setCameraToUser
        case showMap
        case showList
        case selectMarker(_ mapPlace: MapPlace)
        case selectPlace(_ mapPlace: MapPlace)
        case switchSheetState(_ sheetState: SheetState)
        case stopSplash
        
        // api
        case fetchPlaceList
    }
    
    // MARK: - Initializer
    
    init(
        placeListService: PlaceListAPI,
        placeDetailService: PlaceDetailAPI
    ) {
        self.placeListService = placeListService
        self.placeDetailService = placeDetailService
        
        let adjustedCenter = CLLocationCoordinate2D(
            latitude: initialLocation.latitude - (defaultSpan.latitudeDelta * defaultSpanRate),
            longitude: initialLocation.longitude
        )
        
        cameraPosition = .region(MKCoordinateRegion(center: adjustedCenter, span: defaultSpan))
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: Action) {
        switch action {
        case .setCameraToUser:
            if bottomSheetHeight == SheetState.minimumHeight {
                setCameraPosition(
                    coordinate: initialLocation,
                    zoom: false,
                    center: true
                )
            } else {
                setCameraPosition(
                    coordinate: initialLocation,
                    zoom: false
                )
            }
            
        case .showMap:
            bottomSheetHeight = SheetState.minimumHeight
            
        case .showList:
            cancelFetchPlaceDetailTask()
            bottomSheetHeight = SheetState.defaultHeight
            
        case .selectMarker(let mapPlace):
            fetchPlaceDetail(mapPlace)
            
            withAnimation(.easeInOut(duration: 0.3)) {
                bottomSheetHeight = SheetState.defaultHeight
            }
            
        case .selectPlace(let mapPlace):
            fetchPlaceDetail(mapPlace)
            
        case .switchSheetState(let sheetState):
            switch sheetState {
            case .list:
                break
                
            case .detail:
                setCameraPosition(
                    coordinate: currentLocation,
                    zoom: false
                )
                cancelFetchPlaceDetailTask()
                deSelectMarker()
                placeDetail = PlaceDetail.skeletonData
                self.sheetState = .list
            }
            
        case .stopSplash:
            withAnimation(.easeInOut(duration: 0.3)) {
                shouldDisplaySplash = false
            }
            
        case .fetchPlaceList:
            fetchPlaceList()
        }
    }
}

// MARK: - Private Functions

private extension MapSheetViewModel {
    func selectMarker(_ selectedPlace: MapPlace) {
        for index in mapPlaces.indices {
            if mapPlaces[index].id == selectedPlace.id {
                mapPlaces[index].isSelected = true
            } else {
                mapPlaces[index].isSelected = false
            }
        }
    }
    
    func deSelectMarker() {
        for index in mapPlaces.indices {
            mapPlaces[index].isSelected = false
        }
    }
    
    func setCameraPosition(coordinate: CLLocationCoordinate2D, zoom: Bool, center: Bool = false) {
        withAnimation(.easeInOut(duration: 0.8)) {
            let adjustedCenter = CLLocationCoordinate2D(
                latitude: coordinate.latitude - (defaultSpan.latitudeDelta * (center ? 0.0 : zoom ? zoomSpanRate : defaultSpanRate)),
                longitude: coordinate.longitude
            )
            
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: adjustedCenter,
                    span: zoom ? zoomSpan : defaultSpan
                )
            )
        }
    }
    
    func fetchPlaceList() {
        Task {
            await fetchPlaceList(
                request: PlaceListRequestDTO(
                    x: initialLocation.longitude,
                    y: initialLocation.latitude
                )
            )
        }
    }
    
    func fetchPlaceDetail(_ mapPlace: MapPlace) {
        self.isPlaceDetailLoading = true
        self.currentLocation = mapPlace.coordinate
        self.currentLocation = mapPlace.coordinate
        self.placeDetail = PlaceDetail.skeletonData
        
        sheetState = .detail
        selectMarker(mapPlace)
        setCameraPosition(
            coordinate: mapPlace.coordinate,
            zoom: true
        )
        
        fetchPlaceDetailTask?.cancel()
        
        if let cached = cachedPlaceDetail[mapPlace.placeId] {
            placeDetailFetched(cached)
            return
        }
        
        fetchPlaceDetailTask = Task {
            await fetchPlaceDetail(placeId: mapPlace.placeId)
        }
    }
    
    func placeDetailFetched(_ placeDetail: PlaceDetail) {
        self.alertErrorMessage = ""
        self.isPlaceDetailLoading = false
        self.shouldShowErrorAlert = false
        self.placeDetail = placeDetail
    }
    
    func cancelFetchPlaceDetailTask() {
        fetchPlaceDetailTask?.cancel()
        fetchPlaceDetailTask = nil
    }
}

// MARK: - Functions

extension MapSheetViewModel {
    func isBottomSheetMinimumHeight() -> Bool {
        return bottomSheetHeight == SheetState.minimumHeight
    }
    
    func userLocation() -> CLLocationCoordinate2D {
        return self.initialLocation
    }
}

// MARK: - API

private extension MapSheetViewModel {
    func fetchPlaceList(request: PlaceListRequestDTO) async {
        do {
            let response = try await placeListService.fetchPlaceList(request: request)
            
            guard let data = response.data else {
                self.alertErrorMessage = NetworkError.responseError.alertMessage
                self.shouldShowErrorAlert =  true
                return
            }
            
            self.alertErrorMessage = ""
            self.isPlaceListLoading = false
            self.shouldShowErrorAlert = false
            self.mapPlaces = data.placeList.map { MapPlace(from: $0) }
            
        } catch let error as NetworkError {
            self.alertErrorMessage = error.alertMessage
            self.shouldShowErrorAlert = true
            print(error)
            
        } catch {
            self.alertErrorMessage = NetworkError.unknownError.alertMessage
            self.shouldShowErrorAlert = true
        }
    }
    
    func fetchPlaceDetail(placeId: Int) async {
        do {
            let response = try await placeDetailService.fetchPlaceDetail(placeId: placeId)
            
            try Task.checkCancellation()
            
            guard let data = response.data else {
                self.alertErrorMessage = NetworkError.responseError.alertMessage
                self.shouldShowErrorAlert = true
                return
            }
            
            try Task.checkCancellation()
            
            let placeDetail = PlaceDetail(from: data)
            cachedPlaceDetail[placeId] = placeDetail
            placeDetailFetched(placeDetail)
            print("[\(placeId): \(placeDetail.placeName)] - cached")
            
        } catch is CancellationError {
            print("detail Canceled")
            
        } catch let error as NetworkError {
            self.alertErrorMessage = error.alertMessage
            self.shouldShowErrorAlert = true
            print(error)
            
        } catch {
            self.alertErrorMessage = NetworkError.unknownError.alertMessage
            self.shouldShowErrorAlert = true
        }
    }
}

// MARK: - TempImageUrlString

enum TempImageUrlString {
    static func imageUrlString() -> String {
        return "https://gjicp.ggcf.kr/storage/upload/2023/02/28/5XtjWZqT1Lbw29sY26OdFgRWhM5LQ1YJ3ZmNMuIa.jpg"
    }
    
    static func threeImageUrlStrings() -> [String] {
        return [
            imageUrlString(),
            imageUrlString(),
            imageUrlString()
        ]
    }
}
