import UIKit

extension UIFont
{
    class func regular(size:CGFloat) -> UIFont
    {
        return UIFont(name:"Lato-Light", size:size)!
    }
    
    class func medium(size:CGFloat) -> UIFont
    {
        return UIFont(name:"Lato-Regular", size:size)!
    }
    
    class func bold(size:CGFloat) -> UIFont
    {
        return UIFont(name:"Lato-Semibold", size:size)!
    }
}
