import UIKit

class MLinearEquationsSolutionEquationItemConstant:MLinearEquationsSolutionEquationItem
{
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let index:Int
    let showSign:Bool
    let showAsDivision:Bool
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        index:Int,
        showSign:Bool,
        showAsDivision:Bool,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        self.index = index
        self.showSign = showSign
        self.showAsDivision = showAsDivision
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
    
    //MARK: private
    
    private func sum(otherConstant:MLinearEquationsSolutionEquationItemConstant, changeSign:Bool) -> MLinearEquationsSolutionEquationItemConstant
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
            index:index,
            showAsDivision:showAsDivision)
        
        return sumItem
    }
    
    //MARK: public
    
    func add(otherConstant:MLinearEquationsSolutionEquationItemConstant) -> MLinearEquationsSolutionEquationItemConstant
    {
        let addedItem:MLinearEquationsSolutionEquationItemConstant = sum(
            otherConstant:otherConstant,
            changeSign:false)
        
        return addedItem
    }
    
    func subtract(otherConstant:MLinearEquationsSolutionEquationItemConstant) -> MLinearEquationsSolutionEquationItemConstant
    {
        let subtractedItem:MLinearEquationsSolutionEquationItemConstant = sum(
            otherConstant:otherConstant,
            changeSign:true)
        
        return subtractedItem
    }
}
