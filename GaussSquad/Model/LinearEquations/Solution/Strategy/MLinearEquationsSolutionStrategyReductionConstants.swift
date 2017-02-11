import Foundation

class MLinearEquationsSolutionStrategyReductionConstants:MLinearEquationsSolutionStrategyReduction
{
    override func reduction()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyReductionConstants_descr", comment:""),
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
                                
                                let itemConstant:MLinearEquationsSolutionEquationItemConstant = currentItem as? MLinearEquationsSolutionEquationItemConstant,
                                let resultConstant:MLinearEquationsSolutionEquationItemConstant = result as? MLinearEquationsSolutionEquationItemConstant
                                
                            else
                            {
                                return
                            }
                            
                            result = resultConstant.subtract(
                                otherConstant:itemConstant,
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
                                        
                                        let itemConstant:MLinearEquationsSolutionEquationItemConstant = item as? MLinearEquationsSolutionEquationItemConstant,
                                        let otherItemConstant:MLinearEquationsSolutionEquationItemConstant = otherItem as? MLinearEquationsSolutionEquationItemConstant
                                        
                                    else
                                    {
                                        return
                                    }
                                    
                                    item = itemConstant.add(
                                        otherConstant:otherItemConstant,
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
