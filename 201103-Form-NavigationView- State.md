📍100 Days of SwiftUI - day1, day2, day15

📍



## 자료형

### Multi-line strings

* Multi-line strings는 무조건 """ 쌍따옴표 3개가 앞뒤에 있어야 함. 또한 """는 한 줄에 혼자 있어야 함 ( abcd """ 이렇게 끝나면 안 됨)

  ```swift
  var tennyson = """
  Tis better to have loved
  and lost than never
   to have loved at all
  """
  ```





# Project `WeSplit` : **`Form`, `NavigationView`, `@State`**

### 프로젝트 생성하기

![image](https://user-images.githubusercontent.com/28949235/97952051-7ef79780-1ddf-11eb-98d4-93816cdef551.png)

프로젝트 생성할 때, 다른 건 다 똑같고 Interface만 SwiftUI로 바꿔주면 된다

![image](https://user-images.githubusercontent.com/28949235/97952240-0513de00-1de0-11eb-814a-a11db7a3c49f.png)

ContentView.swift 가 초기 유저 인터페이스나 UI를 담당하는 파일.

이 프로젝트에서는 여기서만 작업한다

ContentView.swift의 파일을 살펴보면

```swift
import SwiftUI // import문

struct ContentView: View { //View protocol을 따르는 ContentView struct
    var body: some View { // some View.. View가 body라는 property에 return됨
        Text("Hello, world!" //Text()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider { //앱에 적용되는 건 아니고,canvas로 preview 화면 보기 위해 존재
    static var previews: some View {
        ContentView()
    }
}
```

* View: SwiftUI의 기본 프로토콜, 화면에 뭘 띄우고 싶으면 무조건 사용해야 함
* some View : View Protocol을 따르는 something을 return하겠다는 뜻
  * `some` 키워드 - 어쩔 땐 이거, 어쩔 땐 저거 리턴 못 함. 항상 같은 것만 리턴할 수 있다는 제한이 있음

* Text("") - 화면에 나타나는 정적 텍스트인데, 필요 시 여러 줄도 자동으로 감싸줌

* canvas 단축키 - `option+command+p`

### Form

> 많은 앱들이 사용자에게 여러 종류의 입력값을 요구한다
>
> 환경설정, 차를 어디서 픽업할지, 무슨 음식 메뉴를 고를건지 ... 이럴 때 쓰라고 있는 전용 view type - Form !

* 텍스트, 이미지같은 정적 컨트롤들로 구성된 scrolling lists
* 텍스트 필드, 토글 스위치, 버튼 같은 user interactive한 컨트롤들도 포함 가능!

```swift
var body: some View {
        Form { 				// 이렇게 Form{} 사이에 요소들을 집어넣어주면 된다.
            Text("Hello, world!")
        }
    }
```

`Text("Hello, world!")` 를 여러 번 쓰면 그만큼 row의 개수도 늘어난다.

![image](https://user-images.githubusercontent.com/28949235/97953367-96388400-1de3-11eb-89b4-ccdc89f20868.png)

> 캔버스 진짜 쩐다 ! 노트북 우주선 소리도 쩐다 ! 



![image-20201103145419284](https://user-images.githubusercontent.com/28949235/97962291-2c76a500-1df8-11eb-9329-7460b6f0e7fb.png)

> SwiftUI error - Extra argument in call

근데 만약, `Text("Hello, world!")`를 열 번 이상 쓰는것과 같이 10개 이상의 요소가 생기면

SwiftUI가 **" 야야 그만 ~~!! 10개까진 되는데 11개 부터 그 이상은 안 돼~!! "** 라고 한다.

이건 Form의 요소 뿐만 아니라 SwiftUI 전반적으로 모두 적용되는 rule... **Parent view 안에는 최대 10개의 Child View**...



그럼 10개 이상 넣고 싶으면 어떡하느냐.. Group으로 묶으면 된다. 이것도 매우 쉽다. 

말그대로 Group{}으로 묶어주면 됨  ◠‿◠   

![image](https://user-images.githubusercontent.com/28949235/97953850-157a8780-1de5-11eb-8aad-9dac8122071b.png)

각 Group별로 그 안에 요소가 10개만 안 넘으면 된다. Group에 넣는다고 해서 보이는게 달라지는 건 없다.

그런데 이렇게 나눠놓고 보니.. Swift UITableView에서 했던 것 처럼 Group간에 분리가 됐으면 또 좋겠는거지.. section 처럼..

section...  맞다 ㅋ Group 대신 Section에 넣어주면 된다.

![image](https://user-images.githubusercontent.com/28949235/97953909-507cbb00-1de5-11eb-946a-71e921df4ef9.png)



### Navigation bar

기본적으로 iOS는 시계 부분 밑이나 home indicator ( _______ 이렇게 생긴 애 ) 밑에까지 어디든지 컨텐츠를 배치할 수 있게 해주는데,

보기에 좋을리가 없다... 그래서 SwiftUI는 safearea 내에 컴포넌트들을 위치시킴

![image](https://user-images.githubusercontent.com/28949235/97955083-a7d05a80-1de8-11eb-93e3-8a92a8131662.png)

허지만.. Form을 스크롤하면 저렇게 system clock 밑에 내용이 위치하게 되는데,

이런 걸 고치는 가장 흔한 방법.,, 바로 Navigation bar !



TextView (`Text{}`)를 section안에 넣고 그 section을 Form에 넣었던 것 처럼,

Navigation bar도 같은 방식으로 추가하면 된다. **NavigationView**에다가!

```swift
var body: some View {
    NavigationView {
        Form {
            Section {
                Text("Hello World")
            }
        }
    }
}
```

이렇게 하면 Canvas에는 위에 빈 공간이 크게 생기는데, 여기가 Navigation bar가 들어갈 부분이다.

Simulator를 돌려보면 아래와 같이 스크롤에 따라 Navi bar가 생긴다

![Untitled](https://user-images.githubusercontent.com/28949235/97956306-a6546180-1deb-11eb-9dc2-bfe9dc7db22b.gif)

> 왜 셀이 녹았을까..



자 이제 Navigation bar에 title을 달아보자! ***modifier***를 사용하면 된다. 

*modifier*는 한 가지 작은 차이가있는 일반 메소드인데, **항상 사용하는 모든 항목의 새 인스턴스를 반환**합니다.

```swiftui
.navigationBarTitle(Text("SwiftUI"))
```

를 추가해주는데, 이러면 Swift는 navigation bar title(+우리가 추가한 다른 모든 컨텐츠)를 포함한 새로운 Form을 하나 더 만든다.

![image](https://user-images.githubusercontent.com/28949235/97961655-11576580-1df7-11eb-97a2-6e01ed7ed7f1.png)

> navigation bar title

이렇게 글자가 큰 게 기본이고, 스크롤을 하면 우리가 아는 Navigation bar의 title이 된다.

그럼 처음부터 navigation bar처럼 보이게는 어떻게 하느냐,, - displayMode

```swift
.navigationBarTitle("SwiftUI", displayMode: .inline)
```

![image](https://user-images.githubusercontent.com/28949235/97961798-495ea880-1df7-11eb-8acb-ffa04b4175f6.png)

> navigation bar title - displayMode: .inline

그리고 이건 shortcut 버전! (글자 크기는 large임)

```
.navigationBarTitle("SwiftUI")
```

