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
                
                if let _:MLinearEquationsSolutionEquationItemConstant = rawItem as? MLinearEquationsSolutionEquationItemConstant
                {
                    for indexComparison:Int in indexPolynomial + 1 ..< countPolynomials
                    {
                        let rawComparing:MLinearEquationsSolutionEquationItem = equation.items[indexComparison]
                        
                        if let _:MLinearEquationsSolutionEquationItemConstant = rawComparing as? MLinearEquationsSolutionEquationItemConstant
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
            "\((indexEquation + 1))")
        
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
                                
                                result = resultPolynomial.subtract(
                                    otherPolynomial:itemPolynomial,
                                    newIndex:0)
                            }
                            else if let itemConstant:MLinearEquationsSolutionEquationItemConstant = currentItem as? MLinearEquationsSolutionEquationItemConstant
                            {
                                guard
                                    
                                    let resultConstant:MLinearEquationsSolutionEquationItemConstant = result as? MLinearEquationsSolutionEquationItemConstant
                                    
                                else
                                {
                                    return
                                }
                                
                                result = resultConstant.subtract(
                                    otherConstant:itemConstant,
                                    newIndex:0)
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
                    for indexItem:Int in 0 ..< countItems
                    {
                        var item:MLinearEquationsSolutionEquationItem = currentEquation.items[indexItem]
                        
                        if indexItem == indexPolynomialA
                        {
                            for indexOtherItem:Int in indexItem + 1 ..< countItems
                            {
                                if indexOtherItem == indexPolynomialB
                                {
                                    let otherItem:MLinearEquationsSolutionEquationItem = currentEquation.items[indexOtherItem]
                                    
                                    if let itemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = item as? MLinearEquationsSolutionEquationItemPolynomial
                                    {
                                        guard
                                        
                                            let otherItemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = otherItem as? MLinearEquationsSolutionEquationItemPolynomial
                                        
                                        else
                                        {
                                            return
                                        }
                                        
                                        item = itemPolynomial.add(
                                            otherPolynomial:otherItemPolynomial,
                                            newIndex:indexItem)
                                    }
                                    else if let itemConstant:MLinearEquationsSolutionEquationItemConstant = item as? MLinearEquationsSolutionEquationItemConstant
                                    {
                                        guard
                                        
                                            let otherItemConstant:MLinearEquationsSolutionEquationItemConstant = otherItem as? MLinearEquationsSolutionEquationItemConstant
                                        
                                        else
                                        {
                                            return
                                        }
                                        
                                        item = itemConstant.add(
                                            otherConstant:otherItemConstant,
                                            newIndex:indexItem)
                                    }
                                    
                                    break
                                }
                            }
                        }
                        
                        if indexItem != indexPolynomialB
                        {
                            items.append(item)
                        }
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
