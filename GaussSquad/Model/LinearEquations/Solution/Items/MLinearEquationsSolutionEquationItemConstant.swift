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
        let otherConstantDivisor:Double = otherConstant.coefficientDivisor
        let otherConstantDividend:Double
        let sumDividend:Double
        let sumDivisor:Double
        let showAsDivision:Bool
        
        if changeSign
        {
            otherConstantDividend = -otherConstant.coefficientDividend
        }
        else
        {
            otherConstantDividend = otherConstant.coefficientDividend
        }
        
        if self.showAsDivision || otherConstant.showAsDivision
        {
            showAsDivision = true
        }
        else
        {
            showAsDivision = false
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
        
        let sumItem:MLinearEquationsSolutionEquationItemConstant = MLinearEquationsSolutionEquationItem.coefficient(
            coefficientDividend:sumDividend,
            coefficientDivisor:sumDivisor,
            index:newIndex,
            showAsDivision:showAsDivision)
        
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
    
    func multiplyCoefficient(coefficient:Double, index:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let newDividend:Double = coefficientDividend * coefficient
        
        let multiplied:MLinearEquationsSolutionEquationItemConstant = MLinearEquationsSolutionEquationItem.coefficient(
            coefficientDividend:newDividend,
            coefficientDivisor:coefficientDivisor,
            index:index,
            showAsDivision:showAsDivision)
        
        return multiplied
    }
    
    func divideCoefficient(coefficient:Double, index:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let newDividend:Double = coefficientDividend / coefficient
        
        let divided:MLinearEquationsSolutionEquationItemConstant = MLinearEquationsSolutionEquationItem.coefficient(
            coefficientDividend:newDividend,
            coefficientDivisor:coefficientDivisor,
            index:index,
            showAsDivision:showAsDivision)
        
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
