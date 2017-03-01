import UIKit
import AVFoundation

class CScanner:CController
{
    private weak var viewScanner:VScanner!
    private weak var captureSession:AVCaptureSession?
    private weak var captureOutput:AVCaptureStillImageOutput?
    private weak var captureDeviceInput:AVCaptureDeviceInput?
    private weak var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    private let devicePosition:AVCaptureDevicePosition
    private let queue:DispatchQueue
    private let kMediaType:String = AVMediaTypeVideo
    private let kSessionPreset:String = AVCaptureSessionPreset1280x720
    private let kVideoGravity:String = AVLayerVideoGravityResizeAspectFill
    private let kVideoCodec:String = AVVideoCodecJPEG
    private let kQueueLabel:String = "cameraQueue"
    
    override init()
    {
        devicePosition = AVCaptureDevicePosition.back
        queue = DispatchQueue(
            label:kQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        cleanSession()
    }
    
    override func loadView()
    {
        let viewScanner:VScanner = VScanner(controller:self)
        self.viewScanner = viewScanner
        view = viewScanner
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.hideBar(barHidden:true)
        parentController.viewParent.panRecognizer.isEnabled = false
        
        if captureSession == nil
        {
            askAuthorization()
        }
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        
        parentController.hideBar(barHidden:false)
    }
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        viewScanner.prepareForRotation()
        
        coordinator.animate(
            alongsideTransition:
            { (context:UIViewControllerTransitionCoordinatorContext) in
        })
        { [weak self] (context:UIViewControllerTransitionCoordinatorContext) in
            
            self?.updatePreviewOrientation()
            self?.viewScanner.viewRotated()
        }
    }
    
    //MARK: private
    
    private func askAuthorization()
    {
        AVCaptureDevice.requestAccess(forMediaType:kMediaType)
        { [weak self] (granted:Bool) in
            
            if granted
            {
                self?.queue.async
                { [weak self] in
                    
                    self?.startPreview()
                }
            }
            else
            {
                VAlert.message(
                    message:NSLocalizedString("CScanner_noAuth", comment:""))
            }
        }
    }
    
    private func startPreview()
    {
        let captureSession:AVCaptureSession = AVCaptureSession()
        captureSession.sessionPreset = kSessionPreset
        self.captureSession = captureSession
        
        let videoPreviewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(
            session:captureSession)
        videoPreviewLayer.videoGravity = kVideoGravity
        self.videoPreviewLayer = videoPreviewLayer
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewScanner.viewPreview.addPreviewLayer(
                previewLayer:videoPreviewLayer)
        }
        
        startSession()
    }
    
    private func cleanSession()
    {
        captureSession?.stopRunning()
        captureSession?.removeInput(captureDeviceInput)
        captureSession?.removeOutput(captureOutput)
    }
    
    private func startSession()
    {
        var captureDevice:AVCaptureDevice?
        
        if #available(iOS 10.0, *)
        {
            captureDevice = AVCaptureDevice.defaultDevice(
                withDeviceType:AVCaptureDeviceType.builtInWideAngleCamera,
                mediaType:kMediaType,
                position:devicePosition)
        }
        else
        {
            let devices:[Any] = AVCaptureDevice.devices(
                withMediaType:kMediaType)
            
            for device:Any in devices
            {
                guard
                    
                    let capture:AVCaptureDevice = device as? AVCaptureDevice
                    
                else
                {
                    continue
                }
                
                if capture.position == devicePosition
                {
                    captureDevice = capture
                    
                    break
                }
            }
        }
        
        guard
            
            let foundCaptureDevice:AVCaptureDevice = captureDevice
            
        else
        {
            VAlert.message(
                message:NSLocalizedString("CScanner_errorCaptureDevice", comment:""))
            
            return
        }
        
        let captureDeviceInput:AVCaptureDeviceInput
        
        do
        {
            try captureDeviceInput = AVCaptureDeviceInput(
                device:foundCaptureDevice)
        }
        catch let error
        {
            VAlert.message(message:error.localizedDescription)
            
            return
        }
        
        self.captureDeviceInput = captureDeviceInput
        captureSession?.addInput(captureDeviceInput)
        
        let captureOutput:AVCaptureStillImageOutput = AVCaptureStillImageOutput()
        captureOutput.outputSettings = [AVVideoCodecKey:kVideoCodec]
        self.captureOutput = captureOutput
        
        captureSession?.addOutput(captureOutput)
        captureSession?.startRunning()
        sessionStarted()
    }
    
    private func sessionStarted()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewScanner.activated()
            self?.updatePreviewOrientation()
        }
    }
    
    private func updatePreviewOrientation()
    {
        guard
        
            let connection:AVCaptureConnection = videoPreviewLayer?.connection
        
        else
        {
            return
        }
        
        let orientation:UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        let videoOrientation:AVCaptureVideoOrientation
        
        switch orientation
        {
        case UIInterfaceOrientation.portrait:
            
            videoOrientation = AVCaptureVideoOrientation.portrait
            
            break
            
        case UIInterfaceOrientation.portraitUpsideDown:
            
            videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
            
            break
            
        case UIInterfaceOrientation.landscapeLeft:
            
            videoOrientation = AVCaptureVideoOrientation.landscapeLeft
            
            break
            
        case UIInterfaceOrientation.landscapeRight:
            
            videoOrientation = AVCaptureVideoOrientation.landscapeRight
            
            break
            
        case UIInterfaceOrientation.unknown:
            
            videoOrientation = AVCaptureVideoOrientation.portrait
            
            break
        }
        
        connection.videoOrientation = videoOrientation
    }
    
    private func stillImage()
    {
        guard
            
            let connection:AVCaptureConnection = captureOutput?.connection(
                withMediaType:kMediaType)
            
        else
        {
            return
        }
        
        captureOutput?.captureStillImageAsynchronously(
            from:connection)
        { [weak self] (sampleBuffer:CMSampleBuffer?, error:Error?) in
            
            guard
                
                let buffer:CMSampleBuffer = sampleBuffer,
                let data:Data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(
                    buffer),
                let image:UIImage = UIImage(data:data)
                
            else
            {
                return
            }
            
            self?.processImage(image:image)
        }
    }
    
    private func processImage(image:UIImage)
    {
        stopCamera()
        finishProcessing(image:image)
    }
    
    private func stopCamera()
    {
        cleanSession()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.videoPreviewLayer?.removeFromSuperlayer()
            self?.viewScanner.startLoading()
        }
    }
    
    private func finishProcessing(image:UIImage)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            let controllerOCR:CScannerOCR = CScannerOCR(image:image)
            self?.parentController.push(
                controller:controllerOCR,
                horizontal:CParent.TransitionHorizontal.fromRight)
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(
            horizontal:CParent.TransitionHorizontal.fromRight)
        { [weak self] in
            
            self?.cleanSession()
        }
    }
    
    func undo()
    {
        viewScanner.viewCropper?.resetThumbs()
    }
    
    func shoot()
    {
        viewScanner.viewMenu.blockButtons()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.stillImage()
        }
    }
}
