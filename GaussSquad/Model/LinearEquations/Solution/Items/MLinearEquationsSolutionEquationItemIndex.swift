import UIKit

class MLinearEquationsSolutionEquationItemIndex:MLinearEquationsSolutionEquationItem
{
    private let kCellWidth:CGFloat = 45
    
    init()
    {
        let reusableIdentifier:String =  VLinearEquationsSolutionCellIndex.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
}
