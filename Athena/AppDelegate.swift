//
//  AppDelegate.swift
//  Athena
//
//  Created by Michael Odere on 3/16/18.
//  Copyright © 2018 michaelodere. All rights reserved.
// // swiftlint:disable line_length

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.darkGray
        UITabBar.appearance().tintColor = UIColor.white

        let mainViewController = TabBarController()
        window?.rootViewController = mainViewController

        let tabBar = mainViewController.tabBar
        let pvc = tabBar.items![0]
        pvc.image = UIImage(named: "avatar")?.withRenderingMode(.alwaysOriginal) // deselect image
        pvc.selectedImage = UIImage(named: "avatar")?.withRenderingMode(.alwaysOriginal) // select image
        pvc.tag = 0
        window?.makeKeyAndVisible()

        let attributesNormal = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont(name: "AmericanTypewriter", size: 12.0)!
        ]

        let attributesSelected = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "AmericanTypewriter", size: 20.0)!
        ]

        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: UIControlState.selected)
        return true
    }

    // MARK: - Core Data Stack

    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "WordStatsModel")
        container.loadPersistentStores(completionHandler: { (_ : NSPersistentStoreDescription, error: Error?) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })

        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
