import UIKit

class MLinearEquationsSolutionEquationItemEquals:MLinearEquationsSolutionEquationItem
{
    private let kCellWidth:CGFloat = 40
    
    init()
    {
        let reusableIdentifier:String =  VLinearEquationsSolutionCellEquals.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
}
