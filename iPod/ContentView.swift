//
//  ContentView.swift
//  Copyright © 2020 d1v1b.com All rights reserved.
//

import SwiftUI

struct Menu: Identifiable {
    let id: Int
    let name: String
    let next: Bool
}

struct ContentView: View {
    @State private var menus: [Menu] = [
        Menu(id: 0, name: "Music", next: true),
        Menu(id: 1, name: "Photos", next: true),
        Menu(id: 2, name: "Videos", next: true),
        Menu(id: 3, name: "Extras", next: true),
        Menu(id: 4, name: "Settings", next: true),
        Menu(id: 5, name: "Shuffle Songs", next: false)
    ]
    @State private var menuIndex : Int = 0

    var body: some View {
        VStack () {
            Spacer()
            DisplayView(menus: self.$menus, menuIndex: self.$menuIndex)
            Spacer()
            WheelView(menus: self.$menus, menuIndex: self.$menuIndex)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
