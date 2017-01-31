import Foundation

class MLinearEquationsProjectRow
{
    var items:[MLinearEquationsProjectRowItem]
    private weak var equation:DEquation!
    
    init(equation:DEquation)
    {
        self.equation = equation
        items = []
    }
}
