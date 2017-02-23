import Foundation

class MKeyboardState
{
    var editing:String
    var clearBeforeEdition:Bool
    
    init(
        editing:String,
        clearBeforeEdition:Bool)
    {
        self.editing = editing
        self.clearBeforeEdition = clearBeforeEdition
    }
    
    //MARK: public
    
    func commitState()
    {
        
    }
}
