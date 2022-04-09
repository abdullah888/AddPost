//
//  Cech.swift
//  ZZapp
//
//  Created by abdullah on 28/08/1443 AH.
//

import SwiftUI

struct Cech: View {
    @State var show = false
   
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        
        
        NavigationView{
            VStack{
                
                if self.status {
                    
                 TabBar()
                    
                }else{
                    
                    ZStack{
                        NavigationLink(
                            destination: SignUp(show: self.$show),
                            isActive: self.$show){
                            Text("dfdf")
                        }
                        .hidden()
                        
                        Login(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear(){
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    
                }
            }
        }
    }
}

struct Cech_Previews: PreviewProvider {
    static var previews: some View {
        Cech()
    }
}
