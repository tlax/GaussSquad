import UIKit

class MLinearEquationsSolutionStep
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
            plainItems.append(contentsOf:equation.items)
            plainItems.append(equation.equals)
            plainItems.append(equation.result)
        }
        
        self.plainItems = plainItems
    }
}
