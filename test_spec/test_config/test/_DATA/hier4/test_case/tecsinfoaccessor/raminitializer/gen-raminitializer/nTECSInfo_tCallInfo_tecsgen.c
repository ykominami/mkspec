/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "nTECSInfo_tCallInfo_tecsgen.h"
#include "nTECSInfo_tCallInfo_factory.h"

/* entry port descriptor type #_EDT_# */
/* eCallInfo */
struct tag_nTECSInfo_tCallInfo_eCallInfo_DES {
    const struct tag_nTECSInfo_sCallInfo_VMT *vmt;
    tCallInfo_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eCallInfo */
ER             nTECSInfo_tCallInfo_eCallInfo_getName_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd, char_t* name, int_t max_len)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    return nTECSInfo_tCallInfo_eCallInfo_getName( lepd->idx, name, max_len );
}
uint16_t       nTECSInfo_tCallInfo_eCallInfo_getNameLength_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    return nTECSInfo_tCallInfo_eCallInfo_getNameLength( lepd->idx );
}
void           nTECSInfo_tCallInfo_eCallInfo_getSignatureInfo_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd, Descriptor( nTECSInfo_sSignatureInfo )* desc)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    nTECSInfo_tCallInfo_eCallInfo_getSignatureInfo( lepd->idx, desc );
}
uint32_t       nTECSInfo_tCallInfo_eCallInfo_getArraySize_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    return nTECSInfo_tCallInfo_eCallInfo_getArraySize( lepd->idx );
}
void           nTECSInfo_tCallInfo_eCallInfo_getSpecifierInfo_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd, bool_t* b_optional, bool_t* b_dynamic, bool_t* b_ref_desc, bool_t* b_omit)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    nTECSInfo_tCallInfo_eCallInfo_getSpecifierInfo( lepd->idx, b_optional, b_dynamic, b_ref_desc, b_omit );
}
void           nTECSInfo_tCallInfo_eCallInfo_getInternalInfo_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd, bool_t* b_allocator_port, bool_t* b_require_port)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    nTECSInfo_tCallInfo_eCallInfo_getInternalInfo( lepd->idx, b_allocator_port, b_require_port );
}
void           nTECSInfo_tCallInfo_eCallInfo_getLocationInfo_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd, uint32_t* offset, int8_t* place)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    nTECSInfo_tCallInfo_eCallInfo_getLocationInfo( lepd->idx, offset, place );
}
void           nTECSInfo_tCallInfo_eCallInfo_getOptimizeInfo_skel( const struct tag_nTECSInfo_sCallInfo_VDES *epd, bool_t* b_VMT_useless, bool_t* b_skelton_useless, bool_t* b_cell_unique)
{
    struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *lepd
        = (struct tag_nTECSInfo_tCallInfo_eCallInfo_DES *)epd;
    nTECSInfo_tCallInfo_eCallInfo_getOptimizeInfo( lepd->idx, b_VMT_useless, b_skelton_useless, b_cell_unique );
}

