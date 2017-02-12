import Foundation

class MLinearEquationsSolutionStrategyFractionReduction:MLinearEquationsSolutionStrategy
{
    class func reducible(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyFractionReduction?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            var indexItem:Int = 0
            var items:[MLinearEquationsSolutionEquationItem] = equation.items
            items.append(equation.result)
            
            for item:MLinearEquationsSolutionEquationItem in items
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
                
                if let greatestCommonDivisor:Double = findGreatestCommonDivisor(
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
    
    private class func findGreatestCommonDivisor(
        dividend:Double,
        divisor:Double) -> Double?
    {
        if divisor != 1 && dividend != 0
        {
            let maxNumber:Double = max(dividend, divisor)
            let minNumber:Double = min(dividend, divisor)
            
            let divisor:Double = recursiveDivisor(
                numberA:maxNumber,
                numberB:minNumber)
            
            if abs(divisor) != 1
            {
                return divisor
            }
        }
        
        return nil
    }
    
    private class func recursiveDivisor(
        numberA:Double,
        numberB:Double) -> Double
    {
        if numberB != 0
        {
            let module:Double = numberA.truncatingRemainder(dividingBy:numberB)
            let divisor:Double = recursiveDivisor(
                numberA:numberB,
                numberB:module)
            
            return divisor
        }
        
        return numberA
    }
    
    let indexEquation:Int
    let indexPolynomial:Int
    let greatestCommonDivisor:Double
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        indexPolynomial:Int,
        greatestCommonDivisor:Double)
    {
        self.indexEquation = indexEquation
        self.indexPolynomial = indexPolynomial
        self.greatestCommonDivisor = greatestCommonDivisor
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        reduceFraction()
    }
    
    //MARK: private
    
    private func reduceFraction()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyFractionReduction_descr", comment:""),
            "\((indexEquation + 1))")
        
        let countEquations:Int = self.step.equations.count
        
        for indexEquation:Int in 0 ..< countEquations
        {
            let equation:MLinearEquationsSolutionEquation
            let currentEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
            
            if indexEquation == self.indexEquation
            {
                var items:[MLinearEquationsSolutionEquationItem] = []
                let result:MLinearEquationsSolutionEquationItem
                let countItems:Int = currentEquation.items.count
                
                if indexPolynomial == countItems
                {
                    items = currentEquation.items
                }
                else
                {
                    for indexItem:Int in 0 ..< countItems
                    {
                        if indexItem != indexPolynomial
                        {
                            let currentItem:MLinearEquationsSolutionEquationItem = currentEquation.items[indexItem]
                            items.append(currentItem)
                        }
                    }
                    
                    result = currentEquation.result
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
