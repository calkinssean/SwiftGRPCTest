import Foundation
import GRPC
import NIO
import SwiftProtobuf

class ViewModel: ObservableObject {
    @Published var greetingText: String = ""
    @Published var responseText: String = ""

    private var echoClient: EchoClient

    init() {
        self.echoClient = EchoClient()
    }

    func sendEchoRequest() {
        Task {
            do {
                let response = try await echoClient.callEcho(message: greetingText)
                
                await updateResponseText(response)
            } catch {
                print("Failed to call gRPC service: \(error)")
                await updateResponseText("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getHardcodedResponse() {
        Task {
            do {
                let response = try await echoClient.hardCodedMessage()
                
                await updateResponseText(response)
            } catch {
                print("Failed to call gRPC service: \(error)")
                await updateResponseText("Error: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    func updateResponseText(_ text: String) {
        self.responseText = text
    }
}
