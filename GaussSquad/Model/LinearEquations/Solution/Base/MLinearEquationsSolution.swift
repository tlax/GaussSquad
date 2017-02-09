import Foundation

class MLinearEquationsSolution:MLinearEquationsSolutionStrategyDelegate
{
    private weak var project:DProject?
    private(set) var steps:[MLinearEquationsSolutionStep]
    private(set) var indeterminates:[MLinearEquationsSolutionIndeterminate]
    
    init(project:DProject)
    {
        self.project = project
        steps = []
        indeterminates = []
    }
    
    //MARK: public
    
    func solve()
    {
        
    }
    
    //MARK: solutionsStrategy delegate
    
    func solutionStrategyDone(equations: [MLinearEquationsSolutionEquation])
    {
        
    }
    
    func solutionStrategyError(error: String)
    {
        
    }
}
