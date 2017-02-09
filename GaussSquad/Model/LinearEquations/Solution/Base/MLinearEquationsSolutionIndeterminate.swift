import Foundation

class MLinearEquationsSolutionIndeterminate
{
    let symbol:String
    private weak var indeterminate:DIndeterminate?
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
    
    //MARK: public
    
    func equals(other:MLinearEquationsSolutionIndeterminate) -> Bool
    {
        guard
        
            let indeterminate:DIndeterminate = self.indeterminate,
            let otherIndeterminated:DIndeterminate = other.indeterminate
        
        else
        {
            return false
        }
        
        let isEqual:Bool = indeterminate == otherIndeterminated
        
        return isEqual
    }
}
