import Foundation

class MLinearEquationsSolution:MLinearEquationsSolutionStrategyDelegate
{
    private weak var project:DProject?
    private weak var lastProcessedStep:MLinearEquationsSolutionStep?
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
    
    func solutionStrategyCompleted(step:MLinearEquationsSolutionStep)
    {
        steps.append(step)
    }
}
