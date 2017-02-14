import UIKit

class MLinearEquationsProjectRowItemNewPolynomial:MLinearEquationsProjectRowItem
{
    private weak var equation:DEquation?
    private let kCellWidth:CGFloat = 60
    
    init(equation:DEquation)
    {
        self.equation = equation
        let reusableIdentifier:String = VLinearEquationsProjectCellNewPolynomial.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(
        controller:CLinearEquationsProject,
        index:IndexPath)
    {
        guard
            
            let equation:DEquation = self.equation
        
        else
        {
            return
        }
        
        controller.model.createPolynomial(equation:equation)
    }
}
