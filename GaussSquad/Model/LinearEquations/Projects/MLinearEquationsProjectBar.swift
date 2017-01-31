import Foundation

class MLinearEquationsProjectBar
{
    let items:[MLinearEquationsProjectBarItem]
    
    init(project:DProject)
    {
        let itemBack:MLinearEquationsProjectBarItemButtonBack = MLinearEquationsProjectBarItemButtonBack()
        let itemOptions:MLinearEquationsProjectBarItemButtonOptions = MLinearEquationsProjectBarItemButtonOptions()
        
        items = [
            itemBack,
            itemOptions]
    }
}
