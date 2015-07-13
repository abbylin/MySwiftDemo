//
//  ViewController.swift
//  SwiftCounter
//
//  Created by Abby(Zhu) Lin on 15/1/22.
//  Copyright (c) 2015年 Zhu Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timeLabel : UILabel?
    var timeButtons : [UIButton]?
    var startStopButton : UIButton?
    var clearButton : UIButton?
    let timeButtonsInfo = [("1分", 60), ("3分", 180), ("5分", 300), ("秒", 1)]
    
    var remainingSeconds: Int = 0 {
        willSet(newSeconds){
            let mins = newSeconds / 60
            let seconds = newSeconds % 60
            self.timeLabel!.text = String(format: "%02d:%02d", mins, seconds)
        }
    }
    
    var timer: NSTimer?
    
    var isCounting: Bool = false{
        willSet(newValue){
            if newValue {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
            setSettingButtonsEnabled(!newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupTimeLabel()
        setuptimeButtons()
        setupActionButtons()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        timeLabel!.frame = CGRectMake(10, 40, self.view.bounds.size.width-20, 120)
        let gap = (self.view.bounds.size.width - 10*2 - (CGFloat(timeButtons!.count)*64))/CGFloat(timeButtons!.count-1)
        for (index, button) in enumerate(timeButtons!)
        {
            let buttonLeft = 10 + (64 + gap) * CGFloat(index)
            button.frame = CGRectMake(buttonLeft, self.view.bounds.size.height - 120, 64, 44)
        }
        
        startStopButton!.frame = CGRectMake(10, self.view.bounds.size.height - 60, self.view.bounds.size.width - 20 - 100, 44)
        clearButton!.frame = CGRectMake(10+self.view.bounds.size.width - 20 - 100 + 20, self.view.bounds.size.height - 60, 80, 44                                               )
    }
    
    func setupTimeLabel() {
        timeLabel = UILabel();
        timeLabel!.text = "00:00"
        timeLabel!.textColor = UIColor.whiteColor()
        timeLabel!.font = UIFont(name: "Helvetica", size: 80)
        timeLabel!.backgroundColor = UIColor.blackColor()
        timeLabel!.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(timeLabel!)
    }

    func setuptimeButtons(){
        
        var buttons = [UIButton]()
        for (index, (title, _)) in enumerate(timeButtonsInfo){
            
            let button: UIButton = UIButton()
            button.tag = index
            button.setTitle("\(title)", forState: UIControlState.Normal)
            
            button.backgroundColor = UIColor.orangeColor()
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            button.addTarget(self, action: "timeButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            
            buttons += [button]
            self.view.addSubview(button)
        }
        timeButtons = buttons
    }
    
    func setupActionButtons() {
        startStopButton = UIButton()
        startStopButton!.backgroundColor = UIColor.redColor()
        startStopButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startStopButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        startStopButton!.setTitle("启动/停止", forState: UIControlState.Normal)
        startStopButton!.addTarget(self, action: "startStopButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startStopButton!)
        
        clearButton = UIButton()
        clearButton!.backgroundColor = UIColor.redColor()
        clearButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        clearButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        clearButton!.setTitle("复位", forState: UIControlState.Normal);
        clearButton!.addTarget(self, action: "clearButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(clearButton!)
    }
    
    func startStopButtonTapped(sender: UIButton){
        isCounting = !isCounting
        
        if isCounting {
            createFireLocalNotificationAfterSeconds(remainingSeconds)
        }else{
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
    }
    
    func clearButtonTapped(sender: UIButton)
    {
        remainingSeconds = 0
    }
    
    func timeButtonTapped(sender: UIButton)
    {
        let (_, seconds) = timeButtonsInfo[sender.tag]
        remainingSeconds += seconds
    }
    
    func updateTimer(timer: NSTimer)
    {
        if remainingSeconds <= 0
        {
            self.isCounting = false
            self.timeLabel!.text = "00:00"
            self.remainingSeconds = 0
            
            let alert = UIAlertView()
            alert.title = "计时完成！"
            alert.message = ""
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        
        remainingSeconds -= 1
        
    }
    
    func setSettingButtonsEnabled(enabled: Bool)
    {
        for button in self.timeButtons!
        {
            button.enabled = enabled
            button.alpha = enabled ? 1.0 : 0.3
        }
        clearButton!.enabled = enabled
        clearButton!.alpha = enabled ? 1.0 : 0.3
    }
    
    func createFireLocalNotificationAfterSeconds(seconds: Int)
    {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let notification = UILocalNotification()
        
        let timeIntervalSinceNow = NSNumber(integer: seconds).doubleValue
        notification.fireDate = NSDate(timeIntervalSinceNow: timeIntervalSinceNow)
        
        notification.timeZone = NSTimeZone.systemTimeZone()
        notification.alertBody = "计时完成！"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        let notification2 = UILocalNotification()
        let timeIntervalSinceNow2 = NSNumber(integer: seconds*2).doubleValue
        notification2.fireDate = NSDate(timeIntervalSinceNow: timeIntervalSinceNow2)
        notification2.timeZone = NSTimeZone.systemTimeZone()
        notification2.alertBody = "第二时段！"
        notification2.soundName = "Tock.aiff"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        UIApplication.sharedApplication().scheduleLocalNotification(notification2)
    }

}

