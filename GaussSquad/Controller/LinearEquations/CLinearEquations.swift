import UIKit

class CLinearEquations:CController
{
    var model:MLinearEquations?
    private weak var viewLinearEquations:VLinearEquations!
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        model = MLinearEquations(controller:self)
    }
    
    override func loadView()
    {
        let viewLinearEquations:VLinearEquations = VLinearEquations(controller:self)
        self.viewLinearEquations = viewLinearEquations
        view = viewLinearEquations
    }
    
    //MARK: public
    
    func modelLoaded()
    {
        viewLinearEquations.refresh()
    }
}
