//
//  WaterfallSeriesView.swift
//  FioriCharts
//
//  Created by Xu, Sheng on 6/23/20.
//

import SwiftUI


struct WaterfallSeriesView: View {
    @EnvironmentObject var model: ChartModel
    @Environment(\.layoutDirection) var layoutDirection
    
    let plotSeries: [ChartPlotData]
    let rect: CGRect
    let isSelectionView: Bool
    
    var body: some View {
        let columnWidth: CGFloat = plotSeries.first != nil ? plotSeries[0].rect.size.width * self.rect.size.width * self.model.scale : 0

        return VStack(alignment: .center, spacing: 0) {
            ForEach(plotSeries, id: \.self) { item in
                VStack(spacing: 0) {
                    Spacer(minLength: 0)
                        
                    ZStack() {
                        LineShape(pos1: CGPoint(x: 0, y: 0),
                                  pos2: CGPoint(x: columnWidth, y: 0),
                                  layoutDirection: self.layoutDirection)
                            .stroke(Color.preferredColor(.primary4), lineWidth: 1)
                        
                        LineShape(pos1: CGPoint(x: 0, y: item.rect.size.height * self.rect.size.height),
                                  pos2: CGPoint(x: columnWidth, y: item.rect.size.height * self.rect.size.height),
                                  layoutDirection: self.layoutDirection)
                            .stroke(Color.preferredColor(.primary4), lineWidth: 1)
                    }.background(self.columnColor(for: item))
                        .frame(width: columnWidth, height: item.rect.size.height * self.rect.size.height)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: columnWidth,
                               height: item.rect.origin.y * self.rect.size.height)
                }
            }
        }
    }
    
    func columnColor(for item: ChartPlotData) -> Color {
        if !isSelectionView {
            return model.colorAt(seriesIndex: item.seriesIndex,
                                 categoryIndex: item.categoryIndex)
        } else {
            if item.selected {
                return model.fillColorAt(seriesIndex: item.seriesIndex,
                                         categoryIndex: item.categoryIndex)
            } else {
                return .clear
            }
        }
    }
    
    func isSubTotal(categoryIndex: Int) -> Bool {
        return categoryIndex == 0 ? true : model.indexesOfTotalsCategories.contains(categoryIndex)
    }
}

struct WaterfallSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Tests.waterfallModels[0]
        let axisDataSource = WaterfallAxisDataSource()
        let pd = axisDataSource.plotData(model)
        
        return WaterfallSeriesView(plotSeries: pd[0],
                                   rect: CGRect(x: 0, y: 0, width: 300, height: 200),
                                   isSelectionView: false)
            .environmentObject(model)
    }
}

