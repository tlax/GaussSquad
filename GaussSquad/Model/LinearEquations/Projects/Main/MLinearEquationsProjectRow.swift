import Foundation

class MLinearEquationsProjectRow
{
    let items:[MLinearEquationsProjectRowItem]
    
    class func lastRow() -> MLinearEquationsProjectRow
    {
        let itemNewRow:MLinearEquationsProjectRowItemNewRow = MLinearEquationsProjectRowItemNewRow()
        let row:MLinearEquationsProjectRow = MLinearEquationsProjectRow(
            item:itemNewRow)
        
        return row
    }
    
    fileprivate class func polynomialItem(polynomial:DPolynomial) -> MLinearEquationsProjectRowItemPolynomial
    {
        let itemPolynomial:MLinearEquationsProjectRowItemPolynomial
        
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
        
        return itemPolynomial
    }
    
    init(equation:DEquation)
    {
        guard
            
            let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial],
            let result:DPolynomial = equation.result
        
        else
        {
            self.items = []
            
            return
        }
        
        var items:[MLinearEquationsProjectRowItem] = []
        let itemIndex:MLinearEquationsProjectRowItemIndex = MLinearEquationsProjectRowItemIndex()
        items.append(itemIndex)
        
        for polynomial:DPolynomial in polynomials
        {
            let itemPolynomial:MLinearEquationsProjectRowItemPolynomial = polynomialItem(
                polynomial:polynomial)
            items.append(itemPolynomial)
        }
        
        let itemEquals:MLinearEquationsProjectRowItemEquals = MLinearEquationsProjectRowItemEquals()
        items.append(itemEquals)
        
        let itemResult:MLinearEquationsProjectRowItemPolynomial = polynomialItem(
            polynomial:result)
        items.append(itemResult)
        
        let itemNew:MLinearEquationsProjectRowItemNewPolynomial = MLinearEquationsProjectRowItemNewPolynomial(
            equation:equation)
        items.append(itemNew)
        
        self.items = items
    }
    
    private init(item:MLinearEquationsProjectRowItem)
    {
        items = [
            item
        ]
    }
}
