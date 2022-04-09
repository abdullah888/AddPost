//
//  Notifications.swift
//  ZZapp
//
//  Created by abdullah on 01/09/1443 AH.
//

import SwiftUI

struct Notifications: View {
    var body: some View {
        NavigationView {
            ZStack {
                Text("abdullah")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .navigationTitle("NotificationsView")
        }
        .navigationViewStyle(.stack)
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
