import Foundation

class MKeyboardStateInitial:MKeyboardState
{
    private let kInitialString:String = "0"
    
    init()
    {
        super.init(editing:kInitialString)
    }
}
