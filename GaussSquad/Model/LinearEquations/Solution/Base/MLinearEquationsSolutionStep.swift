import UIKit

class MLinearEquationsSolutionStep:MLinearEquationsSolutionShareProtocol
{
    let equations:[MLinearEquationsSolutionEquation]
    let reusableIdentifier:String
    let headerHeight:CGFloat
    let plainItems:[MLinearEquationsSolutionEquationItem]
    
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
        return "hello world"
    }
    
    func shareImage() -> UIImage?
    {
        return nil
    }
}