/* entry port skelton function table #_EPSFT_# */
/* eCallInfo */
const struct tag_nTECSInfo_sCallInfo_VMT nTECSInfo_tCallInfo_eCallInfo_MT_ = {
    nTECSInfo_tCallInfo_eCallInfo_getName_skel,
    nTECSInfo_tCallInfo_eCallInfo_getNameLength_skel,
    nTECSInfo_tCallInfo_eCallInfo_getSignatureInfo_skel,
    nTECSInfo_tCallInfo_eCallInfo_getArraySize_skel,
    nTECSInfo_tCallInfo_eCallInfo_getSpecifierInfo_skel,
    nTECSInfo_tCallInfo_eCallInfo_getInternalInfo_skel,
    nTECSInfo_tCallInfo_eCallInfo_getLocationInfo_skel,
    nTECSInfo_tCallInfo_eCallInfo_getOptimizeInfo_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */
extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_sTaskBodySignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_sTaskExceptionBodySignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_sPutStringSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sAccessorSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sTECSInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sTECSInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sNamespaceInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sCelltypeInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sSignatureInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sFunctionInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sParamInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sCallInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sEntryInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sVarDeclInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sVarDeclInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sVarDeclInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sTypeInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sRegionInfoSignatureInfo_eSignatureInfo_des;

extern struct tag_nTECSInfo_sSignatureInfo_VDES rTEMP_rTECSInfo_nTECSInfo_sCellInfoSignatureInfo_eSignatureInfo_des;

/* call port array #_CPA_# */



















/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
nTECSInfo_tCallInfo_INIB nTECSInfo_tCallInfo_INIB_tab[] = {
    /* cell: nTECSInfo_tCallInfo_CB_tab[0]:  tTask_cTaskBodyCallInfo id=1 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_sTaskBodySignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cTaskBody",                             /* name */
        tTask_cTaskBody__offset,                 /* offset */
        tTask_cTaskBody__array_size,             /* array_size */
        false,                                   /* b_optional */
        false,                                   /* b_omit */
        false,                                   /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        tTask_cTaskBody__place,                  /* place */
        tTask_cTaskBody__b_VMT_useless,          /* b_VMT_useless */
        tTask_cTaskBody__b_skelton_useless,      /* b_skelton_useless */
        tTask_cTaskBody__b_cell_unique,          /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[1]:  tTask_cExceptionBodyCallInfo id=2 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_sTaskExceptionBodySignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cExceptionBody",                        /* name */
        tTask_cExceptionBody__offset,            /* offset */
        tTask_cExceptionBody__array_size,        /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        false,                                   /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        tTask_cExceptionBody__place,             /* place */
        tTask_cExceptionBody__b_VMT_useless,     /* b_VMT_useless */
        tTask_cExceptionBody__b_skelton_useless, /* b_skelton_useless */
        tTask_cExceptionBody__b_cell_unique,     /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[2]:  tHelloWorld_cPutStringCallInfo id=3 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_sPutStringSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cPutString",                            /* name */
        tHelloWorld_cPutString__offset,          /* offset */
        tHelloWorld_cPutString__array_size,      /* array_size */
        false,                                   /* b_optional */
        false,                                   /* b_omit */
        false,                                   /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        tHelloWorld_cPutString__place,           /* place */
        tHelloWorld_cPutString__b_VMT_useless,   /* b_VMT_useless */
        tHelloWorld_cPutString__b_skelton_useless, /* b_skelton_useless */
        tHelloWorld_cPutString__b_cell_unique,   /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[3]:  tTaskMain_cAccessorCallInfo id=4 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sAccessorSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cAccessor",                             /* name */
        tTaskMain_cAccessor__offset,             /* offset */
        tTaskMain_cAccessor__array_size,         /* array_size */
        false,                                   /* b_optional */
        false,                                   /* b_omit */
        false,                                   /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        tTaskMain_cAccessor__place,              /* place */
        tTaskMain_cAccessor__b_VMT_useless,      /* b_VMT_useless */
        tTaskMain_cAccessor__b_skelton_useless,  /* b_skelton_useless */
        tTaskMain_cAccessor__b_cell_unique,      /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[4]:  nTECSInfo_tTECSInfo_cTECSInfoCallInfo id=5 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sTECSInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cTECSInfo",                             /* name */
        nTECSInfo_tTECSInfo_cTECSInfo__offset,   /* offset */
        nTECSInfo_tTECSInfo_cTECSInfo__array_size, /* array_size */
        false,                                   /* b_optional */
        false,                                   /* b_omit */
        false,                                   /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfo_cTECSInfo__place,    /* place */
        nTECSInfo_tTECSInfo_cTECSInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfo_cTECSInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfo_cTECSInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[5]:  nTECSInfo_tTECSInfoAccessor_cTECSInfoCallInfo id=6 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sTECSInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cTECSInfo",                             /* name */
        nTECSInfo_tTECSInfoAccessor_cTECSInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cTECSInfo__array_size, /* array_size */
        false,                                   /* b_optional */
        false,                                   /* b_omit */
        false,                                   /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cTECSInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cTECSInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cTECSInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cTECSInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[6]:  nTECSInfo_tTECSInfoAccessor_cNSInfoCallInfo id=7 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sNamespaceInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cNSInfo",                               /* name */
        nTECSInfo_tTECSInfoAccessor_cNSInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cNSInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cNSInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cNSInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cNSInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cNSInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[7]:  nTECSInfo_tTECSInfoAccessor_cCelltypeInfoCallInfo id=8 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sCelltypeInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cCelltypeInfo",                         /* name */
        nTECSInfo_tTECSInfoAccessor_cCelltypeInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cCelltypeInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cCelltypeInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cCelltypeInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cCelltypeInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cCelltypeInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[8]:  nTECSInfo_tTECSInfoAccessor_cSignatureInfoCallInfo id=9 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sSignatureInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cSignatureInfo",                        /* name */
        nTECSInfo_tTECSInfoAccessor_cSignatureInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cSignatureInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cSignatureInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cSignatureInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cSignatureInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cSignatureInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[9]:  nTECSInfo_tTECSInfoAccessor_cFunctionInfoCallInfo id=10 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sFunctionInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cFunctionInfo",                         /* name */
        nTECSInfo_tTECSInfoAccessor_cFunctionInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cFunctionInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cFunctionInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cFunctionInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cFunctionInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cFunctionInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[10]:  nTECSInfo_tTECSInfoAccessor_cParamInfoCallInfo id=11 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sParamInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cParamInfo",                            /* name */
        nTECSInfo_tTECSInfoAccessor_cParamInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cParamInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cParamInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cParamInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cParamInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cParamInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[11]:  nTECSInfo_tTECSInfoAccessor_cCallInfoCallInfo id=12 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sCallInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cCallInfo",                             /* name */
        nTECSInfo_tTECSInfoAccessor_cCallInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cCallInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cCallInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cCallInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cCallInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cCallInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[12]:  nTECSInfo_tTECSInfoAccessor_cEntryInfoCallInfo id=13 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sEntryInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cEntryInfo",                            /* name */
        nTECSInfo_tTECSInfoAccessor_cEntryInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cEntryInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cEntryInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cEntryInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cEntryInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cEntryInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[13]:  nTECSInfo_tTECSInfoAccessor_cAttrInfoCallInfo id=14 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sVarDeclInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cAttrInfo",                             /* name */
        nTECSInfo_tTECSInfoAccessor_cAttrInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cAttrInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cAttrInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cAttrInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cAttrInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cAttrInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[14]:  nTECSInfo_tTECSInfoAccessor_cVarInfoCallInfo id=15 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sVarDeclInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cVarInfo",                              /* name */
        nTECSInfo_tTECSInfoAccessor_cVarInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cVarInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cVarInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cVarInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cVarInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cVarInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[15]:  nTECSInfo_tTECSInfoAccessor_cVarDeclInfoCallInfo id=16 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sVarDeclInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cVarDeclInfo",                          /* name */
        nTECSInfo_tTECSInfoAccessor_cVarDeclInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cVarDeclInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cVarDeclInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cVarDeclInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cVarDeclInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cVarDeclInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[16]:  nTECSInfo_tTECSInfoAccessor_cTypeInfoCallInfo id=17 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sTypeInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cTypeInfo",                             /* name */
        nTECSInfo_tTECSInfoAccessor_cTypeInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cTypeInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cTypeInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cTypeInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cTypeInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cTypeInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[17]:  nTECSInfo_tTECSInfoAccessor_cRegionInfoCallInfo id=18 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sRegionInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cRegionInfo",                           /* name */
        nTECSInfo_tTECSInfoAccessor_cRegionInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cRegionInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cRegionInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cRegionInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cRegionInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cRegionInfo__b_cell_unique, /* b_cell_unique */
    },
    /* cell: nTECSInfo_tCallInfo_CB_tab[18]:  nTECSInfo_tTECSInfoAccessor_cCellInfoCallInfo id=19 */
    {
        /* call port (INIB) #_CP_# */ 
        &rTEMP_rTECSInfo_nTECSInfo_sCellInfoSignatureInfo_eSignatureInfo_des, /* cSignatureInfo #_CCP1_# */
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        "cCellInfo",                             /* name */
        nTECSInfo_tTECSInfoAccessor_cCellInfo__offset, /* offset */
        nTECSInfo_tTECSInfoAccessor_cCellInfo__array_size, /* array_size */
        true,                                    /* b_optional */
        false,                                   /* b_omit */
        true,                                    /* b_dynamic */
        false,                                   /* b_ref_desc */
        false,                                   /* b_allocator_port */
        false,                                   /* b_require_port */
        nTECSInfo_tTECSInfoAccessor_cCellInfo__place, /* place */
        nTECSInfo_tTECSInfoAccessor_cCellInfo__b_VMT_useless, /* b_VMT_useless */
        nTECSInfo_tTECSInfoAccessor_cCellInfo__b_skelton_useless, /* b_skelton_useless */
        nTECSInfo_tTECSInfoAccessor_cCellInfo__b_cell_unique, /* b_cell_unique */
    },
};

