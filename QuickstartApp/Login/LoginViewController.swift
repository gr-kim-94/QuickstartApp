//
//  LoginViewController.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: BaseViewController, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.signInButton.isHidden = true

        // Google login init
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        GIDSignIn.sharedInstance()?.restorePreviousSignIn() // 자동로그인
    }
    
    // MARK: GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print ("Error signIn : %@", error.localizedDescription)
            self.signInButton.isHidden = false
            return
        }
        
        guard let authentication = user.authentication else {
            self.signInButton.isHidden = false
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
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
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func skipTouchUpInside(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        self.appDelegate.window?.rootViewController = mainViewController
        self.appDelegate.window?.makeKeyAndVisible()
    }
    
}
