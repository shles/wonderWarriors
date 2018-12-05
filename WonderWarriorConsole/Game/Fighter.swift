//
// Created by Артмеий Шлесберг on 2018-11-05.
// Copyright (c) 2018 Shlesberg. All rights reserved.
//

import Foundation

protocol Fighter {
    //TODO: make generic
    typealias C = BasicCharacteristics
    var name: String { get }
    var state: FighterState {get}
    var gear: AnyEffect<C> { get }
    func nextAbility(selection: AbilitySelection) -> AnyEffect<C>
}

protocol BasicCharacteristics {
    var health: Float { get }
}

class FullBasicCharacteristics: BasicCharacteristics {
    private(set) var health: Float = 100
}

class FighterWithBasicCharacteristicsFrom: Fighter {

    private(set) var name: String
    private(set) var state: FighterState
    private(set) var gear: AnyEffect<BasicCharacteristics>

    private let abilities: [AnyEffect<BasicCharacteristics>]

    init (name: String,
          initialState: FighterState,
          gear: AnyEffect<BasicCharacteristics>,
          abilities: [AnyEffect<BasicCharacteristics>]) {
        self.gear = gear
        self.state = initialState
        self.name = name
        self.abilities = abilities
}

    func nextAbility(selection: AbilitySelection) -> AnyEffect<BasicCharacteristics> {
        return selection.select(from: abilities)
    }
}

class FighterWithBasicCharacteristicsApplyingAbility: Fighter {

    var name: String {
        return originFighter.name
    }

    func nextAbility(selection: AbilitySelection) -> AnyEffect<BasicCharacteristics> {
        return originFighter.nextAbility(selection: selection)
    }
    lazy var state: FighterState = {
        return FighterStateApplyingAbility(fighterState: originFighter.state, ability: ability)
    }()

    lazy var gear: AnyEffect<BasicCharacteristics> = {
        return ability.modifyEffect(effect: originFighter.gear)
    }()

    private var originFighter: Fighter
    private var ability: AnyEffect<BasicCharacteristics>

    init(fighter: Fighter, ability: AnyEffect<BasicCharacteristics>) {
        self.ability = ability
        self.originFighter = fighter
    }

}