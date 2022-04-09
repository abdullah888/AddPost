//
//  PostViewModel.swift
//  ZZapp
//
//  Created by abdullah on 02/09/1443 AH.
//

import SwiftUI
import Firebase

class PostViewModel :ObservableObject{
    
    @Published var user: [UserModel] = []
    @Published var post: [PostModel] = []
    @Published var datas = [PostModel]()
    @Published var Text = ""
    @Published var detail = ""
    // Image Picker...
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    let db = Firestore.firestore()
    let ref = Firestore.firestore()
    
    
    init(){
        GetPost()
        
    }
    
    
    
    
    
    // anynomus login For Reading Database....
    
    func login(){
        
        Auth.auth().signInAnonymously { (res, err) in
            
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res!.user.uid)")
            
            // After Logging in Fetching Data
            
            
        }
    }
    
    func AddPost(){
        
        let db = Firestore.firestore()
        Auth.auth().addStateDidChangeListener { auth, user in
        if let id = user?.uid{
        UserApi.GetUser(ID: id) { User in
        UploadImage(imageData: self.img_Data, path: "Post_Image") { url in
            db.collection("Posts")
                .document()
                .setData(["Text":self.Text,"detail":self.detail,"Image":url,"userName":User.Name!,"userIamge":User.UserImage!]) { (err) in
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                           }
                       }
                    }
                }
            }
        }
      
    }
    
    func GetPost(){
        
        
        db.collection("Posts").addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
                let id = i.document.documentID
                let Text = i.document.get("Text") as! String
                let detail = i.document.get("detail") as! String
                let Image = i.document.get("Image") as! String
                let userName = i.document.get("userName") as! String
                let userIamge = i.document.get("userIamge") as! String
                self.datas.append(PostModel(id: id, time: Date(), text: Text, details: detail, image: Image, userName: userName, userIamge: userIamge))
                
            }
        }
    }
    
   
    
}

