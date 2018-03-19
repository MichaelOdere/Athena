import UIKit

class TabBarController: UITabBarController {
    var topicNavController:UINavigationController!
    let topicsViewController = TopicsViewController()
    let trainerViewController = TrainerViewController()
    let historyViewController = HistoryViewController()
    let profileViewController = ProfileViewController()

    override func viewDidLoad() {
        topicNavController = UINavigationController(rootViewController: topicsViewController)
        topicsViewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        topicsViewController.navigationController?.navigationBar.shadowImage = UIImage()
        topicsViewController.navigationController?.navigationBar.isTranslucent = true
        topicsViewController.navigationController?.view.backgroundColor = UIColor.clear

        topicsViewController.title = "Topics"
        trainerViewController.title = "Trainer"
        historyViewController.title = "History"
        profileViewController.title = "Profile"

        self.delegate = self
        self.viewControllers = [topicNavController] //,
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
