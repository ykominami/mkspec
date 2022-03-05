/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef nTECSInfo_tPtrTypeInfo_TECSGEN_H
#define nTECSInfo_tPtrTypeInfo_TECSGEN_H

/*
 * celltype          :  tPtrTypeInfo
 * global name       :  nTECSInfo_tPtrTypeInfo
 * multi-domain      :  no
 * idx_is_id(actual) :  no(no)
 * singleton         :  no
 * has_CB            :  yes
 * has_INIB          :  no
 * rom               :  no
 * CB initializer    :  yes
 */

/* global header #_IGH_# */
#include "global_tecsgen.h"

/* signature header #_ISH_# */
#include "nTECSInfo_sTypeInfo_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell CB type definition #_CCTPO_# */
typedef struct tag_nTECSInfo_tPtrTypeInfo_CB {
    /* call port #_TCP_# */
    struct tag_nTECSInfo_sTypeInfo_VDES const*cTypeInfo; /* TCP_2 */
    /* call port #_NEP_# */ 
    /* attribute #_AT_# */ 
    char_t*        name;
    int8_t         typeKind;
    uint32_t       size;
    bool_t         b_const;
    bool_t         b_volatile;
}  nTECSInfo_tPtrTypeInfo_CB;
/* singleton cell CB prototype declaration #_MCPB_# */
extern nTECSInfo_tPtrTypeInfo_CB  nTECSInfo_tPtrTypeInfo_CB_tab[];

/* celltype IDX type #_CTIX_# */
typedef struct tag_nTECSInfo_tPtrTypeInfo_CB *nTECSInfo_tPtrTypeInfo_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* nTECSInfo_sTypeInfo */
ER           nTECSInfo_tPtrTypeInfo_eTypeInfo_getName(nTECSInfo_tPtrTypeInfo_IDX idx, char_t* name, int_t max_len);
uint16_t     nTECSInfo_tPtrTypeInfo_eTypeInfo_getNameLength(nTECSInfo_tPtrTypeInfo_IDX idx);
uint32_t     nTECSInfo_tPtrTypeInfo_eTypeInfo_getSize(nTECSInfo_tPtrTypeInfo_IDX idx);
int8_t       nTECSInfo_tPtrTypeInfo_eTypeInfo_getKind(nTECSInfo_tPtrTypeInfo_IDX idx);
uint32_t     nTECSInfo_tPtrTypeInfo_eTypeInfo_getNType(nTECSInfo_tPtrTypeInfo_IDX idx);
ER           nTECSInfo_tPtrTypeInfo_eTypeInfo_getTypeInfo(nTECSInfo_tPtrTypeInfo_IDX idx, Descriptor( nTECSInfo_sTypeInfo )* desc);
uint32_t     nTECSInfo_tPtrTypeInfo_eTypeInfo_getNMember(nTECSInfo_tPtrTypeInfo_IDX idx);
ER           nTECSInfo_tPtrTypeInfo_eTypeInfo_getMemberInfo(nTECSInfo_tPtrTypeInfo_IDX idx, uint32_t ith, Descriptor( nTECSInfo_sVarDeclInfo )* desc);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

#define nTECSInfo_tPtrTypeInfo_ID_BASE        (1)  /* ID Base  #_NIDB_# */
#define nTECSInfo_tPtrTypeInfo_N_CELL       (28)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define nTECSInfo_tPtrTypeInfo_VALID_IDX(IDX) (1)


/* celll CB macro #_GCB_# */
#define nTECSInfo_tPtrTypeInfo_GET_CELLCB(idx) (idx)

/* attr access  #_AAM_# */
#define nTECSInfo_tPtrTypeInfo_ATTR_name( p_that )	((p_that)->name)
#define nTECSInfo_tPtrTypeInfo_ATTR_typeKind( p_that )	((p_that)->typeKind)
#define nTECSInfo_tPtrTypeInfo_ATTR_size( p_that )	((p_that)->size)
#define nTECSInfo_tPtrTypeInfo_ATTR_b_const( p_that )	((p_that)->b_const)
#define nTECSInfo_tPtrTypeInfo_ATTR_b_volatile( p_that )	((p_that)->b_volatile)

