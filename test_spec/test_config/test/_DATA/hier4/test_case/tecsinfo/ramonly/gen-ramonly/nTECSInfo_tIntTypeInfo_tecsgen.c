/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "nTECSInfo_tIntTypeInfo_tecsgen.h"
#include "nTECSInfo_tIntTypeInfo_factory.h"

/* entry port descriptor type #_EDT_# */
/* eTypeInfo */
struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES {
    const struct tag_nTECSInfo_sTypeInfo_VMT *vmt;
    tIntTypeInfo_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eTypeInfo */
ER             nTECSInfo_tIntTypeInfo_eTypeInfo_getName_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd, char_t* name, int_t max_len)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getName( lepd->idx, name, max_len );
}
uint16_t       nTECSInfo_tIntTypeInfo_eTypeInfo_getNameLength_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getNameLength( lepd->idx );
}
uint32_t       nTECSInfo_tIntTypeInfo_eTypeInfo_getSize_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getSize( lepd->idx );
}
int8_t         nTECSInfo_tIntTypeInfo_eTypeInfo_getKind_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getKind( lepd->idx );
}
uint32_t       nTECSInfo_tIntTypeInfo_eTypeInfo_getNType_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getNType( lepd->idx );
}
ER             nTECSInfo_tIntTypeInfo_eTypeInfo_getTypeInfo_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd, Descriptor( nTECSInfo_sTypeInfo )* desc)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getTypeInfo( lepd->idx, desc );
}
uint32_t       nTECSInfo_tIntTypeInfo_eTypeInfo_getNMember_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getNMember( lepd->idx );
}
ER             nTECSInfo_tIntTypeInfo_eTypeInfo_getMemberInfo_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd, uint32_t ith, Descriptor( nTECSInfo_sVarDeclInfo )* desc)
{
    struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *lepd
        = (struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES *)epd;
    return nTECSInfo_tIntTypeInfo_eTypeInfo_getMemberInfo( lepd->idx, ith, desc );
}

/* entry port skelton function table #_EPSFT_# */
/* eTypeInfo */
const struct tag_nTECSInfo_sTypeInfo_VMT nTECSInfo_tIntTypeInfo_eTypeInfo_MT_ = {
    nTECSInfo_tIntTypeInfo_eTypeInfo_getName_skel,
    nTECSInfo_tIntTypeInfo_eTypeInfo_getNameLength_skel,
    nTECSInfo_tIntTypeInfo_eTypeInfo_getSize_skel,
    nTECSInfo_tIntTypeInfo_eTypeInfo_getKind_skel,
    nTECSInfo_tIntTypeInfo_eTypeInfo_getNType_skel,
    nTECSInfo_tIntTypeInfo_eTypeInfo_getTypeInfo_skel,
    nTECSInfo_tIntTypeInfo_eTypeInfo_getNMember_skel,
    nTECSInfo_tIntTypeInfo_eTypeInfo_getMemberInfo_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */











/* call port array #_CPA_# */











/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
struct tag_nTECSInfo_tIntTypeInfo_CB nTECSInfo_tIntTypeInfo_CB_tab[] = {
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[0]:  unsigned__intTypeInfo id=1 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "unsigned int",                          /* name */
        2,                                       /* typeKind */
        sizeof(unsigned int),                    /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[1]:  signed__intTypeInfo id=2 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "signed int",                            /* name */
        2,                                       /* typeKind */
        sizeof(signed int),                      /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[2]:  unsigned__longTypeInfo id=3 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "unsigned long",                         /* name */
        2,                                       /* typeKind */
        sizeof(unsigned long),                   /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[3]:  longTypeInfo id=4 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "long",                                  /* name */
        2,                                       /* typeKind */
        sizeof(long),                            /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[4]:  const__char_tTypeInfo id=5 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "const char_t",                          /* name */
        2,                                       /* typeKind */
        sizeof(const char_t),                    /* size */
        true,                                    /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[5]:  char_tTypeInfo id=6 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "char_t",                                /* name */
        2,                                       /* typeKind */
        sizeof(char_t),                          /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[6]:  int16_tTypeInfo id=7 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "int16_t",                               /* name */
        2,                                       /* typeKind */
        sizeof(int16_t),                         /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[7]:  uint16_tTypeInfo id=8 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "uint16_t",                              /* name */
        2,                                       /* typeKind */
        sizeof(uint16_t),                        /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[8]:  uint32_tTypeInfo id=9 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "uint32_t",                              /* name */
        2,                                       /* typeKind */
        sizeof(uint32_t),                        /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[9]:  int8_tTypeInfo id=10 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "int8_t",                                /* name */
        2,                                       /* typeKind */
        sizeof(int8_t),                          /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
    /* cell: nTECSInfo_tIntTypeInfo_CB_tab[10]:  int32_tTypeInfo id=11 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "int32_t",                               /* name */
        2,                                       /* typeKind */
        sizeof(int32_t),                         /* size */
        false,                                   /* b_const */
        false,                                   /* b_volatile */
    },
};

/* entry port descriptor #_EPD_# */
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_unsigned__intTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_unsigned__intTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[0],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_signed__intTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_signed__intTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[1],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_unsigned__longTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_unsigned__longTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[2],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_longTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_longTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[3],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_const__char_tTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_const__char_tTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[4],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_char_tTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_char_tTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[5],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_int16_tTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_int16_tTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[6],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_uint16_tTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_uint16_tTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[7],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_uint32_tTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_uint32_tTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[8],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_int8_tTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_int8_tTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[9],      /* CB 3 */
};
extern const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_int32_tTypeInfo_eTypeInfo_des;
const struct tag_nTECSInfo_tIntTypeInfo_eTypeInfo_DES rTEMP_rTECSInfo_int32_tTypeInfo_eTypeInfo_des = {
    &nTECSInfo_tIntTypeInfo_eTypeInfo_MT_,
    &nTECSInfo_tIntTypeInfo_CB_tab[10],      /* CB 3 */
};
