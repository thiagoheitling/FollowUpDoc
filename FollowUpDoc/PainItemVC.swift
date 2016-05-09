//
//  NewEntryVC.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-04-22.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit
import RealmSwift

class PainItemVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let painLocationPickerData = [["lower-back", "upper-back", "headache front-side", "headache back-side", "neck", "left arm", "right arm", "left leg", "right leg"]]
    
    @IBOutlet weak var painLocationPicker: UIPickerView!
    @IBOutlet weak var painDescriptionTextView: UITextView!
    @IBOutlet weak var newPhotoButton: UIButton!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var painLocation = "lower-back"
    
//    This value is either passed by `PainTableView` in `prepareForSegue(_:sender:)` or constructed as part of adding a new entry.
    var pain = PainItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up views if editing an existing pain Item

        painDescriptionTextView.text = pain.aDescription
        
        //retrieving image
        if pain.image != nil {
            let image = UIImage.init(data: pain.image!)
            self.newPhotoButton.setImage(image, forState: .Normal)
        }
            ratingControl.rating = pain.intensity
        

        
        // textfield
        painDescriptionTextView.layer.borderWidth = 1
        painDescriptionTextView.layer.borderColor = UIColor.grayColor().CGColor
        painDescriptionTextView.delegate = self
        
        painLocationPicker.delegate = self
        painLocationPicker.dataSource = self
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - UITextView Delegates
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            painDescriptionTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - Pain Location Picker DataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return painLocationPickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return painLocationPickerData[component].count
    }
    
    // MARK: - Pain Location Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return painLocationPickerData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        painLocation = painLocationPickerData[0][painLocationPicker.selectedRowInComponent(0)]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.grayColor()
        
        for painLocationData in painLocationPickerData {
            
            pickerLabel.text = painLocationData[row]
        }
        pickerLabel.font = UIFont(name: "Helvetica Neue", size: 14)
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addImagePressed(sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Add a New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take a New Photo", style: .Default, handler: { action in
            
            self.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose Existing Photo", style: .Default, handler: { action in
            
            self.presentAlbum()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            
        }))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentCamera() {
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func presentAlbum() {
        
        let albumController = UIImagePickerController()
        albumController.sourceType = .PhotoLibrary
        albumController.delegate = self
        presentViewController(albumController, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.newPhotoButton.setImage(image, forState: .Normal)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if saveButton === sender {
            
            addNewItem()
            
            print("New item added")
        }
    }
    
    // MARK: - Realm Methods
    
    func addNewItem() {
            
            // get the current date
            let currentDate = NSDate()
            pain.date = currentDate
            
            pain.location = painLocation
            pain.aDescription = painDescriptionTextView.text
            pain.intensity = ratingControl.rating
            
            //if image has not been set, put the place holder
            let image: UIImage
            if newPhotoButton.imageView?.image == UIImage(named: "addPicturePlaceHolder") {
                image = UIImage(named: "logo")!
            } else {
                image = (newPhotoButton.imageView?.image)!
            }
            
            // saving the image
            let imageData = NSData(data: UIImageJPEGRepresentation(image, 1.0)!)
            
            pain.image = imageData
            
            let realm = try! Realm()
            try! realm.write{
            realm.add(pain)
                
            print(Realm.Configuration.defaultConfiguration.fileURL!)

        }
    }
}
