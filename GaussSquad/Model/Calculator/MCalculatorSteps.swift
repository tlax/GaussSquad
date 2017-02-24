import Foundation

class MCalculatorSteps
{
    var items:[MCalculatorStepsItem]
    
    init()
    {
        let itemBegin:MCalculatorStepsItemBegin = MCalculatorStepsItemBegin()
        
        items = [itemBegin]
    }
}
