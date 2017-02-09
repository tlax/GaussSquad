import Foundation

class MLinearEquationsSolutionStrategyParse:MLinearEquationsSolutionStrategy
{
    private weak var project:DProject?
    
    init(project:DProject?)
    {
        super.init(step:nil)
        self.project = project
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        findIndeterminates()
    }
    
    //MARK: private
    
    private func findIndeterminates()
    {
        var indeterminates:[MLinearEquationsSolutionIndeterminate] = []
        
        if let rawIndeterminates:[DIndeterminate] = self.project?.indeterminates?.array as? [DIndeterminate]
        {
            for rawIndeterminate:DIndeterminate in rawIndeterminates
            {
                let indeterminate:MLinearEquationsSolutionIndeterminate = MLinearEquationsSolutionIndeterminate(
                    indeterminate:rawIndeterminate)
                indeterminates.append(indeterminate)
            }
        }
        
        foundIndeterminates(
            indeterminates:indeterminates)
        
        findEquations(indeterminates:indeterminates)
    }
    
    private func findEquations(indeterminates:[MLinearEquationsSolutionIndeterminate])
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        
        let step:MLinearEquationsSolutionStepStart = MLinearEquationsSolutionStepStart(
            equations:equations)
        completed(step:step)
    }
}
