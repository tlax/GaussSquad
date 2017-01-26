import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemArithmetic:MHomeItemLinearArithmetic = MHomeItemLinearArithmetic()
        let itemLinearEquations:MHomeItemLinearEquations = MHomeItemLinearEquations()
        
        items = [
            itemArithmetic,
            itemLinearEquations]
    }
}
