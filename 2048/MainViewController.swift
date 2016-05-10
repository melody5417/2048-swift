//
//  MainViewController.swift
//  2048
//
//  Created by Yiqi Wang on 16/4/24.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  //游戏方格维度
  var dimension:Int = 4
  //游戏过关最大值
  var maxnumber:Int = 2048 {
    didSet {
      gameModel.maxNumber = maxnumber
    }
  }
  
  //数字格子的宽度
  var width:CGFloat = 50.0
  //格子与格子的间距
  var padding:CGFloat = 6
  
  //保存背景图数据
  var backgrounds:Array<UIView>!
  
  var scoreView:ScoreView!
  var bestScoreView:ScoreView!
  
  var gameModel:GameModel!
  
  //保存界面上的数字Label数据
  var tiles: Dictionary<NSIndexPath, TileView>!
  //保存实际数字值的一个字典
  var tileVals: Dictionary<NSIndexPath, Int>!
  
  init() {
    self.backgrounds = Array<UIView>()
    super.init(nibName: nil, bundle: nil)
    self.tiles = Dictionary()
    self.tileVals = Dictionary()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    //改成主视图背景 白色背景
    self.view.backgroundColor = UIColor.whiteColor()
    setupGameMap()
    setupeScoreViews()
    setupButtons()
    setupSwipeGuestures()
    
    self.gameModel = GameModel(dimension: self.dimension, maxNumber: self.maxnumber, score: self.scoreView, bestScore: self.bestScoreView)
    
    //首先产生两个数字
    genNumber()
    genNumber()
  }
 
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
  func setupGameMap() {
    var x:CGFloat = 50
    var y:CGFloat = 150
    
    for i in 0..<dimension {
      print(i)
      x = 50
      for j in 0..<dimension {
        print(j)
        //初始化视图
        let background = UIView(frame: CGRectMake(x, y, width, width))
        background.backgroundColor = UIColor.darkGrayColor()
        
        self.view.addSubview(background)
        
        //将视图保存起来，以备后续调用
        backgrounds.append(background)
        x += padding + width
      }
      y += padding + width
    }
  }
  
  func setupeScoreViews() {
    scoreView = ScoreView(stype: ScoreType.Common)
    scoreView.frame.origin = CGPointMake(50, 80)
    scoreView.changeScore(value: 0)
    self.view.addSubview(scoreView)
    
    bestScoreView = ScoreView(stype: ScoreType.Best)
    bestScoreView.frame.origin = CGPointMake(170, 80)
    bestScoreView.changeScore(value: 0)
    self.view.addSubview(bestScoreView)
  }
  
  func setupButtons() {
    let resetButton = ViewFactory.createButton("重置", action: Selector("resetTapped"), sender: self)
    resetButton.frame.origin = CGPointMake(50, 450)
    self.view.addSubview(resetButton)
    
    let genNewButton = ViewFactory.createButton("新数", action: Selector("genNewTapped"), sender: self)
    genNewButton.frame.origin = CGPointMake(170, 450)
    self.view.addSubview(genNewButton)
  }
  
  func setupSwipeGuestures() {
    //监控向上的方向，相应的处理方法 swipeUp
    let upSwipe = UISwipeGestureRecognizer(target:self, action:Selector("swipeUp"))
    
    upSwipe.numberOfTouchesRequired = 1
    upSwipe.direction = UISwipeGestureRecognizerDirection.Up
    self.view.addGestureRecognizer(upSwipe)
    //监控向下的方向，相应的处理方法 swipeDown
    let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeDown"))
    downSwipe.numberOfTouchesRequired = 1
    downSwipe.direction = UISwipeGestureRecognizerDirection.Down
    self.view.addGestureRecognizer(downSwipe)
    //监控向左的方向，相应的处理方法 swipeLeft
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft"))
    leftSwipe.numberOfTouchesRequired = 1
    leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
    self.view.addGestureRecognizer(leftSwipe)
    //监控向右的方向，相应的处理方法 swipeRight
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight"))
    rightSwipe.numberOfTouchesRequired = 1
    rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
    self.view.addGestureRecognizer(rightSwipe)
  }
  
  func _showTip(direction:String)
  {
    let alertController = UIAlertController(title: "提示", message: "你刚刚向\(direction)滑动了！", preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  func swipeUp()
  {
    print("swipeUp")
    _showTip("上")
    
    printTiles(gameModel.tiles)
    gameModel.reflowUp()
    printTiles(gameModel.tiles)
  
    
  }
  func swipeDown()
  {
    print("swipeDown")
    _showTip("下")
  }
  func swipeLeft()
  {
    print("swipeLeft")
    _showTip("左")
  }
  func swipeRight()
  {
    print("swipeRight")
    _showTip("右")
  }

  
  func resetTapped() {
    print("reset")
    
    //UI gmodel gen
    resetUI()
    gameModel.initTiles()
    //产生两个新数
    genNumber()
    genNumber()
  }
  
  func genNewTapped() {
    print("genNew")
    genNumber()
  }
  
  func resetUI() {
    for(_, tile) in tiles {
      tile.removeFromSuperview()
    }
    tiles.removeAll(keepCapacity: true)
    tileVals.removeAll(keepCapacity: true)
  }
  
  func insertTile (position:(Int, Int), value:Int ) {
    let (row, col) = position
    
    let x = 50 + CGFloat(col) * (width + padding)
    let y = 150 + CGFloat(row) * (width + padding)
    
    let tile = TileView(position: CGPointMake(x, y), width: width, value: value)
    self.view.addSubview(tile)
    self.view.bringSubviewToFront(tile)
    
    let index = NSIndexPath(forRow: row, inSection: col)
    tiles[index] = tile
    tileVals[index] = value
  }
  
  func genNumber() {
    //用于确定随机数的概率
    let randv = Int(arc4random_uniform(10))
    print(randv)
    
    //默认产生2 0.1的概率产生4
    var seed:Int = 2
    if randv == 1 {
      seed = 4
    }
    
    //随机生成行号和列号
    //随机生成行号和列号
    let col =  Int(arc4random_uniform(UInt32(dimension)))
    let row = Int(arc4random_uniform(UInt32(dimension)))
    if(gameModel.isFull())
    {
      print("位置已经满了")
      return
    }
    if(gameModel.setPosition(row, col:col, value:seed)==false)
    {
      genNumber()
      return
    }
    //执行后续操作
    insertTile((row, col), value: seed)
  }
  
  func printTiles(tiles:Array<Int>)
  {
    let count = tiles.count
    for var i=0; i<count; i++
    {
      if (i+1) % Int(dimension) == 0
      {
        print(tiles[i])
      }
      else
      {
        print("\(tiles[i])\t", terminator: "")
      }
    }
    
    print("")
    
  }
}
