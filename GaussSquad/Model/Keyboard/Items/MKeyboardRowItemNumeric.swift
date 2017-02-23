import UIKit

class MKeyboardRowItemNumeric:MKeyboardRowItem
{
    private let number:String
    private let kEmpty:String = ""
    
    init(number:String, icon:UIImage)
    {
        self.number = number
        super.init(icon:icon)
    }
    
    override func selected(
        model:MKeyboard,
        view:UITextView)
    {
        let currentNumber:Double = model.lastNumber()
        
        if currentNumber == 0
        {
            view.text = kEmpty
        }
        
        view.insertText(number)
        model.states.last?.editing = view.text
    }
}
