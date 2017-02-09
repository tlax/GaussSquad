import UIKit

class MLinearEquationsSolutionStep
{
    let equations:[MLinearEquationsSolutionEquation]
    let reusableIdentifier:String
    let headerHeight:CGFloat
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        reusableIdentifier:String,
        headerHeight:CGFloat)
    {
        self.equations = equations
        self.reusableIdentifier = reusableIdentifier
        self.headerHeight = headerHeight
    }
}
