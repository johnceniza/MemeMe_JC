//
//  MemeEditorVC.swift
//  MemeMe_JC
//
//  Created by John Ceniza on 7/21/15.
//  Copyright (c) 2015 AppDeco. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    let imagePicker = UIImagePickerController()
    var editMeme: Meme!
    
    //MARK: - UIViewController functions

    override func viewDidLoad() {
        super.viewDidLoad()

        //set delegates
        imagePicker.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        //initiate paragraphstyle object and set alignment to center to be used for labels
        var paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = NSTextAlignment.Center
        
        //create and set text attributes for the top and bottom label
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)!,
            NSStrokeWidthAttributeName : -4.0,
            NSParagraphStyleAttributeName : paraStyle
        ]

        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes

        //disable camera button if device doesn't have a camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            cameraButton.enabled = true
        } else {
            cameraButton.enabled = false
        }
        
        //initially disable share button until image is chosen
        shareButton.enabled = false
        
        //load meme if we're editing one and enable share button
        if let meme = editMeme {
            memeImageView.image = meme.image
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            shareButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: - IBActions
    
    @IBAction func cameraPressed(sender: UIBarButtonItem) {
        //set UIImagePicker to source type camera and present view
        imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion:nil)
    }
    
    @IBAction func albumPressed(sender: UIBarButtonItem) {
        //set UIImagePicker to source type photo library and present view
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion:nil)
    }

    @IBAction func sharePressed(sender: UIBarButtonItem) {
        //pass image to ActivityViewController for sharing
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        
        let sharedImage = generateMemeImage()
        let activityView = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
        
        //present activity view
        self.presentViewController(activityView, animated: true, completion:nil)
        
        
        //create meme object and save meme after completion of sharing
        activityView.completionWithItemsHandler = {activity, success, items, error in
            //Create the meme
            var meme = Meme(topTxt: self.topTextField.text,bottomTxt: self.bottomTextField.text,img: self.memeImageView.image!,memeImage: sharedImage)
            
            // Add it to the memes array in the Application Delegate
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memesArray.append(meme)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //dismiss view controller
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - UIImagePicker delegate functions
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        //unwrap dictionary value as image and set it as UIImageView on our memeEditor. Enable share button. Dismiss picker view.
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
            shareButton.enabled = true
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - UITextFieldDelegate delegate functions

    func textFieldDidBeginEditing(textField: UITextField) {
        //check if text fields have default text, if so, clear them
        if textField == bottomTextField {
            if textField.text == "BOTTOM" {
                textField.text = ""
            }
        } else {
            if textField.text == "TOP" {
                textField.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Keyboard Notifications and keyboard management
    
    func subscribeToKeyboardNotifications() {
        //register self for keyboard show and keyboard hide notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        //unregister self for keyboard show and keyboard hide notifications
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //when keyboard shows, adjust view to compensate for keyboard height
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.editing {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    //when keyboard hides, adjust view back to normal
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.editing {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    //gets keyboard height using notification received from NSNotificationCenter
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: - class specific funcs
    
    func generateMemeImage() -> UIImage {

        //hide nav and toolbar before snapshotting view
        navigationController?.navigationBarHidden = true
        toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //show nav and toolbar after snapshotting view
        navigationController?.navigationBarHidden = false
        toolbar.hidden = false
        
        return memedImage
    }
}

