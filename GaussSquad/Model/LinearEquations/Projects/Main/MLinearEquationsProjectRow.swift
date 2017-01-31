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
        
        for polynomial:DPolynomial in polynomials
        {
            let itemOperator:MLinearEquationsProjectRowItemOperator
            let itemCoefficient:MLinearEquationsProjectRowItemCoefficient
            let itemIndeterminate:MLinearEquationsProjectRowItemIndeterminate
            
            if polynomial.isPositive
            {
                if items.isEmpty
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorPositive(
                        polynomial:polynomial,
                        column:items.count)
                }
                else
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorAdd(
                        polynomial:polynomial,
                        column:items.count)
                }
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
                itemCoefficient = MLinearEquationsProjectRowItemCoefficientDivision(
                    polynomial:polynomial,
                    column:items.count)
            }
            else
            {
                itemCoefficient = MLinearEquationsProjectRowItemCoefficientWhole(
                    polynomial:polynomial,
                    column:items.count)
            }
            
            items.append(itemCoefficient)
            
            let indeterminate:DIndeterminate? = polynomial.indeterminate
            
            if let indeterminate:DIndeterminate = indeterminate
            {
                if let symbol:String = indeterminate.symbol
                {
                    itemIndeterminate = MLinearEquationsProjectRowItemIndeterminateSymbol(
                        polynomial:polynomial,
                        symbol:symbol,
                        column:items.count)
                }
                else
                {
                    itemIndeterminate = MLinearEquationsProjectRowItemIndeterminateNone(
                        polynomial:polynomial,
                        column:items.count)
                }
            }
            else
            {
                itemIndeterminate = MLinearEquationsProjectRowItemIndeterminateNone(
                    polynomial:polynomial,
                    column:items.count)
            }
            
            items.append(itemIndeterminate)
        }
        
        self.items = items
    }
}
