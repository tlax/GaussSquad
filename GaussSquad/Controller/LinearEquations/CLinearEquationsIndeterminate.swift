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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewIndeterminate.startEdition()
    }
    
    //MARK: public
    
    func cancel()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        viewIndeterminate.endEdition()
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func save()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
}
