//
//  Setting.swift
//  ZZapp
//
//  Created by abdullah on 01/09/1443 AH.
//

import SwiftUI

struct Setting: View {
    var body: some View {
        NavigationView {
            ZStack {
                Text("abdullah")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .navigationTitle("SettingView")
        }
        .navigationViewStyle(.stack)
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
