/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tMainSingletonForComp_tecsgen.h"
#include "tMainSingletonForComp_factory.h"

/* entry port descriptor type #_EDT_# */
/* eMain */
struct tag_tMainSingletonForComp_eMain_DES {
    const struct tag_sTaskBody_VMT *vmt;
    tMainSingletonForComp_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eMain */
void           tMainSingletonForComp_eMain_main_skel( const struct tag_sTaskBody_VDES *epd)
{
    tMainSingletonForComp_eMain_main( );
}

/* entry port skelton function table #_EPSFT_# */
/* eMain */
const struct tag_sTaskBody_VMT tMainSingletonForComp_eMain_MT_ = {
    tMainSingletonForComp_eMain_main_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sHello_VDES rComposite_Talker0_eHello_des;
extern struct tag_sHello_VDES rComposite_Talker0_eHello_des;

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
tMainSingletonForComp_INIB tMainSingletonForComp_SINGLE_CELL_INIB = 
{
    /* call port (INIB) #_CP_# */ 
    &rComposite_Talker0_eHello_des,          /* cDefaultTalker #_CCP1_# */
    &rComposite_Talker0_eHello_des,          /* cTalker_init_ #_CCP1_# */
    /* entry port #_EP_# */ 
};

/* cell CB #_CB_# */
struct tag_tMainSingletonForComp_CB tMainSingletonForComp_SINGLE_CELL_CB;
/* entry port descriptor #_EPD_# */
extern const struct tag_tMainSingletonForComp_eMain_DES rComposite_CompMain_Main_eMain_des;
const struct tag_tMainSingletonForComp_eMain_DES rComposite_CompMain_Main_eMain_des = {
    &tMainSingletonForComp_eMain_MT_,
    &tMainSingletonForComp_SINGLE_CELL_CB,      /* CB 3 */
};
/* CB initialize code #_CIC_# */
void
tMainSingletonForComp_CB_initialize()
{
    SET_CB_INIB_POINTER(i,p_cb)
    INITIALIZE_CB()
}
