import UIKit

class MLinearEquationsSolutionEquationItemPolynomial:MLinearEquationsSolutionEquationItem
{
    weak var indeterminate:MLinearEquationsSolutionIndeterminatesItem!
    let coefficient:Double
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let showSign:Bool
    let showAsDivision:Bool
    
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool,
        showAsDivision:Bool,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.indeterminate = indeterminate
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
        otherPolynomial:MLinearEquationsSolutionEquationItemPolynomial,
        changeSign:Bool,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let sumItem:MLinearEquationsSolutionEquationItemPolynomial
        let otherPolynomialDivisor:Double = otherPolynomial.coefficientDivisor
        let otherPolynomialDividend:Double
        let sumDividend:Double
        let sumDivisor:Double
        
        if changeSign
        {
            otherPolynomialDividend = -otherPolynomial.coefficientDividend
        }
        else
        {
            otherPolynomialDividend = otherPolynomial.coefficientDividend
        }
        
        if coefficientDivisor == otherPolynomialDivisor
        {
            sumDividend = coefficientDividend + otherPolynomialDividend
            sumDivisor = coefficientDivisor
        }
        else
        {
            let scaledDividend:Double = coefficientDividend * otherPolynomialDivisor
            let scaledOtherPolynomialDividend:Double = otherPolynomialDividend * coefficientDivisor
            sumDividend = scaledDividend + scaledOtherPolynomialDividend
            sumDivisor = coefficientDivisor * otherPolynomialDivisor
        }
        
        let newCoefficient:Double = abs(sumDividend / sumDivisor)
        
        if newCoefficient > MSession.sharedInstance.kMinNumber
        {
            let showAsDivision:Bool
            
            if newCoefficient == 1
            {
                showAsDivision = false
            }
            else
            {
                if self.showAsDivision || otherPolynomial.showAsDivision
                {
                    showAsDivision = true
                }
                else
                {
                    showAsDivision = false
                }
            }
            
            sumItem = MLinearEquationsSolutionEquationItem.polynomial(
                coefficientDividend:sumDividend,
                coefficientDivisor:sumDivisor,
                indeterminate:indeterminate,
                index:newIndex,
                showAsDivision:showAsDivision)
        }
        else
        {
            sumItem = MLinearEquationsSolutionEquationItem.emptyPolynomial(
                indeterminate:indeterminate,
                index:newIndex)
        }
        
        return sumItem
    }
    
    //MARK: public
    
    func add(
        otherPolynomial:MLinearEquationsSolutionEquationItemPolynomial,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let addedItem:MLinearEquationsSolutionEquationItemPolynomial = sum(
            otherPolynomial:otherPolynomial,
            changeSign:false,
            newIndex:newIndex)
        
        return addedItem
    }
    
    func subtract(
        otherPolynomial:MLinearEquationsSolutionEquationItemPolynomial,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let subtractedItem:MLinearEquationsSolutionEquationItemPolynomial = sum(
            otherPolynomial:otherPolynomial,
            changeSign:true,
            newIndex:newIndex)
        
        return subtractedItem
    }
    
    func inversed(newIndex:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let inversedPolynomial:MLinearEquationsSolutionEquationItemPolynomial = MLinearEquationsSolutionEquationItem.polynomial(
            coefficientDividend:-coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            indeterminate:indeterminate,
            index:newIndex,
            showAsDivision:showAsDivision)
        
        return inversedPolynomial
    }
    
    func multiply(
        dividend:Double,
        divisor:Double,
        index:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let multiplied:MLinearEquationsSolutionEquationItemPolynomial
        let newDividend:Double = coefficientDividend * dividend
        let newDivisor:Double = coefficientDivisor * divisor
        let newCoefficient:Double = abs(newDividend / newDivisor)
        
        if newCoefficient > MSession.sharedInstance.kMinNumber
        {
            let showAsDivision:Bool
            
            if newCoefficient == 1
            {
                showAsDivision = false
            }
            else
            {
                showAsDivision = self.showAsDivision
            }
            
            multiplied = MLinearEquationsSolutionEquationItem.polynomial(
                coefficientDividend:newDividend,
                coefficientDivisor:newDivisor,
                indeterminate:indeterminate,
                index:index,
                showAsDivision:showAsDivision)
        }
        else
        {
            multiplied = MLinearEquationsSolutionEquationItem.emptyPolynomial(
                indeterminate:indeterminate,
                index:index)
        }
        
        return multiplied
    }
    
    func divide(
        dividend:Double,
        divisor:Double,
        index:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let divided:MLinearEquationsSolutionEquationItemPolynomial
        let newDividend:Double = coefficientDividend / dividend
        let newDivisor:Double = coefficientDivisor / divisor
        let newCoefficient:Double = abs(newDividend / newDivisor)
        
        if newCoefficient > MSession.sharedInstance.kMinNumber
        {
            let showAsDivision:Bool
            
            if newCoefficient == 1
            {
                showAsDivision = false
            }
            else
            {
                showAsDivision = self.showAsDivision
            }
            
            divided = MLinearEquationsSolutionEquationItem.polynomial(
                coefficientDividend:newDividend,
                coefficientDivisor:newDivisor,
                indeterminate:indeterminate,
                index:index,
                showAsDivision:showAsDivision)
        }
        else
        {
            divided = MLinearEquationsSolutionEquationItem.emptyPolynomial(
                indeterminate:indeterminate,
                index:index)
        }
        
        return divided
    }
    
    func reIndexed(newIndex:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let indexedPolynomial:MLinearEquationsSolutionEquationItemPolynomial = MLinearEquationsSolutionEquationItem.polynomial(
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            indeterminate:indeterminate,
            index:newIndex,
            showAsDivision:showAsDivision)
        
        return indexedPolynomial
    }
}
