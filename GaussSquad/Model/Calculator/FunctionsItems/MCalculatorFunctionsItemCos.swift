import UIKit

class MCalculatorFunctionsItemCos:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionCos")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemCos_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let currentString:String = modelKeyboard.lastString()
        let cosValue:Double = cos(currentValue)
        let cosString:String = modelKeyboard.numberAsString(scalar:cosValue)
        let descr:String = "rad cos(\(currentString)) = \(cosString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:cosString,
            descr:descr)
    }
}
