//
//  MockSDUIBuilder.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/02/25.
//

import Foundation
@testable import Shared

struct MockSDUIBuilder {
    static func make() -> SDUIBuilder {
        return SDUIBuilder(components: [
            MockSDUIComponentData.makeBalanceCard(),
            MockSDUIComponentData.makeQuickMenuButtons(),
            MockSDUIComponentData.makeInvestmentCard()
        ])
    }
}

struct MockSDUIComponentData {
    static func makeBalanceCard() -> SDUIComponentData {
        return SDUIComponentData(model: MockBalanceCardModel.make(), config: MockSDUIConfig.make())
    }
    
    static func makeQuickMenuButtons() -> SDUIComponentData {
        return SDUIComponentData(model: MockQuickMenuButtonsModel.make(), config: MockSDUIConfig.make())
    }
    
    static func makeInvestmentCard() -> SDUIComponentData {
        return SDUIComponentData(model: MockInvestmentCardsModel.make(), config: MockSDUIConfig.make())
    }
}

struct MockBalanceCardModel {
    static func make(
        value: Double = 2500.75,
        icon: String = "balance_icon",
        config: SDUIConfig? = MockSDUIConfig.make()
    ) -> BalanceCardModel {
        return BalanceCardModel(value: value, icon: icon, config: config)
    }
}

struct MockServiceMenuButtonModel {
    static func make(
        title: String = "Pagar",
        icon: String = "pay_icon",
        action: String = "pay_action",
        config: SDUIConfig? = MockSDUIConfig.make()
    ) -> ServiceMenuButtonModel {
        return ServiceMenuButtonModel(title: title, icon: icon, action: action, config: config)
    }
}

struct MockQuickMenuButtonsModel {
    static func make(
        buttons: [ServiceMenuButtonModel] = [MockServiceMenuButtonModel.make(), MockServiceMenuButtonModel.make(title: "Transferir", icon: "transfer_icon", action: "transfer_action")],
        config: SDUIConfig? = MockSDUIConfig.make()
    ) -> QuickMenuButtonsModel {
        return QuickMenuButtonsModel(buttons: buttons, config: config)
    }
}

struct MockInvestmentCardModel {
    static func make(
        title: String = "Investimento Renda Fixa",
        value: Double = 10000.0,
        action: String = "invest_action",
        config: SDUIConfig? = MockSDUIConfig.make()
    ) -> InvestmentCardModel {
        return InvestmentCardModel(title: title, value: value, action: action, config: config)
    }
}

struct MockInvestmentCardsModel {
    static func make(
        cards: [InvestmentCardModel] = [MockInvestmentCardModel.make(), MockInvestmentCardModel.make(title: "Investimento em Ações", value: 5000.0)],
        config: SDUIConfig? = MockSDUIConfig.make()
    ) -> InvestmentCardsModel {
        return InvestmentCardsModel(cards: cards, config: config)
    }
}

struct MockSDUIConfig {
    static func make() -> SDUIConfig {
        return SDUIConfig(colors: MockSDUIColor.make(), spacing: MockSDUISpacing.make())
    }
}

struct MockSDUIColor {
    static func make() -> SDUIColor {
        return SDUIColor(
            background: "#FFFFFF",
            borderColor: "#CCCCCC",
            iconColor: "#000000",
            textColor: "#333333",
            descriptionColor: "#666666",
            investmentsColor: "#FF9900"
        )
    }
}

struct MockSDUISpacing {
    static func make() -> SDUISpacing {
        return SDUISpacing(
            topSpacer: 10.0,
            leadingSpacer: 15.0,
            trailingSpacer: 15.0,
            bottomSpacer: 10.0
        )
    }
}
