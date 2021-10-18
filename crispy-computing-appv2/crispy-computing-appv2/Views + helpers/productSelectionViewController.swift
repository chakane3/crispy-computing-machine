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
            print("ammo selected")
        case 1:
            ammoOrArm = ammoOrArmsState.arms
            print("arms selected")
        case 2:
            ammoOrArm = ammoOrArmsState.gear
            print("gear selected")
        default:
            print("no tag identifier")
        }
    }
    
    // switch enum state when user selects handgun, rifle, shotgun
    @IBAction func gunTypeSelection(_ sender: UIButton) {
        switch sender.tag {
        case 3:
            gunType = gunTypeState.searchAll
            print("searchAll selected")
        case 4:
            gunType = gunTypeState.handgun
            print("handgun selection")
        case 5:
            gunType = gunTypeState.rifle
            print("rifle selection")
        case 6:
            gunType = gunTypeState.shotgun
            print("shotgun selected")
        
        default:
            print("no tag identifier")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pVC = segue.destination as? ProductViewController else {
            return
        }
        pVC.userSelection1 = ammoOrArm
        pVC.userSelection2 = gunType
    }
}

