//
//  SignUp.swift
//  ZZapp
//
//  Created by abdullah on 28/08/1443 AH.
//

import SwiftUI
import Firebase


struct SignUp: View{
    @State var color = Color.black.opacity(0.7)
    @State var name = ""
    @State var email = ""
    @State var pass = ""
    @State var rePass = ""
    @State var visible = false
    @State var reVisible = false
    @State var Isanimation = true
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""
    @State var img_Data = Data.init(count: 0)
    @State var shown = false
    
    var body: some View {
        
        ZStack{
            ZStack(alignment: .topLeading){
                GeometryReader{ _ in
                    
                    
                    VStack{
                        
                        VStack {
                            if img_Data.count != 0 {
                                Image(uiImage: UIImage(data: img_Data)!)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 200, height: 200)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 2)
                                } else {
                                    VStack {
                                        Image(systemName: "person.circle")
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 200, height: 200)
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                            .shadow(radius: 2)
                                            .padding(.bottom, 1)
                                        Text("Choose a profile picture")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            
                                    
                                }
                            }
                            
                        } // VStack
                        .onTapGesture(perform: {
                            self.shown.toggle()
                        })
                        .padding(.top, 10)
                        
                        TextField("Name", text: self.$name)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
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
                        
                        HStack(spacing: 15){
                            
                            
                            VStack{
                                
                                
                                if self.reVisible {
                                    TextField("Repeat password", text: self.$rePass)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Repeat Password" , text: self.$rePass)
                                        .autocapitalization(.none)
                                }
                            }
                            Button(action: {
                                self.reVisible.toggle()
                            }){
                                Image(systemName: self.reVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                                    .opacity(0.9)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.rePass != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        Button(action: {
                            
                            self.register()
                            
                        }) {
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(8)
                        .padding(.top, 25)
                        
                    }
                    .padding(.horizontal ,25)
                    .sheet(isPresented: $shown) {
                        ImagePicker(picker: self.$shown, img_Data: self.$img_Data)
                    }.animation(.spring(),value: Isanimation)
                    
                }
               
            }.navigationBarHidden(true)
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
                
            }
        }
        
    }
    
    
    private func register(){
        
        if self.email != "" && img_Data.count != 0 {
            
            if self.pass == self.rePass {
                //TextFields validated
                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    let uid = Auth.auth().currentUser?.uid
                    UploadImage(imageData: img_Data, path: "User_Image") { url in
                        UserModel(ID: uid!, Name: name, UserImage: url).Upload()
                    }
                    print("success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }
                
                
            }else{
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
        
    }
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}











//private func register(){
//
//    if self.email != "" && IMGData.count != 0 {
//
//        if self.password == self.passwordConfirm {
//            //TextFields validated
//            Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err) in
//                if err != nil {
//                    self.error = err!.localizedDescription
//                    self.alert.toggle()
//                    return
//                }
//                let uid = Auth.auth().currentUser?.uid
//                UploadImage(imageData: IMGData, path: "User_Image") { url in
//                    UserModel(ID: uid!, Name: name, UserImage: url).Upload()
//                }
//                print("success")
//                UserDefaults.standard.set(true, forKey: "status")
//                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
//
//            }
//
//
//        }else{
//            self.error = "Password mismatch"
//            self.alert.toggle()
//        }
//    } else {
//        self.error = "Please fill all the contents properly"
//        self.alert.toggle()
//    }
//
//}
