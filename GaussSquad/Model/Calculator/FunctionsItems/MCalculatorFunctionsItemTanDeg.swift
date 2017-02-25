import UIKit

class MCalculatorFunctionsItemTanDeg:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionTan")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemTanDeg_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let currentString:String = modelKeyboard.lastString()
        let tanDegValue:Double = tan(currentValue * M_PI / 180.0)
        let tanDegString:String = modelKeyboard.numberAsString(scalar:tanDegValue)
        let descr:String = "deg tan(\(currentString)) = \(tanDegString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:tanDegString,
            descr:descr)
    }
}
