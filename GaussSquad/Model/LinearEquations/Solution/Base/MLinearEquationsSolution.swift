import Foundation

class MLinearEquationsSolution:MLinearEquationsSolutionStrategyDelegate
{
    private weak var project:DProject?
    private weak var controller:CLinearEquationsSolution?
    private(set) var steps:[MLinearEquationsSolutionStep]
    private(set) var indeterminates:[MLinearEquationsSolutionIndeterminate]
    
    init(project:DProject)
    {
        self.project = project
        steps = []
        indeterminates = []
    }
    
    //MARK: public
    
    func solve(controller:CLinearEquationsSolution)
    {
        self.controller = controller
        let firstStrategy:MLinearEquationsSolutionStrategyParse = MLinearEquationsSolutionStrategyParse(
            project:project)
        firstStrategy.process(delegate:self)
    }
    
    //MARK: solutionsStrategy delegate
    
    func solutionStrategyCompleted(step:MLinearEquationsSolutionStep)
    {
        steps.append(step)
        
        let nextStrategy:MLinearEquationsSolutionStrategy? = MLinearEquationsSolutionStrategy.strategyFor(
            step:step)
        
        if let nextStrategy:MLinearEquationsSolutionStrategy = nextStrategy
        {
            nextStrategy.process(delegate:self)
        }
        else
        {
            controller?.solutionComplete()
        }
    }
    
    func solutionStrategyIndeterminates(indeterminates:[MLinearEquationsSolutionIndeterminate])
    {
        self.indeterminates.append(contentsOf:indeterminates)
    }
}
