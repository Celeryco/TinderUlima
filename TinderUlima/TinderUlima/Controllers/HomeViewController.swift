//
//  HomeViewController.swift
//  TinderUlima
//
//  Created by Eros Campos on 15/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, OnCarDraggedDelegate {
    
    func OnCardDragged() {
    
    }
    
    @IBOutlet weak var cardView: CardView!{
        didSet{
            cardView.onCarDraggedDelegate = self
        }
    }
    
    var currentUserModel : UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = NavigationImageView()
        titleView.image = UIImage(named: "Actions")
        self.navigationItem.titleView = titleView
        
        DatabaseService.instance.observeUserProfile{(userDict) in
            self.currentUserModel = userDict
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
