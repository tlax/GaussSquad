import UIKit

class CSettings:CController
{
    let model:MSettings
    private weak var viewSettings:VSettings!
    
    override init()
    {
        model = MSettings()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
    
    //MARK: public
    
    func support()
    {
        
    }
    
    func review()
    {
        
    }
    
    func share()
    {
        
    }
}
