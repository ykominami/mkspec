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
/* cell CB #_CB_# */
struct tag_tTask_CB tTask_CB_tab[] = {
    /* cell: tTask_CB_tab[0]:  SerialTask_Task id=1 */
    {
        /* call port (CB_ALL) #_CP_# */ 
        /* entry port #_EP_# */ 
        /* attribute */ 
        TA_ACT,                                  /* attribute */
        11,                                      /* priority */
        4096,                                    /* stackSize */
        "tTask_SerialTask_Task",                 /* name */
        /* var */ 
        0,                                       /* my_thread */
        0,                                       /* my_cond */
        0,                                       /* my_mutex */
        0,                                       /* state */
    },
};

/* entry port descriptor #_EPD_# */
/* eTask : omitted by entry port optimize */
