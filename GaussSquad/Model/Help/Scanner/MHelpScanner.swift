import Foundation

class MHelpScanner:MHelp
{
    init()
    {
        let itemTuring:MHelpScannerItemTuring = MHelpScannerItemTuring()
        
        let items:[MHelpItem] = [
            itemTuring
        ]
        
        super.init(items:items)
    }
}
