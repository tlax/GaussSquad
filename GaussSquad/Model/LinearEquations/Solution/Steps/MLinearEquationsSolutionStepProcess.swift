import UIKit

class MLinearEquationsSolutionStepProcess:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 70
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        descr:String)
    {
        self.descr = descr
        let reusableIdentifier:String = VLinearEquationsSolutionHeaderProcess.reusableIdentifier
        
        super.init(
            equations:equations,
            reusableIdentifier:reusableIdentifier,
            headerHeight:kHeaderHeight)
    }
    
    override func shareText() -> String?
    {
        let mutableString:NSMutableString = NSMutableString()
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
