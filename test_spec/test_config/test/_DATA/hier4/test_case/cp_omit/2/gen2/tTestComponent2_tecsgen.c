/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tTestComponent2_tecsgen.h"
#include "tTestComponent2_factory.h"

/* entry port descriptor type #_EDT_# */
/* entry port skelton function #_EPSF_# */

/* entry port skelton function table #_EPSFT_# */

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
tTestComponent2_INIB tTestComponent2_INIB_tab[] = {
    /* cell: tTestComponent2_CB_tab[0]:  Comp2_Cell id=1 */
    {
        /* entry port #_EP_# */ 
        2,                                       /*  #_EEP_# */
    },
};

/* entry port descriptor #_EPD_# */
/* CB initialize code #_CIC_# */
void
tTestComponent2_CB_initialize()
{
    tTestComponent2_CB	*p_cb;
    int		i;
    FOREACH_CELL(i,p_cb)
        SET_CB_INIB_POINTER(i,p_cb)
        INITIALIZE_CB(p_cb)
    END_FOREACH_CELL
}
