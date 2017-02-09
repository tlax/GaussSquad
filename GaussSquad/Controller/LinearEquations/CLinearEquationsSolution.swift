import UIKit

class CLinearEquationsSolution:CController
{
    let model:MLinearEquationsSolution
    private weak var viewSolution:VLinearEquationsSolution!
    
    init(project:DProject)
    {
        model = MLinearEquationsSolution(project:project)
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewSolution:VLinearEquationsSolution = VLinearEquationsSolution(
            controller:self)
        self.viewSolution = viewSolution
        view = viewSolution
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model.solve()
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func plot()
    {
        
    }
}
