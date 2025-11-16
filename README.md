<img src="https://github.com/user-attachments/assets/6a8f9297-b4e2-405f-8387-f153bc465e52" width="1200">

# <img width="30" height="30" alt="image" src="https://github.com/user-attachments/assets/6cef142c-1e20-4b9d-833e-4d7f83d25052" /> 경기-GO 

> 경기고와 함께, 경기도의 매력을 발견하는 순간까지 바로 GO!

<img src="https://github.com/user-attachments/assets/2b67b88b-cf4e-4226-900a-58932e49fdb1" width="1200">

# 🍏 iOS Developer
|    김승원   |
| :-------------: |
| <img src="https://avatars.githubusercontent.com/SeungWon1125" alt="profile" width="180" height="180"> |
| [SeungWon1125](https://github.com/SeungWon1125) |


# 📷 Screenshot
|    스플래시   |    지도   |    마커   |
| :-------------: | :----------: | :----------: |
| <img src = "https://github.com/user-attachments/assets/22723be3-d497-44c1-8a81-0cf162ebeac4" width ="200"> | <img src = "https://github.com/user-attachments/assets/cedf7ac2-faf4-43f2-be5b-1626d07371a7" width ="200">  | <img src = "https://github.com/user-attachments/assets/561a85da-5dcf-4de6-b956-ce9f24c91e37" width ="200">  | 

|    시트   |    상세   |    큐레이션   |
| :-------------: | :----------: | :----------: |
| <img src = "https://github.com/user-attachments/assets/8649f2ae-47ed-4724-9916-57e2d48a24ab" width ="200"> | <img src = "https://github.com/user-attachments/assets/81a64654-4fd9-4c82-baef-d8f35dc23dbb" width ="200">  | <img src = "https://github.com/user-attachments/assets/4610c18a-e9b1-47ad-a748-797317bf65ed" width ="200">  | 


# 🛠️ Tech stack & Architecture
<img src = "https://github.com/user-attachments/assets/78c82f7b-24c7-40d6-81fd-8e0c892c1a60" width ="700">


<aside>

### **1️⃣ MVVM 패턴 적용**

본 프로젝트는 **MVVM(Model-Viewp-ViewModel)** 아키텍처를 기반으로 설계되었습니다.

UI 로직과 비즈니스 로직을 명확하게 분리함으로써, 테스트 용이성과 유지보수성, 확장성을 고려한 구조를 구현했습니다.

---

### 2️⃣ ViewModel의 의존성 구조 - DIP(의존성 역전 원칙) 준수

**ViewModel**은 네트워크 계층이나 비즈니스 로직과 같은 구체 구현(Service)에 직접 의존하지 않습니다.

대신, 기능을 추상화한 API Protocol에 의존하도록 설계하여 **DIP(Dependency Inversion Principle)**을 준수했습니다.

---

### 3️⃣ Action 기반의 상태 관리 - Redux 스타일 흐름 차용
ViewModel은 단순히 메서드를 호출하는 구조가 아니라, 

Action(Enum)을 정의하고 View가 Action을 Dispatch하는 구조를 채택했습니다.

</aside>


# 🎨 Project Design
<img src = "https://github.com/user-attachments/assets/feb3beef-0e6d-4d24-9f5d-91181dcc4ad3" width ="800">


# 📚 Library
| 계층 | 기술 / 도구 | 역할 | 버전 |
| --- | --- | --- | --- |
| **IDE & SDK** | **Xcode** | Apple 공식 개발 도구 (Swift 6, iOS 18 SDK 포함) | 16.4 |
| **UI 프레임워크** | **SwiftUI** | 선언형 UI 구성, 뷰 간 상태 동기화 및 반응형 업데이트 | SwiftUI 6.0 |
| **상태 관리 & 아키텍처** | **MVVM** | SwiftUI의 선언형 UI 특성과 어울리는 MVVM(Model-View-ViewModel) 아키텍처를 채택하여 뷰와 비즈니스 로직을 명확히 분리. | — |
| **네트워크 계층** | **Moya** | `URLSession` 위에 구축된 추상화 네트워크 레이어, 간편한 API 관리 및 테스트 지원 API 요청의 타입 안정성과 테스트 편의성을 높임 | 15.0.3 |
| **이미지 처리** | **Kingfisher** | 이미지 비동기 다운로드 및 캐싱 처리, 스크롤 성능 최적화 이미지 로딩 성능과 UI 반응성 향상에 기여 | 8.3.3 |
| 지도 | **MapKit** | 지도 기능을 구현하기 위함(내장 라이브러리) | — |
