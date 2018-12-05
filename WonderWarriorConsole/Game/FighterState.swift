//
// Created by Артмеий Шлесберг on 2018-11-05.
// Copyright (c) 2018 Shlesberg. All rights reserved.
//

import Foundation

protocol FighterState {
//    typealias C =
//TODO: make generic
    var characteristicsSet: BasicCharacteristics { get }
    var effect: AnyEffect<BasicCharacteristics> {get}
}

class FighterStateApplyingAbility: FighterState {
    lazy var characteristicsSet: BasicCharacteristics = {
        return ability.modifyCharacteristics(characteristics: fighterState.characteristicsSet)
    }()
    private var fighterState: FighterState
    private var ability: AnyEffect<BasicCharacteristics>

    init(fighterState: FighterState, ability: AnyEffect<BasicCharacteristics> ) {
        self.ability = ability
        self.fighterState = fighterState
    }
}