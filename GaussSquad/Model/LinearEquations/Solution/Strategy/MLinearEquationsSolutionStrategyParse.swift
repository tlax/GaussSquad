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
    }
    
    //MARK: private
}
