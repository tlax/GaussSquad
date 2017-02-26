import UIKit

class VSettingsCellSupport:VSettingsCell
{
    private let kButtonRight:CGFloat = 10
    private let kButtonWidth:CGFloat = 40
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:15),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:15),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.7)]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VSettingsCellSupport_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VSettingsCellSupport_labelSubtitle", comment:""),
            attributes:attributesSubtitle)
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            #imageLiteral(resourceName: "assetGenericHelp").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        button.setImage(
            #imageLiteral(resourceName: "assetGenericHelp").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        button.imageView!.clipsToBounds = true
        button.imageView!.contentMode = UIViewContentMode.center
        button.imageView!.tintColor = UIColor(white:0.8, alpha:1)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.font = UIFont.regular(size:15)
        label.attributedText = mutableString
        
        addSubview(label)
        addSubview(button)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
