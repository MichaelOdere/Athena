//
//  AppDelegate.swift
//  Athena
//
//  Created by Michael Odere on 3/16/18.
//  Copyright © 2018 michaelodere. All rights reserved.
// // swiftlint:disable line_length

import UIKit
import CoreData
import FontAwesome_swift

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
        setupTabBarImages(tabBar: tabBar)
        setupTabBarText()
        window?.makeKeyAndVisible()

        return true
    }

    func setupTabBarImages(tabBar: UITabBar) {
        let small: CGFloat = 30
        let large: CGFloat = 50

        let topics = tabBar.items![0]
        topics.image = UIImage.fontAwesomeIcon(name: .listUL, textColor: UIColor.black, size: CGSize(width: small, height: small))
        topics.selectedImage = UIImage.fontAwesomeIcon(name: .listUL, textColor: UIColor.black, size: CGSize(width: large, height: large))

        let trainer = tabBar.items![1]
        trainer.image = UIImage.fontAwesomeIcon(name: .star, textColor: UIColor.black, size: CGSize(width: small, height: small))
        trainer.selectedImage = UIImage.fontAwesomeIcon(name: .star, textColor: UIColor.black, size: CGSize(width: large, height: large))

        let history = tabBar.items![2]
        history.image = UIImage.fontAwesomeIcon(name: .folder, textColor: UIColor.black, size: CGSize(width: small, height: small))
        history.selectedImage = UIImage.fontAwesomeIcon(name: .folder, textColor: UIColor.black, size: CGSize(width: large, height: large))
    }

    func setupTabBarText() {
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
