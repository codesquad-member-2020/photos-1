# photos-1
iOS 3월 연습 - 1팀

### Ground Rule

- 오전에 스크럼
- 2시 ~ 4시 페어 프로그래밍


### Step1 : iOS - CollectionView
- CollectionView 크기를 처음에 photoCell 의 Size inspector 에서 수정 시도했으나 적용 안됨. Collection View 의 Estimate Size 를 Custom 으로 바꾼 뒤 크기를 지정해주니 적용 되었다.

- Collection View 의 크기를 수동으로 설정하였는데 Autolayout 을 사용하여 다른 기기에서도 같은 출력 되도록 바꾸었다.



<img width="492" alt="CollectionView" src="https://user-images.githubusercontent.com/34564706/76731750-7f381980-67a1-11ea-9304-52a3fdc13e62.png">

### Step2 : iOS - Photos 라이브러리

- Cell 에 ImageView 를 추가해줄때 Cell 크기를 100 x 100 으로 설정해주고 오토레이아웃으로 프레임에 맞게 간격을 맞춰줬는데도 이미지가 크게 출력되는 문제가 있었습니다. ImageView 의 가로, 세로 길이를 강제해줌으로서 해결하였습니다.

- 사진 데이터 관련 동작을 분리해주기위해 PhotoDataManager 클래스를 생성해주었습니다.

<img width="515" alt="스크린샷 2020-03-17 오후 4 30 33" src="https://user-images.githubusercontent.com/50410213/76832504-c3442080-686c-11ea-8167-40af25197315.png">
