/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tTask_tecsgen.h"
#include "tTask_factory.h"

/* entry port descriptor type #_EDT_# */
/* eTask : omitted by entry port optimize */

/* entry port skelton function #_EPSF_# */
/* eTask : omitted by entry port optimize */

/* entry port skelton function table #_EPSFT_# */
/* eTask : omitted by entry port optimize */

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
tTask_INIB tTask_INIB_tab[] = {
    /* cell: tTask_CB_tab[0]:  Task1 id=1 */
    {
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        TA_ACT,                                  /* attribute */
        0,                                       /* priority */
        4096,                                    /* stackSize */
        "tTask_Task1",                           /* name */
    },
};

/* cell CB #_CB_# */
struct tag_tTask_CB tTask_CB_tab[] = {
    /* cell: tTask_CB_tab[0]:  Task1 id=1 */
    {
        &tTask_INIB_tab[0],                      /* _inib */
        /* entry port #_EP_# */ 
        /* var */ 
        0,                                       /* my_thread */
        0,                                       /* my_cond */
        0,                                       /* my_mutex */
        0,                                       /* state */
    },
};

/* entry port descriptor #_EPD_# */
/* eTask : omitted by entry port optimize */
