//
//  DisplayView.swift
//

import SwiftUI

struct DisplayView: View {
    @Binding var menus: [Menu]
    @Binding var menuIndex: Int    
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .leading, spacing: 0) {
                Text("iPod")
                    .font(.system(size: 25))
                    .frame(width: geometry.size.width * 0.95, height: 30.0)
                    .background(Color.gray)
                ForEach(self.menus) { menu in
                    HStack () {
                        Text(menu.name)
                            .font(.system(size: 25))
                        Spacer()
                        if (menu.next){
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding(.horizontal, 5)
                    .foregroundColor(menu.id == self.menuIndex ? .white : .black)
                    .background(menu.id == self.menuIndex ? Color.blue : Color.white)
                }
                Spacer()
            }
            .background(Color.white)
            .frame(width: geometry.size.width * 0.95, height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 2).foregroundColor(Color.gray))
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    @State static var menus: [Menu] = [
        Menu(id: 0, name: "Music", next: true),
        Menu(id: 1, name: "Photos", next: true),
    ]
    
    @State static var menuIndex : Int = 0

    static var previews: some View {
        DisplayView(menus: $menus, menuIndex: $menuIndex)
    }
}
