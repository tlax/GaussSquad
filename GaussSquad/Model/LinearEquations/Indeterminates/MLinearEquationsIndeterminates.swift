import Foundation

class MLinearEquationsIndeterminates
{
    weak var polynomial:DPolynomial?
    let items:[MLinearEquationsIndeterminatesItem]
    let selected:Int?
    
    init(polynomial:DPolynomial)
    {
        self.polynomial = polynomial
        var items:[MLinearEquationsIndeterminatesItem] = []
        var selected:Int?
        let current:DIndeterminate? = polynomial.indeterminate
        let indeterminates:[DIndeterminate]?
        
        if let equationPolynomial:DEquation = polynomial.equationPolynomials
        {
            indeterminates = equationPolynomial.project?.indeterminates?.array as? [DIndeterminate]
        }
        else if let equationResult:DEquation = polynomial.equationResult
        {
            indeterminates = equationResult.project?.indeterminates?.array as? [DIndeterminate]
        }
        else
        {
            indeterminates = nil
        }
        
        guard
            
            let indArray:[DIndeterminate] = indeterminates
        
        else
        {
            self.items = items
            self.selected = selected
            
            return
        }
        
        let countIndeterminates:Int = indArray.count
        
        for indeterminateIndex:Int in 0 ..< countIndeterminates
        {
            let indeterminate:DIndeterminate = indArray[indeterminateIndex]
            let item:MLinearEquationsIndeterminatesItem = MLinearEquationsIndeterminatesItem(
                indeterminate:indeterminate)
            items.append(item)
            
            if indeterminate === current
            {
                selected = indeterminateIndex
            }
        }
        
        self.items = items
        self.selected = selected
    }
}
