import Foundation

class MLinearEquationsSolutionIndeterminates
{
    let items:[MLinearEquationsSolutionIndeterminatesItem]
    
    init(items:[MLinearEquationsSolutionIndeterminatesItem])
    {
        self.items = items
    }
    
    //MARK: public
    
    func indeterminateFor(rawIndeterminate:DIndeterminate) -> MLinearEquationsSolutionIndeterminatesItem?
    {
        for item:MLinearEquationsSolutionIndeterminatesItem in items
        {
            if item.equalsRawIndeterminate(
                rawIndetermianted:rawIndeterminate)
            {
                return item
            }
        }
        
        return nil
    }
}