#define nTECSInfo_tPtrTypeInfo_GET_name(p_that)	((p_that)->name)
#define nTECSInfo_tPtrTypeInfo_GET_typeKind(p_that)	((p_that)->typeKind)
#define nTECSInfo_tPtrTypeInfo_GET_size(p_that)	((p_that)->size)
#define nTECSInfo_tPtrTypeInfo_GET_b_const(p_that)	((p_that)->b_const)
#define nTECSInfo_tPtrTypeInfo_GET_b_volatile(p_that)	((p_that)->b_volatile)



#ifndef TECSFLOW
 /* call port function macro #_CPM_# */
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getName( p_that, name, max_len ) \
	  (p_that)->cTypeInfo->VMT->getName__T( \
	   (p_that)->cTypeInfo, (name), (max_len) )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getNameLength( p_that ) \
	  (p_that)->cTypeInfo->VMT->getNameLength__T( \
	   (p_that)->cTypeInfo )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getSize( p_that ) \
	  (p_that)->cTypeInfo->VMT->getSize__T( \
	   (p_that)->cTypeInfo )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getKind( p_that ) \
	  (p_that)->cTypeInfo->VMT->getKind__T( \
	   (p_that)->cTypeInfo )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getNType( p_that ) \
	  (p_that)->cTypeInfo->VMT->getNType__T( \
	   (p_that)->cTypeInfo )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getTypeInfo( p_that, desc ) \
	  (p_that)->cTypeInfo->VMT->getTypeInfo__T( \
	   (p_that)->cTypeInfo, (desc) )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getNMember( p_that ) \
	  (p_that)->cTypeInfo->VMT->getNMember__T( \
	   (p_that)->cTypeInfo )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getMemberInfo( p_that, ith, desc ) \
	  (p_that)->cTypeInfo->VMT->getMemberInfo__T( \
	   (p_that)->cTypeInfo, (ith), (desc) )

#else  /* TECSFLOW */
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getName( p_that, name, max_len ) \
	  (p_that)->cTypeInfo.getName__T( \
 (name), (max_len) )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getNameLength( p_that ) \
	  (p_that)->cTypeInfo.getNameLength__T( \
 )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getSize( p_that ) \
	  (p_that)->cTypeInfo.getSize__T( \
 )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getKind( p_that ) \
	  (p_that)->cTypeInfo.getKind__T( \
 )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getNType( p_that ) \
	  (p_that)->cTypeInfo.getNType__T( \
 )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getTypeInfo( p_that, desc ) \
	  (p_that)->cTypeInfo.getTypeInfo__T( \
 (desc) )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getNMember( p_that ) \
	  (p_that)->cTypeInfo.getNMember__T( \
 )
#define nTECSInfo_tPtrTypeInfo_cTypeInfo_getMemberInfo( p_that, ith, desc ) \
	  (p_that)->cTypeInfo.getMemberInfo__T( \
 (ith), (desc) )

#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */
/* eTypeInfo */
ER             nTECSInfo_tPtrTypeInfo_eTypeInfo_getName_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd, char_t* name, int_t max_len);
uint16_t       nTECSInfo_tPtrTypeInfo_eTypeInfo_getNameLength_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd);
uint32_t       nTECSInfo_tPtrTypeInfo_eTypeInfo_getSize_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd);
int8_t         nTECSInfo_tPtrTypeInfo_eTypeInfo_getKind_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd);
uint32_t       nTECSInfo_tPtrTypeInfo_eTypeInfo_getNType_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd);
ER             nTECSInfo_tPtrTypeInfo_eTypeInfo_getTypeInfo_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd, Descriptor( nTECSInfo_sTypeInfo )* desc);
uint32_t       nTECSInfo_tPtrTypeInfo_eTypeInfo_getNMember_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd);
ER             nTECSInfo_tPtrTypeInfo_eTypeInfo_getMemberInfo_skel( const struct tag_nTECSInfo_sTypeInfo_VDES *epd, uint32_t ith, Descriptor( nTECSInfo_sVarDeclInfo )* desc);

#ifndef TOPPERS_CB_TYPE_ONLY

