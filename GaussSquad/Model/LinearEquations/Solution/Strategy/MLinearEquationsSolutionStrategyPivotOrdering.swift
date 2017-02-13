import Foundation

class MLinearEquationsSolutionStrategyPivotOrdering:MLinearEquationsSolutionStrategy
{
    class func indeterminateUnordered(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyPivotOrdering?
    {
        var indexEquationA:Int = 0
        let countEquations:Int = step.equations.count
        
        for equationA:MLinearEquationsSolutionEquation in step.equations
        {
            guard
                
                let items:[MLinearEquationsSolutionEquationItemPolynomial] = equationA.items as? [MLinearEquationsSolutionEquationItemPolynomial]
                
            else
            {
                return nil
            }
            
            let pivotIndexA:Int = equationA.pivotIndex()
            
            for indexEquationB:Int in indexEquationA + 1 ..< countEquations
            {
                let equationB:MLinearEquationsSolutionEquation = step.equations[indexEquationB]
                let pivotIndexB:Int = equationB.pivotIndex()
                
                if pivotIndexA > pivotIndexB
                {
                    let strategy:MLinearEquationsSolutionStrategyPivotOrdering = MLinearEquationsSolutionStrategyPivotOrdering(
                        step:step,
                        indexRowA:indexEquationA,
                        indexRowB:indexEquationB)
                    
                    return strategy
                }
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
