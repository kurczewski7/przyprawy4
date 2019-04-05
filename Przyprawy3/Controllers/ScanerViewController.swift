//
//  ScanerViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 02/12/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import AVFoundation

class ScanerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
 
    @IBAction func scannerStartTap(_ sender: UIBarButtonItem) {
        captureSession.startRunning()
    }
    @IBAction func scannerStopTap(_ sender: UIBarButtonItem) {
        captureSession.stopRunning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScanerViewController")

        view.backgroundColor=UIColor.black
        captureSession=AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        else {
            scanerFailed()
            return
        }

        let metadataOutput=AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes=[.ean8, .ean13, .pdf417]
        }
        else{
            scanerFailed()
            return
        }

        previewLayer=AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame=view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession.isRunning == true {
            captureSession.stopRunning()
        }
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue=readableObject.stringValue else { return }
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            scanerFound(code: stringValue)
        }
        dismiss(animated: true)
    }
    func scanerFound(code: String) {
        database.scanerCodebarValue =  code //"34851998"
        self.title = code
        navigationController?.popViewController(animated: true)
        database.searchEanCode()
    }
    func scanerFailed() {
        let allertController=UIAlertController(title: "Scaning not suported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(allertController, animated: true)
        captureSession=nil
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
    }
}
