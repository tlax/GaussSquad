import Foundation

class MHelpScanner:MHelp
{
    init()
    {
        let itemTuring:MHelpScannerItemTuring = MHelpScannerItemTuring()
        let itemCrop:MHelpScannerItemCrop = MHelpScannerItemCrop()
        
        let items:[MHelpItem] = [
            itemTuring,
            itemCrop
        ]
        
        super.init(items:items)
    }
}
