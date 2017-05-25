//
//  PictureViewController.swift
//  Snap!
//
//  Created by Bradley Stovall on 5/5/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Outlets for iamge view controller
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var imageChoice = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imageChoice.delegate = self
    }
    // Image info for selecting photo to add
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        imageChoice.dismiss(animated: true, completion: nil)
    }
    // Action for camera button
    @IBAction func cameraTapped(_ sender: Any) {
        imageChoice.sourceType = .savedPhotosAlbum
        imageChoice.allowsEditing = false
        present(imageChoice, animated: true, completion: nil)
    }
    // Action for next button
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil, completion: { (metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(String(describing: error))")
            } else {
                print(metadata?.downloadURL()! as Any)
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        
    }
    
    
}
