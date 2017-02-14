import UIKit

class MLinearEquationsSolutionStepDone:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 100
    private let kNewLine:String = "\n"
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        let reusableIdentifier:String = VLinearEquationsSolutionHeaderDone.reusableIdentifier
        
        super.init(
            equations:equations,
            reusableIdentifier:reusableIdentifier,
            headerHeight:kHeaderHeight)
    }
    
    override func shareText() -> String?
    {
        let title:String = NSLocalizedString("VLinearEquationsSolutionHeaderDone_title", comment:"")
        let subtitle:String = NSLocalizedString("VLinearEquationsSolutionHeaderDone_subtitle", comment:"")
        
        let mutableString:NSMutableString = NSMutableString()
        mutableString.append(title)
        mutableString.append(subtitle)
        mutableString.append(kNewLine)
        
        if let parentText:String = super.shareText()
        {
            mutableString.append(parentText)
        }
        
        let string:String = mutableString as String
        
        return string
    }
}
