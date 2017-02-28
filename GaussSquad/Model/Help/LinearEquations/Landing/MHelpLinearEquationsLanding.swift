import Foundation

class MHelpLinearEquationsLanding:MHelp
{
    init()
    {
        let itemPolynomials:MHelpLinearEquationsProjectItemPolynomials = MHelpLinearEquationsProjectItemPolynomials()
        
        let items:[MHelpItem] = [
            itemPolynomials
        ]
        
        super.init(items:items)
    }
}
