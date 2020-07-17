//
//  AppDelegate.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import UIKit
import UserNotifications
import FlybitsPushSDK
import FlybitsConciergeSDK
import FlybitsContextSDK
import FlybitsSmartRewardsSDK
import FlybitsContextLocationPluginSDK
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.


        UNUserNotificationCenter.current().delegate = self


        FlybitsManager.enableLogging()
        FlybitsConciergeManager.shared.register(contentTemplates: SmartRewardsContentViewables.contentViewables())
        

        ContextManager.shared.register([.location], launchOptions: launchOptions)
        FlybitsConciergeManager.configure()
        FlybitsConciergeManager.shared.connectFlybitsManager(to: "1F765CBC-DD8D-4B58-B90A-EF2BB8220738", with: AnonymousIDP(), completion: { (error) in
                        guard error == nil else {
                            // Call your applications authentication callback with Error param and fail it
                            print("auth failed")
                            return
                        }
                        
                        
                    })
 

        // Determine if this should be called based on your use cases. It's recommended to register each time the app is ran to
        // ensure the push token hasn't been changed in APNS. If it has then Flybits will not be able to send Notifications to
        // your users when they're in context
        FlybitsConciergeManager.registerForPushNotifications()
        

        return true
    }


    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    @objc
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        guard deviceToken.count > 0 else { return }
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("Device Token: \(deviceTokenString)")
        // Setting the device token here will cause the token to be registered with Flybits.
        PushManager.shared.configuration.apnsToken = deviceToken
    }
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    _ = PushManager.shared.received(userInfo as! [String: Any]) { (result) in
            completionHandler(result)
        }
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler(.alert)
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        print("Did receive push notification.")
        guard let payload = response.notification.request.content.userInfo as? [String: Any] else {
            print("Received a push notification with a malformed payload.")
            return
        }
        _ = PushManager.shared.received(payload)
        completionHandler()
    }
}

