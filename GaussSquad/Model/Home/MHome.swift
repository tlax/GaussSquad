import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemCalculator:MHomeItemCalculator = MHomeItemCalculator()
        let itemLinearEquations:MHomeItemLinearEquations = MHomeItemLinearEquations()
        
        items = [
            itemCalculator,
            itemLinearEquations]
    }
}
