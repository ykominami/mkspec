/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "nTECSInfo_tRegionInfo_tecsgen.h"
#include "nTECSInfo_tRegionInfo_factory.h"

/* entry port descriptor type #_EDT_# */
/* eRegionInfo */
struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES {
    const struct tag_nTECSInfo_sRegionInfo_VMT *vmt;
    tRegionInfo_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eRegionInfo */
ER             nTECSInfo_tRegionInfo_eRegionInfo_getName_skel( const struct tag_nTECSInfo_sRegionInfo_VDES *epd, char_t* name, int_t max_len)
{
    struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *lepd
        = (struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *)epd;
    return nTECSInfo_tRegionInfo_eRegionInfo_getName( lepd->idx, name, max_len );
}
uint16_t       nTECSInfo_tRegionInfo_eRegionInfo_getNameLength_skel( const struct tag_nTECSInfo_sRegionInfo_VDES *epd)
{
    struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *lepd
        = (struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *)epd;
    return nTECSInfo_tRegionInfo_eRegionInfo_getNameLength( lepd->idx );
}
uint32_t       nTECSInfo_tRegionInfo_eRegionInfo_getNCell_skel( const struct tag_nTECSInfo_sRegionInfo_VDES *epd)
{
    struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *lepd
        = (struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *)epd;
    return nTECSInfo_tRegionInfo_eRegionInfo_getNCell( lepd->idx );
}
ER             nTECSInfo_tRegionInfo_eRegionInfo_getCellInfo_skel( const struct tag_nTECSInfo_sRegionInfo_VDES *epd, uint32_t ith, Descriptor( nTECSInfo_sCellInfo )* des)
{
    struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *lepd
        = (struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *)epd;
    return nTECSInfo_tRegionInfo_eRegionInfo_getCellInfo( lepd->idx, ith, des );
}
uint32_t       nTECSInfo_tRegionInfo_eRegionInfo_getNRegion_skel( const struct tag_nTECSInfo_sRegionInfo_VDES *epd)
{
    struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *lepd
        = (struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *)epd;
    return nTECSInfo_tRegionInfo_eRegionInfo_getNRegion( lepd->idx );
}
ER             nTECSInfo_tRegionInfo_eRegionInfo_getRegionInfo_skel( const struct tag_nTECSInfo_sRegionInfo_VDES *epd, uint32_t ith, Descriptor( nTECSInfo_sRegionInfo )* des)
{
    struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *lepd
        = (struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES *)epd;
    return nTECSInfo_tRegionInfo_eRegionInfo_getRegionInfo( lepd->idx, ith, des );
}

/* entry port skelton function table #_EPSFT_# */
/* eRegionInfo */
const struct tag_nTECSInfo_sRegionInfo_VMT nTECSInfo_tRegionInfo_eRegionInfo_MT_ = {
    nTECSInfo_tRegionInfo_eRegionInfo_getName_skel,
    nTECSInfo_tRegionInfo_eRegionInfo_getNameLength_skel,
    nTECSInfo_tRegionInfo_eRegionInfo_getNCell_skel,
    nTECSInfo_tRegionInfo_eRegionInfo_getCellInfo_skel,
    nTECSInfo_tRegionInfo_eRegionInfo_getNRegion_skel,
    nTECSInfo_tRegionInfo_eRegionInfo_getRegionInfo_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_nTECSInfo_sCellInfo_VDES rTEMP_rTECSInfo_PutStringStdioCellInfo_eCellInfo_des;
extern struct tag_nTECSInfo_sCellInfo_VDES rTEMP_rTECSInfo_HelloWorldCellInfo_eCellInfo_des;
extern struct tag_nTECSInfo_sCellInfo_VDES rTEMP_rTECSInfo_TaskCellInfo_eCellInfo_des;
extern const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo_rTEMPRegionInfo_eRegionInfo_des;

extern struct tag_nTECSInfo_sCellInfo_VDES rTEMP_rTECSInfo_rTEMP_TaskMainCellInfo_eCellInfo_des;
extern struct tag_nTECSInfo_sCellInfo_VDES rTEMP_rTECSInfo_rTEMP_TECSInfoCellInfo_eCellInfo_des;
extern const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo_rTEMP_rTECSInfoRegionInfo_eRegionInfo_des;


/* call port array #_CPA_# */
struct tag_nTECSInfo_sCellInfo_VDES * const rTEMP_rTECSInfo__LinkRootRegionInfo_cCellInfo[] = {
    &rTEMP_rTECSInfo_PutStringStdioCellInfo_eCellInfo_des,
    &rTEMP_rTECSInfo_HelloWorldCellInfo_eCellInfo_des,
    &rTEMP_rTECSInfo_TaskCellInfo_eCellInfo_des,
};
struct tag_nTECSInfo_sRegionInfo_VDES * const rTEMP_rTECSInfo__LinkRootRegionInfo_cRegionInfo[] = {
    (struct tag_nTECSInfo_sRegionInfo_VDES *)&rTEMP_rTECSInfo_rTEMPRegionInfo_eRegionInfo_des,
};

struct tag_nTECSInfo_sCellInfo_VDES * const rTEMP_rTECSInfo_rTEMPRegionInfo_cCellInfo[] = {
    &rTEMP_rTECSInfo_rTEMP_TaskMainCellInfo_eCellInfo_des,
    &rTEMP_rTECSInfo_rTEMP_TECSInfoCellInfo_eCellInfo_des,
};
struct tag_nTECSInfo_sRegionInfo_VDES * const rTEMP_rTECSInfo_rTEMPRegionInfo_cRegionInfo[] = {
    (struct tag_nTECSInfo_sRegionInfo_VDES *)&rTEMP_rTECSInfo_rTEMP_rTECSInfoRegionInfo_eRegionInfo_des,
};


/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
nTECSInfo_tRegionInfo_INIB nTECSInfo_tRegionInfo_INIB_tab[] = {
    /* cell: nTECSInfo_tRegionInfo_CB_tab[0]:  _LinkRootRegionInfo id=1 */
    {
        /* call port (INIB) #_CP_# */ 
        rTEMP_rTECSInfo__LinkRootRegionInfo_cCellInfo, /* #_CCP3B_# */
        3,                                       /* length of cCellInfo (n_cCellInfo) #_CCP4_# */
        rTEMP_rTECSInfo__LinkRootRegionInfo_cRegionInfo, /* #_CCP3B_# */
        1,                                       /* length of cRegionInfo (n_cRegionInfo) #_CCP4_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "::",                                    /* name */
    },
    /* cell: nTECSInfo_tRegionInfo_CB_tab[1]:  rTEMPRegionInfo id=2 */
    {
        /* call port (INIB) #_CP_# */ 
        rTEMP_rTECSInfo_rTEMPRegionInfo_cCellInfo, /* #_CCP3B_# */
        2,                                       /* length of cCellInfo (n_cCellInfo) #_CCP4_# */
        rTEMP_rTECSInfo_rTEMPRegionInfo_cRegionInfo, /* #_CCP3B_# */
        1,                                       /* length of cRegionInfo (n_cRegionInfo) #_CCP4_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "rTEMP",                                 /* name */
    },
    /* cell: nTECSInfo_tRegionInfo_CB_tab[2]:  rTEMP_rTECSInfoRegionInfo id=3 */
    {
        /* call port (INIB) #_CP_# */ 
        0,                                       /* #_CCP9_# */
        0,                                       /* length of cCellInfo (n_cCellInfo) #_CCP6_# */
        0,                                       /* #_CCP9_# */
        0,                                       /* length of cRegionInfo (n_cRegionInfo) #_CCP6_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "rTECSInfo",                             /* name */
    },
};

/* entry port descriptor #_EPD_# */
extern const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo__LinkRootRegionInfo_eRegionInfo_des;
const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo__LinkRootRegionInfo_eRegionInfo_des = {
    &nTECSInfo_tRegionInfo_eRegionInfo_MT_,
    &nTECSInfo_tRegionInfo_INIB_tab[0],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo_rTEMPRegionInfo_eRegionInfo_des;
const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo_rTEMPRegionInfo_eRegionInfo_des = {
    &nTECSInfo_tRegionInfo_eRegionInfo_MT_,
    &nTECSInfo_tRegionInfo_INIB_tab[1],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo_rTEMP_rTECSInfoRegionInfo_eRegionInfo_des;
const struct tag_nTECSInfo_tRegionInfo_eRegionInfo_DES rTEMP_rTECSInfo_rTEMP_rTECSInfoRegionInfo_eRegionInfo_des = {
    &nTECSInfo_tRegionInfo_eRegionInfo_MT_,
    &nTECSInfo_tRegionInfo_INIB_tab[2],      /* INIB 3 */
};
