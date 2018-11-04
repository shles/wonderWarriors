//
// Created by Артмеий Шлесберг on 2018-11-05.
// Copyright (c) 2018 Shlesberg. All rights reserved.
//

import Foundation

protocol FighterState {
    var health: Float { get }
}

class FighterStateApplyingAbility: FighterState {

    lazy var health: Float  = {
        return ability.affectHealth(health: fighterState.health)
    }()

    private var fighterState: FighterState
    private var ability: Ability

    init(fighterState: FighterState, ability: Ability) {
        self.ability = ability
        self.fighterState = fighterState
    }
}

class HundredHealthState: FighterState {
    var health: Float = 100
}