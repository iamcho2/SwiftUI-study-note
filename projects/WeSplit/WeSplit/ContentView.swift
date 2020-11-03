//
//  ContentView.swift
//  WeSplit
//
//  Created by 초이 on 2020/11/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Form {
                Section{
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
                Section{
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
