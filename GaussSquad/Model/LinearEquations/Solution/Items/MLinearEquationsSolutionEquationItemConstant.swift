import UIKit

class MLinearEquationsSolutionEquationItemConstant:MLinearEquationsSolutionEquationItem
{
    let coefficient:Double
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let showSign:Bool
    let showAsDivision:Bool
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool,
        showAsDivision:Bool,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        self.showSign = showSign
        self.showAsDivision = showAsDivision
        self.coefficient = coefficientDividend / coefficientDivisor
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
    
    //MARK: private
    
    private func sum(
        otherConstant:MLinearEquationsSolutionEquationItemConstant,
        changeSign:Bool,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let sumItem:MLinearEquationsSolutionEquationItemConstant
        let otherConstantDivisor:Double = otherConstant.coefficientDivisor
        let otherConstantDividend:Double
        let sumDividend:Double
        let sumDivisor:Double
        
        if changeSign
        {
            otherConstantDividend = -otherConstant.coefficientDividend
        }
        else
        {
            otherConstantDividend = otherConstant.coefficientDividend
        }
        
        if coefficientDivisor == otherConstantDivisor
        {
            sumDividend = coefficientDividend + otherConstantDividend
            sumDivisor = coefficientDivisor
        }
        else
        {
            let scaledDividend:Double = coefficientDividend * otherConstantDivisor
            let scaledOtherConstantDividend:Double = otherConstantDividend * coefficientDivisor
            sumDividend = scaledDividend + scaledOtherConstantDividend
            sumDivisor = coefficientDivisor * otherConstantDivisor
        }
        
        let newCoeffiecient:Double = abs(sumDividend / sumDivisor)
        
        if newCoeffiecient > MSession.sharedInstance.kMinNumber
        {
            let showAsDivision:Bool
            
            if self.showAsDivision || otherConstant.showAsDivision
            {
                showAsDivision = true
            }
            else
            {
                showAsDivision = false
            }
            
            sumItem = MLinearEquationsSolutionEquationItem.coefficient(
                coefficientDividend:sumDividend,
                coefficientDivisor:sumDivisor,
                index:newIndex,
                showAsDivision:showAsDivision)
        }
        else
        {
            sumItem = MLinearEquationsSolutionEquationItem.emptyCoefficient(
                index:newIndex)
        }
        
        return sumItem
    }
    
    //MARK: public
    
    func add(
        otherConstant:MLinearEquationsSolutionEquationItemConstant,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let addedItem:MLinearEquationsSolutionEquationItemConstant = sum(
            otherConstant:otherConstant,
            changeSign:false,
            newIndex:newIndex)
        
        return addedItem
    }
    
    func subtract(
        otherConstant:MLinearEquationsSolutionEquationItemConstant,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let subtractedItem:MLinearEquationsSolutionEquationItemConstant = sum(
            otherConstant:otherConstant,
            changeSign:true,
            newIndex:newIndex)
        
        return subtractedItem
    }
    
    func inversed(newIndex:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let inversedConstant:MLinearEquationsSolutionEquationItemConstant = MLinearEquationsSolutionEquationItem.coefficient(
            coefficientDividend:-coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            index:newIndex,
            showAsDivision:showAsDivision)
        
        return inversedConstant
    }
    
    func multiply(
        dividend:Double,
        divisor:Double,
        index:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let multiplied:MLinearEquationsSolutionEquationItemConstant
        let newDividend:Double = coefficientDividend * dividend
        let newDivisor:Double = coefficientDivisor * divisor
        let newCoefficient:Double = abs(newDividend / newDivisor)
        
        if newCoefficient > MSession.sharedInstance.kMinNumber
        {
            multiplied = MLinearEquationsSolutionEquationItem.coefficient(
                coefficientDividend:newDividend,
                coefficientDivisor:newDivisor,
                index:index,
                showAsDivision:showAsDivision)
        }
        else
        {
            multiplied = MLinearEquationsSolutionEquationItem.emptyCoefficient(
                index:index)
        }
        
        return multiplied
    }
    
    func divide(
        dividend:Double,
        divisor:Double,
        index:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let divided:MLinearEquationsSolutionEquationItemConstant
        let newDividend:Double = coefficientDividend / dividend
        let newDivisor:Double = coefficientDivisor / divisor
        let newCoefficient:Double = abs(newDividend / newDivisor)
        
        if newCoefficient > MSession.sharedInstance.kMinNumber
        {
            divided = MLinearEquationsSolutionEquationItem.coefficient(
                coefficientDividend:newDividend,
                coefficientDivisor:newDivisor,
                index:index,
                showAsDivision:showAsDivision)
        }
        else
        {
            divided = MLinearEquationsSolutionEquationItem.emptyCoefficient(
                index:index)
        }
        
        return divided
    }
    
    func reIndexed(newIndex:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let indexedConstant:MLinearEquationsSolutionEquationItemConstant = MLinearEquationsSolutionEquationItem.coefficient(
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            index:newIndex,
            showAsDivision:showAsDivision)
        
        return indexedConstant
    }
}
