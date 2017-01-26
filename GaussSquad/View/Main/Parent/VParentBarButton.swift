import UIKit

class VParentBarButton:UIButton
{
    convenience init(image:UIImage)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
    }
}
