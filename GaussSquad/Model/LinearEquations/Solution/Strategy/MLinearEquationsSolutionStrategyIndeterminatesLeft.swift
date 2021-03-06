import Foundation

class MLinearEquationsSolutionStrategyIndeterminatesLeft:MLinearEquationsSolutionStrategy
{
    class func indeterminatesRight(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyIndeterminatesLeft?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            if let _:MLinearEquationsSolutionEquationItemPolynomial = equation.result as? MLinearEquationsSolutionEquationItemPolynomial
            {
                let strategy:MLinearEquationsSolutionStrategyIndeterminatesLeft = MLinearEquationsSolutionStrategyIndeterminatesLeft(
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
        
        moveToLeft()
    }
    
    //MARK: private
    
    private func moveToLeft()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyIndeterminatesLeft_descr", comment:""),
            "\((indexEquation + 1))")
        
        let countEquations:Int = self.step.equations.count
        
        for indexEquation:Int in 0 ..< countEquations
        {
            let equation:MLinearEquationsSolutionEquation
            let currentEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
            
            if indexEquation == self.indexEquation
            {
                guard
                    
                    let oldResult:MLinearEquationsSolutionEquationItemPolynomial = currentEquation.result as? MLinearEquationsSolutionEquationItemPolynomial
                else
                {
                    return
                }
                
                var items:[MLinearEquationsSolutionEquationItem] = currentEquation.items
                let currentItems:Int = items.count
                let inversedResult:MLinearEquationsSolutionEquationItemPolynomial = oldResult.inversed(
                    newIndex:currentItems)
                let newResult:MLinearEquationsSolutionEquationItemConstant = MLinearEquationsSolutionEquationItem.emptyCoefficient(
                    index:0)
                items.append(inversedResult)
                
                equation = MLinearEquationsSolutionEquation(
                    items:items,
                    result:newResult,
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
