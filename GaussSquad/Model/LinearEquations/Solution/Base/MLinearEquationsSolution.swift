import Foundation

class MLinearEquationsSolution
{
    private weak var project:DProject?
    private(set) var steps:[MLinearEquationsSolutionStep]
    
    init(project:DProject)
    {
        self.project = project
        steps = []
    }
    
    //MARK: public
    
    func solve()
    {
        
    }
}
