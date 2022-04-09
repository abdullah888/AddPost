//
//  Home.swift
//  ZZapp
//
//  Created by abdullah on 28/08/1443 AH.
//

import SwiftUI

struct Home: View {
    @StateObject var profileDate = ProfileViewModel()
    @StateObject var postDate = PostViewModel()
    @State var color = Color.black.opacity(0.7)
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Text(profileDate.userInfo.Name!)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding()
                    
                    
                    AsyncImage(url: URL(string: profileDate.userInfo.UserImage!), scale: 2) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 2)
                            .padding()
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(width: 40, height: 40)
                    }
                
                }.padding(.top,30)
                VStack{
                    
                    if postDate.post.count != 0 {
                        
                        ProgressView()
                        
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack(spacing: 25){
                                ForEach(postDate.datas){ post in
                                    PostCell(post: post)
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
