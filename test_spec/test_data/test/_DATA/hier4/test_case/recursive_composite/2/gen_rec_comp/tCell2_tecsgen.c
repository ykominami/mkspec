/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tCell2_tecsgen.h"
#include "tCell2_factory.h"

/* entry port descriptor type #_EDT_# */
/* eEntry2 : omitted by entry port optimize */

/* eEntryB : omitted by entry port optimize */

/* entry port skelton function #_EPSF_# */
/* eEntry2 : omitted by entry port optimize */
/* eEntryB : omitted by entry port optimize */

/* entry port skelton function table #_EPSFT_# */
/* eEntry2 : omitted by entry port optimize */
/* eEntryB : omitted by entry port optimize */

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_sSig3_VDES comp1_comp12_cell3_eEntry3_des0;
extern struct tag_sSig3_VDES comp1_comp12_cell3_eEntry3_des1;

extern struct tag_sSig3_VDES comp2_comp12_cell3_eEntry3_des0;
extern struct tag_sSig3_VDES comp2_comp12_cell3_eEntry3_des1;

/* call port array #_CPA_# */
struct tag_sSig3_VDES * const comp1_comp11_cell2_cCall2[] = {
    &comp1_comp12_cell3_eEntry3_des0,
    &comp1_comp12_cell3_eEntry3_des1,
};

struct tag_sSig3_VDES * const comp2_comp11_cell2_cCall2[] = {
    &comp2_comp12_cell3_eEntry3_des0,
    &comp2_comp12_cell3_eEntry3_des1,
};

/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
tCell2_INIB tCell2_INIB_tab[] = {
    /* cell: tCell2_CB_tab[0]:  comp1_comp11_cell2 id=1 */
    {
        /* call port (INIB) #_CP_# */ 
        comp1_comp11_cell2_cCall2,               /* #_CCP3B_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        20,                                      /* a */
        "comp1_comp11_cell2",                    /* name */
    },
    /* cell: tCell2_CB_tab[1]:  comp2_comp11_cell2 id=2 */
    {
        /* call port (INIB) #_CP_# */ 
        comp2_comp11_cell2_cCall2,               /* #_CCP3B_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        20,                                      /* a */
        "comp2_comp11_cell2",                    /* name */
    },
};

/* entry port descriptor #_EPD_# */
/* eEntry2 : omitted by entry port optimize */
/* eEntryB : omitted by entry port optimize */
/* eEntry2 : omitted by entry port optimize */
/* eEntryB : omitted by entry port optimize */
