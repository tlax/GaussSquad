import UIKit

class CLinearEquationsIndeterminateList:CController
{
    private weak var viewIndeterminate:VLinearEquationsIndeterminate!
    private weak var project:DProject!
    
    init(project:DProject)
    {
        self.project = project
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
}
