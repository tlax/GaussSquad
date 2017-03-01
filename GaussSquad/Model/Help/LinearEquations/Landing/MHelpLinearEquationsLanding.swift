import Foundation

class MHelpLinearEquationsLanding:MHelp
{
    init()
    {
        let itemGauss:MHelpLinearEquationsLandingItemGauss = MHelpLinearEquationsLandingItemGauss()
        let itemAddEquation:MHelpLinearEquationsLandingItemAddEquation = MHelpLinearEquationsLandingItemAddEquation()
        let itemAutoSave:MHelpLinearEquationsLandingItemAutoSave = MHelpLinearEquationsLandingItemAutoSave()
        
        let items:[MHelpItem] = [
            itemGauss,
            itemAddEquation,
            itemAutoSave
        ]
        
        super.init(items:items)
    }
}
