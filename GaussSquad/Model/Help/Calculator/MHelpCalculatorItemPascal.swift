import UIKit

class MHelpCalculatorItemPascal:MHelpItemLong
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericGauss")
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:16),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesDate:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:16),
            NSForegroundColorAttributeName:UIColor.black]
        
        let rawTitle:String = NSLocalizedString("MHelpCalculatorItemPascal_title", comment:"")
        let rawDate:String = NSLocalizedString("MHelpCalculatorItemPascal_date", comment:"")
        let rawSubtitle:String = NSLocalizedString("MHelpCalculatorItemPascal_subtitle", comment:"")
        
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
