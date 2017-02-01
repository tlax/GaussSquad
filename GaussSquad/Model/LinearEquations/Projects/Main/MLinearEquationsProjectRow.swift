import Foundation

class MLinearEquationsProjectRow
{
    let items:[MLinearEquationsProjectRowItem]
    private weak var equation:DEquation!
    
    init(
        equation:DEquation,
        rowIndex:Int)
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
        let itemIndex:MLinearEquationsProjectRowItemIndex = MLinearEquationsProjectRowItemIndex(
            polynomial:nil,
            index:rowIndex)
        items.append(itemIndex)
        
        for polynomial:DPolynomial in polynomials
        {
            let itemOperator:MLinearEquationsProjectRowItemOperator
            let itemPolynomial:MLinearEquationsProjectRowItemPolynomial
            
            if polynomial.isPositive
            {
                itemOperator = MLinearEquationsProjectRowItemOperatorAdd(
                    polynomial:polynomial,
                    column:items.count)
            }
            else
            {
                itemOperator = MLinearEquationsProjectRowItemOperatorSubstract(
                    polynomial:polynomial,
                    column:items.count)
            }
            
            items.append(itemOperator)
            
            if polynomial.showAsDivision
            {
                itemPolynomial = MLinearEquationsProjectRowItemPolynomialDivision(
                    polynomial:polynomial,
                    column:items.count)
            }
            else
            {
                itemPolynomial = MLinearEquationsProjectRowItemPolynomialDecimal(
                    polynomial:polynomial,
                    column:items.count)
            }
            
            items.append(itemPolynomial)
        }
        
        let itemNew:MLinearEquationsProjectRowItemNewPolynomial = MLinearEquationsProjectRowItemNewPolynomial(
            column:items.count)
        items.append(itemNew)
        
        self.items = items
    }
}
