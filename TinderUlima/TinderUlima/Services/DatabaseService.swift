//
//  DatabaseService.swift
//  TinderUlima
//
//  Created by Eros Campos on 16/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

let DB_BASE_ROOT = Firebase.Database.database().reference()

class DatabaseService{
    static let instance = DatabaseService()
    
    private let _Base_Ref = DB_BASE_ROOT
    private let _User_Ref = DB_BASE_ROOT.child("users")
    
    //Metodos de acceso
    var Base_Ref: DatabaseReference{
        return _Base_Ref
    }
    var User_Ref: DatabaseReference{
        return _User_Ref
    }
    
    func observeUserProfile(handler: @escaping(_ userProfileDic: UserModel?) -> Void){
        if let currentUser = Auth.auth().currentUser{
            DatabaseService.instance.User_Ref.child(currentUser.uid).observe(.value, with: {(snapshot) in
                if let userDict = UserModel(snapshot: snapshot){
                    handler(userDict)
                }
            })
        }
    }
    
    func createFirebaseDBUser(userUID: String, userData: Dictionary<String, Any>){
        User_Ref.child(userUID).updateChildValues(userData)
    }
}
