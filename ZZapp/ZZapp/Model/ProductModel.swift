//
//  ProductModel.swift
//  ZZapp
//
//  Created by abdullah on 02/09/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class ProductModel : Identifiable {
    
//    var id : String?
//    var Text : String?
//    var detail : String?
//    var user : UserModel?
//    var Image : String?
    
    
    

    var user: UserModel?
    var isAdded: Bool = false
    var id : String?
    var time : Date?
    var details : String?
    var name : String?
    var image: String?



    init(id : String, time : Date, name : String,details : String, image : String) {
        self.id = id
        self.time = time
        self.name = name
        self.details = details
        self.image = image
    }

    init(Dictionary : [String : AnyObject]) {
        self.id = Dictionary["id"] as? String
        self.time = Dictionary["time"] as? Date
        self.name = Dictionary["name"] as? String
        self.details = Dictionary["details"] as? String
        self.image = Dictionary["image"] as? String

    }

    func MakeDictionary()->[String : AnyObject] {
        var D : [String : AnyObject] = [:]
        D["id"] = self.id as AnyObject
        D["time"] = self.time as AnyObject
        D["name"] = self.name as AnyObject
        D["details"] = self.details as AnyObject
        D["image"] = self.image as AnyObject
        return D
    }

    func Upload(){
        guard let id = self.id else { return }
        Firestore.firestore().collection("Products").document(id).setData(MakeDictionary())
    }

    func Remove(){
        guard let id = self.id else { return }
        Firestore.firestore().collection("Products").document(id).delete()

       // Firestore.firestore().collection("Ads").document(id).delete()
    }


}


class ProductApi {

    static func GetProduct(ID : String, completion : @escaping (_ Product : ProductModel)->()){
        Firestore.firestore().collection("Products").document(ID).addSnapshotListener { (Snapshot : DocumentSnapshot?, Error : Error?) in
            if let data = Snapshot?.data() as [String : AnyObject]? {
                let New = ProductModel(Dictionary: data)
                completion(New)
            }
        }
    }

    static func GetAllProducts(completion : @escaping (_ Product : ProductModel)->()){
        Firestore.firestore().collection("Products").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = ProductModel(Dictionary: data)
                    completion(New)
                }
            }
        }

    }

}

