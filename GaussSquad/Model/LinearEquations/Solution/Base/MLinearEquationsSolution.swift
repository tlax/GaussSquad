import Foundation

class MLinearEquationsSolution
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
}
