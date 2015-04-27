//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Alex Paul on 4/26/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//
//
//  Reordering Slots into Rows

import Foundation

class SlotBrain {
    class func unpackSlotsIntoSlotRows(slots: [[Slot]]) -> [[Slot]]{
        var slotRow1 = [Slot]()
        var slotRow2 = [Slot]()
        var slotRow3 = [Slot]()
        
        for slotArray in slots{
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                
                switch(index){
                case 0:
                    slotRow1.append(slot)
                case 1:
                    slotRow2.append(slot)
                case 2:
                    slotRow3.append(slot)
                default:
                    println("Error")
                }
            }
        }
        var slotInRows = [slotRow1, slotRow2, slotRow3] // add the now modified columns to rows array to slotInRows array
        
        return slotInRows
    }
    
    class func computeWinnings(slots: [[Slot]]) -> Int{
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        
        var winnings = 0
        
        var flushWithCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        // function checks for the various (3) types of winnings
        
        for (index, slotRow) in enumerate(slotsInRows) {
            // 1. flush
            if checkFlush(slotRow) == true {
                println("Row \(index + 1) is a Flush")
                winnings++
                flushWithCount++
            }
            if flushWithCount == 3{
                println("Royal Flush")
                winnings += 15
            }
            
            // 2. threeOfAKind
            if checkThreeOfAKind(slotRow) == true{
                println("Row \(index + 1) has three of a kind")
                winnings += 10
                threeOfAKindWinCount++
            }
            if threeOfAKindWinCount == 3{
                println("Jackpot - 3 of a KIND")
                winnings += 50
            }
            
            // 3. straight
            if checkStraight(slotRow){
                println("Row \(index + 1) is straight")
                winnings++
                straightWinCount++
            }
            if straightWinCount == 3{
                println("Pretty Awesome = Straight")
                winnings += 25
            }
        }
        return winnings
    }
    
    class func checkFlush(slotRow: [Slot]) -> Bool{
        var redCount = 0, blackCount = 0
        var isFlush = false
        for slot in slotRow{
            if slot.isRed == true {redCount++}
            else if slot.isRed == false {blackCount++}
        }
        if blackCount == slotRow.count || redCount == slotRow.count{
            isFlush = true
        }
        return isFlush
    }
    
    class func checkThreeOfAKind(slotRow: [Slot]) -> Bool{
        var isThreeOfAKind = true
        var value = 0
        for (index, slot) in enumerate(slotRow) {
            if value != 0{
                if value != slot.value{
                    return false
                }
            }
            value = slot.value
        }
        return isThreeOfAKind
    }
    
    class func checkStraight(slotRow: [Slot]) -> Bool{
        var isStraight = true
        var previousValue = 0
        for (index, slot) in enumerate(slotRow){
            if previousValue != 0{
                if slot.value - previousValue != 1 {
                    return false
                }
            }
            previousValue = slot.value
        }
        return isStraight
    }
    
}
