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
        viewCalculator.viewAppeared()
    }
    
    //MARK: public
    
    func back()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        parentController.hideBar(barHidden:false)
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
