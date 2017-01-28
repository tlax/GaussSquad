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
    
    //MARK: public
    
    func selected(item:MHomeItem)
    {
        guard
        
            let controller:CController = item.selected()
        
        else
        {
            return
        }
        
        parentController.push(
            controller:controller,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
