import UIKit

class MLinearEquationsSolutionEquation:MLinearEquationsSolutionShareProtocol
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
            if abs(item.coefficient) > MSession.sharedInstance.kMinNumber
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
            if abs(item.coefficient) > MSession.sharedInstance.kMinNumber
            {
                return true
            }
        }
        
        return false
    }
    
    func multiplyScalar(scalar:Double) -> MLinearEquationsSolutionEquation
    {
        var items:[MLinearEquationsSolutionEquationItem] = []
        var result:MLinearEquationsSolutionEquationItem = self.result
        
        for item:MLinearEquationsSolutionEquationItem in self.items
        {
            let itemIndex:Int = items.count
            
            if let itemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = item as? MLinearEquationsSolutionEquationItemPolynomial
            {
                let newPolynomial:MLinearEquationsSolutionEquationItemPolynomial = itemPolynomial.multiply(
                    dividend:scalar,
                    divisor:1,
                    index:itemIndex)
                
                items.append(newPolynomial)
            }
            else if let itemConstant:MLinearEquationsSolutionEquationItemConstant = item as? MLinearEquationsSolutionEquationItemConstant
            {
                let newConstant:MLinearEquationsSolutionEquationItemConstant = itemConstant.multiply(
                    dividend:scalar,
                    divisor:1,
                    index:itemIndex)
                
                items.append(newConstant)
            }
        }
        
        if let resultPolynomial:MLinearEquationsSolutionEquationItemPolynomial = result as? MLinearEquationsSolutionEquationItemPolynomial
        {
            result = resultPolynomial.multiply(
                dividend:scalar,
                divisor:1,
                index:0)
        }
        else if let resultConstant:MLinearEquationsSolutionEquationItemConstant = result as? MLinearEquationsSolutionEquationItemConstant
        {
            result = resultConstant.multiply(
                dividend:scalar,
                divisor:1,
                index:0)
        }
        
        let newEquation:MLinearEquationsSolutionEquation = MLinearEquationsSolutionEquation(
            items:items,
            result:result,
            equationIndex:index.index)
        
        return newEquation
    }
    
    func addEquation(equation:MLinearEquationsSolutionEquation) -> MLinearEquationsSolutionEquation
    {
        var items:[MLinearEquationsSolutionEquationItem] = []
        var result:MLinearEquationsSolutionEquationItem = self.result
        
        if self.items.count == equation.items.count
        {
            var indexItem:Int = 0
            
            for item:MLinearEquationsSolutionEquationItem in self.items
            {
                if let itemPolynomial:MLinearEquationsSolutionEquationItemPolynomial = item as? MLinearEquationsSolutionEquationItemPolynomial
                {
                    guard
                    
                        let addingPolynomial:MLinearEquationsSolutionEquationItemPolynomial = equation.items[indexItem] as? MLinearEquationsSolutionEquationItemPolynomial
                        
                    else
                    {
                        continue
                    }
                    
                    if itemPolynomial.indeterminate === addingPolynomial.indeterminate
                    {
                        let newPolynomial:MLinearEquationsSolutionEquationItemPolynomial = itemPolynomial.add(
                            otherPolynomial:addingPolynomial,
                            newIndex:indexItem)
                        items.append(newPolynomial)
                    }
                }
                else if let itemConstant:MLinearEquationsSolutionEquationItemConstant = item as? MLinearEquationsSolutionEquationItemConstant
                {
                    guard
                    
                        let addingConstant:MLinearEquationsSolutionEquationItemConstant = equation.items[indexItem] as? MLinearEquationsSolutionEquationItemConstant
                    
                    else
                    {
                        continue
                    }
                    
                    let newConstant:MLinearEquationsSolutionEquationItemConstant = itemConstant.add(
                        otherConstant:addingConstant,
                        newIndex:indexItem)
                    
                    items.append(newConstant)
                }
                
                indexItem += 1
            }
            
            if let resultPolynomial:MLinearEquationsSolutionEquationItemPolynomial = result as? MLinearEquationsSolutionEquationItemPolynomial
            {
                if let addingResult:MLinearEquationsSolutionEquationItemPolynomial = equation.result as? MLinearEquationsSolutionEquationItemPolynomial
                {
                    result = resultPolynomial.add(
                        otherPolynomial:addingResult,
                        newIndex:0)
                }
            }
            else if let resultConstant:MLinearEquationsSolutionEquationItemConstant = result as? MLinearEquationsSolutionEquationItemConstant
            {
                if let addingResult:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
                {
                    result = resultConstant.add(
                        otherConstant:addingResult,
                        newIndex:0)
                }
            }
        }
        
        let newEquation:MLinearEquationsSolutionEquation = MLinearEquationsSolutionEquation(
            items:items,
            result:result,
            equationIndex:index.index)
        
        return newEquation
    }
    
    //MARK: share protocol
    
    func shareText() -> String?
    {
        return nil
    }
    
    func shareImage() -> UIImage?
    {
        return nil
    }
}
