import Foundation

class MLinearEquationsIndeterminatesItem
{
    weak var indeterminate:DIndeterminate?
    let symbol:String
    private let kEmpty:String = ""
    
    init(indeterminate:DIndeterminate)
    {
        self.indeterminate = indeterminate
        
        guard
        
            let symbol:String = indeterminate.symbol
        
        else
        {
            self.symbol = kEmpty
            
            return
        }
        
        self.symbol = symbol
    }
}
