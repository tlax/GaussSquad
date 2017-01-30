import UIKit

class CLinearEquations:CController
{
    var model:MLinearEquations?
    private weak var viewLinearEquations:VLinearEquations!
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewLinearEquations.modelLoading()
        model = MLinearEquations(controller:self)
    }
    
    override func loadView()
    {
        let viewLinearEquations:VLinearEquations = VLinearEquations(controller:self)
        self.viewLinearEquations = viewLinearEquations
        view = viewLinearEquations
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func add()
    {
        selectedProject(project:nil)
    }
    
    func modelLoaded()
    {
        viewLinearEquations.refresh()
    }
    
    func selectedProject(project:DProject?)
    {
        let controller:CLinearEquationsProject = CLinearEquationsProject(
            project:project)
        parentController.push(
            controller:controller,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
