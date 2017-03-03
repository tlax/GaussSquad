import Foundation

class MHelpScanner:MHelp
{
    init()
    {
        let itemTuring:MHelpScannerItemTuring = MHelpScannerItemTuring()
        let itemCrop:MHelpScannerItemCrop = MHelpScannerItemCrop()
        let itemEdit:MHelpScannerItemEdit = MHelpScannerItemEdit()
        let itemClean:MHelpScannerItemClean = MHelpScannerItemClean()
        
        let items:[MHelpItem] = [
            itemTuring,
            itemCrop,
            itemEdit,
            itemClean
        ]
        
        super.init(items:items)
    }
}
