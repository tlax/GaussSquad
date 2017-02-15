import UIKit

class MLinearEquationsSolutionStepStart:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 60
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        super.init(
            equations:equations,
            headerHeight:kHeaderHeight)
    }
    
    override func shareText() -> String?
    {
        let title:String = NSLocalizedString("VLinearEquationsSolutionHeaderStart_label", comment:"")
        
        let mutableString:NSMutableString = NSMutableString()
        mutableString.append(title)
        mutableString.append(kNewLine)
        
        if let parentText:String = super.shareText()
        {
            mutableString.append(parentText)
        }
        
        let string:String = mutableString as String
        
        return string
    }
}
