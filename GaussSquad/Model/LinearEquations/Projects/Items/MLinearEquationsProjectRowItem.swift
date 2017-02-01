import UIKit

class MLinearEquationsProjectRowItem
{
    let cellWidth:CGFloat
    let reusableIdentifier:String
    private(set) weak var polynomial:DPolynomial?
    
    init(
        polynomial:DPolynomial?,
        cellWidth:CGFloat,
        reusableIdentifier:String)
    {
        self.polynomial = polynomial
        self.cellWidth = cellWidth
        self.reusableIdentifier = reusableIdentifier
    }
    
    //MARK: public
    
    func selected(controller:CLinearEquationsProject)
    {
    }
}
