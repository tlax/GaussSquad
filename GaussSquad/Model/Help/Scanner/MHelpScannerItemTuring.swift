import UIKit

class MHelpScannerItemTuring:MHelpItemLong
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericTuring")
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:17),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesDate:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:17),
            NSForegroundColorAttributeName:UIColor.black]
        
        let rawTitle:String = NSLocalizedString("MHelpScannerItemTuring_title", comment:"")
        let rawDate:String = NSLocalizedString("MHelpScannerItemTuring_date", comment:"")
        let rawSubtitle:String = NSLocalizedString("MHelpScannerItemTuring_subtitle", comment:"")
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:rawTitle,
            attributes:attributesTitle)
        let stringDate:NSAttributedString = NSAttributedString(
            string:rawDate,
            attributes:attributesDate)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:rawSubtitle,
            attributes:attributesSubtitle)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringDate)
        mutableString.append(stringSubtitle)
        
        super.init(
            image:image,
            title:mutableString)
    }
}
