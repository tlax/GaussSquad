import UIKit

class CHome:CController
{
    let model:MHome
    
    override init()
    {
        model = MHome()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
