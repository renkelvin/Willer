//
//  Player.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import Foundation

class Player: NSObject {

    var no: Int = 0

    var character: Character = Character()

    var effectMachine: EffectMachine = EffectMachine()

    var stateMachine: StateMachine = StateMachine()

    // MARK: -

    override init() {

    }

    // MARK: -

    func settle() {
        let alive = self.effectMachine.settle()
        self.stateMachine.alive = alive
    }

    func steps() -> [Step] {
        var steps = [Step]()
                for (_, ability) in self.character.abilities {
                    steps.append(ability.step())
                }
        return steps
    }

}
