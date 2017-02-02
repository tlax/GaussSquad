import UIKit

class CLinearEquationsProject:CController
{
    let model:MLinearEquationsProject
    private weak var viewProject:VLinearEquationsProject!
    
    init(project:DProject?)
    {
        model = MLinearEquationsProject(project:project)
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        model.load(controller:self)
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
        DManager.sharedInstance?.save()
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func delete()
    {
        
    }
    
    func modelLoaded()
    {
        viewProject.refresh()
    }
    
    func editPolynomial(polynomial:DPolynomial)
    {
        let controllerPolynomial:CLinearEquationsPolynomial = CLinearEquationsPolynomial(
            polynomial:polynomial)
        parentController.animateOver(
            controller:controllerPolynomial)
    }
}
