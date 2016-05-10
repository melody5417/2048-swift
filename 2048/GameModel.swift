//
//  GameModel.swift
//  2048
//
//  Created by Yiqi Wang on 16/4/25.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

import Foundation

class GameModel {
  
  var dimension:Int = 0
  
  var tiles:Array<Int> = []
  var mtiles:Array<Int>!
  var scoreDelegate:ScoreViewProtocol!
  var bestScoreDelegate:ScoreViewProtocol!
  
  var score:Int = 0
  var bestScore:Int = 0 {
    didSet {
      bestScoreDelegate.changeScore(value: bestScore)
    }
  }
  
  var maxNumber:Int = 0
  
  //由外部来传入维度值
  init(dimension:Int, maxNumber:Int, score:ScoreViewProtocol, bestScore:ScoreViewProtocol) {
    self.dimension = dimension
    self.maxNumber = maxNumber;
    self.scoreDelegate = score
    self.bestScoreDelegate = bestScore
    
    self.initTiles()
  }
  
  func initTiles()
  {
    self.tiles = Array<Int>(count:self.dimension*self.dimension, repeatedValue:0)
    self.mtiles = Array<Int>(count:self.dimension*self.dimension, repeatedValue:0)
  }
  
  //找出空位置
  func emptyPostitions() -> [Int] {
    var emptyTitles = Array<Int>()
    
    for i in 0..<(dimension * dimension) {
      if (tiles[i] == 0) {
        emptyTitles.append(i)
      }
    }
    return emptyTitles
  }
  
  //位置是否已满
  func isFull() -> Bool {
    if emptyPostitions().count == 0 {
      return true
    }
    return false
  }
  
  //输出当前数据模型
  func printTiles() {
    print(tiles)
    print("输出数据模型数据")
    
    let count = tiles.count
    for i in 0 ..< count {
      if (i+1) % Int(dimension) == 0 {
        print(tiles[i])
      } else {
        print("\(tiles[i])\t", terminator: "")
      }
    }
    print ("")
  }
  
  //false：表示该位置已经有值
  func setPosition(row:Int, col:Int, value:Int) -> Bool {
    assert(row >= 0 && row < dimension)
    assert(col >= 0 && col < dimension)
    
    //3行4列，即  row=2 , col=3  index=2*4+3 = 11
    //4行4列，即  3*4+3 = 15
    let index = self.dimension * row + col
    let positionValue = tiles[index]
    if positionValue > 0 {
      print("位置\(row+1)行，\(col+1)列的值为\(positionValue)")
      return false
    }
    tiles[index] = value
    return true
  }
  
  func copyToMtiles()
  {
    for i in 0..<self.dimension * self.dimension
    {
      mtiles[i] = tiles[i]
    }
  }
  
  func copyFromMtiles()
  {
    for i in 0..<self.dimension * self.dimension
    {
      tiles[i] = mtiles[i]
    }
  }
  
  //跟随滑动方向，数据重排
  func reflowUp()
  {
    copyToMtiles()
    var index:Int
    //从最后一行开始往上找
    //为什么是 i>0 ，而不是 i>= 0，因为第一行不用再动了
    for var i=dimension-1; i>0; i--
    {
      for j in 0..<dimension
      {
        index = self.dimension * i+j
        //如果当前位置有值，上一行没有值
        if(mtiles[index-self.dimension] == 0
          && (mtiles[index] > 0))
        {
          //把下一行的值赋值到上一行
          mtiles[index-self.dimension] = mtiles[index]
          mtiles[index] = 0
          
          var subindex:Int = index
          //因为当前行发生了移动，得让其后面的行跟上
          //否则滑动重排之后，会出现空隙
          while(subindex+self.dimension<mtiles.count)
          {
            if(mtiles[subindex+self.dimension]>0)
            {
              mtiles[subindex] = mtiles[subindex+self.dimension]
              mtiles[subindex+self.dimension] = 0
            }
            subindex += self.dimension
          }
        }
      }
    }
    copyFromMtiles()
  }

}
