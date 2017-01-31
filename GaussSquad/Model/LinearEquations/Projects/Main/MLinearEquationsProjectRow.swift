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
                        column:items.count)
                }
                else
                {
                    itemOperator = MLinearEquationsProjectRowItemOperatorAdd(
                        column:items.count)
                }
            }
            else
            {
                itemOperator = MLinearEquationsProjectRowItemOperatorSubstract(
                    column:items.count)
            }
            
            items.append(itemOperator)
            
            let coefficientDividend:Double = polynomial.coefficientDividend
            let coefficientDivisor:Double = polynomial.coefficientDivisor
            
            if polynomial.showAsDivision
            {
                itemCoefficient = MLinearEquationsProjectRowItemCoefficientDivision(
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor,
                    column:items.count)
            }
            else
            {
                itemCoefficient = MLinearEquationsProjectRowItemCoefficientWhole(
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor,
                    column:items.count)
            }
            
            items.append(itemCoefficient)
            
            let indeterminate:DIndeterminate? = polynomial.indeterminate
            
            if let indeterminate:DIndeterminate = indeterminate
            {
                if let symbol:String = indeterminate.symbol
                {
                    itemIndeterminate = MLinearEquationsProjectRowItemIndeterminateSymbol(
                        symbol:symbol,
                        column:items.count)
                }
                else
                {
                    itemIndeterminate = MLinearEquationsProjectRowItemIndeterminateNone(
                        column:items.count)
                }
            }
            else
            {
                itemIndeterminate = MLinearEquationsProjectRowItemIndeterminateNone(
                    column:items.count)
            }
        }
        
        self.items = items
    }
}
