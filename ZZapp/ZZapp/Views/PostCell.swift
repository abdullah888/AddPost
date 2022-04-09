//
//  PostCell.swift
//  ZZapp
//
//  Created by abdullah on 02/09/1443 AH.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct PostCell: View {
    @State var  darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
    @StateObject var xfile = PostViewModel()
    @StateObject var profileDate = ProfileViewModel()
    var post : PostModel
    var body: some View {
        
        VStack {
            
            WebImage(url: URL(string: post.image!))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 30, height: 200)
                .aspectRatio(contentMode: .fit)
                .overlay(NEWMYview( post: post), alignment: .bottomLeading)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.8275, green: 0, blue: 0.1373, alpha: 1)), lineWidth: 1))
            HStack{
                VStack{
            Text(post.text!)
               
                .foregroundColor(Color.black)
                Text(post.details!)
                    
                    .foregroundColor(Color.black)
                }
                Spacer()
                
                
                VStack{
                AsyncImage(url: URL(string: post.userIamge!), scale: 2) { image in
                                image
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 2)
                            
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .frame(width: 40, height: 40)
                            }
                Text(post.userName!)
                    
                    .foregroundColor(Color.black)
                    
                }
                
                    
            }.padding()
        }
        
    }
}

struct ImageOverlay: View {
    @StateObject var xfile = PostViewModel()
    @StateObject var xxfile = ProfileViewModel()
    var post : PostModel
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("abdullah")
                        .font(.title)
                        .foregroundColor(Color("Color3"))
                        .padding()
                    Text(post.text!)
                        .font(.headline)
                        .foregroundColor(Color("Color3"))
                        .fontWeight(.bold)
                    HStack{
                    Text(post.details!)
                        .foregroundColor(Color("Color3"))
                        .lineLimit(1)
                        Spacer()
                        if xxfile.userInfo.UserImage != ""{
                            
                                WebImage(url: URL(string: xxfile.userInfo.UserImage!))
                       
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 33, height: 33)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .padding(3)
                            .background(Color("Color3"))
                            .clipShape(Circle())
                         
                        } else {
                            Image("33")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 33, height: 33)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                                .padding(3)
                                .background(Color.red)
                                .clipShape(Circle())
                                

                        }
                        
                       
                    }
                    
                }
                .padding()
                Spacer()
            }
            .frame(width: 200, height: 120)
            .padding(.bottom)
            .background(
                
                LinearGradient(gradient: .init(colors: [Color.red.opacity(0.9),Color.black.opacity(0.25)]), startPoint: .top, endPoint: .bottom)
                    .cornerRadius(25)
                    .padding(.top,10))
            .padding()
        }
    }
}

struct NEWMYview: View {
    @StateObject var xfile = PostViewModel()
   
    var post : PostModel
    var body: some View {
        ZStack {
            NavigationLink(destination: PostDetail( post: post)) {
            
            WebImage(url: URL(string: post.image!))
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 120)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .shadow(color: Color.black, radius: 4, x: 4, y: 4)
                .padding()
             }
            
        }
        
    }
    
}
