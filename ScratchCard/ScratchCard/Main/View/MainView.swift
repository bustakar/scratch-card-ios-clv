import SwiftUI

struct MainView<ViewModel: MainViewModel>: View {

    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = MainViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                CardView(card: viewModel.card)
                if viewModel.isActivated {
                    Text("Card has been activated")
                }
                HStack {
                    NavigationLink(
                        "Scratch",
                        destination: ScratchView()
                    )
                    .disabled(viewModel.isScratchButtonDisabled)
                    NavigationLink(
                        "Activate",
                        destination: ActivationView()
                    )
                    .disabled(viewModel.isActivateButtonDisabled)
                }
                .buttonStyle(.borderedProminent)
                .animation(.default, value: viewModel.isScratchButtonDisabled)
                .animation(.default, value: viewModel.isActivateButtonDisabled)
            }
            .padding()
            .animation(.default, value: viewModel.isActivated)
            .onAppear { viewModel.onAppear() }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
