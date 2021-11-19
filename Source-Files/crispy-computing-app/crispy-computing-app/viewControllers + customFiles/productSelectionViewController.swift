//
//  productSelectionViewController.swift
//  crispy-computing-app
//
//  Created by Chakane Shegog on 9/27/21.
//

import UIKit

// navigation to different product lines
enum ammoOrArm {
    case ammo
    case arms
}

enum gunType {
    case handgun
    case rifle
    case shotgun
}

class productSelectionViewController: UIViewController {
    var products = [CTDproductData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // initialize enums
    var ammoOrArms = ammoOrArm.ammo
    var aGunType = gunType.handgun
    
    
    @IBAction func ammoOrArmSelection(_ sender: UIButton!) {
        switch sender.tag {
        case 0:
            print("user selected ammo")
            ammoOrArms = ammoOrArm.ammo
            
        case 1:
            print("user selected arms")
            ammoOrArms = ammoOrArm.arms
            
        default:
            print("no tag identifier")
        }
    }
    
    @IBAction func gunTypeSelect(_ sender: UIButton) {
        switch sender.tag {
        case 2:
            print("user selected handgun")
            aGunType = gunType.handgun
            
        case 3:
            print("user selected rifle")
            aGunType = gunType.rifle
            
        case 4:
            print("user selected shotgun")
            aGunType = gunType.shotgun
            
        default:
            print("no tag identifier")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pVC = segue.destination as? CTDproductViewController else {
            return
        }
        pVC.selected1 = ammoOrArms
        pVC.selected2 = aGunType
    }
}
