//
//  WheelView.swift
//  Copyright © 2020 d1v1b.com All rights reserved.
//

import SwiftUI
import AVFoundation

struct WheelView: View {
    @Binding var menus: [Menu]
    @Binding var menuIndex: Int
    @State private var lastAngle: CGFloat = 0
    @State private var counter: CGFloat = 0
    
    var body: some View {
        ZStack () {
            Circle()
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                .foregroundColor(Color("wheel"))
                .gesture(DragGesture()
                    .onChanged{ v in
                        // 回転角を計算する
                        var angle = atan2(v.location.x - UIScreen.main.bounds.width * 0.9 / 2, UIScreen.main.bounds.width * 0.9 / 2 - v.location.y) * 180 / .pi
                        if (angle < 0) { angle += 360 }
                        // 回転差分を計算する
                        let theta = self.lastAngle - angle
                        self.lastAngle = angle
                        // 少ない回転角のものを積み上げていく
                        if (abs(theta) < 20) {
                            self.counter += theta
                        }
                        // counterが20以上(以下)になったらメニューを移動
                        if (self.counter > 20 && self.menuIndex > 0) {
                            self.menuIndex -= 1
                            AudioServicesPlaySystemSound (1104)
                        } else if (self.counter < -20 && self.menuIndex < self.menus.count - 1) {
                            self.menuIndex += 1
                            AudioServicesPlaySystemSound (1104)
                        }
                        if (abs(self.counter) > 20) { self.counter = 0 }
                    }
                    .onEnded { v in
                        self.counter = 0
                    }
                )
                .overlay(
                    Circle()
                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                        .foregroundColor(Color("shell"))
                        .gesture(
                            TapGesture(count: 1)
                                .onEnded {
                                    AudioServicesPlaySystemSound (1104)
                                    print("Tapped")
                                }
                        )
                )
            Text("MENU")
                .font(.title)
                .foregroundColor(.white)
                .offset(y: -140)
            Image(systemName: "playpause.fill")
                .font(.title)
                .foregroundColor(.white)
                .offset(y: 140)
            Image(systemName: "forward.end.alt.fill")
                .font(.title)
                .foregroundColor(.white)
                .offset(x: 140)
            Image(systemName: "backward.end.alt.fill")
                .font(.title)
                .foregroundColor(.white)
                .offset(x: -140)
        }
    }
}

struct WheelView_Previews: PreviewProvider {

    @State static var menus: [Menu] = [
        Menu(id: 0, name: "Music", next: true),
        Menu(id: 1, name: "Photos", next: true),
    ]
    
    @State static var menuIndex : Int = 0

    static var previews: some View {
        WheelView(menus: $menus, menuIndex: $menuIndex)
    }
}
