📍Inflearn - SwiftUI ios14 퍼펙트 가이드 12

# Alert View

> 경고창

버튼일 때 true일때만 alert 창이 나오는 코드 예제

```swift
@State private var isShowAlert = false

var body: some View {
  Button("show alert") {
    isShowAlert.toggle()
  }
  .alert(isPresented: $isShowAlert, content: {
    Alert(title: Text("alert"))
  })
}
```

* isPresented: Binding\<Bool> 타입 이여서 $ 달러 표시 붙여줌

* 자동으로 값 바뀌게 되어있는 코드임
  * `show alert` 버튼 누르면 `isShowAlert`값이 true가 되고, alert 창의 OK 버튼 누르면 다시 false 됨
  * 이렇게 Boolean 변수를 사용하거나 하는 흐름을 이해하자

<img src="https://user-images.githubusercontent.com/28949235/99265008-8b123900-2864-11eb-8801-625ff0365e04.png" alt="image" width="300" />

### Alert 의 style들

> 버튼 하나 있고, 두개 있고 하는 스타일들

```swift
Alert(title: Text("alert title"), dismissButton: .cancel()) 
//cancel이라는 dismissbutton 설정 (기본으로 내장되어있는 버튼)
```



버튼을 만들어서 쓴다면? content closure 안에 

```swift
let primaryButton = Alert.Button.default(Text("Done"))
let secondaryButton = Alert.Button.default(Text("Cancel"))

Alert(title: Text("show alert"), primaryButton: primaryButton, secondaryButton: secondaryButton)
```

요렇게 하면 이것들중에 어떤걸 return 할건지 명시적으로 표시해라! 라는 에러가 뜬다  
Alert 앞에 return 써주면 된다. 빨간줄도 Alert 반환할 것 같으니까 거기에 표시된다 ㅋ

<img src="https://user-images.githubusercontent.com/28949235/99265685-4b981c80-2865-11eb-8e6b-bdf7e731f603.png" alt="image" width="300" />



### 버튼에 기능 추가하기 - default(_:action:)

```swift
let primaryButton = Alert.Button.default(Text("Done")){
  // 여기에 수행 할 action 코드 작성
}
```

예를들면...

```swift
@State private var selectText = "x"

...

let primaryButton = Alert.Button.default(Text("Done")){
  selectText = "Done"
}

...

Text("\(selectText)")
```

머 이런 식 ..

