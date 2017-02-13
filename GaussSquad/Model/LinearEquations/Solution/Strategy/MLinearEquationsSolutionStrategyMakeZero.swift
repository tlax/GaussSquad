import Foundation

class MLinearEquationsSolutionStrategyMakeZero:MLinearEquationsSolutionStrategy
{
    class func onlyZeros(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyMakeZero?
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
                guard
                
                    let result:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
                
                else
                {
                    return nil
                }
                
                if result.coefficientDividend != 0
                {
                    let strategy:MLinearEquationsSolutionStrategyMakeZero = MLinearEquationsSolutionStrategyMakeZero(
                        step:step,
                        indexEquation:indexEquation)
                    
                    return strategy
                }
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    let indexEquation:Int
    
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
        
        removeResult()
    }
    
    //MARK: private
    
    private func removeResult()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyMakeZero_descr", comment:""),
            "\((indexEquation + 1))")
        
        let countEquations:Int = self.step.equations.count
        
        for indexEquation:Int in 0 ..< countEquations
        {
            let equation:MLinearEquationsSolutionEquation
            let currentEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
            
            if indexEquation == self.indexEquation
            {
                let items:[MLinearEquationsSolutionEquationItem] = currentEquation.items
                let result:MLinearEquationsSolutionEquationItemConstant = MLinearEquationsSolutionEquationItem.emptyCoefficient(
                    index:0)
                
                equation = MLinearEquationsSolutionEquation(
                    items:items,
                    result:result,
                    equationIndex:indexEquation)
            }
            else
            {
                equation = currentEquation
            }
            
            equations.append(equation)
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
