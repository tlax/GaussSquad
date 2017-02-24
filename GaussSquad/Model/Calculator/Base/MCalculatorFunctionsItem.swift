import UIKit

class MCalculatorFunctionsItem
{
    let icon:UIImage
    let title:String
    
    init(icon:UIImage, title:String)
    {
        self.icon = icon
        self.title = title
    }
    
    //MARK: public
    
    func selected(controller:CCalculator)
    {
        let textView:UITextView = controller.viewCalculator.viewText
        
        guard
        
            let keyboard:VKeyboard = textView.inputView as? VKeyboard
        
        else
        {
            return
        }
        
        applyTo(
            modelKeyboard:keyboard.model,
            view:textView)
    }
    
    func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
    }
}
