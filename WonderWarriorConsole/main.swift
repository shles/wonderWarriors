//
//  main.swift
//  WonderWarriorConsole
//
//  Created by Артмеий Шлесберг on 2018-11-05.
//  Copyright © 2018 Shlesberg. All rights reserved.
//

import Foundation

print("Hello, World!")

let fight = SimpleRandomFight(
    initialState: FightStateFrom(
        orderedFighters: OrderedFightersFrom(
            attacker: FighterFrom(
                name:"Des",
                initialState: HundredHealthState(),
                gear: EmptyGear(),
                atkAbilities: [SimpleAttack(), HeavyAttack()],
                defAbilities: [Idle()]
            ),
            defender: FighterFrom(
                name: "Troy",
                initialState: HundredHealthState(),
                gear: EmptyGear(),
                atkAbilities: [SimpleAttack(), HeavyAttack()],
                defAbilities: [Idle()]
            )
        ), endingCondition: DeathEndingCondition() //WHY?
    ),
    endingCondition: DeathEndingCondition()
)

fight.start()