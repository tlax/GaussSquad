import UIKit

class CLinearEquationsPlot:CController
{
    let model:MPlot
    private weak var viewPlot:VLinearEquationsPlot!
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        model = MPlot(stepDone:stepDone)
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewPlot:VLinearEquationsPlot = VLinearEquationsPlot(controller:self)
        self.viewPlot = viewPlot
        view = viewPlot
    }
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
            
            let device:MTLDevice = viewPlot.viewMetal?.device
            
        else
        {
            return
        }
        
        if model.modelRender == nil
        {
            model.modelRender = MPlotRender(device:device)
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
