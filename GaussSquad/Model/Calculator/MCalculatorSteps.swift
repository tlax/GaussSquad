import Foundation

class MCalculatorSteps
{
    var items:[MCalculatorStepsItem]
    
    init()
    {
        let itemBegin:MCalculatorStepsItemInfo = MCalculatorStepsItemInfo(
            info:NSLocalizedString("MCalculatorSteps_stepBegin", comment:""))
        
        items = [itemBegin]
    }
}
