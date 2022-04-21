//
//  GRPCinteractor.swift
//  GRPC-framework
//
//  Created by Daniel on 4/10/22.
//

import Foundation
import GRPC
import NIO

public class GRPCInteractor: NSObject {
    
    public static let shared = GRPCInteractor()
    
    private var client: TestPack_TestServiceClient?
    private let group: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    public static func initialize(host: String, port: Int) {
        // build a fountain of EventLoops
        do {
          // open a channel to the gPRC server
          let channel = try GRPCChannelPool.with(
            target: .host(host, port: port),
            transportSecurity: .plaintext,
            eventLoopGroup: self.shared.group
          )
          // create a Client
            self.shared.client = TestPack_TestServiceClient(channel: channel)
          print("grpc connection initialized")
        } catch {
          print("Couldn’t connect to gRPC server")
        }
    }
    
    public func testSimpleCallWithErrorResponse(
        value: String
    ) throws -> String {
        var teste = TestPack_SimpleCallRequest.init()
        teste.value = value
        do {
            let response = client!.testSimpleCallWithErrorResponse(teste, callOptions: nil)
                .response
                .map { response in
                    response.value
                }.hop(to: group.next())
                return try response.wait()
        } catch let err {
            throw err
        }
    }
    
    public func testSimpleCallWithResponse(
        value: String
    ) throws -> String {
        var teste = TestPack_SimpleCallRequest.init()
        teste.value = value
        do {
            let response = client!.testSimpleCallWithResponse(teste, callOptions: nil)
                .response
                .map { response in
                    response.value
                }.hop(to: group.next())
                return try response.wait()
        } catch let err {
            throw err
        }
    }
    
}
