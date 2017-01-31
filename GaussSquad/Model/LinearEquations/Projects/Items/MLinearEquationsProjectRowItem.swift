import UIKit

class MLinearEquationsProjectRowItem
{
    let cellWidth:CGFloat
    let reusableIdentifier:String
    let column:Int
    private(set) weak var polynomial:DPolynomial?
    
    init(
        polynomial:DPolynomial?,
        cellWidth:CGFloat,
        reusableIdentifier:String,
        column:Int)
    {
        self.polynomial = polynomial
        self.cellWidth = cellWidth
        self.reusableIdentifier = reusableIdentifier
        self.column = column
    }
    
    //MARK: public
    
    func selected(controller:CLinearEquationsProject)
    {
    }
}
