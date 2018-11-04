//
// Created by Артмеий Шлесберг on 2018-11-05.
// Copyright (c) 2018 Shlesberg. All rights reserved.
//

import Foundation

protocol Fighter {
    var name: String { get }
    var state: FighterState {get}
    var gear: Gear { get }
    func nextAbility(selection: AbilitySelectoin) -> Ability
}

class FighterFrom: Fighter {
    var name: String
    var state: FighterState
    var gear: Gear

    //bad. same problem with distinguishing abilities types
    func nextAbility(selection: AbilitySelectoin) -> Ability {
        return selection.select(from: atkAbilities)
    }
    private var defAbilities: [Ability]
    private var atkAbilities: [Ability]
    init(name: String, initialState: FighterState, gear: Gear, atkAbilities: [Ability], defAbilities: [Ability]) {
        self.gear = gear
        self.atkAbilities = atkAbilities
        self.defAbilities = defAbilities
        self.state = initialState
        self.name = name
    }
}

class FighterApplyingAbilyty: Fighter {

    var name: String {
        return originFighter.name
    }

    func nextAbility(selection: AbilitySelectoin) -> Ability {
        return originFighter.nextAbility(selection: selection)
    }
    lazy var state: FighterState = {
        return FighterStateApplyingAbility(fighterState: originFighter.state, ability: ability)
    }()

    var gear: Gear {
        return GearApplyingAbility(gear: originFighter.gear, ability: ability)
    }

    private var originFighter: Fighter
    private var ability: Ability

    init(fighter: Fighter, ability: Ability) {
        self.ability = ability
        self.originFighter = fighter
    }

}