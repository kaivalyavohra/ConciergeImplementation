//
//  ContentTableViewController.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import UIKit
import FlybitsPushSDK
import FlybitsConciergeSDK
import FlybitsContextSDK
import FlybitsSmartRewardsSDK
import FlybitsContextLocationPluginSDK
class ViewController: UIViewController {
    var userNo = -1
    var userNameArray = ["testuser1@yopmail.com","testuser2@yopmail.com"]
    var passArray = ["System100$","System100$"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        FlybitsManager.enableLogging()
        //FlybitsConciergeManager.shared.register(contentTemplates: SmartRewardsContentViewables.contentViewables())
        

        FlybitsManager.environment = FlybitsManager.Environment.other("https://api.demo.flybits.com/")

        //ContextManager.shared.register([.location], launchOptions: launchOptions)
        FlybitsConciergeManager.configure()
        FlybitsConciergeManager.shared.connectFlybitsManager(to: "1F765CBC-DD8D-4B58-B90A-EF2BB8220738", with: FlybitsIDP(email: userNameArray[userNo], password: passArray[userNo])) { (error) in
            DispatchQueue.main.async {
                let concierge = FlybitsConciergeManager.conciergeViewController(for: "1F765CBC-DD8D-4B58-B90A-EF2BB8220738", using: "", display: [.displayMode: DisplayMode.navigation])
                self.addChild(concierge)

                self.view.addSubview(concierge.view)
                self.view.pin(concierge.view)

                concierge.didMove(toParent: self)
            }
        }


    }
}



extension UIView {
    func pin(_ view: UIView) {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
}
