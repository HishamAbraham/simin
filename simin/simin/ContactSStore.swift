//
//  SiminContacts.swift
//  simin
//
//  Created by Hisham Abraham on 3/26/17.
//  Copyright © 2017 Hisham Abraham. All rights reserved.
//

import Foundation
class ContactsStore: NSObject {
    var allContacts = [SiminContact] ()
    
    override init() {
        super.init()
        let direct = SiminContact(type: "Direct", contact: "703-669-9847")
        let cell = SiminContact(type: "Cell", contact: "301-514-6270")
        let website = SiminContact(type: "web", contact: "www.siminadham.com")

        allContacts.append(direct)
        allContacts.append(cell)
        allContacts.append(website)
        
    }
}
