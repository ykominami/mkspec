/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tAttribute3_tecsgen.h"
#include "tAttribute3_factory.h"


/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
char tAttribute3_Attr3_CB_buf_INIT[5][2];
/* cell INIB #_INIB_# */
tAttribute3_INIB tAttribute3_INIB_tab[] = {
    /* cell: tAttribute3_CB_tab[0]:  Attr3 id=1 */
    {
        /* attribute(RO) */ 
        5,                                       /* size */
        tAttribute3_Attr3_CB_buf_INIT,           /* buf */
    },
};

/* entry port descriptor #_EPD_# */
/* CB initialize code #_CIC_# */
void
tAttribute3_CB_initialize()
{
    tAttribute3_CB	*p_cb;
    int		i;
    FOREACH_CELL(i,p_cb)
        SET_CB_INIB_POINTER(i,p_cb)
        INITIALIZE_CB(p_cb)
    END_FOREACH_CELL
}
