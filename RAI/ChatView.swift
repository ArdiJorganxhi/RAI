import SwiftUI


struct ChatView: View {
    @StateObject private var chatBotViewModel = ChatBotViewModel()
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Pershendetje zoteri Ardi, si mund te ju ndihmojme?", isUser: false)
    ]
    @State private var currentMessage: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(chatBotViewModel.chats) { message in
                        HStack {
                            if message.isUser {
                                Spacer()
                                Text(message.text)
                                    .padding()
                                    .background(Color.yellow)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(maxWidth: 250, alignment: .trailing)
                            } else {
                                Text(message.text)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                                    .frame(maxWidth: 250, alignment: .leading)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            HStack {
                Text("ChatBot is typing...")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                    .opacity(chatBotViewModel.isBotTyping ? 1 : 0)
                Spacer()
            }
            .padding(.bottom, 8)
            
            // Input field
            HStack {
                TextField("Type a message", text: $currentMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(8)
                
                Button(action: {chatBotViewModel.chat(in: currentMessage); currentMessage = ""}) {
                    Text("Send")
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .background(Color.black.opacity(0.85).edgesIgnoringSafeArea(.all))
    }
    
    private func sendMessage() {
        guard !currentMessage.isEmpty else { return }
        chatBotViewModel.chats.append(ChatMessage(text: currentMessage, isUser: true))
        Task {
            chatBotViewModel.chat(in: currentMessage)
        }
        simulateBotResponse()
        currentMessage = ""
    }
    
    private func simulateBotResponse() {
        let botResponses = [
            "Per momentin kemi probleme teknike me ATM ne degen e Prizrenit, ju kerkojme falje per kete incident."
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let response = botResponses.randomElement() ?? "Nuk jam i sigurt nese e kam kuptuar pyetjen tuaj."
            chatBotViewModel.chats.append(ChatMessage(text: response, isUser: false))
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
