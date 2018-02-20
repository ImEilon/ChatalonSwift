//
//  ViewController.swift
//  Chatalon
//
//  Created by Eilon Cohen on 1/26/18.
//  Copyright © 2018 Eilon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore

class ViewController: UIViewController {
   

    
    
    @IBOutlet var lbl: UILabel!
    @IBOutlet var emtxt: UITextField!
    @IBOutlet var pwtxt: UITextField!
    @IBOutlet var usernametxt: UITextField!
    @IBOutlet var tologinbtn: UIButton!
    @IBOutlet var bckbtn: UIButton!
    @IBOutlet var toregbtn: UIButton!
    @IBOutlet var loginn: UIButton!
    
    func hideOut(){
        tologinbtn.isHidden=true;
        toregbtn.isHidden=true;
        loginn.isHidden=false;
        bckbtn.isHidden=false;
        emtxt.isHidden=false;
        pwtxt.isHidden=false;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func bckact(_ sender: Any) {
        bckbtn.isHidden=true;
        tologinbtn.isHidden=false;
        toregbtn.isHidden=false;
        loginn.isHidden=true;
        emtxt.isHidden=true;
        pwtxt.isHidden=true;
         usernametxt.isHidden=true;
    }
    @IBAction func actionlog2(_ sender: UIButton) {
        if loginn.currentTitle == "Login" {
            SignIn();
        }else{
            regHandler();
        }
        
    }
    
    @IBAction func tologact(_ sender: Any) {
        loginn.setTitle("Login", for: .normal)
        lbl.textColor = .black;
        hideOut();
        
        
    }
    
    
    @IBAction func toregact(_ sender: UIButton) {
        loginn.setTitle("Register", for: .normal)
        emtxt.placeholder = "Email";
        usernametxt.isHidden=false;
        hideOut();
       
    }
    
    func SignIn() {
        if(emtxt.text != "" && pwtxt.text != ""){
        Auth.auth().signIn(withEmail: emtxt.text! , password: pwtxt.text!) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                print(error ?? "Wut")
            }else{
                self.performSegue(withIdentifier: "toProfiles" , sender: self)
            }
            
            }
        }
    }
    func regHandler() {
         if(emtxt.text != "" && pwtxt.text != "" && usernametxt.text != "" ){
        Auth.auth().createUser(withEmail: emtxt.text! , password: pwtxt.text!) { (user, error) in
            if error != nil{
                print(error?.localizedDescription)
                print( error ?? "WUT")
                
                
            }else{
                let uid = Auth.auth().currentUser?.uid;
                let userData: [String : Any] = ["Email":self.emtxt.text! ,
                                                "Uid":uid! ,
                                                "Username":self.usernametxt.text! ]
                DbService.shared.useref.child(uid!).setValue(userData);
                self.lbl.text = "Registration Successful Please Sign-In"
                self.usernametxt.isHidden = true;
                self.loginn.setTitle("Login", for: .normal)
                self.lbl.textColor = .black;
                
            }
            }
         }else{lbl.text = "Please fill all the fields and try again"
            lbl.textColor = .red;
        }
    }
    
   
    
}
    
    
    
    
    
    
    
    

