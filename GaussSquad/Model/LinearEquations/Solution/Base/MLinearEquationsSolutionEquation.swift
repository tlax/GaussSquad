import Foundation

class MLinearEquationsSolutionEquation
{
    let items:[MLinearEquationsSolutionEquationItem]
    let result:MLinearEquationsSolutionEquationItem
    let index:MLinearEquationsSolutionEquationItemIndex
    let equals:MLinearEquationsSolutionEquationItemEquals
    let plainItems:[MLinearEquationsSolutionEquationItem]
    
    init(
        items:[MLinearEquationsSolutionEquationItem],
        result:MLinearEquationsSolutionEquationItem,
        equationIndex:Int)
    {
        self.items = items
        self.result = result
        index = MLinearEquationsSolutionEquationItemIndex(index:equationIndex)
        equals = MLinearEquationsSolutionEquationItemEquals()
        
        var plainItems:[MLinearEquationsSolutionEquationItem] = []
        plainItems.append(index)
        plainItems.append(contentsOf:items)
        plainItems.append(equals)
        plainItems.append(result)
        self.plainItems = plainItems
    }
    
    //MARK: public
    
    func pivotIndex() -> Int
    {
        guard
        
            let items:[MLinearEquationsSolutionEquationItemPolynomial] = self.items as? [MLinearEquationsSolutionEquationItemPolynomial]
            
        else
        {
            let totalItems:Int = self.items.count
            
            return totalItems
        }
        
        var index:Int = 0
        
        for item:MLinearEquationsSolutionEquationItemPolynomial in items
        {
            if item.coefficientDividend != 0
            {
                break
            }
            
            index += 1
        }
        
        return index
    }
    
    func reIndexed(newIndex:Int) -> MLinearEquationsSolutionEquation
    {
        let indexedEquation:MLinearEquationsSolutionEquation = MLinearEquationsSolutionEquation(
            items:items,
            result:result,
            equationIndex:newIndex)
        
        return indexedEquation
    }
    
    func nonZero() -> Bool
    {
        guard
            
            let items:[MLinearEquationsSolutionEquationItemPolynomial] = self.items as? [MLinearEquationsSolutionEquationItemPolynomial]
            
        else
        {
            return false
        }
        
        for item:MLinearEquationsSolutionEquationItemPolynomial in items
        {
            if item.coefficientDividend != 0
            {
                return true
            }
        }
        
        return false
    }
}
