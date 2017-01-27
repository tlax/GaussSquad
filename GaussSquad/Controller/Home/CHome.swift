import UIKit

class CHome:CController
{
    let model:MHome
    private weak var viewHome:VHome!
    
    override init()
    {
        model = MHome()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
}
