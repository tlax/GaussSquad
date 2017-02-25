import UIKit

class CCalculatorOptions:CController
{
    weak var model:MCalculator!
    private weak var viewOptions:VCalculatorOptions!
    
    init(model:MCalculator)
    {
        self.model = model
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
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
    
    func selectOption(item:MCalculatorFunctions?)
    {
        model.currentFunction = item
        back()
    }
}
