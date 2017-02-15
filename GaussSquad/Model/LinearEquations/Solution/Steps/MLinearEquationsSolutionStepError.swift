import UIKit

class MLinearEquationsSolutionStepError:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 80
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        descr:String)
    {
        super.init(
            equations:equations,
            headerHeight:kHeaderHeight)
    }
    
    override func shareText() -> String?
    {
        let title:String = NSLocalizedString("VLinearEquationsSolutionHeaderError_title", comment:"")
        
        let mutableString:NSMutableString = NSMutableString()
        mutableString.append(title)
        mutableString.append(descr)
        mutableString.append(kNewLine)
        
        if let parentText:String = super.shareText()
        {
            mutableString.append(parentText)
        }
        
        let string:String = mutableString as String
        
        return string
    }
}
