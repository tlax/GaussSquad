import Foundation

class MLinearEquationsSolutionEquation
{
    let items:[MLinearEquationsSolutionEquationItem]
    let result:MLinearEquationsSolutionEquationItem
    
    init(
        items:[MLinearEquationsSolutionEquationItem],
        result:MLinearEquationsSolutionEquationItem)
    {
        self.items = items
        self.result = result
    }
}
