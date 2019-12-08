//
// Created by Nathan Flint on 12/8/19.
//

#ifndef ROG11SRC_RANDOM_H
#define ROG11SRC_RANDOM_H

extern long seed;				/* Random number seed */

#define RN		(((seed = seed*11109L+13849L) >> 16) & 0xffff)
/*
 * Random number generator -
 * adapted from the FORTRAN version
 * in "Software Manual for the Elementary Functions"
 * by W.J. Cody, Jr and William Waite.
 */

long ran();
/*
 * rnd:
 *	Pick a very random number.
 */
int rnd(int range);

/*
 * roll:
 *	Roll a number of dice
 */
int roll(int number, int sides);

#endif //ROG11SRC_RANDOM_H
