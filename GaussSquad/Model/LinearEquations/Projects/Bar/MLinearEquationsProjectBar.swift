import Foundation

class MLinearEquationsProjectBar
{
    let items:[MLinearEquationsProjectBarItem]
    
    init()
    {
        let itemBack:MLinearEquationsProjectBarItemBack = MLinearEquationsProjectBarItemBack()
        let itemHelp:MLinearEquationsProjectBarItemHelp = MLinearEquationsProjectBarItemHelp()
        let itemTrash:MLinearEquationsProjectBarItemTrash = MLinearEquationsProjectBarItemTrash()
        let itemCompress:MLinearEquationsProjectBarItemCompress = MLinearEquationsProjectBarItemCompress()
        let itemNext:MLinearEquationsProjectBarItemNext = MLinearEquationsProjectBarItemNext()
        
        items = [
            itemBack,
            itemHelp,
            itemTrash,
            itemCompress,
            itemNext]
    }
}
