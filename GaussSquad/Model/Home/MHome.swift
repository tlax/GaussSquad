import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemArithmetic:MHomeItemArithmetic = MHomeItemArithmetic()
        let itemLinearEquations:MHomeItemLinearEquations = MHomeItemLinearEquations()
        
        items = [
            itemArithmetic,
            itemLinearEquations]
    }
}
