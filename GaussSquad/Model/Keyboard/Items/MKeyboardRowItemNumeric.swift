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
        let currentString:String = view.text
        let countCharacters:Int = currentString.characters.count
        
        if countCharacters < 3
        {
            let currentNumber:Double = model.lastNumber()
            
            if currentNumber == 0
            {
                if currentString.contains(kSign)
                {
                    view.text = kSign
                }
                else
                {
                    view.text = kEmpty
                }
            }
        }
        
        view.insertText(number)
        model.states.last?.editing = view.text
    }
}
