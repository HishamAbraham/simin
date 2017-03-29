//
//  SecondViewController.swift
//  SiminAdham
//
//  Created by Hisham Abraham on 3/26/17.
//  Copyright © 2017 Hisham Abraham. All rights reserved.
//

import UIKit
import CoreLocation
import Photos
import AddressBookUI
import MessageUI
import AVFoundation
import CoreLocation

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate {
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var sendButton: UIBarButtonItem!
    @IBOutlet var address: UITextView!
    
    var location: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        location=CLLocationManager()
        location.delegate = self
        
        location.requestWhenInUseAuthorization()
        
        location.desiredAccuracy=kCLLocationAccuracyBest
        
        location.startUpdatingLocation()
        sendButton?.isEnabled = false
    }
    
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        //If the device has a camera, take a picture; otherwise, just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        
        //place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        //Put the image on the screen in the image view
        imageView.image = image
        
        var currentLocation = location.location
        
        let url = info[UIImagePickerControllerReferenceURL] as? URL
        if url != nil {
            
            let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset = fetchResult.firstObject
            if let imageLocation = asset?.location {
                currentLocation = imageLocation
            }
            
        }
        getAddressFrom(location: currentLocation!) { (addressFromImage) in
            self.address.text=addressFromImage
            self.sendButton?.isEnabled = true
        }
        
        //Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func send(_ sender: UIBarButtonItem) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients(["hishamabraham@gmail.com"])
        mailComposerVC.setSubject("Simin, I am interested in this property")
        mailComposerVC.setMessageBody(address.text, isHTML: false)
        //Add Image as Attachment
        if let image = imageView.image {
            let data = UIImageJPEGRepresentation(image, 1.0)
            mailComposerVC.addAttachmentData(data!, mimeType: "image/jpg", fileName: "image")
        }
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        let alert = UIAlertController(title: "Could Not Send Email", message:"Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            // Put here any code that you would like to execute when
            // the user taps that OK button (may be empty in your case if that's just
            // an informative alert)
        }
        alert.addAction(action)
        self.present(alert, animated: true){}
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func getAddressFrom(location: CLLocation, completion:@escaping ((String?) -> Void)) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                
                
                return completion(ABCreateStringWithAddressDictionary(placemark.addressDictionary!, true))
                
            }
            completion("Address not found")
        }
    }
}

