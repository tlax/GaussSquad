import UIKit

class MLinearEquationsProjectRowItemOperatorAdd:MLinearEquationsProjectRowItemOperator
{
    init(
        polynomial:DPolynomial,
        column:Int)
    {
        super.init(
            polynomial:polynomial,
            image:#imageLiteral(resourceName: "assetGenericAdd"),
            column:column)
    }
}
