import Foundation

class MKeyboardState
{
    var editing:String
    var previousValue:Double?
    private(set) var clearBeforeEdition:Bool
    
    init(
        editing:String,
        clearBeforeEdition:Bool)
    {
        self.editing = editing
        self.clearBeforeEdition = clearBeforeEdition
    }
    
    //MARK: public
    
    func clearForEdition(previousValue:Double, editing:String)
    {
        clearBeforeEdition = false
        self.previousValue = previousValue
        self.editing = editing
    }
    
    func commitState()
    {
        
    }
}
