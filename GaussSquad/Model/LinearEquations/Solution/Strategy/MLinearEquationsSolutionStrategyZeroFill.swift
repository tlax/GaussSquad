import Foundation

class MLinearEquationsSolutionStrategyZeroFill:MLinearEquationsSolutionStrategy
{
    class func missingIndeterminate(
        step:MLinearEquationsSolutionStep,
        indeterminates:MLinearEquationsSolutionIndeterminates?) -> MLinearEquationsSolutionStrategyZeroFill?
    {
        guard
            
            let indeterminates:MLinearEquationsSolutionIndeterminates = indeterminates
        
        else
        {
            return nil
        }
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            guard
            
                let items:[MLinearEquationsSolutionEquationItemPolynomial] = equation.items as? [MLinearEquationsSolutionEquationItemPolynomial]
            
            else
            {
                return nil
            }
            
            for indeterminate:MLinearEquationsSolutionIndeterminatesItem in indeterminates.items
            {
                var found:Bool = false
                
                for item:MLinearEquationsSolutionEquationItemPolynomial in items
                {
                    if item.indeterminate === indeterminate
                    {
                        found = true
                        
                        break
                    }
                }
                
                if !found
                {
                    print("not found: \(indeterminate.symbol)")
                }
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    private let indexEquation:Int
    private weak var indeterminate:MLinearEquationsSolutionIndeterminatesItem!
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        indeterminate:MLinearEquationsSolutionIndeterminatesItem)
    {
        self.indexEquation = indexEquation
        self.indeterminate = indeterminate
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
            format:NSLocalizedString("MLinearEquationsSolutionStrategyRemoveZeros_descr", comment:""),
            "\((indexEquation + 1))")
        
        let countEquations:Int = self.step.equations.count
        
        for indexEquation:Int in 0 ..< countEquations
        {
            
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
