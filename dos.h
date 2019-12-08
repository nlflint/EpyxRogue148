//
// Created by Nathan Flint on 12/7/19.
//

#ifndef ROG11SRC_DOS_H
#define ROG11SRC_DOS_H

// Saves buffer to DS:OFFSET
void dmaout(char *buffer, int length, int ds, int offset);

// Saves DS:OFFSET to buffer
void dmain(char *buffer, int length, int ds, int offset);

#endif //ROG11SRC_DOS_H


