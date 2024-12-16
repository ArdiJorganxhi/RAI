import SwiftUI


struct ChatView: View {
    @StateObject private var chatBotViewModel = ChatBotViewModel()
    @State private var currentMessage: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                
                Spacer()
                
                Text("RAI")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                
                Spacer()
                }
            .padding()
            .background(Color.yellow)
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
                Text(chatBotViewModel.getTextForTyping())
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
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
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
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
