import UIKit

class CLinearEquationsIndeterminate:CController
{
    private weak var viewIndeterminate:VLinearEquationsIndeterminate!
    private weak var model:MLinearEquationsProject!
    
    init(model:MLinearEquationsProject)
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
        let viewIndeterminate:VLinearEquationsIndeterminate = VLinearEquationsIndeterminate(
            controller:self)
        self.viewIndeterminate = viewIndeterminate
        view = viewIndeterminate
    }
    
    //MARK: public
    
    func cancel()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func save()
    {
        
    }
}
