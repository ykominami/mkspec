/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tMainSingleArrayForComp_tecsgen.h"
#include "tMainSingleArrayForComp_factory.h"

/* entry port descriptor type #_EDT_# */
/* eMain */
struct tag_tMainSingleArrayForComp_eMain_DES {
    const struct tag_sTaskBody_VMT *vmt;
    tMainSingleArrayForComp_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eMain */
void           tMainSingleArrayForComp_eMain_main_skel( const struct tag_sTaskBody_VDES *epd)
{
    tMainSingleArrayForComp_eMain_main( );
}

/* entry port skelton function table #_EPSFT_# */
/* eMain */
const struct tag_sTaskBody_VMT tMainSingleArrayForComp_eMain_MT_ = {
    tMainSingleArrayForComp_eMain_main_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sHello_VDES rComposite_Talker0_eHello_des;
extern struct tag_sHello_VDES rComposite_Talker0_eHello_des;
extern struct tag_sHello_VDES rComposite_Talker1_eHello_des;
extern struct tag_sHello_VDES rComposite_Talker2_eHello_des;

/* call port array #_CPA_# */
struct tag_sHello_VDES * rComposite_CompMain_Main_cTalker[] = {
    &rComposite_Talker0_eHello_des,
    &rComposite_Talker1_eHello_des,
    &rComposite_Talker2_eHello_des,
};
struct tag_sHello_VDES * rComposite_CompMain_Main_cTalker2[] = {
    0,
    0,
};

/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
struct tag_tMainSingleArrayForComp_CB tMainSingleArrayForComp_SINGLE_CELL_CB = 
{
    /* call port (CB_ALL) #_CP_# */ 
    &rComposite_Talker0_eHello_des,          /* cDefaultTalker #_CCP1_# */
    rComposite_CompMain_Main_cTalker,        /* #_CCP3B_# */
    3,                                       /* length of cTalker (n_cTalker) #_CCP4_# */
    rComposite_CompMain_Main_cTalker2,       /* #_CCP8_# */
    /* entry port #_EP_# */ 
};

/* entry port descriptor #_EPD_# */
extern const struct tag_tMainSingleArrayForComp_eMain_DES rComposite_CompMain_Main_eMain_des;
const struct tag_tMainSingleArrayForComp_eMain_DES rComposite_CompMain_Main_eMain_des = {
    &tMainSingleArrayForComp_eMain_MT_,
    &tMainSingleArrayForComp_SINGLE_CELL_CB,      /* CB 3 */
};
