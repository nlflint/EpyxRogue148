//
// Created by Nathan Flint on 12/7/19.
//

#ifndef ROG11SRC_FIO_H
#define ROG11SRC_FIO_H

int open(char *filename, int mode);
int read(int fd, int *cd, int count);
int close(int fd);

#endif //ROG11SRC_FIO_H
