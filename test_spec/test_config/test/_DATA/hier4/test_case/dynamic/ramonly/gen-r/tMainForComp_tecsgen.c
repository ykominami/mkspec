/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tMainForComp_tecsgen.h"
#include "tMainForComp_factory.h"

/* entry port descriptor type #_EDT_# */
/* eMain */
struct tag_tMainForComp_eMain_DES {
    const struct tag_sTaskBody_VMT *vmt;
    tMainForComp_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eMain */
void           tMainForComp_eMain_main_skel( const struct tag_sTaskBody_VDES *epd)
{
    struct tag_tMainForComp_eMain_DES *lepd
        = (struct tag_tMainForComp_eMain_DES *)epd;
    tMainForComp_eMain_main( lepd->idx );
}

/* entry port skelton function table #_EPSFT_# */
/* eMain */
const struct tag_sTaskBody_VMT tMainForComp_eMain_MT_ = {
    tMainForComp_eMain_main_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sHello_VDES rComposite_Talker0_eHello_des;
extern struct tag_sHello_VDES rComposite_Talker0_eHello_des;

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
/* cell: rComposite_CompMain_Main_CB:  CompMain_Main id=1 */
tMainForComp_CB rComposite_CompMain_Main_CB = {
    /* call port (CB_ALL) #_CP_# */ 
    &rComposite_Talker0_eHello_des,          /* cDefaultTalker #_CCP1_# */
    &rComposite_Talker0_eHello_des,          /* cTalker #_CCP1_# */
    /* entry port #_EP_# */ 
};

/* entry port descriptor #_EPD_# */
extern const struct tag_tMainForComp_eMain_DES rComposite_CompMain_Main_eMain_des;
const struct tag_tMainForComp_eMain_DES rComposite_CompMain_Main_eMain_des = {
    &tMainForComp_eMain_MT_,
    1,     /* ID */
};
/* ID to CB table #_CBTAB_# */
tMainForComp_CB *const tMainForComp_CB_ptab[] ={
    &rComposite_CompMain_Main_CB,
};
