import UIKit

class MLinearEquationsSolutionStepError:MLinearEquationsSolutionStep
{
    let descr:String
    private let kHeaderHeight:CGFloat = 150
    private let kNewLine:String = "\n"
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        descr:String)
    {
        self.descr = descr
        let reusableIdentifier:String = VLinearEquationsSolutionHeaderError.reusableIdentifier
        
        super.init(
            equations:equations,
            reusableIdentifier:reusableIdentifier,
            headerHeight:kHeaderHeight)
    }
    
    override func shareText() -> String?
    {
        let title:String = NSLocalizedString("VLinearEquationsSolutionHeaderError_title", comment:"")
        
        let mutableString:NSMutableString = NSMutableString()
        mutableString.append(title)
        mutableString.append(kNewLine)
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
