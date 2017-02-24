import Foundation

class MCalculatorFunctions
{
    let title:String
    let items:[MCalculatorFunctionsItem]
    
    init(
        title:String,
        items:[MCalculatorFunctionsItem])
    {
        self.title = title
        self.items = items
    }
}
