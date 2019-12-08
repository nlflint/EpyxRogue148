//
// Created by Nathan Flint on 12/7/19.
//

#ifndef ROG11SRC_INIT_H
#define ROG11SRC_INIT_H

void init_player(void);
void init_ds(void);
void init_things(void);
void init_names(void);
void init_colors(void);
void init_stones(void);
void init_materials(void);

/*
 *  Declarations for data space that must be saved and restored exaxtly
 */
byte *_level;
byte *_flags;


#endif //ROG11SRC_INIT_H`
