import Foundation

class MLinearEquationsSolutionStrategyFractionReduction:MLinearEquationsSolutionStrategy
{
    class func hasZeros(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyFractionReduction?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            var indexItem:Int = 0
            
            for item:MLinearEquationsSolutionEquationItem in equation.items
            {
                let itemDividend:Double?
                let itemDivisor:Double?
                
                if let polynomial:MLinearEquationsSolutionEquationItemPolynomial = item as? MLinearEquationsSolutionEquationItemPolynomial
                {
                    itemDividend = polynomial.coefficientDividend
                    itemDivisor = polynomial.coefficientDivisor
                }
                else if let coefficient:MLinearEquationsSolutionEquationItemConstant = item as? MLinearEquationsSolutionEquationItemConstant
                {
                    itemDividend = coefficient.coefficientDividend
                    itemDivisor = coefficient.coefficientDivisor
                }
                else
                {
                    itemDividend = nil
                    itemDivisor = nil
                }
                
                guard
                    
                    let dividend:Double = itemDividend,
                    let divisor:Double = itemDivisor
                
                else
                {
                    return nil
                }
                
                if let greatestCommonDivisor:Int = findGreatesCommonDivisor(
                    dividend:dividend,
                    divisor:divisor)
                {
                    let strategy:MLinearEquationsSolutionStrategyFractionReduction = MLinearEquationsSolutionStrategyFractionReduction(
                        step:step,
                        indexEquation:indexEquation,
                        indexPolynomial:indexItem,
                        greatestCommonDivisor:greatestCommonDivisor)
                    
                    return strategy
                }
                
                indexItem += 1
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    private class func findGreatesCommonDivisor(
        dividend:Double,
        divisor:Double) -> Int?
    {
        return nil
    }
    
    let indexEquation:Int
    let indexPolynomial:Int
    let greatestCommonDivisor:Int
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        indexPolynomial:Int,
        greatestCommonDivisor:Int)
    {
        self.indexEquation = indexEquation
        self.indexPolynomial = indexPolynomial
        self.greatestCommonDivisor = greatestCommonDivisor
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
            let equation:MLinearEquationsSolutionEquation?
            let currentEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
            
            if indexEquation == self.indexEquation
            {
                let countItems:Int = currentEquation.items.count
                
                if countItems > 1
                {
                    var items:[MLinearEquationsSolutionEquationItem] = []
                    let result:MLinearEquationsSolutionEquationItem = currentEquation.result
                    
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
                    equation = nil
                }
            }
            else
            {
                equation = currentEquation
            }
            
            if let equation:MLinearEquationsSolutionEquation = equation
            {
                equations.append(equation)
            }
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
