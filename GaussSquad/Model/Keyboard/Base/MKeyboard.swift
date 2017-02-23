import Foundation

class MKeyboard
{
    var states:[MKeyboardState]
    let rows:[MKeyboardRow]
    let cols:Int
    
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
    }
}
