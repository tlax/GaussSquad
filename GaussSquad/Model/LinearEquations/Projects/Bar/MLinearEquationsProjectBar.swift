import Foundation

class MLinearEquationsProjectBar
{
    let items:[MLinearEquationsProjectBarItem]
    
    init(project:DProject)
    {
        let itemBack:MLinearEquationsProjectBarItemBack = MLinearEquationsProjectBarItemBack()
        
        items = [
            itemBack]
    }
}
