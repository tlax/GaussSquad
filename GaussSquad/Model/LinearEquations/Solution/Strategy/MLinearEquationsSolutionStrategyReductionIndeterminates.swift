import Foundation

class MLinearEquationsSolutionStrategyReductionIndeterminates:MLinearEquationsSolutionStrategyReduction
{
    override func reduction()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyReductionIndeterminates_descr", comment:""),
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
                            guard
                                
                                let itemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = currentItem as? MLinearEquationsSolutionEquationItemPolynomial,
                                let resultPolynomial:MLinearEquationsSolutionEquationItemPolynomial = result as? MLinearEquationsSolutionEquationItemPolynomial
                                
                            else
                            {
                                return
                            }
                            
                            result = resultPolynomial.subtract(
                                otherPolynomial:itemPolynomial,
                                newIndex:0)
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
                                    
                                    guard
                                        
                                        let itemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = item as? MLinearEquationsSolutionEquationItemPolynomial,
                                        let otherItemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = otherItem as? MLinearEquationsSolutionEquationItemPolynomial
                                        
                                    else
                                    {
                                        return
                                    }
                                    
                                    item = itemPolynomial.add(
                                        otherPolynomial:otherItemPolynomial,
                                        newIndex:indexItem)
                                    
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
