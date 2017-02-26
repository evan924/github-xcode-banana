//
//  DragonViewController.swift
//  NINJA
//
//  Created by Annie Wang on 27/12/16.
//  Copyright © 2016 Annie Wang. All rights reserved.
//

import UIKit

class DragonViewController: UIViewController {
    
    var curBananaPosX:CGFloat = 0
    var curBananaPosY:CGFloat = 0
    
    var buttons:[UIButton] = [UIButton()]
    
    var BananaImageView = UIImageView()
    
    var timer = Timer()
    var TimerLabel = UILabel()
    var timerCounter = 0
    
    let bananaController:BananaController = BananaController()
    
    @IBOutlet weak var NaviBar: UINavigationBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        resetGame(reset: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackground(){
        let BackImageView = UIImageView()
        BackImageView.frame = CGRect(x: 0,y: 0,width: 400,height: 720)
        
        let BackgroundImage = UIImage(named: "background.jpg")
        BackImageView.image = BackgroundImage
        self.view.addSubview(BackImageView)

    }   //Set Background
    
    func resetGame(reset:Bool){
        if reset{
            curBananaPosX = CGFloat(self.view.frame.size.width/2-17.5)
            curBananaPosY = CGFloat(self.view.frame.size.height/2-17.5)
            bananaController.Init()
            setBackground()
            setButtons()
            setBanana()
            setTimer()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setTimer(){
        timerCounter = 0
        TimerLabel.text = "00:00:00"
        TimerLabel.frame = CGRect(x: 20, y: 40, width: 200, height: 30)
        TimerLabel.font = UIFont(name: "Papyrus", size: 30)
        TimerLabel.textColor = UIColor(red:0.19, green:0.62, blue:0.04, alpha:1.0)
        self.view.addSubview(TimerLabel)
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    func timerAction(){
        timerCounter += 1
        let seconds = timerCounter%60
        let minutes = (timerCounter/60)%60
        let hours = (timerCounter/60)/60
        let strSeconds = String(format:"%02d",seconds)      //two digits timer
        let strMinutes = String(format: "%02d",minutes)
        let strHours = String(format: "%02d",hours)
        TimerLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }
    
    
    func setBanana(){
        BananaImageView.frame = CGRect(x: curBananaPosX,y:curBananaPosY ,width: 35,height: 35)
        self.view.addSubview(BananaImageView)
        let BananaImage1 = UIImage(named: "banana1.jpg")
        let BananaImage2 = UIImage(named: "banana2.jpg")
        let BananaImage3 = UIImage(named: "banana3.jpg")
        let BananaImage4 = UIImage(named: "banana4.jpg")
        BananaImageView.animationImages = [BananaImage1!,BananaImage2!,BananaImage3!,BananaImage4!]
        BananaImageView.animationDuration = 1.0
        BananaImageView.startAnimating()
    }
    
    func setButtons(){
        let gameMap = bananaController.bananaGetMap()
        for j:Int in 0..<9{
            for i:Int in 0..<9{
                let b = UIButton()
                let xs = self.view.frame.size.width/2-17.5-140
                let ys = self.view.frame.size.height/2-17.5-140
                if(j%2 == 0){
                    b.frame = CGRect(x:xs+CGFloat(i*35),y:ys+CGFloat(j*35),width:35,height:35)
                }
                else{
                    b.frame = CGRect(x:xs+CGFloat(i*35)+17.5,y:ys+CGFloat(j*35),width:35,height:35)// indent before odd line
                }
                b.setImage(UIImage(named:"button1"),for:UIControlState())
                b.setTitle("\(j)"+"\(i)", for: UIControlState())        //set title to identify postion in game map
                self.view.addSubview(b)
                b.addTarget(self, action: #selector(DragonViewController.pressButton(_:)), for:.touchUpInside)
                
                if gameMap[j][i] == 0{
                    b.setImage(UIImage(named:"button2"), for: UIControlState())
                    b.setTitle("Pressed",for: UIControlState())
                }
                if j == 4 && i == 4{
                    b.isUserInteractionEnabled = false
                }
                buttons.append(b)
            }
        }

        
    }
    
    func pressButton(_ btn:UIButton){
        if btn.currentTitle != "Pressed"{
            let curX:Int? = Int(btn.currentTitle!)! / 10            //get button position in game map and set it to pressed
            let curY:Int? = Int(btn.currentTitle!)! % 10
            btn.setImage(UIImage(named:"button2"), for: UIControlState())
            btn.setTitle("Pressed",for: UIControlState())
            bananaController.setButton(curX: curX!,curY: curY!)
            BananaEscape()
        }

    }
    
    
    func BananaEscape(){
        let curPos = bananaController.bananaGetPos()
        
        for b in buttons{
            if b.currentTitle == "\(curPos[0])"+"\(curPos[1])"{
                b.isUserInteractionEnabled = true
            }// set banana postion disable
        }
        
        var esc = bananaController.getEscDirections()
        for b in buttons{
            if b.currentTitle == "\(esc[0])"+"\(esc[1])"{
                b.isUserInteractionEnabled = false
            }// set last banana postion enable
        }
        let xs = self.view.frame.size.width/2-17.5-140
        let ys = self.view.frame.size.height/2-17.5-140
        if(esc[0]%2 == 0){
            BananaImageView.frame = CGRect(x:xs+CGFloat(esc[1]*35),y:ys+CGFloat(esc[0]*35),width:35,height:35)
        }
        else{
            BananaImageView.frame = CGRect(x:xs+CGFloat(esc[1]*35)+17.5,y:ys+CGFloat(esc[0]*35),width:35,height:35)
        }
        
        if bananaController.doesBananaEscape(){
            showResult(win:0)
        }else if (bananaController.isBananaCaught() > 0){
            let count = bananaController.isBananaCaught()
            showResult(win: count)
        }
        
    }
    

    
    func showResult(win:Int){
        timer.invalidate()
        if (win > 0){
            let alert = UIAlertController(title: "You Win!!", message: "You saved the world in \(win)"+" Moves", preferredStyle: .alert)
            let actionYes = UIAlertAction(title: "Start Again", style: .default, handler: {act in self.resetGame(reset: true)})
            let actionNo = UIAlertAction(title: "Exit Game", style: .default, handler: {act in self.resetGame(reset:false)})
            alert.addAction(actionYes)
            alert.addAction(actionNo)
            self.present(alert, animated: true, completion: nil)

        }
        else{
            let alert = UIAlertController(title: "Wasted !!", message: "Banana screwed up the world", preferredStyle: .alert)
            let actionYes = UIAlertAction(title: "Try Again", style: .default, handler: {act in self.resetGame(reset: true)})
            let actionNo = UIAlertAction(title: "Exit Game", style: .default, handler: {act in self.resetGame(reset:false)})
            alert.addAction(actionYes)
            alert.addAction(actionNo)
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
