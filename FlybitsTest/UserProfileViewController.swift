//
//  UserProfileViewController.swift
//  FlybitsTest
//
//  Created by Kaivalya Vohra on 08/10/2020.
//  Copyright © 2020 Kaivalya Vohra. All rights reserved.
//

import UIKit


class UserProfileViewController: UIViewController {
    var target = ProcessInfo.processInfo.environment["bank"]
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        var bundle = Bundle(identifier: "com.flybits.whitelabel.mastercard")
//        label1.textColor = UIColor(named: "primary", in: bundle, compatibleWith: nil)
        
        
        
        var labelList = [label1,label2,label3,label4]
        for i in labelList{
            i!.textColor = UIColor(named: target!+"/primary")
        }
          


    }

}
