//
//  ViewController.swift
//  crispy-computing-appv2
//
//  Created by Chakane Shegog on 10/11/21.
//

import UIKit

// keep track of what products to display
enum ammoOrArmsState: String {
    case ammo
    case arms
    case gear
}

enum gunTypeState: String {
    case searchAll
    case handgun
    case rifle
    case shotgun
}

class productSelectionViewController: UIViewController {
    
    // make a variable to hold our products data
    var products = [productData]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // initialize enums
    var ammoOrArm = ammoOrArmsState.ammo
    var gunType = gunTypeState.handgun
    var us1: Int = 0
    var us2: Int = 0
    
    
    // switch enum state when user selects ammo or arms
    @IBAction func ammoOrArmsSelection(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            ammoOrArm = ammoOrArmsState.ammo
            us1 = 0
            print("productSelectionViewController ammo selected")
        case 1:
            ammoOrArm = ammoOrArmsState.arms
            us1 = 1
            print("productSelectionViewController arms selected")
        case 2:
            ammoOrArm = ammoOrArmsState.gear
            us1 = 2
            print("productSelectionViewController gear selected")
        default:
            print("productSelectionViewController no tag identifier")
        }
    }
    
    // switch enum state when user selects handgun, rifle, shotgun
    @IBAction func gunTypeSelection(_ sender: UIButton) {
        switch sender.tag {
        case 3:
            us2 = 3
            print("productSelectionViewController searchAll selected")
        case 4:
            us2 = 4
            print("productSelectionViewController handgun selection")
        case 5:
            us2 = 5
            print("productSelectionViewController rifle selection")
        case 6:
            us2 = 6
            print("productSelectionViewController shotgun selected")
        
        default:
            print("no tag identifier")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pVC = segue.destination as? ProductViewController else {
            return
        }
        pVC.userSelection1 = us1
        pVC.userSelection2 = us2
    }
}

