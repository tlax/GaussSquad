import UIKit

class MLinearEquationsSolutionStepProcess:MLinearEquationsSolutionStep
{
    let descr:String
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
}
