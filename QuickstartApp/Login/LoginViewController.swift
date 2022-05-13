//
//  LoginViewController.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
          if error != nil || user == nil {
            // Show the app's signed-out state.
          } else {
            // Show the app's signed-in state.
            self.skipTouchUpInside(UIButton.init())
          }
        }
    }
    
    @IBAction func signIn(sender: Any) {
        // 서버에 ID 토큰 보내기
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else {
                print ("Error signIn : %@", error?.localizedDescription ?? "")
                
                return
            }
            // 사용자 정보 가져오기
            guard let user = user else {
                return
            }
            
            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }
                
                let idToken = authentication.idToken
                let accessToken = authentication.accessToken
                // Send ID token to backend (example below).
                                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "",
                                                               accessToken: accessToken)
                
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error {
                        print ("Error signing in: %@", error.localizedDescription)
                        self.signInButton.isHidden = false
                        return
                    }
                    // User is signed in
                    // ...
                    //print ("Sign In.")
                    
                    self.appDelegate.user = user;
                    
                    let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
                    self.appDelegate.window?.rootViewController = mainViewController
                    self.appDelegate.window?.makeKeyAndVisible()
                }
                
            }
        }
    }
    
    @IBAction func signOut(sender: Any) {
        GIDSignIn.sharedInstance.signOut()
    }
    
    @IBAction func skipTouchUpInside(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        self.appDelegate.window?.rootViewController = mainViewController
        self.appDelegate.window?.makeKeyAndVisible()
    }
    
}
