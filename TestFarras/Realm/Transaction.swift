//
//  Transaction.swift
//  TestFarras
//
//  Created by Farras on 20/09/23.
//

import RealmSwift
class Transaction: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    // Example: BNI
    @Persisted var recipient: String
    // Example: MERCHANT MOCK TEST
    @Persisted var merchant: String
    // Example: 50000
    @Persisted var nominal: Int
    
    convenience init(recipient: String, merchant: String, nominal: Int) {
        self.init()
        self.recipient = recipient
        self.merchant = merchant
        self.nominal = nominal
    }
}
