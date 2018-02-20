//
//  ProfilesTable.swift
//  Chatalon
//
//  Created by Eilon Cohen on 2/8/18.
//  Copyright © 2018 Eilon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase






class ProfilesTable: UITableViewController {

    

    var users = [User]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = Auth.auth().currentUser?.uid;
        DbService.shared.useref.queryOrderedByKey().observe(.childAdded , with: {
            snapshot in
            let username = (snapshot.value as? NSDictionary)?["Username"] as? String ?? ""
            let uid = (snapshot.value as? NSDictionary)?["Uid"] as? String ?? ""
            self.users.append(User(username: username , uid:uid))
           
            self.tableView.reloadData();
        })
        tableView.reloadData();
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count ;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       DbService.shared.currentID = users[indexPath.row].uid;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let userField =  cell.viewWithTag(1) as! UILabel
        userField.text = users[indexPath.row].username
        return cell
    }
    
}
    
    


