//
//  RealmHelper.swift
//  TestFarras
//
//  Created by Farras on 20/09/23.
//

import RealmSwift

struct RealmHelper {
    
    /// Create new user
    static func createUser(with name: String) {
        let user = User(name: name)
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
    }
    
    /// Get all users in the realm
    static func getUsers() -> [User] {
        let realm = try! Realm()
        return Array(realm.objects(User.self))
    }
    
    /// Get main user
    static func getMainUser() -> User? {
        return RealmHelper.getUsers().first
    }

    /// Update user balance.
    /// (-) to decrease and (+) to increase.
    static func performTransactionOnMainUser(nominal: Int) {
        let realm = try! Realm()
        let mainUser = realm.objects(User.self).first
        try! realm.write {
            mainUser?.balance = (mainUser?.balance ?? 0) + nominal
        }
        
        // Notify that balance has new value.
        NotificationCenter.default.post(name: NSNotification.Name.BalanceDidChange, object: nil)
    }
    
    static func getMainUserBalance() -> Int? {
        RealmHelper.getMainUser()?.balance
    }
}
