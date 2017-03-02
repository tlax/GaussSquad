import UIKit
import TesseractOCR

class CScannerOCR:CController, G8TesseractDelegate
{
    private weak var viewOCR:VScannerOCR!
    private var recognized:Bool
    private let image:UIImage
    private let kLanguage:String = "eng"
    
    init(image:UIImage)
    {
        self.image = image
        recognized = false
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
        
//        if !recognized
//        {
//            recognized = true
//            
//            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
//            { [weak self] in
//                
//                self?.imageRecognition()
//            }
//        }
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[image],
            applicationActivities:nil)

        
        if let popover:UIPopoverPresentationController = activity.popoverPresentationController
        {
            popover.sourceView = viewOCR
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
    
    //MARK: private
    
    private func imageRecognition()
    {
        let tesseract:G8Tesseract = G8Tesseract(
            language:kLanguage,
            engineMode:G8OCREngineMode.tesseractCubeCombined)
        tesseract.pageSegmentationMode = G8PageSegmentationMode.singleBlock
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        
        print("text:\(tesseract.recognizedText!)")
    }
    
    //MARK: tesseract delegate
    
    
    func shouldCancelImageRecognition(for tesseract:G8Tesseract!) -> Bool
    {
        return false
    }
}
