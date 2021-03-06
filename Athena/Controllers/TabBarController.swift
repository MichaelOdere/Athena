import UIKit

class TabBarController: UITabBarController {
    var topicNavController: UINavigationController!
    let topicsViewController = TopicsViewController()

    var trainerNavController: UINavigationController!
    let trainerCollectionViewController = TrainerCollectionViewController()

    var historyNavController: UINavigationController!
    let historyViewController = HistoryViewController()

    let profileViewController = ProfileViewController()

    override func viewDidLoad() {
        topicNavController = UINavigationController(rootViewController: topicsViewController)
        topicsViewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        trainerNavController = UINavigationController(rootViewController: trainerCollectionViewController)
        trainerCollectionViewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        historyNavController = UINavigationController(rootViewController: historyViewController)
        historyViewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        topicsViewController.title = "Topics"
        trainerCollectionViewController.title = "Trainer"
        historyViewController.title = "History"
        profileViewController.title = "Profile"

        self.delegate = self
        self.viewControllers = [topicNavController, trainerNavController, historyNavController] //,
//                               trainerViewController]
//                               historyViewController,
//                               profileViewController]
    }

//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        UIView.animate(withDuration: 2.0) {
//            let rotation = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//            item.
//
//        }
//    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {

        if selectedViewController == nil || viewController == selectedViewController {
            return false
        }

        let fromView = selectedViewController!.view
        let toView = viewController.view

        UIView.transition(from: fromView!, to: toView!, duration: 0.3,
                          options: [.transitionCrossDissolve], completion: nil)

        return true
    }
}
