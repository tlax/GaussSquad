import Foundation

class MLinearEquationsSolutionEquation
{
    let items:[MLinearEquationsSolutionEquationItem]
    let result:MLinearEquationsSolutionEquationItem
    let equals:MLinearEquationsSolutionEquationItemEquals
    
    init(
        items:[MLinearEquationsSolutionEquationItem],
        result:MLinearEquationsSolutionEquationItem)
    {
        self.items = items
        self.result = result
        equals = MLinearEquationsSolutionEquationItemEquals()
    }
}
