/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tMainSingleton_tecsgen.h"
#include "tMainSingleton_factory.h"

/* entry port descriptor type #_EDT_# */
/* eMain */
struct tag_tMainSingleton_eMain_DES {
    const struct tag_sTaskBody_VMT *vmt;
    tMainSingleton_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eMain */
void           tMainSingleton_eMain_main_skel( const struct tag_sTaskBody_VDES *epd)
{
    tMainSingleton_eMain_main( );
}

/* entry port skelton function table #_EPSFT_# */
/* eMain */
const struct tag_sTaskBody_VMT tMainSingleton_eMain_MT_ = {
    tMainSingleton_eMain_main_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sHello_VDES Talker0_eHello_des;
extern struct tag_sHello_VDES Talker0_eHello_des;

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
tMainSingleton_INIB tMainSingleton_SINGLE_CELL_INIB = 
{
    /* call port (INIB) #_CP_# */ 
    &Talker0_eHello_des,                     /* cDefaultTalker #_CCP1_# */
    &Talker0_eHello_des,                     /* cTalker_init_ #_CCP1_# */
    /* entry port #_EP_# */ 
};

/* cell CB #_CB_# */
struct tag_tMainSingleton_CB tMainSingleton_SINGLE_CELL_CB;
/* entry port descriptor #_EPD_# */
extern const struct tag_tMainSingleton_eMain_DES Main_eMain_des;
const struct tag_tMainSingleton_eMain_DES Main_eMain_des = {
    &tMainSingleton_eMain_MT_,
    &tMainSingleton_SINGLE_CELL_CB,      /* CB 3 */
};
/* CB initialize code #_CIC_# */
void
tMainSingleton_CB_initialize()
{
    SET_CB_INIB_POINTER(i,p_cb)
    INITIALIZE_CB()
}
