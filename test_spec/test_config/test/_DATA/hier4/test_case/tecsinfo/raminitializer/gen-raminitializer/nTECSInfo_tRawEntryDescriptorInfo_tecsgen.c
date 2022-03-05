/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "nTECSInfo_tRawEntryDescriptorInfo_tecsgen.h"
#include "nTECSInfo_tRawEntryDescriptorInfo_factory.h"

/* entry port descriptor type #_EDT_# */
/* eRawEntryDescriptor */
struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES {
    const struct tag_nTECSInfo_sRawEntryDescriptorInfo_VMT *vmt;
    tRawEntryDescriptorInfo_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eRawEntryDescriptor */
uint16_t       nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_getNRawEntryDescriptorInfo_skel( const struct tag_nTECSInfo_sRawEntryDescriptorInfo_VDES *epd)
{
    struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES *lepd
        = (struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES *)epd;
    return nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_getNRawEntryDescriptorInfo( lepd->idx );
}
ER             nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_getRawDescriptor_skel( const struct tag_nTECSInfo_sRawEntryDescriptorInfo_VDES *epd, int_t subsc, void** rawDesc)
{
    struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES *lepd
        = (struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES *)epd;
    return nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_getRawDescriptor( lepd->idx, subsc, rawDesc );
}

/* entry port skelton function table #_EPSFT_# */
/* eRawEntryDescriptor */
const struct tag_nTECSInfo_sRawEntryDescriptorInfo_VMT nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_MT_ = {
    nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_getNRawEntryDescriptorInfo_skel,
    nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_getRawDescriptor_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */





/* call port array #_CPA_# */





/* array of attr/var #_AVAI_# */
const void* nTECSInfo_tRawEntryDescriptorInfo_PutStringStdio_ePutStringRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT[1] = { &PutStringStdio_ePutString_des, };
const void* nTECSInfo_tRawEntryDescriptorInfo_HelloWorld_eMainRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT[1] = { &HelloWorld_eMain_des, };
const void* nTECSInfo_tRawEntryDescriptorInfo_Task_eTaskRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT[1] = { &Task_eTask_des, };
const void* nTECSInfo_tRawEntryDescriptorInfo_rTEMP_TaskMain_eBodyRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT[1] = { &rTEMP_TaskMain_eBody_des, };
const void* nTECSInfo_tRawEntryDescriptorInfo_rTEMP_TECSInfo_eTECSInfoRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT[1] = { &rTEMP_TECSInfo_eTECSInfo_des, };
/* cell INIB #_INIB_# */
nTECSInfo_tRawEntryDescriptorInfo_INIB nTECSInfo_tRawEntryDescriptorInfo_INIB_tab[] = {
    /* cell: nTECSInfo_tRawEntryDescriptorInfo_CB_tab[0]:  PutStringStdio_ePutStringRawEntryDescriptorInfo id=1 */
    {
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        1,                                       /* size */
        nTECSInfo_tRawEntryDescriptorInfo_PutStringStdio_ePutStringRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT, /* rawEntryDescriptor */
    },
    /* cell: nTECSInfo_tRawEntryDescriptorInfo_CB_tab[1]:  HelloWorld_eMainRawEntryDescriptorInfo id=2 */
    {
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        1,                                       /* size */
        nTECSInfo_tRawEntryDescriptorInfo_HelloWorld_eMainRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT, /* rawEntryDescriptor */
    },
    /* cell: nTECSInfo_tRawEntryDescriptorInfo_CB_tab[2]:  Task_eTaskRawEntryDescriptorInfo id=3 */
    {
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        1,                                       /* size */
        nTECSInfo_tRawEntryDescriptorInfo_Task_eTaskRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT, /* rawEntryDescriptor */
    },
    /* cell: nTECSInfo_tRawEntryDescriptorInfo_CB_tab[3]:  rTEMP_TaskMain_eBodyRawEntryDescriptorInfo id=4 */
    {
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        1,                                       /* size */
        nTECSInfo_tRawEntryDescriptorInfo_rTEMP_TaskMain_eBodyRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT, /* rawEntryDescriptor */
    },
    /* cell: nTECSInfo_tRawEntryDescriptorInfo_CB_tab[4]:  rTEMP_TECSInfo_eTECSInfoRawEntryDescriptorInfo id=5 */
    {
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        1,                                       /* size */
        nTECSInfo_tRawEntryDescriptorInfo_rTEMP_TECSInfo_eTECSInfoRawEntryDescriptorInfo_CB_rawEntryDescriptor_INIT, /* rawEntryDescriptor */
    },
};

/* entry port descriptor #_EPD_# */
extern const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_PutStringStdio_ePutStringRawEntryDescriptorInfo_eRawEntryDescriptor_des;
const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_PutStringStdio_ePutStringRawEntryDescriptorInfo_eRawEntryDescriptor_des = {
    &nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_MT_,
    &nTECSInfo_tRawEntryDescriptorInfo_INIB_tab[0],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_HelloWorld_eMainRawEntryDescriptorInfo_eRawEntryDescriptor_des;
const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_HelloWorld_eMainRawEntryDescriptorInfo_eRawEntryDescriptor_des = {
    &nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_MT_,
    &nTECSInfo_tRawEntryDescriptorInfo_INIB_tab[1],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_Task_eTaskRawEntryDescriptorInfo_eRawEntryDescriptor_des;
const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_Task_eTaskRawEntryDescriptorInfo_eRawEntryDescriptor_des = {
    &nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_MT_,
    &nTECSInfo_tRawEntryDescriptorInfo_INIB_tab[2],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_rTEMP_TaskMain_eBodyRawEntryDescriptorInfo_eRawEntryDescriptor_des;
const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_rTEMP_TaskMain_eBodyRawEntryDescriptorInfo_eRawEntryDescriptor_des = {
    &nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_MT_,
    &nTECSInfo_tRawEntryDescriptorInfo_INIB_tab[3],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_rTEMP_TECSInfo_eTECSInfoRawEntryDescriptorInfo_eRawEntryDescriptor_des;
const struct tag_nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_DES rTEMP_rTECSInfo_rTEMP_TECSInfo_eTECSInfoRawEntryDescriptorInfo_eRawEntryDescriptor_des = {
    &nTECSInfo_tRawEntryDescriptorInfo_eRawEntryDescriptor_MT_,
    &nTECSInfo_tRawEntryDescriptorInfo_INIB_tab[4],      /* INIB 3 */
};
