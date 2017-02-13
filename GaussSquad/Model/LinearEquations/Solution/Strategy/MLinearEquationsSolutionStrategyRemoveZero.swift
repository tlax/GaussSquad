import Foundation

class MLinearEquationsSolutionStrategyRemoveZero:MLinearEquationsSolutionStrategy
{
    class func onlyZeros(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyRemoveZero?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            var onlyZeros:Bool = true
            
            for item:MLinearEquationsSolutionEquationItem in equation.items
            {
                guard
                    
                    let polynomial:MLinearEquationsSolutionEquationItemPolynomial = item as? MLinearEquationsSolutionEquationItemPolynomial
                    
                else
                {
                    continue
                }
                
                if polynomial.coefficientDividend != 0
                {
                    onlyZeros = false
                    
                    break
                }
            }
            
            if onlyZeros
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
                
                if indexEquation < self.indexEquation
                {
                    equation = self.step.equations[indexEquation]
                }
                else
                {
                    equation = self.step.equations[indexEquation].reIndexed(
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
