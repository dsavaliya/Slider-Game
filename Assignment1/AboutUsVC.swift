//
//  AboutUsVC.swift
//  Assignment1
//
//  Created by Drashti Akbari on 2020-02-19.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
