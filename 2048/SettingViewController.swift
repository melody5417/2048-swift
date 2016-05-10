//
//  SettingViewController.swift
//  2048
//
//  Created by Yiqi Wang on 16/4/24.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
  
  var txtNum:UITextField!
  var segDimension:UISegmentedControl!

    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.whiteColor()
      setupControls()
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()

    }
  
  func setupControls() {
    //创建文本输入
    txtNum = ViewFactory.createTextField("", action: Selector("numChanged"), sender: self)
    txtNum.frame = CGRect(x: 80, y: 100, width: 200, height: 30)
    txtNum.returnKeyType = .Done
    self.view.addSubview(txtNum)
    
    let labelNum = ViewFactory.createLabel("阈值：")
    labelNum.frame = CGRect(x: 20, y: 100, width: 60, height: 30)
    self.view.addSubview(labelNum)
    
    //创建分段单选控件
    segDimension = ViewFactory.createSegment(["3*3","4*4","5*5"], action: Selector("dimensionChanged:"), sender: self)
    segDimension.frame = CGRect(x: 80, y: 200, width: 200, height: 30)
    self.view.addSubview(segDimension)
    
    segDimension.selectedSegmentIndex = 1
    
    let labelDm = ViewFactory.createLabel("维度：")
    labelDm.frame = CGRect(x: 20, y: 200, width: 60, height: 30)
    self.view.addSubview(labelDm)
    
  }
}
