/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tSerialTaskBody_tecsgen.h"
#include "tSerialTaskBody_factory.h"

/* entry port descriptor type #_EDT_# */
/* eTaskBody : omitted by entry port optimize */

/* entry port skelton function #_EPSF_# */
/* eTaskBody : omitted by entry port optimize */

/* entry port skelton function table #_EPSFT_# */
/* eTaskBody : omitted by entry port optimize */

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sTaskBody_VDES Main_eMain_des;
extern struct tag_sTaskBody_VDES rComposite_CompMain_Main_eMain_des;

/* call port array #_CPA_# */
struct tag_sTaskBody_VDES * const Task_SerialTaskBody_cBodyArray[] = {
    &Main_eMain_des,
    &rComposite_CompMain_Main_eMain_des,
};

/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
struct tag_tSerialTaskBody_CB tSerialTaskBody_CB_tab[] = {
    /* cell: tSerialTaskBody_CB_tab[0]:  Task_SerialTaskBody id=1 */
    {
        /* call port (CB_ALL) #_CP_# */ 
        Task_SerialTaskBody_cBodyArray,          /* #_CCP3B_# */
        2,                                       /* length of cBodyArray (n_cBodyArray) #_CCP4_# */
        0,                                       /* #_CCP9_# */
        0,                                       /* length of cTaskExceptionBodyArray (n_cTaskExceptionBodyArray) #_CCP6_# */
        /* entry port #_EP_# */ 
        /* attribute */ 
        "tSerialTask_Task",                      /* name */
    },
};

/* entry port descriptor #_EPD_# */
/* eTaskBody : omitted by entry port optimize */
