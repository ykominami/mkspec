/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tSCt_no_CB_a_INIB_tecsgen.h"
#include "tSCt_no_CB_a_INIB_factory.h"


/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
int8_t tSCt_no_CB_a_INIB_SINGLE_CELL_CB_buf_INIT[6];
/* cell INIB #_INIB_# */
tSCt_no_CB_a_INIB_INIB tSCt_no_CB_a_INIB_SINGLE_CELL_INIB = 
{
    /* attribute(RO) */ 
    6,                                       /* size */
    tSCt_no_CB_a_INIB_SINGLE_CELL_CB_buf_INIT, /* buf */
};

/* entry port descriptor #_EPD_# */
/* CB initialize code #_CIC_# */
void
tSCt_no_CB_a_INIB_CB_initialize()
{
    SET_CB_INIB_POINTER(i,p_cb)
    INITIALIZE_CB()
}
