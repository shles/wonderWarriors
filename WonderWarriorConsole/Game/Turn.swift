//
// Created by Артмеий Шлесберг on 2018-11-05.
// Copyright (c) 2018 Shlesberg. All rights reserved.
//

import Foundation

protocol Turn {
    var stateAfterTurn: FightState { get }
}

//Pass some rendering system.
//EveryThing Should be Renderable(?) or smth. They will render them self using this system
//Or give an object like Render to be siplayed by the system
class SimpleSwitchingTurn: Turn {
    //Now can only aplly attack. Need to make more complex system of ability interactiion.
    //maybe there should be difference between attaking and defending abilities types
    lazy var stateAfterTurn: FightState = {
        print("Fighter's \(initialState.attacker.name) turn")
        //swap fighters and apply attack to deffender
        return FightStateFrom(
            orderedFighters: OrderedFightersFrom(
                attacker: FighterApplyingAbilyty(
                    fighter: initialState.defender,
                    ability: initialState.attacker.nextAbility(selection: abilitySelection)
                ),
                defender: initialState.attacker
            ),
            endingCondition: endingCondition
        )
    }()

    private var initialState: FightState
    private var endingCondition: FightEndCondition
    private var abilitySelection: AbilitySelectoin

    init(state: FightState, endingCondition: FightEndCondition, abilitySelection: AbilitySelectoin) {
        self.initialState = state
        self.endingCondition = endingCondition
        self.abilitySelection = abilitySelection
    }

}