//
//  ProfileSelectViewController.swift
//  FlybitsTest
//
//  Created by Kaivalya Vohra on 28/09/2020.
//  Copyright © 2020 Kaivalya Vohra. All rights reserved.
//

import UIKit


class ProfileSelectViewController: UIViewController {
    var userNo = -1

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func user1clicked(_ sender: Any) {
        userNo = 0
        self.performSegue(withIdentifier: "profileToTab", sender: self)
    }
    @IBAction func user2clicked(_ sender: Any) {
        userNo = 1
        self.performSegue(withIdentifier: "profileToTab", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileToTab"){
                let displayVC = segue.destination as! UITabBarController
                let destinationViewController = displayVC.viewControllers![1] as! ViewController

                destinationViewController.userNo = userNo
        }
    }
}
