import Foundation

class MLinearEquationsSolutionIndeterminate
{
    let symbol:String
    private let kEmpty:String = ""
    
    init(indeterminate:DIndeterminate)
    {
        if let symbol:String = indeterminate.symbol
        {
            self.symbol = symbol
        }
        else
        {
            self.symbol = kEmpty
        }
    }
}
