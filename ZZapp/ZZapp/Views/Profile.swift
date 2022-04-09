//
//  Profile.swift
//  ZZapp
//
//  Created by abdullah on 01/09/1443 AH.
//

import SwiftUI

struct Profile: View {
    @StateObject var profileDate = ProfileViewModel()
    @State var color = Color.black.opacity(0.7)
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    VStack{
                        if profileDate.userInfo.UserImage != ""{
                            AsyncImage(url: URL(string: profileDate.userInfo.UserImage!), scale: 2) { image in
                                        image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 2)
                                    .padding()
                                    } placeholder: {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .frame(width: 80, height: 80)
                                    }
                     
                        } else {
                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 2)
                                .padding()
                        }
                        
                        Text(profileDate.userInfo.Name!)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .navigationTitle("ProfileView")
        }
        .navigationViewStyle(.stack)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
