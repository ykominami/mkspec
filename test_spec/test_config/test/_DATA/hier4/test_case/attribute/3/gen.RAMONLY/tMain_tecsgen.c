/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tMain_tecsgen.h"
#include "tMain_factory.h"


/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sMain_VDES attr1_eMain_des;
extern struct tag_sMain_VDES attr2_eMain_des;
extern struct tag_sMain_VDES attr3_eMain_des;
extern struct tag_sMain_VDES tst_eMain_des;
extern struct tag_sMain_VDES tst2_eMain_des;

/* call port array #_CPA_# */
struct tag_sMain_VDES * const Main_cMain[] = {
    &attr1_eMain_des,
    &attr2_eMain_des,
    &attr3_eMain_des,
    &tst_eMain_des,
    &tst2_eMain_des,
};

/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
struct tag_tMain_CB tMain_SINGLE_CELL_CB = 
{
    /* call port (CB_ALL) #_CP_# */ 
    Main_cMain,                              /* #_CCP3B_# */
    5,                                       /* length of cMain (n_cMain) #_CCP4_# */
    /* attribute */ 
    100,                                     /* a */
    /* var */ 
    100,                                     /* v */
};

/* entry port descriptor #_EPD_# */
