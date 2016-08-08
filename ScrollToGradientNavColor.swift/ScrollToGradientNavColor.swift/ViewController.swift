//
//  ViewController.swift
//  ScrollToGradientNavColor.swift
//
//  Created by allthings_LuYD on 16/8/8.
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    let SCREEN_WIDTH = UIScreen.main().bounds.size.width
    let tableView = UITableView()
    let identifier = "cell"
    let topConentInset = 136
    let topImageView = UIImageView()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.barTintColor = UIColor.orange()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.subviews[0].alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.reply, target: nil, action: nil)
        setUpUI()
        topImageViewSet()
    }

    func setUpUI() -> Void {
        tableView.frame = self.view.bounds
        tableView.contentInset.top = CGFloat (topConentInset+64)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        self.view.addSubview(tableView)
    }

    func topImageViewSet()  {
        topImageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*871/828.0)
        topImageView.image = UIImage(named: "backImage")
        self.view.insertSubview(topImageView, belowSubview: tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath)
        cell.textLabel?.text = "scrum_snail@yeah.net"
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y + tableView.contentInset.top
        print(offsetY)
        if offsetY < 0 {
            topImageView.transform = CGAffineTransform.init(scaleX: 1+offsetY/(-500), y: 1+offsetY/(-500))
        }
        if offsetY <= CGFloat(topConentInset*2) && offsetY > CGFloat(topConentInset - 64) {
            let alpa = offsetY >= CGFloat(topConentInset*2) ? 1 : offsetY / CGFloat(topConentInset * 2);
            self.navigationController?.navigationBar.subviews[0].alpha = alpa;
        }
        if (offsetY <= CGFloat(topConentInset - 64)) {
            self.navigationController?.navigationBar.subviews[0].alpha = 0;
        }

        topImageView.frame.origin.y = 0
    }

}

