//
//  AppIosW6CodePatrollAppDelegate.swift
//  AppIosW6CodePatroll
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//

import UIKit
import MLConfigurationProvider
import MLCommons

@UIApplicationMain
class AppIosW6CodePatrollAppDelegate: MLCBaseAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        let navigation = addAsRoot(EntryPointViewController())
        window.rootViewController = navigation

        let queue = DispatchQueue(label: "Monitor")
        InternetStatus.start(queue: queue)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func applicationIsSubscribingAppBehaviours(_ behaviourManager: MLCAppBehaviourManager) {
        // suscribe here your app behaviours
        // more info: https://sites.google.com/mercadolibre.com/mobile/arquitectura/ios/app-behaviours
    }
    
    private func addAsRoot(_ controller: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.tintColor = .black
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backgroundColor = .ml_meli_yellow()
        navBarAppearance.largeTitleTextAttributes = [.font: UIFont(name: "Helvetica", size: 14)!]
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.left"), transitionMaskImage: UIImage(systemName: "arrow.left"))

        let appearance = UINavigationBar.appearance()
        appearance.standardAppearance = navBarAppearance
        appearance.compactAppearance = navBarAppearance
        appearance.scrollEdgeAppearance = navBarAppearance
        if #available(iOS 15.0, *) {
            appearance.compactScrollEdgeAppearance = navBarAppearance
        } else {
            // Fallback on earlier versions
        }
        return navigation
    }
}
