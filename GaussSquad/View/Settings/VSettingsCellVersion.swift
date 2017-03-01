import UIKit

class VSettingsCellVersion:VSettingsCell
{
    private let kVersionKey:String = "CFBundleShortVersionString"
    private let kLabelHeight:CGFloat = 80
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetGenericLogo")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:14)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        
        addSubview(icon)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:icon,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
        
        guard
            
            let bundleDictionary:[String:Any] = Bundle.main.infoDictionary
        
        else
        {
            return
        }
        
        let versionString:String? = bundleDictionary[kVersionKey] as? String
        label.text = versionString
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
