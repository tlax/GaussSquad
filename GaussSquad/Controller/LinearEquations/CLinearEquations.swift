import UIKit

class CLinearEquations:CController
{
    private weak var viewLinearEquations:VLinearEquations!
    
    override func loadView()
    {
        let viewLinearEquations:VLinearEquations = VLinearEquations(controller:self)
        self.viewLinearEquations = viewLinearEquations
        view = viewLinearEquations
    }
}
