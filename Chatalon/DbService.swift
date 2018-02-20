//
//  DbService.swift
//  Chatalon
//
//  Created by Eilon Cohen on 2/5/18.
//  Copyright © 2018 Eilon. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User{
    let username:String!
    let uid:String!
}



public class DbService {

    static let shared = DbService()
    private init(){}
   
    let useref = Database.database().reference().child("users")
    let msgref = Database.database().reference().child("msgs")
    
    var currentID = String();
    
    
    }

