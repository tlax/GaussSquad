import UIKit

class MLinearEquationsProjectRowItemOperatorSubstract:MLinearEquationsProjectRowItemOperator
{
    init(
        polynomial:DPolynomial,
        column:Int)
    {
        super.init(
            polynomial:polynomial,
            image:#imageLiteral(resourceName: "assetGenericColSubstract"),
            column:column)
    }
}
