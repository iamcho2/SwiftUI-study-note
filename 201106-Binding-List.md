📍 100 Days of SwiftUI - day2, day16

📍Inflearn - SwiftUI ios14 퍼펙트 가이드 9

## @Binding

어제 배웠던 **@Binding**에 대해 더 이해해보자!
**@Binding**도 **@State**와 같이 property wrapper 중 하나인데,

```swift
struct ContentView: View {
    @State private var tapCount = 0
    
    var body: some View {
        Button("Tap Count \(tapCount)"){
            self.tapCount += 1
        }
    }
}
```

**@State**는 뷰의 struct들을 자유롭게 바꾸게 해줘서, 프로그램이 변경되면 뷰 프로퍼티들이 그에 맞게 갱신되게 만들 수 있었다.

근데, 여기에 user interface controls이 끼면 일이 좀 복잡해진다,,

예를들어, 사용자들이 타이핑 할 수 있는 editable한 텍스트 박스를 만들고 싶다면?

```swift
struct ContentView: View {
    var body: some View {
        Form {
            TextField("Enter your name")
            Text("Hello World")
        }
    }
}
```

이렇게 하시겠읍니까? 하지만.. 컴파일 오류가 뜬다.

왜냐면 SwiftUI는 text field의 text를 어디다 저장할지를 알고싶어하기 때문!

<br>

저번에 **view는 view의 state들의 함수이다!** 라고 했던 것을 다시 떠올려보면,

textField는 프로그램에 저장되어있는 값을 그냥 보여주기만 할 수 있음.

SwiftUI가 원하는 건 우리 struct에 있는 문자열 프로퍼티가 

textField에도 보여지면서, 유저가 타이핑하는 것들을 저장할 수 있었으면 좋겠는 것..

그럼 아래처럼 코드를 바꿔보자

```swift
struct ContentView: View {
    var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: name)
            Text("Hello World")
        }
    }
}
```

> name 프로퍼티 추가

But... 이래도 안 됨.

왜냐면 Swift는 우리가 추가한 name  프로퍼티를 유저가 타이핑한거랑 매치되게끔 업데이트해야 하니까..

아하 그러면 **@State** 쓰면 되겠군?

```swift
@State private var name = ""
```

그러나 이것도 Not enough !! 컴파일 안 됨.

<br>

문제가 뭐냐면, Swift는

**"여기에 이 프로퍼티의 값을 보여주세요"**와 **"여기에 이 프로퍼티의 값을 보여주는데, 변경 사항이 있으면 그 프로퍼티에 작성해주세요"**를

별개로 구분짓기 때문.

<br>

예로 들었던 text field에서, Swift는 텍스트가 무엇이 됐든 그게 name 프로퍼티에도 있게 만들어야 한다.

그러면 뷰는 state의 함수다! 라는 약속을 지킬 수 있게 되고,

유저가 볼 수 있는 모든것들이 그냥 우리의 코드에 있는 struct들, 프로퍼티들의 visible한 표현이 되는 것.

<br>

이런 걸 two-way binding (양방향 바인딩)이라고 하는데, 

text field가 프로퍼티의 값을 보여주도록 바인딩하지만

text field의 변경 사항도 속성을 업데이트하도록 바인딩 함.

<br>

그래서 나온 최종 코드 !

```swift
struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
          	Text("Your name is \(name)") 
        }
    }
}
```

![image](https://user-images.githubusercontent.com/28949235/98327567-2ae6f000-2037-11eb-9838-d6fea8c0179d.png)



프로퍼티 이름 앞에 **$** dollar sign을 보면, 아아 이건 양방향 바인딩이군 ㅋ 하면 됨.

프로퍼티의 값이 읽히는데, 동시에 작성되는 것.



> p.s.
>
> ```swift
> Text("Your name is \(name)") 
> ```
>
> 여기선 왜 $name 안 쓰고 name을 썼나?
>
> 왜냐면 여기서는 양방향 바인딩을 할 필요가 없기 때문.
>
> 우리는 그냥 값을 읽고싶은거지 다시 어디다 저장하고 그러는 걸 원하는 게 아님.

<br>

## List - ForEach

> 테이블 뷰 처럼 쭉 나오는 형태

List가 있으려면 데이터가 있어야 하는데, 그런 Data Model을 직접 만든다고 했을 때 Model을 만드는 것 까지 배워보자

```swift
struct LocationInfo {
	var city = ""
	var weather = ""
}
```

이런 model을 가지고, 왼쪽에는 도시 이름, 오른쪽엔 날씨 정보가 나오는 List를 만들어보자

```swift
@State private var locations = [
	locationInfo(city: "seoul", weather: "rainy"),
	locationInfo(city: "daejeon", weather: "sunny"),
  locationInfo(city: "busan", weather: "cloudy")
]
List{
	HStack{ //하나의 row (cell)
	
	}
}
```

* Data를 List에 녹이기 위해선 For문 - ForEach문을 많이 사용한다

* ForEach 요구조건이 여러 개 있는데 그 중에 상황에 따라 맞는 거 쓰면 됨

  * 1. **id**: 어떤 걸 아이디로 쓸래? city? weather? / **content**: 클로저형태

    * 근데 city나 weather나 같은 값이 다른 데이터에 들어갈 수 있어서 id로는 적절하지 않기 때문에 이 방식 적절X

    * id라는 개념이 필요한 이유 : 하나하나 셀을 구별하기 위해서

    * `locationInfo(city: "seoul", weather: "rainy")` 이런 거 하나하나를 고유한 id로서 쓰겠다 -> **id: \\.self** 라고 쓰면 됨

      * 이 때는 **Hashable** 프로토콜을 준수해야 함

        ```swift
        struct LocationInfo: Hashable {
        	var city = ""
        	var weather = ""
        }
        ```

    * content:는 클로저형태

      ```swift
      ForEach(locations, id: \.self) {location in 
        Hstack {
          Text("\(location.city)")
          Text("\(location.weather)")
        }
      }
      ```

      ![image](https://user-images.githubusercontent.com/28949235/98381495-4e3c8a00-208d-11eb-88c0-b206700bba85.png)

      <br>

  * 2. id가 없고 **content:**만 있는 형태

    ```swift
    ForEach(locations) {location in //위에도 그렇고 여기서의 location은 그냥 맘대로 정한 것
      Hstack {
        Text("\(location.city)")
        Text("\(location.weather)")
      }
    }
    ```

    * 얘처럼 id가 없는데 데이터를 뿌리려면, 모델이 **Identifiable** 프로토콜을 준수해야 함 - 필수구현 id값 하나 생성해야 함

      ```swift
      struct LocationInfo: Identifiable {
        var id = UUID() // 난수 고유한 값이 자동으로 생성되게 UUID()라고 쓴 
        
      	var city = ""
      	var weather = ""
      }
      ```

    * 1번에서 `id: \.id` 라고 쓴 것과 동일함! 2번은 그걸 생략한거

  * 3. 인덱싱 형태 - **Range\<Int>** 부분이 있는 형태

    * 0...10 = 0 ~ 10 / 0..<10 = 0 ~ 9

      ```swift
      ForEach(0..<locations.count) { index in //index는 앞의 숫자값을 받아옴 (이름은 임의로 정한 것)
       HStack{
         Text("\(index + 1)")
         Text("\(locations[index].city)")
         Text("\(locations[index].weather)")
       }
      }
      ```

    * 인덱스 자체로 뭘 하고싶을 때 사용

