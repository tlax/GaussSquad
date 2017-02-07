import Foundation

extension DPolynomial
{
    func coefficient() -> Double
    {
        let coefficientValue:Double = coefficientDividend / coefficientDivisor
        
        return coefficientValue
    }
}
