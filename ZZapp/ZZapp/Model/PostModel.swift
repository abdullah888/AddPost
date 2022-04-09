//
//  PostModel.swift
//  ZZapp
//
//  Created by abdullah on 02/09/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestore

class PostModel  :Identifiable {

    var user: UserModel?
    var isAdded: Bool = false
    var id : String?
    var time : Date?
    var details : String?
    var text : String?
    var image: String?
    var userName: String?
    var userIamge: String?
  
   
    
    init(id : String, time : Date, text : String,details : String, image : String, userName : String, userIamge : String) {
        self.id = id
        self.time = time
        self.text = text
        self.details = details
        self.image = image
        self.userName = userName
        self.userIamge = userIamge
    }
    
    init(Dictionary : [String : AnyObject]) {
        self.id = Dictionary["id"] as? String
        self.time = Dictionary["time"] as? Date
        self.text = Dictionary["text"] as? String
        self.details = Dictionary["details"] as? String
        self.image = Dictionary["image"] as? String
        self.userName = Dictionary["userName"] as? String
        self.userIamge = Dictionary["userIamge"] as? String
        
    }
    
    func MakeDictionary()->[String : AnyObject] {
        var D : [String : AnyObject] = [:]
        D["id"] = self.id as AnyObject
        D["time"] = self.time as AnyObject
        D["text"] = self.text as AnyObject
        D["details"] = self.details as AnyObject
        D["image"] = self.image as AnyObject
        D["userName"] = self.userName as AnyObject
        D["userIamge"] = self.userIamge as AnyObject
        return D
    }
    
    func Upload(){
        guard let id = self.id else { return }
        Firestore.firestore().collection("Posts").document(id).setData(MakeDictionary())
    }
    
    func Remove(){
        guard let id = self.id else { return }
        Firestore.firestore().collection("Posts").document(id).delete()
        
       // Firestore.firestore().collection("Ads").document(id).delete()
    }
    
    
}


class PostApi {

    static func GetPost(ID : String, completion : @escaping (_ Post : PostModel)->()){
        Firestore.firestore().collection("Posts").document(ID).addSnapshotListener { (Snapshot : DocumentSnapshot?, Error : Error?) in
            if let data = Snapshot?.data() as [String : AnyObject]? {
                let New = PostModel(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetAllPosts(completion : @escaping (_ Post : PostModel)->()){
        Firestore.firestore().collection("Posts").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = PostModel(Dictionary: data)
                    completion(New)
                }
            }
        }

    }
    
}

