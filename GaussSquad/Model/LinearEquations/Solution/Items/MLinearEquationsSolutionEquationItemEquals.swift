import UIKit

class MLinearEquationsSolutionEquationItemEquals:MLinearEquationsSolutionEquationItem
{
    private let kCellWidth:CGFloat = 40
    private let kEquals:String = "="
    
    init()
    {
        let reusableIdentifier:String =  VLinearEquationsSolutionCellEquals.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
    
    override func shareText() -> String?
    {
        return kEquals
    }
}
