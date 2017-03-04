import Foundation

class MHelpScanner:MHelp
{
    init()
    {
        let itemTuring:MHelpScannerItemTuring = MHelpScannerItemTuring()
        let itemCrop:MHelpScannerItemCrop = MHelpScannerItemCrop()
        let itemEdit:MHelpScannerItemEdit = MHelpScannerItemEdit()
        let itemClean:MHelpScannerItemClean = MHelpScannerItemClean()
        let itemCalculator:MHelpScannerItemCalculator = MHelpScannerItemCalculator()
        
        let items:[MHelpItem] = [
            itemTuring,
            itemCrop,
            itemEdit,
            itemClean,
            itemCalculator
        ]
        
        super.init(items:items)
    }
}
