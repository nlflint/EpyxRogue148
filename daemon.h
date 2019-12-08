//
// Created by Nathan Flint on 12/7/19.
//

#ifndef ROG11SRC_DAEMON_H
#define ROG11SRC_DAEMON_H

void daemon(int (*func)(), int arg);
void fuse(int (*func)(), int arg, int time);
void do_fuses(void);
void do_daemons(void);
void lengthen(int (*func)(), int xtime);

#endif //ROG11SRC_DAEMON_H
