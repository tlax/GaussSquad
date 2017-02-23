import Foundation

class MKeyboardState
{
    var editingNumber:Double
    var editingString:String
    let number:Double
    private let numberFormatter:NumberFormatter
    private let kEmpty:String = ""
    private let kMinFraction:Int = 0
    private let kMaxFraction:Int = 10
    private let kMinIntegers:Int = 1
    private let kMaxIntegers:Int = 10
    
    init(number:Double)
    {
        self.number = number
        editingNumber = 0
        editingString = kEmpty
        
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = kMinFraction
        numberFormatter.maximumFractionDigits = kMaxFraction
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumFractionDigits = kMaxFraction
        
        updateEditing(editingNumber:number)
    }
    
    //MARK: public
    
    func updateEditing(editingNumber:Double)
    {
        self.editingNumber = editingNumber
        
        let editingAsNumber:NSNumber = NSNumber(value:editingNumber)
        
        guard
        
            let editingString:String = numberFormatter.string(
                from:editingAsNumber)
        
        else
        {
            self.editingString = kEmpty
            
            return
        }
        
        self.editingString = editingString
    }
}
