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
            let initialItems:Int = items.count
            let itemOperator:MLinearEquationsProjectRowItemOperator
            let itemPolynomial:MLinearEquationsProjectRowItemPolynomial
            
            if polynomial.isPositive
            {
                if initialItems == 1
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorPositive(
                        polynomial:polynomial,
                        column:initialItems)
                }
                else
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorAdd(
                        polynomial:polynomial,
                        column:initialItems)
                }
            }
            else
            {
                itemOperator = MLinearEquationsProjectRowItemOperatorSubstract(
                    polynomial:polynomial,
                    column:initialItems)
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
        
        self.items = items
    }
}
