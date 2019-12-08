//
// Created by Nathan Flint on 12/8/19.
//

#include "random.h"

long seed;				/* Random number seed */

#define RN		(((seed = seed*11109L+13849L) >> 16) & 0xffff)
/*
 * Random number generator -
 * adapted from the FORTRAN version
 * in "Software Manual for the Elementary Functions"
 * by W.J. Cody, Jr and William Waite.
 */
long ran()
{
    seed *= 125;
    seed -= (seed/2796203) * 2796203;
    return seed;
}

/*
 * rnd:
 *	Pick a very random number.
 */
int rnd(int range)
{
    return range < 1 ? 0 : ((ran() + ran())&0x7fffffffl) % range;
}

/*
 * roll:
 *	Roll a number of dice
 */
int roll(int number, int sides)
{
    register int dtotal = 0;

    while (number--)
        dtotal += rnd(sides)+1;
    return dtotal;
}
