/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tCCP5Caller_tecsgen.h"
#include "tCCP5Caller_factory.h"

/* entry port descriptor type #_EDT_# */
/* eMain */
struct tag_tCCP5Caller_eMain_DES {
    const struct tag_sTaskBody_VMT *vmt;
    tCCP5Caller_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eMain */
void           tCCP5Caller_eMain_main_skel( const struct tag_sTaskBody_VDES *epd)
{
    struct tag_tCCP5Caller_eMain_DES *lepd
        = (struct tag_tCCP5Caller_eMain_DES *)epd;
    tCCP5Caller_eMain_main( lepd->idx );
}

/* entry port skelton function table #_EPSFT_# */
/* eMain */
const struct tag_sTaskBody_VMT tCCP5Caller_eMain_MT_ = {
    tCCP5Caller_eMain_main_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sSig_VDES CCP5E_1_eEnt_des;


/* call port array #_CPA_# */


/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
struct tag_tCCP5Caller_CB tCCP5Caller_CB_tab[] = {
    /* cell: tCCP5Caller_CB_tab[0]:  CCP5R_1 id=1 */
    {
        /* call port (CB_ALL) #_CP_# */ 
        &CCP5E_1_eEnt_des,                       /* cCall #_CCP1_# */
        /* entry port #_EP_# */ 
    },
    /* cell: tCCP5Caller_CB_tab[1]:  CCP5R_2 id=2 */
    {
        /* call port (CB_ALL) #_CP_# */ 
        0,                                       /* #_CCP5_# */
        /* entry port #_EP_# */ 
    },
};

/* entry port descriptor #_EPD_# */
extern const struct tag_tCCP5Caller_eMain_DES CCP5R_1_eMain_des;
const struct tag_tCCP5Caller_eMain_DES CCP5R_1_eMain_des = {
    &tCCP5Caller_eMain_MT_,
    &tCCP5Caller_CB_tab[0],      /* CB 3 */
};
extern const struct tag_tCCP5Caller_eMain_DES CCP5R_2_eMain_des;
const struct tag_tCCP5Caller_eMain_DES CCP5R_2_eMain_des = {
    &tCCP5Caller_eMain_MT_,
    &tCCP5Caller_CB_tab[1],      /* CB 3 */
};
