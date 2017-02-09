import UIKit

class CLinearEquationsSolution:CController
{
    private weak var viewSolution:VLinearEquationsSolution!
    
    override func loadView()
    {
        let viewSolution:VLinearEquationsSolution = VLinearEquationsSolution(
            controller:self)
        self.viewSolution = viewSolution
        view = viewSolution
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func plot()
    {
        
    }
}
