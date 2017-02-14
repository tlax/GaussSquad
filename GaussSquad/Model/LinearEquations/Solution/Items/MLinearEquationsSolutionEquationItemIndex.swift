import UIKit

class MLinearEquationsSolutionEquationItemIndex:MLinearEquationsSolutionEquationItem
{
    let index:Int
    private let kCellWidth:CGFloat = 45
    
    init(index:Int)
    {
        self.index = index
        let reusableIdentifier:String =  VLinearEquationsSolutionCellIndex.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
    
    override func shareText() -> String?
    {
        let string:String = "\(index):"
        
        return string
    }
}
