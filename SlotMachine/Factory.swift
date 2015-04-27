//
//  Factory.swift
//  SlotMachine
//
//  Created by Alex Paul on 4/24/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    // class function
    class func createSlots() -> [[Slot]] {
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        
        var slots = [[Slot]]() // slots = [[slot1, slot2, slot3], [slot4, slot5, slot6], [[slot7], [slot8],[slot9]]] - array of arrays
        
        for var numberOfContainer = 0; numberOfContainer < kNumberOfContainers; ++numberOfContainer{
            var slotArray: [Slot] = []
            for var numberOfSlot = 0; numberOfSlot < kNumberOfSlots; ++numberOfSlot{
                var slot = Factory.createSlot(slotArray) // create slot
                slotArray.append(slot)
            }
            slots.append(slotArray)
        }
        return slots
    }
    
    class func createSlot(currentCards: [Slot]) -> Slot{
        
        var currentCardValues = [Int]() // this empty array will contain card values from 1 to 13
        
        for slot in currentCards{
            currentCardValues.append(slot.value) // 1...13
        }
        
        var randomNumber = Int(arc4random_uniform(UInt32(13))) // generates a random number from 0 to 12
        while contains(currentCardValues, randomNumber + 1){ // generate a random number if already exist in the currendCardValues array
            randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
        
        var slot: Slot
        switch(randomNumber){
        case 0:
            slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
        case 1:
            slot = Slot(value: 2, image: UIImage(named: "Two"), isRed: true)
        case 2:
            slot = Slot(value: 3, image: UIImage(named: "Three"), isRed: true)
        case 3:
            slot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
        case 4:
            slot = Slot(value: 5, image: UIImage(named: "Five"), isRed: false)
        case 5:
            slot = Slot(value: 6, image: UIImage(named: "Six"), isRed: false)
        case 6:
            slot = Slot(value: 7, image: UIImage(named: "Seven"), isRed: true)
        case 7:
            slot = Slot(value: 8, image: UIImage(named: "Eight"), isRed: false)
        case 8:
            slot = Slot(value: 9, image: UIImage(named: "Nine"), isRed: false)
        case 9:
            slot = Slot(value: 10, image: UIImage(named: "Ten"), isRed: true)
        case 10:
            slot = Slot(value: 11, image: UIImage(named: "Jack"), isRed: false)
        case 11:
            slot = Slot(value: 12, image: UIImage(named: "Queen"), isRed: false)
        case 12:
            slot = Slot(value: 13, image: UIImage(named: "King"), isRed: true)
        default:
            slot = Slot(value: 0, image: UIImage(named: "Ace"), isRed: true)
        }
        return slot
    }
}


