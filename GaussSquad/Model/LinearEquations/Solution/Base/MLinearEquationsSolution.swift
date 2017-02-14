import UIKit

class MLinearEquationsSolution:MLinearEquationsSolutionStrategyDelegate, MLinearEquationsSolutionShareProtocol
{
    private weak var project:DProject?
    private weak var controller:CLinearEquationsSolution?
    private(set) var steps:[MLinearEquationsSolutionStep]
    private(set) var indeterminates:MLinearEquationsSolutionIndeterminates?
    private let kNewLine:String = "\n"
    
    init(project:DProject)
    {
        self.project = project
        steps = []
    }
    
    //MARK: public
    
    func solve(controller:CLinearEquationsSolution)
    {
        self.controller = controller
        let firstStrategy:MLinearEquationsSolutionStrategyParse = MLinearEquationsSolutionStrategyParse(
            project:project)
        firstStrategy.process(delegate:self)
    }
    
    //MARK: solutionsStrategy delegate
    
    func solutionStrategyCompleted(step:MLinearEquationsSolutionStep)
    {
        steps.append(step)
        
        if let _:MLinearEquationsSolutionStepDone = step as? MLinearEquationsSolutionStepDone
        {
            controller?.solutionComplete()
        }
        else if let _:MLinearEquationsSolutionStepError = step as? MLinearEquationsSolutionStepError
        {
            controller?.solutionComplete()
        }
        else
        {
            let nextStrategy:MLinearEquationsSolutionStrategy? = MLinearEquationsSolutionStrategy.strategyFor(
                step:step,
                indeterminates:indeterminates)
            
            if let nextStrategy:MLinearEquationsSolutionStrategy = nextStrategy
            {
                nextStrategy.process(delegate:self)
            }
            else
            {
                controller?.solutionComplete()
            }
        }
    }
    
    func solutionStrategyIndeterminates(indeterminates:MLinearEquationsSolutionIndeterminates)
    {
        self.indeterminates = indeterminates
    }
    
    //MARK: share protocol
    
    func shareText() -> String?
    {
        let mutableString:NSMutableString = NSMutableString()
        
        for step:MLinearEquationsSolutionStep in steps
        {
            guard
                
                let stepString:String = step.shareText()
                
            else
            {
                continue
            }
            
            if mutableString.length > 0
            {
                mutableString.append(kNewLine)
            }
            
            mutableString.append(stepString)
        }
        
        let string:String = mutableString as String
        
        return string
    }
    
    func shareImage() -> UIImage?
    {
        return nil
    }
}
