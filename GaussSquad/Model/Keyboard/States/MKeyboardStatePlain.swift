import Foundation

class MKeyboardStatePlain:MKeyboardState
{
    private let kClearBeforEdition:Bool = false
    
    init(editing:String)
    {
        super.init(
            editing:editing,
            clearBeforeEdition:kClearBeforEdition)
    }
}
