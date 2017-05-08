//
//  SnapsViewController.swift
//  Snap!
//
//  Created by Bradley Stovall on 5/5/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    // Logout button takes you back to home screen
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
