//
// Created by Nathan Flint on 12/8/19.
//

#ifndef ROG11SRC_FIGHT_H
#define ROG11SRC_FIGHT_H

int is_magic(THING *obj);
void remove(coord *mp, THING *tp, bool waskill);
void killed(THING *tp, bool pr);

#endif //ROG11SRC_FIGHT_H
