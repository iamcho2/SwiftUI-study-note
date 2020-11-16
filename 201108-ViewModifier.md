📍Inflearn - SwiftUI ios14 퍼펙트 가이드 11

# ViewModifier

같은 설정들을 여러 번 써야 할 때, 같은 코드들의 반복의 최소화를 지원해주는 기능

### ViewModifier 만들기

```swift
struct MyTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
    	.font(.title2)
    	.foregroundColor(.orange)
      .padding(.bottom, 20)
  }
}
```

> .italic 같이 공통으로 적용하려면 안된다고 뜨는 것들이 몇 개 있는데,  
> 나중에 수정될 것 같긴 하지만 우선 빼서 사용하는 방법이 있고,  
> 같이 쓰는 방법은 밑에 따로 작성

```swift
struct MyTextStyle: ViewModifier {
  var myWeight = Font.Weight.regular
  var myFont = Font.title2
  var myColor - Color.black
  
  func body(content: Content) -> some View {
    content
    	.font(myFont.weight(myWeight)) //이렇게도 가능
    	.foregroundColor(myColor)
      .padding(.bottom, 20)
  }
}
```



### ViewModifier 사용하기

```swift
Text("blah blah")
	.modifier(MyTextStyle(myWeight:.bold))
	// ()안에 myWeight:.bold 이런건 넣어줘도 되고 default값으로 쓸거면 안 넣어줘도 되고
Text("hello!")
	.modifier(MyTextStyle(myColor: .red))
Text("another one")
	.modifier(MyTextStyle())
```



### 그래서 italic같은 건 어떻게 쓰죠?

기능을 확장하는 extension 개념으로 생각해봅시다

```swift
extension Text {
  func customFont() -> Text {
    self
    	.font(.title2) //위 ViewModifier 할때랑 같은 개념
    	.bold()
    	.italic()
    	.foregroundColor(.blue)
  }
}
```

```swift
Text("this is...")
	.customFont()
```

extension으로 하면 ViewModifier 처럼 변수를 만들어서 초기값을 지정하고  
나중에 바꿔서 쓸 수 있고.. 하는 그런 게 안됨

Color같은 걸 받으려면

```swift
extension Text{
  func customFont(color: Color) -> Text {
    self
    	.font(.title2)
    	.bold()
    	.italic()
    	.foregroundColor(color)
  }
}
```

```swift
Text("Color text")
	.customFont(color: .red)
```

이런식으로 해야겠죠!

