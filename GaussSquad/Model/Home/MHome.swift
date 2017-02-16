import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemLinearEquations:MHomeItemLinearEquations = MHomeItemLinearEquations()
        
        items = [
            itemLinearEquations]
    }
}
