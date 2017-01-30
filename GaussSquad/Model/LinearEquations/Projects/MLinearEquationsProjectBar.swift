import Foundation

class MLinearEquationsProjectBar
{
    let items:[MLinearEquationsProjectBarItem]
    
    init(project:DProject)
    {
        let itemBack:MLinearEquationsProjectBarItemButtonBack = MLinearEquationsProjectBarItemButtonBack()
        
        items = [
            itemBack]
    }
}
