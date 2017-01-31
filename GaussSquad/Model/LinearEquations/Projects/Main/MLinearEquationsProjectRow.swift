import Foundation

class MLinearEquationsProjectRow
{
    let items:[MLinearEquationsProjectRowItem]
    private weak var equation:DEquation!
    
    init(equation:DEquation)
    {
        self.equation = equation
        
        guard
            
            let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial]
        
        else
        {
            self.items = []
            
            return
        }
        
        var items:[MLinearEquationsProjectRowItem] = []
        var column:Int = 0
        
        for polynomial:DPolynomial in polynomials
        {
            let itemOperator:MLinearEquationsProjectRowItemOperator
            
            if polynomial.isPositive
            {
                if items.isEmpty
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorPositive(
                        column:column)
                }
                else
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorAdd(
                        column:column)
                }
            }
            else
            {
                itemOperator = MLinearEquationsProjectRowItemOperatorSubstract(
                    column:column)
            }
            
            items.append(itemOperator)
            column += 1
        }
        
        self.items = items
    }
}
