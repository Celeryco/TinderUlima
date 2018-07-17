//
//  ProfileViewController.swift
//  TinderUlima
//
//  Created by Eros Campos on 16/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileDisplayName: UILabel!
    
    @IBOutlet weak var profileEmail: UILabel!
    
    var currentUserProfile: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.layer.borderWidth = 1.0
        self.profileImage.clipsToBounds = true
        
        self.profileDisplayName.text = self.currentUserProfile?.displayName
        self.profileEmail.text = self.currentUserProfile?.email
        
        // Do any additional setup after loading the view.
    }

    @IBAction func signOut(_ sender: UIButton) {
        try! Auth.auth().signOut()
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }
    
    
    @IBAction func importUsers(_ sender: UIButton) {
        let users  = [["email": "bruno@asd.com", "password": "123456", "displayName": "Bruno", "photoURL":"https://i.imgur.com/YYqOgZB.jpg"],
                      ["email": "bublie@asd.com", "password": "123456", "displayName": "Bublie", "photoURL":"https://i.imgur.com/rmBXzbv.jpg"],
                      ["email": "buddy@asd.com", "password": "123456", "displayName": "Buddy", "photoURL":"https://i.imgur.com/piEDB2T.jpg"],
                      ["email": "boss@asd.com", "password": "123456", "displayName": "Boss", "photoURL":"https://i.imgur.com/gCclkXK.jpg"],
                      ["email": "chipotle@asd.com", "password": "123456", "displayName": "Chipotle", "photoURL":"https://i.imgur.com/ocNYvgJ.jpg"]]
        
        for userDemo in users{
            Auth.auth().createUser(withEmail: userDemo["email"]!, password: userDemo["password"]!, completion: { (user, error) in
                if let user = user{
                    let userData = ["provider": user.providerID, "email": user.email!, "profileImage": userDemo["photoURL"]!, "displayName": userDemo["displayName"]!, "userIsOnMatch": false] as [String: Any]
                    DatabaseService.instance.createFirebaseDBUser(userUID: user.uid, userData: userData)
                }
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
