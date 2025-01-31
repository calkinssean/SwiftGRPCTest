//
//  EchoClient.swift
//  SwiftGPRCTest
//
//  Created by Sean Calkins on 1/31/25.
//

import GRPC
import NIO
import SwiftProtobuf

class EchoClient {
    var client: Echo_EchoServiceAsyncClient?
    var connection: ClientConnection?
    let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    init() {
        let configuration = ClientConnection.Configuration(
            target: .hostAndPort("localhost", 50051),  // Address of your Python server
            eventLoopGroup: eventLoopGroup
        )
        
        connection = ClientConnection(configuration: configuration)
        client = Echo_EchoServiceAsyncClient(channel: connection!)
    }
    
    func callEcho(message: String) async throws -> String {
        var request = Echo_EchoRequest()
        request.message = message
        
        // Make the call to the Python server
        let response = try await client?.echo(request)
        return response?.message ?? "No response"
    }
    
    func hardCodedMessage() async throws -> String {
        let request = Echo_EchoRequest()
        let response = try await client?.hardCodedMessage(request)
        return response?.message ?? "No response"
    }
}
