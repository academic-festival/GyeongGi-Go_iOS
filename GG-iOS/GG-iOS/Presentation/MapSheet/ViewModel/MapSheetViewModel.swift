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
    
    @Published var cameraPosition: MapCameraPosition
    @Published var sheetState: SheetState = .list
    @Published var bottomSheetHeight: CGFloat = SheetState.defaultHeight
    // TODO: - HomeAPI 수정되면 다시 빈배열로
    @Published var mapPlaces: [MapPlace] = MapPlace.mockData
    @Published var placeDetail: PlaceDetail = PlaceDetail.skeletonData
    
    private let placeListService: PlaceListAPI
    private let placeDetailService: PlaceDetailAPI
    private var fetchPlaceDetailTask: Task<Void, Never>?
    
    private let initialLocation = CLLocationCoordinate2D(latitude: 37.5598, longitude: 126.9770)
    private let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    private let spanRate: Double = 0.45
    
    var alertErrorMessage: String = ""
    
    // MARK: - Action
    
    enum Action {
        case setCameraToUser
        case showMap
        case showList
        case selectMarker(_ mapPlace: MapPlace)
        case selectPlace(_ mapPlace: MapPlace)
        case switchSheetState(_ sheetState: SheetState)
        
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
            latitude: initialLocation.latitude - (span.latitudeDelta * spanRate),
            longitude: initialLocation.longitude
        )
        
        cameraPosition = .region(MKCoordinateRegion(center: adjustedCenter, span: span))
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: Action) {
        switch action {
        case .setCameraToUser:
            if bottomSheetHeight == SheetState.minimumHeight {
                setCameraPosition(coordinate: initialLocation, spanRate: 0.0)
            } else {
                setCameraPosition(coordinate: initialLocation, spanRate: spanRate)
            }
            
        case .showMap:
            bottomSheetHeight = SheetState.minimumHeight
            
        case .showList:
            fetchPlaceDetailTask?.cancel()
            fetchPlaceDetailTask = nil
            
            bottomSheetHeight = SheetState.defaultHeight
            
        case .selectMarker(let mapPlace):
            self.isPlaceDetailLoading = true
            self.placeDetail = PlaceDetail.skeletonData
            
            fetchPlaceDetailTask?.cancel()
            fetchPlaceDetailTask = Task {
                // TODO: - 임시 placeId
                await fetchPlaceDetail(placeId: 153)
            }
            
            selectMarker(mapPlace)
            setCameraPosition(coordinate: mapPlace.coordinate, spanRate: spanRate)
            sheetState = .detail
            
            withAnimation(.easeInOut(duration: 0.3)) {
                bottomSheetHeight = SheetState.defaultHeight
            }
            
        case .selectPlace(let mapPlace):
            self.isPlaceDetailLoading = true
            self.placeDetail = PlaceDetail.skeletonData
            
            fetchPlaceDetailTask?.cancel()
            fetchPlaceDetailTask = Task {
                // TODO: - 임시 placeId
                await fetchPlaceDetail(placeId: 153)
            }
            
            selectMarker(mapPlace)
            setCameraPosition(coordinate: mapPlace.coordinate, spanRate: spanRate)
            sheetState = .detail
            
        case .switchSheetState(let sheetState):
            switch sheetState {
            case .list:
                break
                
            case .detail:
                fetchPlaceDetailTask?.cancel()
                fetchPlaceDetailTask = nil
                
                deSelectMarker()
                placeDetail = PlaceDetail.skeletonData
                self.sheetState = .list
            }
            
        case .fetchPlaceList:
            self.isPlaceDetailLoading = true
            
            Task {
                await fetchPlaceList(
                    request: PlaceListRequestDTO(
                        x: initialLocation.longitude,
                        y: initialLocation.latitude
                    )
                )
            }
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
    
    /// 카메라 위치를 변경합니다.
    func setCameraPosition(coordinate: CLLocationCoordinate2D, spanRate: Double) {
        withAnimation(.easeInOut(duration: 0.8)) {
            let adjustedCenter = CLLocationCoordinate2D(
                latitude: coordinate.latitude - (span.latitudeDelta * spanRate),
                longitude: coordinate.longitude
            )
            
            cameraPosition = .region(MKCoordinateRegion(center: adjustedCenter, span: span))
        }
    }
}

// MARK: - Functions

extension MapSheetViewModel {
    func isBottomSheetMinimumHeight() -> Bool {
        return bottomSheetHeight == SheetState.minimumHeight
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
            
            self.alertErrorMessage = ""
            self.isPlaceDetailLoading = false
            self.shouldShowErrorAlert = false
            self.placeDetail = PlaceDetail(from: data)
            
        } catch is CancellationError {
            self.isPlaceDetailLoading = true
            self.placeDetail = PlaceDetail.skeletonData
            
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
