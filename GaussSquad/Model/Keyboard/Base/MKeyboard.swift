import Foundation

class MKeyboard
{
    var states:[MKeyboardState]
    let rows:[MKeyboardRow]
    let cols:Int
    let kEmpty:String = ""
    let kSign:String = "-"
    let kInitial:String = "0"
    let kDot:String = "."
    private let numberFormatter:NumberFormatter
    
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
    }
    
    //MARK: public
    
    func lastString() -> String
    {
        guard
        
            let string:String = states.last?.editing
        
        else
        {
            return kEmpty
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
}
