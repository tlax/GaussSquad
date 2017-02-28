import UIKit

class MHelpCalculatorItemPascal:MHelpItemLong
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericGauss")
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:16),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:16),
            NSForegroundColorAttributeName:UIColor.black]
        
        let rawTitle:String = NSLocalizedString("MHelpCalculatorItemPascal_title", comment:"")
        let rawSubtitle:String = NSLocalizedString("MHelpCalculatorItemPascal_subtitle", comment:"")
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:,
            attributes:attributesTitle)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(<#T##attrString: NSAttributedString##NSAttributedString#>)
        
        super.init(
            image:image,
            title:mutableString)
    }
}
