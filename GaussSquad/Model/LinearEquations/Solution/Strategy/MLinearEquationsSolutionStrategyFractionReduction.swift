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
            
            guard
            
                let divisor:Double = recursiveDivisor(
                    numberA:maxNumber,
                    numberB:minNumber)
            
            else
            {
                return nil
            }
            
            return divisor
        }
        
        return nil
    }
    
    private class func recursiveDivisor(
        numberA:Double,
        numberB:Double) -> Double?
    {
        if numberB != 0
        {
            if abs(numberB) < 1
            {
                return nil
            }
            
            let module:Double = numberA.truncatingRemainder(dividingBy:numberB)
            let divisor:Double? = recursiveDivisor(
                numberA:numberB,
                numberB:module)
            
            return divisor
        }
        
        if abs(numberA) == 1
        {
            return nil
        }
        
        return numberA
    }
    
    private let indexEquation:Int
    private let indexPolynomial:Int
    private let greatestCommonDivisor:Double
    
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
                let currentResult:MLinearEquationsSolutionEquationItem = currentEquation.result
                let countItems:Int = currentEquation.items.count
                
                if indexPolynomial == countItems
                {
                    items = currentEquation.items
                    
                    if let polynomialResult:MLinearEquationsSolutionEquationItemPolynomial = currentResult as? MLinearEquationsSolutionEquationItemPolynomial
                    {
                        result = polynomialResult.divideCoefficient(
                            coefficient:greatestCommonDivisor,
                            index:0)
                    }
                    else if let constantResult:MLinearEquationsSolutionEquationItemConstant = currentResult as? MLinearEquationsSolutionEquationItemConstant
                    {
                        result = constantResult.divideCoefficient(
                            coefficient:greatestCommonDivisor,
                            index:0)
                    }
                    else
                    {
                        result = currentResult
                    }
                }
                else
                {
                    for indexItem:Int in 0 ..< countItems
                    {
                        let currentItem:MLinearEquationsSolutionEquationItem = currentEquation.items[indexItem]
                        
                        if indexItem == indexPolynomial
                        {
                            let dividedItem:MLinearEquationsSolutionEquationItem?
                            
                            if let itemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = currentItem as? MLinearEquationsSolutionEquationItemPolynomial
                            {
                                dividedItem = itemPolynomial.divideCoefficient(
                                    coefficient:greatestCommonDivisor,
                                    index:indexItem)
                            }
                            else if let itemConstant:MLinearEquationsSolutionEquationItemConstant = currentItem as? MLinearEquationsSolutionEquationItemConstant
                            {
                                dividedItem = itemConstant.divideCoefficient(
                                    coefficient:greatestCommonDivisor,
                                    index:indexItem)
                            }
                            else
                            {
                                dividedItem = nil
                            }
                            
                            if let dividedItem:MLinearEquationsSolutionEquationItem = dividedItem
                            {
                                items.append(dividedItem)
                            }
                        }
                        else
                        {
                            
                            items.append(currentItem)
                        }
                    }
                    
                    result = currentResult
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
