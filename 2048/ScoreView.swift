//
//  ScoreView.swift
//  2048
//
//  Created by Yiqi Wang on 16/4/24.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

import UIKit

enum ScoreType {
  case Common //普通分数面板
  case Best   //最高分数面板
}

protocol ScoreViewProtocol {
  func changeScore(value s:Int)
}

class ScoreView: UIView, ScoreViewProtocol {
  var label:UILabel!
  let defaultFrame = CGRectMake(0, 0, 100, 30)
  var stype:String! //label显示文字 “最高分” or “分数”
  var score:Int = 0 {
    didSet {
      //分数变化，标签内容随之改变
      label.text = "\(stype):\(score)"
    }
  }
  
  //传入分数面板的类型，用于控制标签的显示
  init(stype:ScoreType) {
    label = UILabel(frame: defaultFrame)
    label.textAlignment = NSTextAlignment.Center
    
    super.init(frame: defaultFrame)
    
    self.stype = (stype == ScoreType.Common ? "分数" : "最高分")
    
    backgroundColor = UIColor.orangeColor()
    label.font = UIFont(name: "微软雅黑", size: 16)
    label.textColor = UIColor.whiteColor()
    self.addSubview(label)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  //实现协议中的方法
  func changeScore(value s: Int) {
    score = s
  }
}
