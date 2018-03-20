import UIKit

class TopicsViewController: UIViewController {
    var tableView: UITableView!
    var store: RussianStore = RussianStore()
    var colors = [AthenaPalette.parisGreen,
                  AthenaPalette.maximumBlue,
                  AthenaPalette.lightPink,
                  AthenaPalette.rasberryPink,
                  AthenaPalette.maximumRed]

    override func viewDidLoad() {
        initTableView()
    }

    
    func initTableView() {
        guard let tabHeight = self.tabBarController?.tabBar.frame.height else {
            fatalError("tabbar height not found.")
        }
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - tabHeight)
        tableView = UITableView(frame: frame)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.bounces = false
        tableView.rowHeight = 120
        tableView.sectionHeaderHeight = 0.0
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
    }
}

extension TopicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LearTopicViewController()
        vc.topic = store.topics[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.topics.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellOptional = tableView.dequeueReusableCell(withIdentifier: "TopicCell") as? TopicCell
        let topic = store.topics[indexPath.row]
        guard let cell =  cellOptional else {
            fatalError("TopicCell not found.")
        }

        cell.title.text = topic.name
        cell.progress.progress = 0.55

        cell.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
}
