import SwiftUI

struct ScratchView<ViewModel: ScratchViewModel>: View {

    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = ScratchViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Button("Scratch") { viewModel.onScratch() }
            .onDisappear { viewModel.onDisappear() }
            .navigationTitle("Scratch Card")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScratchView_Previews: PreviewProvider {
    static var previews: some View {
        ScratchView(viewModel: ScratchViewModel())
    }
}
