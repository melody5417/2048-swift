//
//  ViewController.swift
//  2048
//
//  Created by Yiqi Wang on 16/4/24.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

 
  @IBAction func startGame(sender: UIButton) {
    let alertController = UIAlertController(title: "开始！", message: "游戏要开始，你准备好了吗？", preferredStyle: UIAlertControllerStyle.Alert)
    
    alertController.addAction(UIAlertAction(title: "Ready Go!", style: UIAlertActionStyle.Default, handler: {
      action in
      print(action)
      self.presentViewController(MainTabViewController(), animated: true, completion: nil)
    }))
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }

}

