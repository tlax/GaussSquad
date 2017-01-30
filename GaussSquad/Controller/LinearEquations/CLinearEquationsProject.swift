import UIKit

class CLinearEquationsProject:CController
{
    var model:DProject?
    
    override init()
    {
        super.init()
    }
    
    init(model:DProject)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func loadView()
    {
        
    }
}
