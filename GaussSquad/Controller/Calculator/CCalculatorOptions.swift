import UIKit

class CCalculatorOptions:CController
{
    private weak var viewOptions:VCalculatorOptions!
    
    override func loadView()
    {
        let viewOptions:VCalculatorOptions = VCalculatorOptions(
            controller:self)
        self.viewOptions = viewOptions
        view = viewOptions
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewOptions.viewAppeared()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
}
