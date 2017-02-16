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
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func openStore()
    {
        let parentController:CParent = self.parentController
        let controllerStore:CStore = CStore()
        
        parentController.dismissAnimateOver
        {
            parentController.slideTo(
                horizontal:CParent.TransitionHorizontal.fromRight,
                controller:controllerStore)
        }
    }
}
