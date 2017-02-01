import UIKit

extension UIFont
{
    class func regular(size:CGFloat) -> UIFont
    {
        return UIFont(name:"Avenir-Light", size:size)!
    }
    
    class func medium(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Regular", size:size)!
    }
    
    class func bold(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Medium", size:size)!
    }
}
