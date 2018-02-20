//
//  DaChat.swift
//  Chatalon
//
//  Created by Eilon Cohen on 2/8/18.
//  Copyright © 2018 Eilon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

struct Post {
    let bodyText: String!
}

class DaChat: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var msgput: UITextField!

    
   
    var posts = [Post]();

    @IBOutlet var sbtn: UIButton!
    /*
    
    .queryOrderedByKey().observe(.childAdded , with: {
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        DbService.shared.msgref.child(DbService.shared.currentID).observe(.childAdded) {
            snapshot in
        
        let bodyText = ( snapshot.value as? NSDictionary)?["bodyText"] as? String
        self.posts.append(Post(bodyText : bodyText! ))
        
        self.tableView.reloadData();
            print(bodyText)
            }
         tableView.reloadData();
    }
    
    
    @IBAction func sendbtn(_ sender: Any) {
        if (msgput.text != "" ) {
           
            let uid = Auth.auth().currentUser?.uid
            let bodyData : [String: Any] = ["uid" : uid!,
                                            "bodyText" : msgput.text!]
            DbService.shared.msgref.child(DbService.shared.currentID).childByAutoId().setValue(bodyData)
        }else{
            
            print("Nothing TO SEND");
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "msgCell" , for: indexPath)
        let bodyText = cell.viewWithTag(0) as! UITableViewCell
        cell.textLabel?.text = posts[indexPath.row].bodyText!
        return cell
        
    }
    
    
    
   
}
