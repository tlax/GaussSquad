import UIKit

class CCalculator:CController
{
    private weak var viewCalculator:VCalculator!
    
    override func loadView()
    {
        let viewCalculator:VCalculator = VCalculator(controller:self)
        self.viewCalculator = viewCalculator
        view = viewCalculator
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.hideBar(barHidden:true)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.hideBar(barHidden:false)
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
