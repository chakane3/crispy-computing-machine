//
//  ViewController.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/11/21.
//

import UIKit

// keep track of what products to display
enum ammoOrArmsState {
    case ammo
    case arms
}

enum gunTypeState {
    case handgun
    case rifle
    case shotgun
}

class productSelectionViewController: UIViewController {
    
    // make a variable to hold our products data
    var products = [productData]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        dump(result.getAmmo())
    }
    
    // initialize enums
    var ammoOrArm = ammoOrArmsState.ammo
    var gunType = gunTypeState.handgun
    
    
    // switch enum state when user selects ammo or arms
    @IBAction func ammoOrArmsSelection(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            ammoOrArm = ammoOrArmsState.ammo
        case 1:
            ammoOrArm = ammoOrArmsState.arms
        default:
            print("no tag identifier")
        }
    }
    
    // switch enum state when user selects handgun, rifle, shotgun
    @IBAction func gunTypeSelection(_ sender: UIButton) {
        switch sender.tag {
        case 2:
            gunType = gunTypeState.handgun
        case 3:
            gunType = gunTypeState.rifle
        case 4:
            gunType = gunTypeState.shotgun
        
        default:
            print("no tag identifier")
        }
    }
}

