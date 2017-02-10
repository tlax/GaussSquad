import Foundation

class MLinearEquationsSolutionStrategyReduction:MLinearEquationsSolutionStrategy
{
    class func reducible(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyReduction?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            let countPolynomials:Int = equation.items.count
            
            for indexPolynomial:Int in 0 ..< countPolynomials
            {
                let rawItem:MLinearEquationsSolutionEquationItem = equation.items[indexPolynomial]
                
                if let constant:MLinearEquationsSolutionEquationItemConstant = rawItem as? MLinearEquationsSolutionEquationItemConstant
                {
                    
                }
                else if let polynomial:MLinearEquationsSolutionEquationItemPolynomial = rawItem as? MLinearEquationsSolutionEquationItemPolynomial
                {
                    for indexComparison:Int in indexPolynomial + 1 ..< countPolynomials
                    {
                        let rawComparing:MLinearEquationsSolutionEquationItem = equation.items[indexComparison]
                        
                        if let polynomialCompare:MLinearEquationsSolutionEquationItemPolynomial = rawComparing as? MLinearEquationsSolutionEquationItemPolynomial
                        {
                            if polynomial.indeterminate === polynomialCompare.indeterminate
                            {
                                let strategy:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReduction(
                                    step:step,
                                    indexEquation:indexEquation,
                                    indexPolynomialA:indexPolynomial,
                                    indexPolynomialB:indexComparison)
                                
                                return strategy
                            }
                        }
                    }
                    
                    if let resultCompare:MLinearEquationsSolutionEquationItemPolynomial = equation.result as? MLinearEquationsSolutionEquationItemPolynomial
                    {
                        if polynomial.indeterminate === resultCompare.indeterminate
                        {
                            let strategy:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReduction(
                                step:step,
                                indexEquation:indexEquation,
                                indexPolynomialA:indexPolynomial,
                                indexPolynomialB:countPolynomials)
                            
                            return strategy
                        }
                    }
                }
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    private let indexEquation:Int
    private let indexPolynomialA:Int
    private let indexPolynomialB:Int
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        indexPolynomialA:Int,
        indexPolynomialB:Int)
    {
        self.indexEquation = indexEquation
        self.indexPolynomialA = indexPolynomialA
        self.indexPolynomialB = indexPolynomialB
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        reduction()
    }
    
    //MARK: private
    
    private func reduction()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyReduction_descr", comment:""),
            indexEquation + 1)
        
        let countEquations:Int = self.step.equations.count
        
        for indexEquation:Int in 0 ..< countEquations
        {
            let equation:MLinearEquationsSolutionEquation
            let currentEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
            
            if indexEquation == self.indexEquation
            {
                var items:[MLinearEquationsSolutionEquationItem] = []
                var result:MLinearEquationsSolutionEquationItem = currentEquation.result
                let countItems:Int = currentEquation.items.count
                
                if indexPolynomialB == countItems
                {
                    for indexItem:Int in 0 ..< countItems
                    {
                        let currentItem:MLinearEquationsSolutionEquationItem = currentEquation.items[indexItem]
                        
                        if indexItem == indexPolynomialA
                        {
                            if let itemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = currentItem as? MLinearEquationsSolutionEquationItemPolynomial
                            {
                                guard
                                    
                                    let resultPolynomial:MLinearEquationsSolutionEquationItemPolynomial = result as? MLinearEquationsSolutionEquationItemPolynomial
                                
                                else
                                {
                                    return
                                }
                                
                                let itemDividend:Double = -itemPolynomial.coefficientDividend
                                let itemDivisor:Double = itemPolynomial.coefficientDivisor
                                let resultDividend:Double = resultPolynomial.coefficientDividend
                                let resultDivisor:Double = resultPolynomial.coefficientDivisor
                                let reducedDividend:Double
                                let reducedDivisor:Double
                                let showAsDivision:Bool
                                let itemShowAsDivision:Bool
                                let resultShowAsDivision:Bool
                                
                                if let _:MLinearEquationsSolutionEquationItemPolynomialDivision = itemPolynomial as? MLinearEquationsSolutionEquationItemPolynomialDivision
                                {
                                    itemShowAsDivision = true
                                }
                                else
                                {
                                    itemShowAsDivision = false
                                }
                                
                                if let _:MLinearEquationsSolutionEquationItemPolynomialDivision = result as? MLinearEquationsSolutionEquationItemPolynomialDivision
                                {
                                    resultShowAsDivision = true
                                }
                                else
                                {
                                    resultShowAsDivision = false
                                }
                                
                                if itemShowAsDivision || resultShowAsDivision
                                {
                                    showAsDivision = true
                                }
                                else
                                {
                                    showAsDivision = false
                                }
                                
                                if itemDivisor == resultDivisor
                                {
                                    reducedDividend = itemDividend + resultDividend
                                    reducedDivisor = itemDivisor
                                }
                                else
                                {
                                    let scaledItemDividend:Double = itemDividend * resultDivisor
                                    let scaledResultDividend:Double = resultDividend * itemDivisor
                                    reducedDividend = scaledItemDividend + scaledResultDividend
                                    reducedDivisor = itemDivisor * resultDivisor
                                }
                                
                                result = MLinearEquationsSolutionEquationItem.polynomial(
                                    coefficientDividend:reducedDividend,
                                    coefficientDivisor:reducedDivisor,
                                    indeterminate:resultPolynomial.indeterminate,
                                    index:0,
                                    showAsDivision:showAsDivision)
                            }
                            else if let itemConstant:MLinearEquationsSolutionEquationItemConstant = currentItem as? MLinearEquationsSolutionEquationItemConstant
                            {
                                guard
                                    
                                    let resultConstant:MLinearEquationsSolutionEquationItemConstant = result as? MLinearEquationsSolutionEquationItemConstant
                                    
                                else
                                {
                                    return
                                }
                                
                                
                            }
                        }
                        else
                        {
                            items.append(currentItem)
                        }
                    }
                }
                else
                {
                    
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