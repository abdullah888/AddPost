//
//  Login.swift
//  ZZapp
//
//  Created by abdullah on 28/08/1443 AH.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI




struct Login: View{
    @StateObject var profileDate = ProfileViewModel()
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        
        ZStack{
            
            ZStack(alignment: .topTrailing){
                GeometryReader{ _ in
                    
                    VStack{
                        
                        if profileDate.userInfo.UserImage != ""{
                            AsyncImage(url: URL(string: profileDate.userInfo.UserImage!), scale: 2) { image in
                                        image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 200, height: 200)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 2)
                                    .padding()
                                    } placeholder: {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .frame(width: 200, height: 200)
                                    }
                     
                        } else {
                            Image("22")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 2)
                                .padding()
                        }
                        Text("اوقاتي السعيدة")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                
                                
                                if self.visible {
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Password" , text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            Button(action: {
                                self.visible.toggle()
                            }){
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                                    .opacity(0.9)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                self.reset()
                            }) {
                                Text("Forget password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                            }
                            
                        }
                        .padding(.top, 20)
                        
                        Button(action: {
                            self.verify()
                        }) {
                            Text("Log in")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(8)
                        .padding(.top, 25)
                        
                    }
                    .padding(.horizontal ,25)
                }
                
                Button(action: {
                    self.show.toggle()
                }){
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                    
                }
                .padding()
                
            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error:self.$error)
            }
        }
    }
    
    private func verify(){
        if self.email != "" && self.pass != "" {
            Auth.auth().signIn(withEmail: self.email, password: self.pass){ (res, err) in
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("Success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
        }else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    
    private func reset() {
        if self.email != ""{
            Auth.auth().sendPasswordReset(withEmail: self.email){ (err) in
                
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        }else{
            self.error = "Email Id is empty."
            self.alert.toggle()
        }
    }
    
    
}
