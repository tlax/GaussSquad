import Foundation

class MLinearEquationsSolutionStrategyPivotOrdering:MLinearEquationsSolutionStrategy
{
    class func indeterminateUnordered(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyPivotOrdering?
    {
        var indexEquationA:Int = 0
        let countEquations:Int = step.equations.count
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            guard
                
                let items:[MLinearEquationsSolutionEquationItemPolynomial] = equation.items as? [MLinearEquationsSolutionEquationItemPolynomial]
                
            else
            {
                return nil
            }
            
            var pivotIndex:Int = 0
            
            for item:MLinearEquationsSolutionEquationItemPolynomial in items
            {
                if item.coefficientDividend != 0
                {
                    break
                }
                
                pivotIndex += 1
            }
            
            for indexEquationB:Int in indexEquationA + 1 ..< countEquations
            {
                
            }
            
            indexEquationA += 1
        }
        
        return nil
    }
    
    private let indexRowA:Int
    private let indexRowB:Int
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexRowA:Int,
        indexRowB:Int)
    {
        self.indexRowA = indexRowA
        self.indexRowB = indexRowB
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        order()
    }
    
    //MARK: private
    
    private func order()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyPivotOrdering_descr", comment:""),
            "\((indexRowA + 1))",
            "\((indexRowB + 1))")
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
