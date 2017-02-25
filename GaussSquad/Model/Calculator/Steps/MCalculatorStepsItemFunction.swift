import Foundation

class MCalculatorStepsItemFunction:MCalculatorStepsItem
{
    private let kTab:String = "       "
    
    init(descr:String)
    {
        let tabbedDescr:String = "\(kTab)\(descr)"
        
        super.init(itemDescr:tabbedDescr)
    }
}
