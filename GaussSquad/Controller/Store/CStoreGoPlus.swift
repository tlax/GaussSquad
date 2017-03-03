import UIKit

class CStoreGoPlus:CController
{
    private weak var viewGoPlus:VStoreGoPlus!
    
    override func loadView()
    {
        let viewGoPlus:VStoreGoPlus = VStoreGoPlus(controller:self)
        self.viewGoPlus = viewGoPlus
        view = viewGoPlus
    }
    
    //MARK: public
    
    func close()
    {
        AnalyticsManager.sharedInstance?.trackFroob(action:AnalyticsManager.FroobAction.plusClose)
        
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func openStore()
    {
        AnalyticsManager.sharedInstance?.trackFroob(action:AnalyticsManager.FroobAction.plusStore)
        
        let parentController:CParent = self.parentController
        
        parentController.dismissAnimateOver
        {
            parentController.pop(
                horizontal:CParent.TransitionHorizontal.fromRight)
            {
                parentController.pop(
                    horizontal:CParent.TransitionHorizontal.fromRight)
                {
                    parentController.viewParent.viewBar.goStore()
                }
            }
        }
    }
}
