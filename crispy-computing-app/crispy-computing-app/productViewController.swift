//
//  ViewController.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/15/21.
//

import UIKit

class productViewcontroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dump(webData.getProducts())
        dump(webData.getCaliberName())
        
        // Do any additional setup after loading the view.
    }
}

