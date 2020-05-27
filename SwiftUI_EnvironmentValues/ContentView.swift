//
//  ContentView.swift
//  SwiftUI_EnvironmentValues
//
//  Created by Paymint on 2020/05/27.
//  Copyright © 2020 Paymint. All rights reserved.
//

import SwiftUI

/**
 
 -EnvironmentValues -
 
 1. SwiftUI에서 뷰를 구성하는 데 필요한 각종 환경 설정과 관련된 정보를 EnvironmentValues 타입이 관리한다.
 
 2. colorScheme, timeZone, locale, calendar, layoutDirection, sizeCategory, undoManager 등 다양한 클래스에서 나위어 사용하고 관리되던 속성들을 EnvironmentValues 하나에 모두 담아서 사용할 수 있다.
 
 3. EvironmentValues는 프레임워크에 의해 별도로 관리되고 있으므로 어떤 뷰에서든 접근할 수 있다. 이 때 얻게 되는 값은 상위 계층의 뷰가 가진 환경요소를 그대로 상속받는다. 그러므로 최상위 뷰에서 적용된 값은 모든 자식 뷰에 영향을 주게 된다. 하지만 하위계층에 있는 뷰가 독자적으로 다른 환경을 구성했다면 그 뷰에 속한 자식 뷰들은 변경된 값을 우선하여 사용하게 된다.
 
 <code>
 Text("Hello, SwiftUI").frame(width: 100)
 .environment(\.font, .title)
 .environment(\.lineLimit, 1)
 .environment(\.minimumScaleFactor, 0.5)
 
 위 코드를 구현해보면 결국 맨 하단의 environment만 적용된다.
 
 environment 수식어와 일반 수식어의 가장 큰 차이점은 자식 뷰에게 영향을 미치느냐 해당 뷰에만 영향을 미치느냐에 달려 있다.
 
 
 -@Environment-
 1. environment 수식어가 뷰의 환경 요소를 변경시키기 위한 쓰기 전용의 기능이었다면, @Environment라는 프로퍼티 래퍼는 읽기 전용으로 특정 뷰에서 EnvironmentValues의 특정 요소를 읽어 와 뷰 구성에 반영해야 할 때 사용한다.
 
 2. 프로젝트의 예제처럼 Left to Right 언어를 사용하는 환경과 아랍어나 히브리어처럼 Right to Left 언어 환경에서 뷰를 서로 다르게 표현하고 싶다고 가정했을때, Environment를 이용해 여러 가지 환경 변수 중 layoutDirection을 선택하고, 레이아웃 방향에 대한 환경 정보를 읽어와서 처리할 수 있다.
 
 3. Environment는 시스템에서 제공하는 것 외에도 커스텀하여 사용할 수 있는데, 앱에 필요한 환경 변수를 직접 추가하고 활용하는 것도 가능하다. 그러기 위해서는 EnvironmentKey 프로토콜을 상속받은 타입을 만들고, defaultValue를 만들어줘야 한다. 이 값은 기본값이 되며, 값이 타입을 정의하는 역할을 한다.
 
 
 */


struct ContentView: View {
    
//    @Environment(\.layoutDirection) var layoutDirection
    
    var body: some View {
        
        
        VStack{
            
//            VStack{
//                if layoutDirection == .leftToRight {
//                    return Text("Left to Right")
//                }else{
//                    return Text("Right to Left")
//                }
//            }
            
            VStack{
                MySubView()
                    .environment(\.myEnvironment, 7)
            }
        }
        
        
    }
}

struct MySubView: View {
    @Environment(\.myEnvironment) var myValue
    var body: some View{
        Text("\(myValue)")
    }
}

struct MyEnvironmentKey: EnvironmentKey {
    static let defaultValue: Int = 0
}


extension EnvironmentValues {
    var myEnvironment: Int{
        get{ self[MyEnvironmentKey.self] }
        set{ self[MyEnvironmentKey.self] = newValue }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
