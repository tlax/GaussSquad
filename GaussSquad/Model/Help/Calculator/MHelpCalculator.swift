import Foundation

class MHelpCalculator:MHelp
{
    init()
    {
        let itemPolynomials:MHelpLinearEquationsProjectItemPolynomials = MHelpLinearEquationsProjectItemPolynomials()
        let itemAddPolynomial:MHelpLinearEquationsProjectItemAddPolynomial = MHelpLinearEquationsProjectItemAddPolynomial()
        let itemEditRow:MHelpLinearEquationsProjectItemEditRow = MHelpLinearEquationsProjectItemEditRow()
        let itemAddRow:MHelpLinearEquationsProjectItemAddRow = MHelpLinearEquationsProjectItemAddRow()
        let itemIndeterminates:MHelpLinearEquationsProjectItemIndeterminates = MHelpLinearEquationsProjectItemIndeterminates()
        let itemCompress:MHelpLinearEquationsProjectItemCompress = MHelpLinearEquationsProjectItemCompress()
        let itemSolution:MHelpLinearEquationsProjectItemSolution = MHelpLinearEquationsProjectItemSolution()
        
        let items:[MHelpItem] = [
            itemPolynomials,
            itemAddPolynomial,
            itemEditRow,
            itemAddRow,
            itemIndeterminates,
            itemCompress,
            itemSolution
        ]
        
        super.init(items:items)
    }
}
