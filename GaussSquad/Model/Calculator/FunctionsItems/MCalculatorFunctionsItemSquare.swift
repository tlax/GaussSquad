import UIKit

class MCalculatorFunctionsItemSquare:MCalculatorFunctionsItem
{
    private let kExponent:Double = 2
    
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionSquareRoot")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemSquare_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func processFunction(
        currentValue:Double,
        currentString:String,
        modelKeyboard:MKeyboard,
        view:UITextView)
    {
        let sqValue:Double = pow(currentValue, kExponent)
        let sqString:String = modelKeyboard.numberAsString(scalar:sqValue)
        let descr:String = "square (\(currentString)) = \(sqString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:sqString,
            descr:descr)
    }
}
