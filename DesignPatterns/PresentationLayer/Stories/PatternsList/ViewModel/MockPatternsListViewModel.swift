//
//  MockPatternsListViewModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

final class MockPatternsListViewModel: PatternsListViewModelType {
    var message: AppMessageDisplayModel?
    var patternSections: [PatternsListSectionDisplayModel] = [
        .getStub(for: .architectural, numberOfItems: 5),
        .getStub(for: .behavioral, numberOfItems: 6)
    ]
    
    func loadPatterns() async {
    }
    
    func toggleSectionVisibility(for section: PatternsListSectionDisplayModel) {
        guard let index = patternSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        patternSections[index].isExpanded.toggle()
    }
    
    func patternSelected(_ pattern: PatternsListDisplayModel) {
    }
}
