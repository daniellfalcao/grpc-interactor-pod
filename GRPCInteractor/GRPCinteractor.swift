//
//  GRPCinteractor.swift
//  GRPC-framework
//
//  Created by Daniel on 4/10/22.
//

import Foundation
import GRPC
import NIO

class GRPCInteractor: NSObject {
    
    static let shared = GRPCInteractor()
    
    private var client: TestPack_TestServiceClient?
    private let group: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    static func initialize(host: String, port: Int) {
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
    
    func testSimpleCallWithErrorResponse(request: TestPack_SimpleCallRequest) -> EventLoopFuture<Any> {
        
        let teste = TestPack_SimpleCallRequest()
        return client!.testSimpleCallWithErrorResponse(teste, callOptions: nil)
            .response
            .map { response in
                response.value
            }.hop(to: group.next())
    }
}
