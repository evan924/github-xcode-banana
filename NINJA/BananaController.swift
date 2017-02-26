//
//  BananaController.swift
//  NINJA
//
//  Created by Annie Wang on 2/1/17.
//  Copyright © 2017 Annie Wang. All rights reserved.
//

import Foundation

class BananaController:NSObject{
    var bananaPosX:Int = 0
    var bananaPosY:Int = 0
    
    var gameMap = [[Int]]()
    
    var count:Int?

    
    func Init(){
        self.bananaPosX = 4
        self.bananaPosY = 4         //set start point
        
        count = 0
        
        let ran1 =  arc4random_uniform(12)+5
        gameMap.removeAll()
        for j:Int in 0 ..< 9{
            for _:Int in 0 ..< 9{
                let ran2 = arc4random_uniform(82)
                if ran2 < ran1 {
                    gameMap.append([Int]())
                    gameMap[j].append(0)
                }
                else{
                    gameMap.append([Int]())
                    gameMap[j].append(1)
                }
                
            }
            print(gameMap[j])       //put some random blocks on the game map
        }
        gameMap[4][4] = 1           // set start point unpressed
    }
    
    func isPointSafe(i:Int,j:Int) -> Bool{
        if gameMap[j][i] == 0{
            return false
        }
        else if j == 0 || i == 0 || j == 8 || i == 8{
            if gameMap[j][i] != 0{
                return true
            }
            else{
                return false
            }
        }
        else if j < 4 && i < 4{
            var count = 0
            if isPointSafe(i: i-1, j: j){
                count += 1
            }
            if isPointSafe(i: i+j%2, j: j-1){
                count += 1
            }
            if isPointSafe(i: i-(j+1)%2, j: j-1){
                count += 1
            }

            if count > 1{
                return true
            }else{
                return false
            }
        }
        else if j < 4 && i >= 4{
            var count = 0
            if isPointSafe(i: i-(j+1)%2, j: j-1){
                count += 1
            }
            if isPointSafe(i: i+1, j: j){
                count += 1
            }
            if isPointSafe(i: i+j%2, j: j-1){
                count += 1
            }
            if count > 1{
                return true
            }else{
                return false
            }
        }
        else if j > 4 && i < 4{
            var count = 0
            if isPointSafe(i: i-1, j: j){
                count += 1
            }
            if isPointSafe(i: i+j%2, j: j+1){
                count += 1
            }
            if isPointSafe(i: i-(j+1)%2, j: j+1){
                count += 1
            }
            
            if count > 1{
                return true
            }else{
                return false
            }
        }
        else if j > 4 && i >= 4{
            var count = 0
            if isPointSafe(i: i-(j+1)%2, j: j+1){
                count += 1
            }
            if isPointSafe(i: i+1, j: j){
                count += 1
            }
            if isPointSafe(i: i+j%2, j: j+1){
                count += 1
            }
            if count > 1{
                return true
            }else{
                return false
            }
        }
        else if j == 4 && i <= 4{
            var count = 0
            if isPointSafe(i: i-(j+1)%2, j: j-1){
                count += 1
            }
            if isPointSafe(i: i-1, j: j){
                count += 1
            }
            if isPointSafe(i: i-(j+1)%2, j: j+1){
                count += 1
            }
            if count > 1{
                return true
            }else{
                return false
            }
        }
        else if j == 4 && i > 4{
            var count = 0
            if isPointSafe(i: i-(j+1)%2, j: j-1){
                count += 1
            }
            if isPointSafe(i: i+1, j: j){
                count += 1
            }
            if isPointSafe(i: i-(j+1)%2, j: j+1){
                count += 1
            }
            if count > 1{
                return true
            }else{
                return false
            }
        }
        else{
            print("*******warning")
            return false
        }
    }
    
    func bananaGetMap() -> [[Int]]{
        return gameMap
    }
    

    func doesBananaEscape() -> Bool{
        if (bananaPosX  == 0 || bananaPosX == 8 || bananaPosY == 0 || bananaPosY == 8){
            return true
        }
        else{
            return false
        }
    }
    
    func setButton(curX:Int,curY:Int){
        gameMap[curX][curY] = 0
        count! += 1
    }
    
