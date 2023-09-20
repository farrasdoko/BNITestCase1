//
//  User.swift
//  TestFarras
//
//  Created by Farras on 20/09/23.
//

import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    // 2,000,000 is the default user balance after registration
    @Persisted var balance: Int = 2000000
    
    convenience init(name: String) {
           self.init()
           self.name = name
       }
}
