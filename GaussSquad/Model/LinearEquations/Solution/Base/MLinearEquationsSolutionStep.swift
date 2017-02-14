import UIKit

class MLinearEquationsSolutionStep:MLinearEquationsSolutionShareProtocol
{
    let equations:[MLinearEquationsSolutionEquation]
    let reusableIdentifier:String
    let headerHeight:CGFloat
    let plainItems:[MLinearEquationsSolutionEquationItem]
    private let kNewLine:String = "\n"
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        reusableIdentifier:String,
        headerHeight:CGFloat)
    {
        self.equations = equations
        self.reusableIdentifier = reusableIdentifier
        self.headerHeight = headerHeight
        
        var plainItems:[MLinearEquationsSolutionEquationItem] = []
        
        for equation:MLinearEquationsSolutionEquation in equations
        {
            plainItems.append(contentsOf:equation.plainItems)
        }
        
        self.plainItems = plainItems
    }
    
    //MARK: share protocol
    
    func shareText() -> String?
    {
        let mutableString:NSMutableString = NSMutableString()
        
        for equation:MLinearEquationsSolutionEquation in equations
        {
            guard
                
                let equationString:String = equation.shareText()
                
            else
            {
                continue
            }
            
            if mutableString.length > 0
            {
                mutableString.append(kNewLine)
            }
            
            mutableString.append(equationString)
        }
        
        let string:String = mutableString as String
        
        return string
    }
}
