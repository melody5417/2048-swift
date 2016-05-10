//
//  MainTabViewController.swift
//  2048
//
//  Created by Yiqi Wang on 16/4/24.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //包括两个视图 主视图 和 设置视图
      let mainView = MainViewController()
      mainView.title = "2048"
      
      let settingView = SettingViewController()
      settingView.title = "设置"

      //分别声明两个视图控制器
      let main = UINavigationController(rootViewController: mainView)
      let setting = UINavigationController(rootViewController: settingView)
      
      self.viewControllers = [main, setting]
      
      //默认选中的是游戏主界面视图
      self.selectedIndex = 0
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
