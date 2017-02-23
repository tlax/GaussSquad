import Foundation

class MKeyboard
{
    var states:[MKeyboardState]
    let rows:[MKeyboardRow]
    let cols:Int
    private let numberFormatter:NumberFormatter
    private let kEmpty:String = ""
    
    init(rows:[MKeyboardRow])
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
        
        let stateInitial:MKeyboardStateInitial = MKeyboardStateInitial()
        states = [stateInitial]
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
