import Foundation

class MLinearEquationsSolutionStrategyRemoveZeros:MLinearEquationsSolutionStrategy
{
    class func hasZeros(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyRemoveZeros?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            var indexItem:Int = 0
            
            for item:MLinearEquationsSolutionEquationItem in equation.items
            {
                if let polynomial:MLinearEquationsSolutionEquationItemPolynomial = item as? MLinearEquationsSolutionEquationItemPolynomial
                {
                    if polynomial.coefficientDividend == 0
                    {
                        let strategy:MLinearEquationsSolutionStrategyRemoveZeros = MLinearEquationsSolutionStrategyRemoveZeros(
                            step:step,
                            indexEquation:indexEquation,
                            indexPolynomial:indexItem)
                        
                        return strategy
                    }
                }
                else if let coefficient:MLinearEquationsSolutionEquationItemConstant = item as? MLinearEquationsSolutionEquationItemConstant
                {
                    if coefficient.coefficientDividend == 0
                    {
                        let strategy:MLinearEquationsSolutionStrategyRemoveZeros = MLinearEquationsSolutionStrategyRemoveZeros(
                            step:step,
                            indexEquation:indexEquation,
                            indexPolynomial:indexItem)
                        
                        return strategy
                    }
                }
                
                indexItem += 1
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    let indexEquation:Int
    let indexPolynomial:Int
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        indexPolynomial:Int)
    {
        self.indexEquation = indexEquation
        self.indexPolynomial = indexPolynomial
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
            let equation:MLinearEquationsSolutionEquation
            let currentEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
            
            if indexEquation == self.indexEquation
            {
                var items:[MLinearEquationsSolutionEquationItem] = []
                let result:MLinearEquationsSolutionEquationItem = currentEquation.result
                let countItems:Int = currentEquation.items.count
                
                for indexItem:Int in 0 ..< countItems
                {
                    if indexItem != indexPolynomial
                    {
                        let currentItem:MLinearEquationsSolutionEquationItem = currentEquation.items[indexItem]
                        items.append(currentItem)
                    }
                }
                
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
