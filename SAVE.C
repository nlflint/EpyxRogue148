/*
 * save and restore routines
 *
 * save.c	1.32	(A.I. Design)	12/13/84
 */

/*
 *  routines for saving a program in any given state.
 *  This is the first pass of this, so I have no idea
 *  how it is really going to work.
 *  The two basic functions here will be "save" and "restor".
 */

/*
 * save_game:
 *	Implement the "save game" command
 */
void save_game(void)
{

}

/*
 *	Restore:
 *		Open saved data file, read in header, and determine how much
 *		data area is going to be restored,
 *		Close save data file,
 *		Allocate enough data space so that open data file information
 *		will be stored outside the data area that will be restored,
 *		Now reopen data save file,
 *		skip header,
 *		dump into memory all saved data.
 */
void restore(char *savefile)
{

}