//
//  ViewController.swift
//  SlotMachine
//
//  Created by Alex Paul on 4/19/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Properties
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    // in first container
    var titleLabel: UILabel!
    
    // in third container
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    // in fourth container
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    // slots array 
    var slots = [[Slot]]()
    
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    // Constants
    let kMarginForView: CGFloat = 10.0
    let kSixth: CGFloat = 1.0/6.0
    let kStatusBar: CGFloat = 20.0
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    let kThird: CGFloat = 1.0/3.0
    let kMarginForSlot: CGFloat = 2.0
    let kEighth: CGFloat = 1.0/8.0
    let kHalf: CGFloat = 1.0/2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupContainerView()
        
        // Setup Containers
        setupFirstContainer(self.firstContainer)
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        
        // Start new game
        hardReset()
    }
    
    func setupContainerView() {
        // First Container View
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView,
            y: self.view.bounds.origin.y,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        // Second Container View
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.firstContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        // Third Container View
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.firstContainer.frame.height + self.secondContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        // Fourth Container View
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
    }
    
    func setupFirstContainer(containerView: UIView){
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40.0)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
    }
    
    func setupSecondContainer(containerView: UIView){
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber{ // add 3 columns
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber{ // add 3 rows for each column
                var slotImageView = UIImageView() // create an instance of UIImageView
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
                
                var slot: Slot
                if slots.count != 0{
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    
                    slotImageView.image = slot.image
                    
                }else{
                    slotImageView.image = UIImage(named: "Ace")
                }
            }
        }
        
    }
    
    // MARK: Third Container 
    
    func setupThirdContainer(containerView: UIView){
        // Credits Label
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16.0)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        // Bet Label
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.sizeToFit()
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16.0)
        containerView.addSubview(self.betLabel)
        
        // Winner Paid Label 
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16.0)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        containerView.addSubview(self.winnerPaidLabel)
        
        // Credits Title Label
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditsTitleLabel)
        
        // Bet Title Label 
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLabel)
        
        // Winner Paid Title Label
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * 5 * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.winnerPaidTitleLabel)
    }
    
     // MARK: Fourth Conatainer
    
    func setupFourthContainer(containerView: UIView){
        
        // Reset Button
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.bounds.width * kEighth, y: containerView.bounds.height * kHalf)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetButton)
        
        // Bet One Button 
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.bounds.width * kEighth * 3, y: containerView.bounds.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betOneButton)
        
        // Bet Max Button 
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.bounds.width * kEighth * 5, y: containerView.bounds.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        // Spin Button
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.bounds.width * kEighth * 7, y: containerView.bounds.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
    }
    
    func resetButtonPressed(button: UIButton){
        hardReset()
    }
    
    func betOneButtonPressed(button: UIButton){
        if self.credits <= 0{
            showAlertWithText(header: "No more credits left", message: "Reset Game")
        }else{
            if currentBet < 5{
                currentBet += 1
                credits -= 1
                updateMainView()
            }else{
                showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
    }
    
    func betMaxButtonPressed(button: UIButton){
        if credits < 5{ // not enough credits to do the MAX bet of 5
            showAlertWithText(header: "Not enough credits", message: "Bet less")
        }else{
            if currentBet < 5{  // User can place the MAX bet of 5
                var creditsToBetMax = 5 - currentBet // e.g. 5 - 4 = 1
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
                
            }else{ // User is attempting to bet more than 5 credits
                showAlertWithText(message: "You can ONLY bet 5 credits at a time")
            }
        }
    }
    
    func spinButtonPressed(button: UIButton){
        // first remove all images from the slots
        removeSlotImageViews()
        
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
        
        // Compute Winnings 
        winnings = SlotBrain.computeWinnings(slots)
        
        updateMainView()
    }
    
    func removeSlotImageViews(){
        if self.secondContainer != nil{
            let container: UIView? = self.secondContainer // use optional here b/c there may be no views
            let subViews: Array? = container!.subviews
            
            for view in subViews!{ // unwrap subview
                view.removeFromSuperview() // remove the image from the superview
            }
        }
    }
    
    func hardReset(){
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true) // save the same amount of capacity (true)
        self.setupSecondContainer(self.secondContainer)
        self.currentBet = 0
        self.credits = 50
        self.winnings = 0
        
        updateMainView()
    }
    
    func updateMainView(){
        self.betLabel.text = "\(self.currentBet)"
        self.winnerPaidLabel.text = "\(self.winnings)"
        self.creditsLabel.text = "\(self.credits)"
    }
    
    // MARK: Alert
    func showAlertWithText(header: String = "Warning", message: String){
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

