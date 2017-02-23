import UIKit

class MKeyboardRowItemNumeric:MKeyboardRowItem
{
    private let number:String
    
    init(number:String, icon:UIImage)
    {
        self.number = number
        super.init(icon:icon)
    }
    
    override func selected(
        model:MKeyboard,
        view:UITextView)
    {
        updateIfNeeded(model:model, view:view)
        
        let currentString:String = view.text
        let countCharacters:Int = currentString.characters.count
        
        if countCharacters < 3
        {
            let currentNumber:Double = model.lastNumber()
            
            if currentNumber == 0
            {
                if !currentString.contains(model.kDot)
                {
                    if currentString.contains(model.kSign)
                    {
                        view.text = model.kSign
                    }
                    else
                    {
                        view.text = model.kEmpty
                    }
                }
            }
        }
        
        view.insertText(number)
        model.states.last?.editing = view.text
    }
}
