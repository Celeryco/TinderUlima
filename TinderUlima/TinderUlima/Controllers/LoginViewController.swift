//
//  LoginViewController.swift
//  TinderUlima
//
//  Created by Eros Campos on 16/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import RevealingSplashView


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var subLoginButton: UIButton!
    
    @IBOutlet weak var loginAccLabel: UILabel!
    
    var registerMode : Bool = true
    
    let revealingSplashScreen = RevealingSplashView(iconImage: UIImage(named:"splash-icon")!, iconInitialSize: CGSize(width:80, height:80), backgroundColor: UIColor.white)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.revealingSplashScreen)
        self.revealingSplashScreen.animationType = SplashAnimationType.popAndZoomOut
        self.revealingSplashScreen.startAnimation()

        
        self.view.bindKeyboard()
        let tap  = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }

    @objc func handleTap(sender: UIButton){
        self.view.endEditing(true)
    }
    
    func showAlert(title: String, message: String){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        if self.emailTextField.text == "" || self.passTextField.text == ""{
            self.showAlert(title: "Error", message: "Algunos de los campos estan vacios")
        }else{
            if let email = self.emailTextField.text, let password = self.passTextField.text{
                if registerMode{
                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                        if error != nil{
                            self.showAlert(title: "Error", message: error!.localizedDescription)
                            
                        }else{
                            print("Cuenta creada")
                            if let user = user{
                                let userData = ["provider" : user.providerID, "email": user.email, "profileImage" : "...", "displayName" : "Eros"] as [String : Any]
                                DatabaseService.instance.createFirebaseDBUser(userUID: user.uid, userData: userData)
                                
                            }
                            //Aqui se pasa informacion de tener que hacerlo
                            UserDefaults.standard.set(true, forKey: "status")
                            Switcher.updateRootVC()
                        }
                    })
                }else{
                    Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                        if error != nil{
                            self.showAlert(title: "Error", message: error!.localizedDescription)
                            
                        }else{
                            print("Login correcto")
                            //Aqui se pasa informacion de tener que hacerlo
                            UserDefaults.standard.set(true, forKey: "status")
                            Switcher.updateRootVC()
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func doSubLogin(_ sender: UIButton) {
        if self.registerMode{
            self.loginButton.setTitle("Login", for: .normal)
            self.loginAccLabel.text = "¿Eres nuevo?"
            self.subLoginButton.setTitle("Registrate", for: .normal)
            self.registerMode = false
        }else{
            self.loginButton.setTitle("Crear Cuenta", for: .normal)
            self.loginAccLabel.text = "¿Ya tienes cuenta?"
            self.subLoginButton.setTitle("Login", for: .normal)
            self.registerMode = true
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
