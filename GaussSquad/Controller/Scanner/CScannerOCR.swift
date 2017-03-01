import UIKit

class CScannerOCR:CController
{
    private weak var viewOCR:VScannerOCR!
    private let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewOCR:VScannerOCR = VScannerOCR(controller:self)
        self.viewOCR = viewOCR
        view = viewOCR
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[image],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = self.viewOCR
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
}
