import UIKit

class MCalculatorFunctionsItemSinDeg:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionSin")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemSinDeg_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let currentString:String = modelKeyboard.lastString()
        let sinDegValue:Double = sin(currentValue * M_PI / 180.0)
        let sinDegString:String = modelKeyboard.numberAsString(scalar:sinDegValue)
        let descr:String = "deg sin(\(currentString)) = \(sinDegString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:sinDegString,
            descr:descr)
    }
}
