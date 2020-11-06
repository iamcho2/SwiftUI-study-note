📍 Inflearn - SwiftUI ios14 퍼펙트 가이드 6,7,8

📍 HoyeonMoon님 강의 - Buttons

## Shape

어제 잠깐 맛봤던 도형 그리기... 자세히 배워보자 ~!

**Rectangle()**

```swift
Rectangle()
	.background(Color.blue)
```

Shape는 .background로 배경 지정이 안 된다. fill을 써야 함

```swift
Rectangle()
	.fill(Color.blue)
	.frame(width:100, height:100) //크기지정
```

**RoundedRectangle(conerRadius: / cornerSize:)**

얘는 기본 생성자(`RoundedRectangle()`) 쓰면 오류남. 기본 지정해줘야 하는 설정값이 있음

```swift
RoundedRectangle(cornerRadius: 20)
	.fill(Color.blue)
	.frame(width:100, height:100) //크기지정
```

**Circle()**

```swift
Circle()
	.fill(Color.blue)
	.frame(width:100, height:100) //크기지정
```

* 원은 frame을 200*100으로 줘도 늘어나지 않고 그냥 그 frame 안에서 최대 크기 원 생성

**Capsule()**

* 원은 원인데 늘어날 수 있는 원 (알약모양)

![image](https://user-images.githubusercontent.com/28949235/98261931-5a124880-1fc8-11eb-9cea-bb8bd7293f57.png)

> 원이랑 차이를 보세요!

**Ellipse()**

* 타원 모양으로 늘어남



### 그 외

* VStack 안에 5개의 Shape가 있다고 했을 때, 모든 Shape의 크기가 동일하다면 VStack에 한번에 frame 속성 주는게 코드가 줄어듦

* **.stroke()** - 외곽선만 표시

  * ```swift
    Rectangle()
    	.stroke(Color.orange,
              linewidth: 10)
    	.stroke(Color.orange,
             style: StrokeStyle(lineWidth:10, dash:[50, 10], dashPhase: 5) //원하는 속성 선택해서 작성
    ```



## Button

> 이랑 @State(property wrapper) 도 같이 알아볼 것 - 하나의 뷰 안에서 사용되는 값

![image](https://user-images.githubusercontent.com/28949235/98319957-3d582e00-2025-11eb-9721-db135327ed39.png)

```swift
Button(action: {
  //action
}, label: {
  //display
}) 

Button(action: {
  //action
}) {
  //display
}
```

Button은 action, label 이 형태를 가장 많이 사용함. 버튼 형태를 마음대로 바꿀 수 있기 때문

action 클로저는 버튼의 행동, label 클로저는 버튼의 모양  

label 클로저에서 label: 부분은 생략 가능 (클로저 줄이기)  

```swift
struct ContentView: View {
  @State pricate var didSelected = false
  
  var body: some View {
    VStack{
      Button(action: {
        didSelected.toggle()
      }, label: {
        Text("Button")
      })
      Text("Current Status: \(didSelectred.description)")
    }
  }
}
```

**.toggle()** : true -> false, false -> true로 바꿔줌

**.description** : 프로퍼티를 string으로 

```swift
Text("Current Status : \(didSelected.description)")
```

**@State**로 돼있으면 순차적으로가 아니라(버튼이 아래여도 상관X) didSelected값이 변경되면 자동으로 Text 출력도(UI도) 바꿔줌‼️



### 클릭에 따라 SF symbol 이미지 바꿔주기

```swift
var buttonImage: String{ //이건 뭐 값이 변하고 갱신되고 이런게 아니라 string만 표현하는거라 @State 안 써도 됨
  if didSelected {
    return "circle"
  }else{
    return "pencil"
  }
 //UI그리는 쪽에 if문 쓰면 지저분해지니까 분리해서 작성 ~!

...

Image(systemName: buttonImage)
```

> computed property, stored property 함 검색해보세요



## Toggle

> UIKit의 UISwitch

![image](https://user-images.githubusercontent.com/28949235/98321500-95446400-2028-11eb-8291-d56e72613e6e.png)

title이랑 isOn, on인지 off인지.  

Binding 타입의 Boolean이 필요한데, 이게 뭔말이냐면  

```swift
struct ContentView: View {
	@State private var isOn = false

	var body: some View {
  	Toggle("toggle \(isOn.description)", isOn: $isOn)
	}
}
```

바인딩을 해야 될 @State값을 하나 만듦. 바인딩 타입으로 만드려면 사용할 때 변수명 앞에 $를 붙임.

**그래서 이게 뭘 의미하는데?** 원래 값과 연결되어있다는 개념

변경되는 값이랑, 변경돼서 보여줘야하는 UI랑 바로 매칭이 되어야 할 때.. toggle, textfield 등등에서 사용

<br>

이렇게 하기보다는.. 아래처럼 해보자 toggle을 따로 빼 보자

```swift
struct ContentView: View {
  @State private var isOn = false
  var body: some View {
    VStack{
      MyToggle(isOn: $isOn)
    	Text("\(isOn.description)")
    }
  }
}

struct MyToggle: View {
  @Binding var isOn: Bool // property wrapper @Binding
  
  var body: some View {
    Toggle("toggle \(isOn.description)", isOn: $isOn)
  }
}
```

* **@Binding**은 = 해서 초기화하면 오류 남. @Binding 은 값을 가질 수 없음. 원본 값이 어딘가 있다는 개념이라..
  * 타입만 지정하고, 본 ContentView에서 MyToggle을 생성할 때 isOn값을 지정해주면 됨.
* 원본 값이 연결되어있다는 개념.. 포인터 같은 개념
* 다른 뷰 (MyToggle)에서 값을 변경하지만 실제 변경되는 값은 ContentView의 isOn

<br>

### label 구성하기

```swift
Toggle(isOn: $isOn, label: {
  VStack{
    Text("label")
    Text("label")
  }
})
```

![image](https://user-images.githubusercontent.com/28949235/98324373-67165280-202f-11eb-88d3-b4c1eb469e24.png)



 **text들을 toggle과 붙이고 싶다면 ? - Spacer()**

```swift
Toggle(isOn: $isOn, label: {
  HStack{
    Spacer()
    VStack{
    	Text("label")
    	Text("label")
  	}
  }
})
```

![image](https://user-images.githubusercontent.com/28949235/98324431-92993d00-202f-11eb-8144-6b3931fcd08b.png)

 