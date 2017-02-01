import Foundation

class MLinearEquationsProjectRow
{
    let items:[MLinearEquationsProjectRowItem]
    private weak var equation:DEquation!
    
    private class func polynomialItems(polynomial:DPolynomial) -> [MLinearEquationsProjectRowItem]
    {
        var items:[MLinearEquationsProjectRowItem] = []
        let itemOperator:MLinearEquationsProjectRowItemOperator
        let itemPolynomial:MLinearEquationsProjectRowItemPolynomial
        
        if polynomial.isPositive
        {
            itemOperator = MLinearEquationsProjectRowItemOperatorAdd(
                polynomial:polynomial)
        }
        else
        {
            itemOperator = MLinearEquationsProjectRowItemOperatorSubstract(
                polynomial:polynomial)
        }
        
        items.append(itemOperator)
        
        if polynomial.showAsDivision
        {
            itemPolynomial = MLinearEquationsProjectRowItemPolynomialDivision(
                polynomial:polynomial)
        }
        else
        {
            itemPolynomial = MLinearEquationsProjectRowItemPolynomialDecimal(
                polynomial:polynomial)
        }
        
        items.append(itemPolynomial)
        
        return items
    }
    
    init(
        equation:DEquation,
        rowIndex:Int)
    {
        self.equation = equation
        
        guard
            
            let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial],
            let result:DPolynomial = equation.result
        
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
            let polynomialItems:[MLinearEquationsProjectRowItem] = MLinearEquationsProjectRow.polynomialItems(
                polynomial:polynomial)
            items.append(contentsOf:polynomialItems)
        }
        
        let itemEquals:MLinearEquationsProjectRowItemEquals = MLinearEquationsProjectRowItemEquals(
            polynomial: <#T##DPolynomial#>)
        
        let polynomialItems:[MLinearEquationsProjectRowItem] = MLinearEquationsProjectRow.polynomialItems(
            polynomial:result)
        items.append(contentsOf:polynomialItems)
        
        let itemNew:MLinearEquationsProjectRowItemNewPolynomial = MLinearEquationsProjectRowItemNewPolynomial()
        items.append(itemNew)
        
        self.items = items
    }
}
