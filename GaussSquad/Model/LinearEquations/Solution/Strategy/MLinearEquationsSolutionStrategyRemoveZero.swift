import Foundation

class MLinearEquationsSolutionStrategyRemoveZero:MLinearEquationsSolutionStrategy
{
    class func onlyZeros(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyRemoveZero?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            let nonZero:Bool = equation.nonZero()
            
            if !nonZero
            {
                let strategy:MLinearEquationsSolutionStrategyRemoveZero = MLinearEquationsSolutionStrategyRemoveZero(
                    step:step,
                    indexEquation:indexEquation)
                
                return strategy
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    private let indexEquation:Int
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int)
    {
        self.indexEquation = indexEquation
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        removeZero()
    }
    
    //MARK: private
    
    private func removeZero()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyRemoveZero_descr", comment:""),
            "\((indexEquation + 1))")
        
        let countEquations:Int = self.step.equations.count
        
        for indexEquation:Int in 0 ..< countEquations
        {
            if indexEquation != self.indexEquation
            {
                let equation:MLinearEquationsSolutionEquation
                let currentEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
                
                if indexEquation < self.indexEquation
                {
                    equation = currentEquation
                }
                else
                {
                    equation = currentEquation.reIndexed(
                        newIndex:indexEquation - 1)
                }
                
                equations.append(equation)
            }   
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