/* entry port descriptor #_EPD_# */
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tTask_cTaskBodyCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tTask_cTaskBodyCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[0],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tTask_cExceptionBodyCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tTask_cExceptionBodyCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[1],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tHelloWorld_cPutStringCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tHelloWorld_cPutStringCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[2],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tTaskMain_cAccessorCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_tTaskMain_cAccessorCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[3],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfo_cTECSInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfo_cTECSInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[4],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cTECSInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cTECSInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[5],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cNSInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cNSInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[6],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cCelltypeInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cCelltypeInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[7],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cSignatureInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cSignatureInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[8],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cFunctionInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cFunctionInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[9],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cParamInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cParamInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[10],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cCallInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cCallInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[11],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cEntryInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cEntryInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[12],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cAttrInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cAttrInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[13],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cVarInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cVarInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[14],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cVarDeclInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cVarDeclInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[15],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cTypeInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cTypeInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[16],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cRegionInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cRegionInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[17],      /* INIB 3 */
};
extern const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cCellInfoCallInfo_eCallInfo_des;
const struct tag_nTECSInfo_tCallInfo_eCallInfo_DES rTEMP_rTECSInfo_nTECSInfo_tTECSInfoAccessor_cCellInfoCallInfo_eCallInfo_des = {
    &nTECSInfo_tCallInfo_eCallInfo_MT_,
    &nTECSInfo_tCallInfo_INIB_tab[18],      /* INIB 3 */
};
/* CB initialize code #_CIC_# */
void
nTECSInfo_tCallInfo_CB_initialize()
{
    nTECSInfo_tCallInfo_CB	*p_cb;
    int		i;
    FOREACH_CELL(i,p_cb)
        SET_CB_INIB_POINTER(i,p_cb)
        INITIALIZE_CB(p_cb)
    END_FOREACH_CELL
}
