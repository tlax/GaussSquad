import UIKit

class CLinearEquationsProject:CController
{
    var model:DProject?
    private weak var viewProject:VLinearEquationsProject!
    
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
        let viewProject:VLinearEquationsProject = VLinearEquationsProject(controller:self)
        self.viewProject = viewProject
        view = viewProject
    }
    
    //MARK: public
    
    func next()
    {
        
    }
    
    func save()
    {
        
    }
    
    func delete()
    {
        
    }
}
