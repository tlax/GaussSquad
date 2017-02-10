import UIKit

class MLinearEquationsSolutionEquationItemPolynomial:MLinearEquationsSolutionEquationItem
{
    weak var indeterminate:MLinearEquationsSolutionIndeterminatesItem!
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
        let otherPolynomialDivisor:Double = otherPolynomial.coefficientDivisor
        let otherPolynomialDividend:Double
        let sumDividend:Double
        let sumDivisor:Double
        let showAsDivision:Bool
        
        if changeSign
        {
            otherPolynomialDividend = -otherPolynomial.coefficientDividend
        }
        else
        {
            otherPolynomialDividend = otherPolynomial.coefficientDividend
        }
        
        if self.showAsDivision || otherPolynomial.showAsDivision
        {
            showAsDivision = true
        }
        else
        {
            showAsDivision = false
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
        
        let sumItem:MLinearEquationsSolutionEquationItemPolynomial = MLinearEquationsSolutionEquationItem.polynomial(
            coefficientDividend:sumDividend,
            coefficientDivisor:sumDivisor,
            indeterminate:indeterminate,
            index:newIndex,
            showAsDivision:showAsDivision)
        
        return sumItem
    }
    
    //MARK: public
    
    func add(
        otherPolynomial:MLinearEquationsSolutionEquationItemPolynomial,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let addedItem:MLinearEquationsSolutionEquationItemPolynomial = sum(
            otherPolynomial:otherPolynomial,
            changeSign:false)
        
        return addedItem
    }
    
    func subtract(
        otherPolynomial:MLinearEquationsSolutionEquationItemPolynomial,
        newIndex:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let subtractedItem:MLinearEquationsSolutionEquationItemPolynomial = sum(
            otherPolynomial:otherPolynomial,
            changeSign:true)
        
        return subtractedItem
    }
}
