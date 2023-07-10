//
//  ViewController.swift
//  FaceBookSignIn
//
//  Created by Mac on 10/07/23.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fbloginbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLogin()
    }
    @IBAction func facebookActionButton(_ sender: Any) {
        self.facebookLogin()
    }
  
//facebooklogin create a function
    func facebookLogin(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .cancelled :
                print("User clicked on cancle button")
            case .failed(let error):
                print(error.localizedDescription)
            case .success(_,_,_):
                self.getFacebookData()
            }
        }
    }
    func getFacebookData(){
        if AccessToken.current != nil {
            GraphRequest(graphPath: "me",  parameters: ["field": "id, email , name , piture.type(large)"]).start { connection , result, error in
                if error == nil {
                    
                    let dict = result as! [String: AnyObject] as NSDictionary
                    let name = dict.object(forKey: "name") as! String
                    let email = dict.object(forKey: "email") as! String
                    let id = dict.object(forKey: "id") as! String
                    
                    print("Name: \(name)")
                    print("Email: \(email)")
                    print("id: \(id)")
                    print(dict)
                    
                    
                    
                }else{
                    print(error?.localizedDescription)
                }
            }
        }else{
            print("Access Token is NIL")
        }
        
    }
}

