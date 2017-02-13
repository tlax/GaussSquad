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
                    let strategy:MLinearEquationsSolutionStrategyZeroFill = MLinearEquationsSolutionStrategyZeroFill(
                        step:step,
                        indexEquation:indexEquation,
                        indeterminate:indeterminate)
                    
                    return strategy
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
        
        addZero()
    }
    
    //MARK: private
    
    private func addZero()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyZeroFill_descr", comment:""),
            indeterminate.symbol,
            "\((self.indexEquation + 1))")
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            let newEquation:MLinearEquationsSolutionEquation
            
            if indexEquation == self.indexEquation
            {
                var items:[MLinearEquationsSolutionEquationItem] = equation.items
                let countItems:Int = items.count
                let newPolynomial:MLinearEquationsSolutionEquationItemPolynomial = MLinearEquationsSolutionEquationItem.emptyPolynomial(
                    indeterminate:indeterminate,
                    index:countItems)
                items.append(newPolynomial)
                
                newEquation = MLinearEquationsSolutionEquation(
                    items:items,
                    result:equation.result,
                    equationIndex:indexEquation)
            }
            else
            {
                newEquation = equation
            }
            
            equations.append(newEquation)
            
            indexEquation += 1
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