    func isBananaCaught() -> Int{
        let bananaPos0 = [bananaPosX-1,bananaPosY-(bananaPosX+1) % 2]       //    0  5
        let bananaPos1 = [bananaPosX,bananaPosY-1]                          //  1      4
        let bananaPos2 = [bananaPosX+1,bananaPosY-(bananaPosX+1) % 2]       //    2  3
        let bananaPos3 = [bananaPosX+1,bananaPosY+bananaPosX % 2]           //
        let bananaPos4 = [bananaPosX,bananaPosY+1]
        let bananaPos5 = [bananaPosX-1,bananaPosY+bananaPosX % 2]
        
        if (gameMap[bananaPos0[0]][bananaPos0[1]] == 0 && gameMap[bananaPos1[0]][bananaPos1[1]] == 0
         && gameMap[bananaPos2[0]][bananaPos2[1]] == 0 && gameMap[bananaPos3[0]][bananaPos3[1]] == 0
         && gameMap[bananaPos4[0]][bananaPos4[1]] == 0 && gameMap[bananaPos5[0]][bananaPos5[1]] == 0){
            return count!
        }
        else {
            return 0
        }
  
        
    }
    func bananaSetPos(i:Int,j:Int){
        bananaPosY = j
        bananaPosX = i
    }
    func bananaGetPos() -> [Int]{
        return [bananaPosX,bananaPosY]
    }
    
    func getEscDirections() -> [Int]{
        let bananaPos0 = [bananaPosX-1,bananaPosY-(bananaPosX+1) % 2]
        let bananaPos1 = [bananaPosX,bananaPosY-1]
        let bananaPos2 = [bananaPosX+1,bananaPosY-(bananaPosX+1) % 2]
        let bananaPos3 = [bananaPosX+1,bananaPosY+bananaPosX % 2]
        let bananaPos4 = [bananaPosX,bananaPosY+1]
        let bananaPos5 = [bananaPosX-1,bananaPosY+bananaPosX % 2]
        
        if isPointSafe(i: bananaPos0[1], j: bananaPos0[0]){
            bananaSetPos(i: bananaPos0[0], j: bananaPos0[1])
            return bananaPos0
        }
        else if isPointSafe(i: bananaPos1[1], j: bananaPos1[0]){
            bananaSetPos(i: bananaPos1[0], j: bananaPos1[1])
            return bananaPos1
        }
        else if isPointSafe(i: bananaPos2[1], j: bananaPos2[0]){
            bananaSetPos(i: bananaPos2[0], j: bananaPos2[1])
            return bananaPos2
        }
        else if isPointSafe(i: bananaPos3[1], j: bananaPos3[0]){
            bananaSetPos(i: bananaPos3[0], j: bananaPos3[1])
            return bananaPos3
        }
        else if isPointSafe(i: bananaPos4[1], j: bananaPos4[0]){
            bananaSetPos(i: bananaPos4[0], j: bananaPos4[1])
            return bananaPos4
        }
        else if isPointSafe(i: bananaPos5[1], j: bananaPos5[0]){
            bananaSetPos(i: bananaPos5[0], j: bananaPos5[1])
            return bananaPos5
        }
        else{
            print("all nearby points are unsafe warning*********")
            
            if gameMap[bananaPos0[0]][bananaPos0[1]] != 0{
                bananaSetPos(i: bananaPos0[0], j: bananaPos0[1])
                return bananaPos0
            }
            else if gameMap[bananaPos1[0]][bananaPos1[1]] != 0{
                bananaSetPos(i: bananaPos1[0], j: bananaPos1[1])
                return bananaPos1
            }
            else if gameMap[bananaPos2[0]][bananaPos2[1]] != 0{
                bananaSetPos(i: bananaPos2[0], j: bananaPos2[1])
                return bananaPos2
            }
            else if gameMap[bananaPos3[0]][bananaPos3[1]] != 0{
                bananaSetPos(i: bananaPos3[0], j: bananaPos3[1])
                return bananaPos3
            }
            else if gameMap[bananaPos4[0]][bananaPos4[1]] != 0{
                bananaSetPos(i: bananaPos4[0], j: bananaPos4[1])
                return bananaPos4
            }
            else if gameMap[bananaPos5[0]][bananaPos5[1]] != 0{
                bananaSetPos(i: bananaPos5[0], j: bananaPos5[1])
                return bananaPos5
            }else{
                return [bananaPosX,bananaPosY]
            }
        }
    }

}
