/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tMain_tecsgen.h"
#include "tMain_factory.h"

/* entry port descriptor type #_EDT_# */
/* eMain */
struct tag_tMain_eMain_DES {
    const struct tag_sTaskBody_VMT *vmt;
    tMain_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eMain */
void           tMain_eMain_main_skel( const struct tag_sTaskBody_VDES *epd)
{
    struct tag_tMain_eMain_DES *lepd
        = (struct tag_tMain_eMain_DES *)epd;
    tMain_eMain_main( lepd->idx );
}

/* entry port skelton function table #_EPSFT_# */
/* eMain */
const struct tag_sTaskBody_VMT tMain_eMain_MT_ = {
    tMain_eMain_main_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sHello_VDES Talker0_eHello_des;
extern struct tag_sHello_VDES Talker0_eHello_des;

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
struct tag_tMain_CB tMain_CB_tab[] = {
    /* cell: tMain_CB_tab[0]:  Main id=1 */
    {
        /* call port (CB_ALL) #_CP_# */ 
        &Talker0_eHello_des,                     /* cDefaultTalker #_CCP1_# */
        &Talker0_eHello_des,                     /* cTalker #_CCP1_# */
        /* entry port #_EP_# */ 
    },
};

/* entry port descriptor #_EPD_# */
extern const struct tag_tMain_eMain_DES Main_eMain_des;
const struct tag_tMain_eMain_DES Main_eMain_des = {
    &tMain_eMain_MT_,
    &tMain_CB_tab[0],      /* CB 3 */
};
