//
//  ContentView.swift
//  WeSplit
//
//  Created by 초이 on 2020/11/03.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    
    var body: some View {
        Button("Tap Count \(tapCount)"){
            self.tapCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
