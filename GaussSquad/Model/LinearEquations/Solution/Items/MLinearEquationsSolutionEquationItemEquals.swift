import UIKit

class MLinearEquationsSolutionEquationItemEquals:MLinearEquationsSolutionEquationItem
{
    private let kCellWidth:CGFloat = 30
    
    init()
    {
        let reusableIdentifier:String =  VLinearEquationsSolutionCellEquals.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
}
