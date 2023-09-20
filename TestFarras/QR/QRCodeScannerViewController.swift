//
//  QRCodeScannerViewController.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import AVFoundation
import UIKit

class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSessionForQR()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.startRunning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }
    
    private func setupCaptureSessionForQR() {
        captureSession = setupCaptureSession()
        
        do {
            try setupVideoCaptureInput()
        } catch {
            print(error)
            return
        }
        setupCaptureOutput()
        
        previewLayer = setupVideoPreviewLayer()
    }
    
    private func setupCaptureSession() -> AVCaptureSession {
        let captureSession = AVCaptureSession()
        return captureSession
    }
    private func setupVideoCaptureInput() throws {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            throw createError(with: "Can't find video devices")
        }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            captureSession.addInput(videoInput)
        } catch {
            throw error
        }
    }
    
    private func setupCaptureOutput() {
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)

        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
    }
    
    private func setupVideoPreviewLayer() -> AVCaptureVideoPreviewLayer {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        return previewLayer
    }
    
    private func createError(with localizedDescription: String) -> Error {
        let errorDomain = Bundle.main.bundleIdentifier ?? "com.farras.TestFarras"
        let errorCode = 0
        let errorUserInfo = [NSLocalizedDescriptionKey: localizedDescription]
        let error = NSError(domain: errorDomain, code: errorCode, userInfo: errorUserInfo)
        return error
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject, let stringValue = metadataObject.stringValue {
            
            
            guard let payment = getPayment(from: stringValue) else { return }
            let vc = PaymentConfirmationVC(paymentData: payment)
            navigationController?.setViewControllers([vc], animated: true)
            // Handle the scanned QR code data (stringValue)
            print("string value is", stringValue)
        }
    }
    
    private func getPayment(from strMetaData: String) -> Payment? {
        let components = strMetaData.components(separatedBy: ".")
        guard components.count == 4 else {return nil}
        
        let payment = Payment(
            transactionId: components[1],
            recipient: components[0],
            merchant: components[2],
            nominal: Int(components[3]) ?? 0)
        return payment
    }
}
