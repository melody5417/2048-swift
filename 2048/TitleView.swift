//
//  TitleView.swift
//  2048
//
//  Created by Yiqi Wang on 16/4/25.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

import UIKit

class TileView:UIView {
  
  //颜色映射表，不同的数字颜色不同
  let colorMap = [
    2:UIColor.redColor(),
    4:UIColor.orangeColor(),
    8:UIColor.yellowColor(),
    16: UIColor.greenColor(),
    32:UIColor.brownColor(),
    64:UIColor.blueColor(),
    128:UIColor.purpleColor(),
    256:UIColor.cyanColor(),
    512:UIColor.lightGrayColor(),
    1024:UIColor.magentaColor(),
    2048:UIColor.blackColor()
  ]
  
  //在设置值时，更新视图的背景和文字
  var value:Int = 0 {
    didSet {
      backgroundColor = colorMap[value]
      numberLabel.text = "\(value)"
    }
  }
  
  var numberLabel:UILabel!
  
  //初始化视图
  init(position:CGPoint, width:CGFloat, value:Int) {
    numberLabel = UILabel(frame:CGRectMake(0,0,width,width))
    numberLabel.textColor = UIColor.whiteColor()
    numberLabel.textAlignment = .Center
    numberLabel.minimumScaleFactor = 0.5
    numberLabel.font = UIFont(name:"微软雅黑", size:20)
    numberLabel.text = "\(value)"
    
    super.init(frame:CGRectMake(position.x, position.y, width, width))
    addSubview(numberLabel)
    
    self.value = value
    backgroundColor = colorMap[value]
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder : aDecoder)
  }
}