//
//  ContactViewController.swift
//  simin
//
//  Created by Hisham Abraham on 3/26/17.
//  Copyright © 2017 Hisham Abraham. All rights reserved.
//

import UIKit
class ContactViewController: UITableViewController {
    var contactStore: ContactsStore!

    @IBOutlet var contactTable: UITableView!
    override func viewDidLoad() {
        contactTable.dataSource = self
        contactStore = ContactsStore()
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactStore.allContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get a new or recyce cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        return cell
    }
}