/* refer to descriptor function #_CRD_# */
/* [ref_desc] cTypeInfo */
Inline Descriptor( nTECSInfo_sTypeInfo )
nTECSInfo_tPtrTypeInfo_cTypeInfo_refer_to_descriptor( nTECSInfo_tPtrTypeInfo_CB  *p_that )
{
    Descriptor( nTECSInfo_sTypeInfo )  des;
    nTECSInfo_tPtrTypeInfo_CB *p_cellcb = p_that;
    /* cast is ncecessary for removing 'const'  */
    des.vdes = (struct tag_nTECSInfo_sTypeInfo_VDES *)p_cellcb->cTypeInfo;
    return des;
}

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* IDX validation macro (abbrev.) #_CVIA_# */
#define VALID_IDX(IDX)  nTECSInfo_tPtrTypeInfo_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  nTECSInfo_tPtrTypeInfo_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	nTECSInfo_tPtrTypeInfo_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	nTECSInfo_tPtrTypeInfo_IDX

#define tPtrTypeInfo_IDX  nTECSInfo_tPtrTypeInfo_IDX

/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_name            nTECSInfo_tPtrTypeInfo_ATTR_name( p_cellcb )
#define ATTR_typeKind        nTECSInfo_tPtrTypeInfo_ATTR_typeKind( p_cellcb )
#define ATTR_size            nTECSInfo_tPtrTypeInfo_ATTR_size( p_cellcb )
#define ATTR_b_const         nTECSInfo_tPtrTypeInfo_ATTR_b_const( p_cellcb )
#define ATTR_b_volatile      nTECSInfo_tPtrTypeInfo_ATTR_b_volatile( p_cellcb )


/* call port function macro (abbrev) #_CPMA_# */
#define cTypeInfo_getName( name, max_len ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getName( p_cellcb, name, max_len )
#define cTypeInfo_getNameLength( ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getNameLength( p_cellcb )
#define cTypeInfo_getSize( ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getSize( p_cellcb )
#define cTypeInfo_getKind( ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getKind( p_cellcb )
#define cTypeInfo_getNType( ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getNType( p_cellcb )
#define cTypeInfo_getTypeInfo( desc ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getTypeInfo( p_cellcb, desc )
#define cTypeInfo_getNMember( ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getNMember( p_cellcb )
#define cTypeInfo_getMemberInfo( ith, desc ) \
          nTECSInfo_tPtrTypeInfo_cTypeInfo_getMemberInfo( p_cellcb, ith, desc )


/* refer to descriptor macro (abbrev) #_CRDA_# */
#define cTypeInfo_refer_to_descriptor()\
          nTECSInfo_tPtrTypeInfo_cTypeInfo_refer_to_descriptor( p_cellcb )
#define cTypeInfo_ref_desc()\
          cTypeInfo_refer_to_descriptor()



/* entry port function macro (abbrev) #_EPM_# */
#define eTypeInfo_getName nTECSInfo_tPtrTypeInfo_eTypeInfo_getName
#define eTypeInfo_getNameLength nTECSInfo_tPtrTypeInfo_eTypeInfo_getNameLength
#define eTypeInfo_getSize nTECSInfo_tPtrTypeInfo_eTypeInfo_getSize
#define eTypeInfo_getKind nTECSInfo_tPtrTypeInfo_eTypeInfo_getKind
#define eTypeInfo_getNType nTECSInfo_tPtrTypeInfo_eTypeInfo_getNType
#define eTypeInfo_getTypeInfo nTECSInfo_tPtrTypeInfo_eTypeInfo_getTypeInfo
#define eTypeInfo_getNMember nTECSInfo_tPtrTypeInfo_eTypeInfo_getNMember
#define eTypeInfo_getMemberInfo nTECSInfo_tPtrTypeInfo_eTypeInfo_getMemberInfo

/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < nTECSInfo_tPtrTypeInfo_N_CELL; (i)++ ){ \
       (p_cb) = &nTECSInfo_tPtrTypeInfo_CB_tab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#define INITIALIZE_CB(p_that)	(void)(p_that);
#define SET_CB_INIB_POINTER(i,p_that)\
	/* empty */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* nTECSInfo_tPtrTypeInfo_TECSGENH */
