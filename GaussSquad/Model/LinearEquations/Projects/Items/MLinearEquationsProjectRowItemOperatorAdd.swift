import UIKit

class MLinearEquationsProjectRowItemOperatorAdd:MLinearEquationsProjectRowItemOperator
{
    init(polynomial:DPolynomial)
    {
        super.init(
            polynomial:polynomial,
            image:#imageLiteral(resourceName: "assetGenericColAdd"))
    }
}
