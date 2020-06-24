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


    @IBOutlet var LeadingC: NSLayoutConstraint!
    @IBOutlet var TrailingC: NSLayoutConstraint!
    var showingHamburgerMenu = false
    @IBAction func hamburgerClicked(_ sender: Any) {
        print(LeadingC.constant)
        if !showingHamburgerMenu{
            LeadingC.constant = 150
            //TrailingC.constant = -150
            showingHamburgerMenu = true
        }else{
            LeadingC.constant = 0
            TrailingC.constant = 0
            showingHamburgerMenu = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FlybitsManager.enableLogging()
        FlybitsConciergeManager.shared.register(contentTemplates: SmartRewardsContentViewables.contentViewables())


    }
    
    @IBAction func showConcierge(_ sender: Any) {

        if FlybitsConciergeManager.isConnected {
            DispatchQueue.main.async {
                //let flybitsConfig = self.flybitsConfiguration()
                let contextData = ContextData(pluginId: "ctx.flybits.locationDeviceAnalytics",
                values: ["locationlabel1": "Home",
                "locationlabel2": "Work",
                "coordinates1": ["lat": 25.056345, "lng": 55.207793],
                "coordinates2": ["lat": 25.056345, "lng": 55.207793]
                ])
                ContextManager.sendContextData([contextData]) { (error) in
                }
                

                let viewController = FlybitsConciergeManager.shared.conciergeNavigationController()
                self.present(viewController, animated: true, completion: nil)
                self.LeadingC.constant = 0
                self.TrailingC.constant = 0
                self.showingHamburgerMenu = false
                
                
                
            }
        }
        
        
    }
    func flybitsConfiguration() -> [String: String] {
        var result:[String:String] = [:]
       
       if let value = ProcessInfo.processInfo.environment["Flybits-Configuration"] {
         let plistPath = Bundle.main.path(forResource: value, ofType: nil)!
         let nsDictionary = NSDictionary(contentsOfFile: plistPath)
         if let config = NSDictionary(contentsOfFile: plistPath) as? [String: String] {
            result = config
         }
       }
       
       return result
    }
}
