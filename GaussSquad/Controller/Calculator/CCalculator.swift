import UIKit

class CCalculator:CController
{
    let model:MCalculator
    private weak var viewCalculator:VCalculator!
    
    override init()
    {
        model = MCalculator()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView()
    {
        let viewCalculator:VCalculator = VCalculator(controller:self)
        self.viewCalculator = viewCalculator
        view = viewCalculator
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            forName:Notification.keyboardUpdate,
            object:nil,
            queue:OperationQueue.main)
        { [weak self] (notification) in
            
            guard
            
                let keyboardState:MKeyboardState = notification.object as? MKeyboardState
            
            else
            {
                return
            }
            
            let item:MCalculatorStepsItemKeyboardState = MCalculatorStepsItemKeyboardState(
                keyboardState:keyboardState)
            self?.model.steps.items.append(item)
            self?.viewCalculator.viewHistory.refresh()
        }
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.hideBar(barHidden:true)
        viewCalculator.viewAppeared()
    }
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        coordinator.animate(alongsideTransition:
        { (context:UIViewControllerTransitionCoordinatorContext) in
        
        })
        { [weak self] (context:UIViewControllerTransitionCoordinatorContext) in
            
            self?.viewCalculator.orientationChange()
        }
    }
    
    //MARK: private
    
    private func lookForUndo()
    {
        guard
        
            let lastStep:MCalculatorStepsItem = model.steps.items.popLast()
        
        else
        {
            undoFinished()
            
            return
        }
        
        if let stepKeyboardStatus:MCalculatorStepsItemKeyboardState = lastStep as? MCalculatorStepsItemKeyboardState
        {
            print("found")
        }
        else
        {
            lookForUndo()
        }
    }
    
    private func undoFinished()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewCalculator.isUserInteractionEnabled = false
            self?.viewCalculator.viewHistory.refresh()
        }
    }
    
    //MARK: public
    
    func back()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        parentController.hideBar(barHidden:false)
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func undo()
    {
        viewCalculator.isUserInteractionEnabled = false
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.lookForUndo()
        }
    }
}
