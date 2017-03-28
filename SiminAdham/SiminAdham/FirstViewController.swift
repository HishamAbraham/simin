//
//  FirstViewController.swift
//  SiminAdham
//
//  Created by Hisham Abraham on 3/26/17.
//  Copyright © 2017 Hisham Abraham. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var contactTable: UITableView!
    var contactStore = ContactsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactStore.allContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        
        let contact = contactStore.allContacts[indexPath.row]
        cell.type.text = contact.type
        cell.contact.text = nil
        cell.contact.text = "​\u{200B}\(contact.contact)"
        cell.contact.text = contact.contact
        return cell
    }


}

