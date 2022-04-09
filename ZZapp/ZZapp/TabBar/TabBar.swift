//
//  TabBar.swift
//  ZZapp
//
//  Created by abdullah on 01/09/1443 AH.
//

import SwiftUI

struct TabBar: View {
    
    @State private var selectedTab: Tab = .home
    @State private var showingAlert = false
    @State private var show = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    Home()
                case .setting:
                    Setting()
                case .allview:
                    AllView()
                case .profile:
                    Profile()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 88.0)
          
            TabClipperShape(radius: 38.0)
                .fill(Color("TabBarBackground"))
                .frame(height: 88, alignment: .top)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                .overlay(bottomBar)
                .sheet(isPresented: $show) {
                    Add()
                }
//                .alert("add", isPresented: $showingAlert) {
//                            Button("ok", role: .cancel) { }
//                        }
        }
        .background(Color("Background"))
        .ignoresSafeArea()
    }
    
    var bottomBar: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                Button(action: {
                    if tabItem.type == .TabType {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                        }
                    } else {
                        show = true
                    }
                }) {
                    if tabItem.type == .TabType {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                            Text(tabItem.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                    } else {
                        Image(systemName: "plus")
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 56, height: 56)
                            .foregroundColor(Color.white)
                            .background(Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color("FloatingButtonTopLeft"), Color("FloatingButtonBottomRight")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .shadow(color: Color.accentColor.opacity(0.3), radius: 10, x: 8, y: 16))
                            .offset(y: -35)
                        
                    }
                }
                .foregroundColor(selectedTab == tabItem.tab ? .accentColor : .secondary)
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: 88, alignment: .top)
        .padding(.horizontal, 8)
        .padding(.top, 14)
        
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
