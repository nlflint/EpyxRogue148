//
// Created by Nathan Flint on 12/7/19.
//

#ifndef ROG11SRC_DAEMON_H
#define ROG11SRC_DAEMON_H

void daemon(int (*func)(), int arg);
void fuse(int (*func)(), int arg, int time);

#endif //ROG11SRC_DAEMON_H
