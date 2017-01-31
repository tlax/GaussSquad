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
            let itemCoefficient:MLinearEquationsProjectRowItemCoefficient
            let itemIndeterminate:MLinearEquationsProjectRowItemIndeterminate
            let currentItems:Int = items.count
            
            if polynomial.isPositive
            {
                if currentItems == 1
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorPositive(
                        polynomial:polynomial,
                        column:currentItems)
                }
                else
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorAdd(
                        polynomial:polynomial,
                        column:currentItems)
                }
            }
            else
            {
                itemOperator = MLinearEquationsProjectRowItemOperatorSubstract(
                    polynomial:polynomial,
                    column:currentItems)
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
