import UIKit

class MLinearEquationsSolutionEquationItemEquals:MLinearEquationsSolutionEquationItem
{
    private let kCellWidth:CGFloat = 20
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
