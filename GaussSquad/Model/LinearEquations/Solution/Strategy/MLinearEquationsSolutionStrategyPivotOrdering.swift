import Foundation

class MLinearEquationsSolutionStrategyPivotOrdering:MLinearEquationsSolutionStrategy
{
    class func indeterminateUnordered(
        step:MLinearEquationsSolutionStep,
        indeterminates:MLinearEquationsSolutionIndeterminates?) -> MLinearEquationsSolutionStrategyOrderIndeterminates?
    {
        guard
            
            let indeterminates:MLinearEquationsSolutionIndeterminates = indeterminates
            
            else
        {
            return nil
        }
        
        let countIndeterminates:Int = indeterminates.items.count
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            guard
                
                let items:[MLinearEquationsSolutionEquationItemPolynomial] = equation.items as? [MLinearEquationsSolutionEquationItemPolynomial]
                
                else
            {
                return nil
            }
            
            let countItems:Int = items.count
            
            if countIndeterminates != countItems
            {
                return nil
            }
            
            var orderMap:[Int] = []
            
            for indeterminate:MLinearEquationsSolutionIndeterminatesItem in indeterminates.items
            {
                var indexItem:Int = 0
                
                for item:MLinearEquationsSolutionEquationItemPolynomial in items
                {
                    if item.indeterminate === indeterminate
                    {
                        orderMap.append(indexItem)
                        
                        break
                    }
                    
                    indexItem += 1
                }
            }
            
            for indexMap:Int in 0 ..< countIndeterminates
            {
                let mapItem:Int = orderMap[indexMap]
                
                if mapItem != indexMap
                {
                    let strategy:MLinearEquationsSolutionStrategyOrderIndeterminates = MLinearEquationsSolutionStrategyOrderIndeterminates(
                        step:step,
                        indexEquation:indexEquation,
                        orderMap:orderMap)
                    
                    return strategy
                }
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    private let indexEquation:Int
    private let orderMap:[Int]
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        orderMap:[Int])
    {
        self.indexEquation = indexEquation
        self.orderMap = orderMap
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        order()
    }
    
    //MARK: private
    
    private func order()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyOrderIndeterminates_descr", comment:""),
            "\((self.indexEquation + 1))")
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            let newEquation:MLinearEquationsSolutionEquation
            
            if self.indexEquation == indexEquation
            {
                var items:[MLinearEquationsSolutionEquationItem] = []
                
                for ordering:Int in orderMap
                {
                    guard
                        
                        let unorderdItem:MLinearEquationsSolutionEquationItemPolynomial = equation.items[ordering] as? MLinearEquationsSolutionEquationItemPolynomial
                        
                        else
                    {
                        continue
                    }
                    
                    let newIndex:Int = items.count
                    let orderedItem:MLinearEquationsSolutionEquationItemPolynomial = unorderdItem.reIndexed(
                        newIndex:newIndex)
                    items.append(orderedItem)
                }
                
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
