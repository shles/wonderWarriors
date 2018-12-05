//
// Created by Артмеий Шлесберг on 2018-11-05.
// Copyright (c) 2018 Shlesberg. All rights reserved.
//

import Foundation

protocol Fight {
    func start()
}

protocol Gear {

}

protocol Ability {
    func affectHealth(health: Float) -> Float
}

protocol AbilitySelection {
    func select<C>(from: [AnyEffect<C>]) -> AnyEffect<C>
}


protocol FightState {
    var attacker: Fighter { get }
    var defender: Fighter { get }
    //Maybe not here
    var isOver: Bool { get }
}

//TODO: Name it properly
protocol FightEndCondition {
    func isOver(fighter1: Fighter, fighter2: Fighter) -> Bool
}

protocol OrderedFighters {
    var inOreder: (Fighter, Fighter) {get}
}

class DeathEndingCondition: FightEndCondition {
    func isOver(fighter1: Fighter, fighter2: Fighter) -> Bool {
        if fighter1.state.health <= 0 {
            print("\(fighter2.name) wins!")
            return true
        } else if fighter2.state.health <= 0 {
            print("\(fighter1.name) wins!")
            return true
        } else {
            return false
        }
    }
}


class FightStateFrom: FightState {

    lazy var isOver: Bool = endingCondition.isOver(fighter1: self.attacker, fighter2: self.defender)
    private var endingCondition: FightEndCondition
    var attacker: Fighter
    var defender: Fighter

    init(orderedFighters: OrderedFighters, endingCondition: FightEndCondition) {
        (attacker, defender) = orderedFighters.inOreder
        self.endingCondition = endingCondition
    }
}

class OrderedFightersFrom: OrderedFighters {
    private var attacker: Fighter
    private var defender: Fighter

    var inOreder: (Fighter, Fighter) {
        return (attacker, defender)
    }

    init(attacker: Fighter, defender: Fighter) {
        self.attacker = attacker
        self.defender = defender
    }
}





class EmptyGear: Gear {

}

class GearApplyingAbility: Gear {

    private var gear: Gear
    private var ability: Ability

    init(gear: Gear, ability: Ability) {
        self.ability = ability
        self.gear = gear
    }
}

class RandomAbilitySelection: AbilitySelectoin {
    func select(from: [Ability]) -> Ability {
        return from.randomElement()!
    }

}

class SimpleRandomFight: Fight {

    private var initialState: FightState
    private var endingCondition: FightEndCondition

    init(initialState: FightState, endingCondition: FightEndCondition) {
        self.initialState = initialState
        self.endingCondition = endingCondition
    }

    func start() {
        makeTurn(turn: SimpleSwitchingTurn(
            state: initialState,
            endingCondition: endingCondition,
            abilitySelection: RandomAbilitySelection()
        ))
    }

    private func makeTurn(turn: Turn) {
        let newState = turn.stateAfterTurn
        if !newState.isOver {
            makeTurn(turn: SimpleSwitchingTurn(state: newState, endingCondition: endingCondition, abilitySelection: RandomAbilitySelection()))
        } else {
            print("Fight is over!")
        }
    }
}





