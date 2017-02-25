import UIKit

class MCalculatorFunctionsItemTan:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionTan")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemTan_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let currentString:String = modelKeyboard.lastString()
        let tanValue:Double = tan(currentValue)
        let tanString:String = modelKeyboard.numberAsString(scalar:tanValue)
        let descr:String = "rad tan(\(currentString)) = \(tanString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:tanString,
            descr:descr)
    }
}
