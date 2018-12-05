//
// Created by Артмеий Шлесберг on 2018-11-05.
// Copyright (c) 2018 Shlesberg. All rights reserved.
//

import Foundation

//TODO: need to design something that return new effect for fighter.

protocol Effect {

    associatedtype CharacteristicsSet

    func modifyEffect(effect: AnyEffect<CharacteristicsSet>) -> AnyEffect<CharacteristicsSet>
    func modifyCharacteristics(characteristics: CharacteristicsSet) -> CharacteristicsSet

    func asAnyEffect() -> AnyEffect<CharacteristicsSet>

}

extension Effect {
    func asAnyEffect() -> AnyEffect<CharacteristicsSet> {
        return AnyEffect(self)
    }
}


class AnyEffect<CharacteristicsSet>: Effect {

    private var effectModification: (AnyEffect<CharacteristicsSet>) -> AnyEffect<CharacteristicsSet>
    private var characteristicsModification: (CharacteristicsSet) -> CharacteristicsSet

    init<E: Effect>(_ origin: E) where E.CharacteristicsSet == CharacteristicsSet {
        self.characteristicsModification = origin.modifyCharacteristics
        self.effectModification = origin.modifyEffect
    }

    func modifyEffect(effect: AnyEffect<CharacteristicsSet>) -> AnyEffect<CharacteristicsSet> {
        return effectModification(effect)
    }

    func modifyCharacteristics(characteristics: CharacteristicsSet) -> CharacteristicsSet {
        return characteristicsModification(characteristics)
    }

}

class SimpleAttack: Ability {
    func affectHealth(health: Float) -> Float {
        let newHealf = health - 20
        print("makes simple attack\t(20 DMG | \(newHealf) HP left).")
        return newHealf
    }
}

class HeavyAttack: Ability {
    func affectHealth(health: Float) -> Float {
        let newHealf = health - 40
        print("makes heavy attack\t(40 DMG | \(newHealf) HP left).")
        return newHealf
    }
}

class SimpleBlock: Ability {
    func affectHealth(health: Float) -> Float {

        print("makes simple block (+20 HP).")
        return health + 20
    }
}

class Idle: Ability {
    func affectHealth(health: Float) -> Float {

        print("makes nothing :/.")
        return health
    }
}