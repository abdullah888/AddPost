//
//  AllView.swift
//  ZZapp
//
//  Created by abdullah on 01/09/1443 AH.
//

import SwiftUI

struct AllView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Text("abdullah")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .navigationTitle("AllView")
        }
        .navigationViewStyle(.stack)
    }
}

struct AllView_Previews: PreviewProvider {
    static var previews: some View {
        AllView()
    }
}
