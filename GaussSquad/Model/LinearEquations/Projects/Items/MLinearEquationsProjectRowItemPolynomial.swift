import UIKit

class MLinearEquationsProjectRowItemPolynomial:MLinearEquationsProjectRowItem
{
    private(set) weak var polynomial:DPolynomial?
    
    init(polynomial:DPolynomial,
         cellWidth:CGFloat,
         reusableIdentifier:String)
    {
        self.polynomial = polynomial
        
        super.init(
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        guard
            
            let polynomial:DPolynomial = self.polynomial
        
        else
        {
            return
        }
        
        controller.editPolynomial(polynomial:polynomial)
    }
}
