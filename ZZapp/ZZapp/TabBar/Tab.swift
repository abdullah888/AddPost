//
//  Tab.swift
//  ZZapp
//
//  Created by abdullah on 01/09/1443 AH.
//

import SwiftUI


enum TabItemType {
    case TabType
    case ButtonType
}

struct TabItem: Identifiable {
    
    var id = UUID()
    
    var type: TabItemType
    var icon: String
    var text: String
    var tab: Tab?
    
}

enum Tab: String {
    case home
    case allview
    case setting
    case profile
}

var tabItems = [
    TabItem(type: .TabType, icon: "house", text: "Home", tab: .home),
    TabItem(type: .TabType, icon: "rectangle.split.3x3.fill", text: "AllView", tab: .allview),
    TabItem(type: .ButtonType, icon: "plus", text: "Add", tab: nil),
    TabItem(type: .TabType, icon: "slider.horizontal.3", text: "Stting", tab: .setting),
    TabItem(type: .TabType, icon: "person", text: "Profile", tab: .profile),
]
