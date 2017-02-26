import UIKit

class CSettings:CController
{
    let model:MSettings
    private weak var viewSettings:VSettings!
    private let kSupportUrl:String = "mailto:squad@iturbi.de"
    private let kShareUrl:String = "https://itunes.apple.com/gb/app/gausssquad/id1206653108"
    
    override init()
    {
        model = MSettings()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
    
    //MARK: public
    
    func support()
    {
        guard
            
            let url:URL = URL(string:kSupportUrl)
            
        else
        {
            return
        }
        
        UIApplication.shared.openURL(url)
    }
    
    func review()
    {
        
    }
    
    func share()
    {
        guard
            
            let url:URL = URL(string:kShareUrl)
        
        else
        {
            return
        }
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[url],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = self.viewSettings
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
}
