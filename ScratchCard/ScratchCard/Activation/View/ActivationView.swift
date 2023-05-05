import SwiftUI

struct ActivationView<ViewModel: ActivationViewModel>: View {

    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = ActivationViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Button("Activate") { viewModel.onActivate() }
            .navigationTitle("Activate Card")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActivationView_Previews: PreviewProvider {
    static var previews: some View {
        ActivationView(
            viewModel: ActivationViewModel()
        )
    }
}
