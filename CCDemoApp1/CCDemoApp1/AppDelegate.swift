//
//  AppDelegate.swift
//  CCDemoApp1
//
//  Created by Parth on 11/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        redirectToTicTacToeBoardScreen()
        decorateNavigationBarAppearance()
        return true
    }

    func redirectToTicTacToeBoardScreen(){
        let ticTacToeVC = CurrencyConverterVC(
            nibName: "CurrencyConverterVC",
            bundle: nil)
        let navigationController = UINavigationController(rootViewController: ticTacToeVC)
        navigationController.navigationBar.isTranslucent = true
        navigationController.isNavigationBarHidden = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func decorateNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.orange
    }
}

