//
//  HomeViewController.swift
//  TinderUlima
//
//  Created by Eros Campos on 15/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class HomeViewController: UIViewController, OnCarDraggedDelegate {
    
    func OnCardDragged(){
        if self.users.count > 0{
            self.updateImage(uid: self.users[self.random(0..<self.users.count)].uid)
        }
    }
    
    @IBOutlet weak var cardView: CardView!{
        didSet{
            cardView.onCarDraggedDelegate = self
        }
    }
    
    var currentUserModel : UserModel?
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = NavigationImageView()
        titleView.image = UIImage(named: "Actions")
        self.navigationItem.titleView = titleView
        
        Auth.auth().addStateDidChangeListener{
            (auth, user) in
            if let user = user {
                print("El usuario ingreso correctamente")
                self.getUsers()
            }else{
                print("Logout")
            }
            DatabaseService.instance.observeUserProfile{(userDict) in
                self.currentUserModel = userDict
            }
        }
        
        let profileButton = UIButton(type: .custom)
        profileButton.setImage(UIImage(named: "Login"), for: .normal)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.addTarget(self, action: #selector(goToProfile(sender:)), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: profileButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    @objc func goToProfile(sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.currentUserProfile = self.currentUserModel
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func getUsers(){
        DatabaseService.instance.User_Ref.observeSingleEvent(of: .value){(snapshot) in
            let userSnapshots = snapshot.children.compactMap{UserModel(snapshot: $0 as! DataSnapshot)}
            for user in userSnapshots{
                print("user: \(user)")
                self.users.append(user)
            }
        }
    }
    
    func updateImage(uid: String){
        DatabaseService.instance.User_Ref.observeSingleEvent(of: .value){(snapshot) in
            if let userProfile = UserModel(snapshot: snapshot){
                self.cardView.cardProfileImage.sd_setImage(with: URL(string: userProfile.profileImage), completed: nil)
                self.cardView.cardProfileLabel.text = userProfile.displayName
            }
        }
    }
    
    func random(_ range: Range<Int>) -> Int{
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
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
