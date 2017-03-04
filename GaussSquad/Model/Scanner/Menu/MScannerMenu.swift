import Foundation

class MScannerMenu
{
    let items:[MScannerMenuItem]
    
    init()
    {
        let itemHelp:MScannerMenuItemHelp = MScannerMenuItemHelp()
        let itemClean:MScannerMenuItemClean = MScannerMenuItemClean()
        let itemCalculator:MScannerMenuItemCalculator = MScannerMenuItemCalculator()
        
        items = [
            itemHelp,
            itemClean,
            itemCalculator]
    }
}
