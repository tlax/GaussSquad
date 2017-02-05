import Foundation

class MLinearEquationsIndeterminates
{
    let items:[MLinearEquationsIndeterminatesItem]
    
    init(polynomial:DPolynomial)
    {
        var items:[MLinearEquationsIndeterminatesItem] = []
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
            
            return
        }
        
        for indeterminate:DIndeterminate in indArray
        {
            let item:MLinearEquationsIndeterminatesItem = MLinearEquationsIndeterminatesItem(
                indeterminate:indeterminate)
            items.append(item)
        }
        
        self.items = items
    }
}
