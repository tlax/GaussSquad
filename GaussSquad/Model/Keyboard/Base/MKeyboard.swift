import UIKit

class MKeyboard
{
    var states:[MKeyboardState]
    let rows:[MKeyboardRow]
    let cols:Int
    let kEmpty:String = ""
    let kSign:String = "-"
    let kInitial:String = "0"
    let kDot:String = "."
    let kInfinitum:String = "∞"
    private let numberFormatter:NumberFormatter
    private let kMinIntegers:Int = 1
    private let kMaxIntegers:Int = 9
    private let kMinDecimals:Int = 0
    private let kMaxDecimals:Int = 9
    
    init(rows:[MKeyboardRow], states:[MKeyboardState]?)
    {
        self.rows = rows
        
        var cols:Int = 0
        
        for row:MKeyboardRow in rows
        {
            let rowItems:Int = row.items.count
            
            if rowItems > cols
            {
                cols = rowItems
            }
        }
        
        self.cols = cols
        
        if let states:[MKeyboardState] = states
        {
            self.states = states
        }
        else
        {
            let stateInitial:MKeyboardStatePlain = MKeyboardStatePlain(editing:kInitial)
            self.states = [stateInitial]
        }
        
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumIntegerDigits = kMaxIntegers
        numberFormatter.minimumFractionDigits = kMinDecimals
        numberFormatter.maximumFractionDigits = kMaxDecimals
    }
    
    //MARK: public
    
    func removeAllAfter(state:MKeyboardState) -> String
    {
        guard
        
            let lastState:MKeyboardState = states.popLast()
        
        else
        {
            let editing:String = state.editing
            
            return editing
        }
        
        if lastState === state
        {
            let editing:String
            
            if let previous:MKeyboardState = states.last
            {
                editing = previous.editing
            }
            else
            {
                editing = lastState.editing
            }
            
            states.append(lastState)
            
            return editing
        }
        else
        {
            let editing:String = removeAllAfter(state:state)
            
            return editing
        }
    }
    
    func lastString() -> String
    {
        guard
        
            let string:String = states.last?.editing
        
        else
        {
            return kInitial
        }
        
        return string
    }
    
    func lastNumber() -> Double
    {
        guard
            
            let string:String = states.last?.editing,
            let number:NSNumber = numberFormatter.number(
                from:string)
            
        else
        {
            return 0
        }
        
        let scalar:Double = number.doubleValue
        
        return scalar
    }
    
    func numberAsString(scalar:Double) -> String
    {
        let number:NSNumber = NSNumber(value:scalar)
        
        guard
        
            let string:String = numberFormatter.string(from:number)
        
        else
        {
            return kInitial
        }
        
        return string
    }
    
    func stringAsNumber(string:String) -> Double
    {
        guard
            
            let number:NSNumber = numberFormatter.number(
                from:string)
            
        else
        {
            return 0
        }
        
        let scalar:Double = number.doubleValue
        
        return scalar
    }
    
    func updateIfNeeded(view:UITextView)
    {
        guard
            
            let lastState:MKeyboardState = states.last
            
        else
        {
            return
        }
        
        if lastState.needsUpdate
        {
            lastState.needsUpdate = false
            view.text = lastState.editing
        }
    }
    
    func commitIfNeeded(view:UITextView)
    {
        guard
            
            let lastState:MKeyboardState = states.last
            
        else
        {
            return
        }
        
        if lastState.needsUpdate
        {
            states.removeLast()
        }
        else
        {
            lastState.commitState(
                model:self,
                view:view)
            
            NotificationCenter.default.post(
                name:Notification.keyboardUpdate,
                object:lastState)
        }
    }
}
