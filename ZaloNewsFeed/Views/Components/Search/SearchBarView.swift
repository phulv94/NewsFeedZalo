import SwiftUI

struct SearchBarView: View {
    @State private var searchText: String = ""
    private let skyBlue = Color(red: 112 / 255, green: 204 / 255, blue: 225 / 255)

    var body: some View {
        HStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)

                    TextField("Search", text: $searchText)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundStyle(.white)

                    Spacer(minLength: 0)

                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.white)

                    Image(systemName: "bell")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.blue)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
