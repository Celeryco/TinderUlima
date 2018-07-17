//
//  ProfileViewController.swift
//  TinderUlima
//
//  Created by Eros Campos on 16/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//

import UIKit
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
