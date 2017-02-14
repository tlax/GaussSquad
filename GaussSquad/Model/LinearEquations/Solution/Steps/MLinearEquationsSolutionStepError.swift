import UIKit

class MLinearEquationsSolutionStepError:MLinearEquationsSolutionStep
{
    let descr:String
    private let kHeaderHeight:CGFloat = 150
    
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
}
