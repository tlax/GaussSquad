import UIKit

class CScanner:CController
{
    private weak var vScanner:VScanner!
    
    override func loadView()
    {
        let vScanner:VScanner = VScanner(controller:self)
        self.vScanner = vScanner
        view = vScanner
    }
}
