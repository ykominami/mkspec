/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tTalkerSelector_TECSGEN_H
#define tTalkerSelector_TECSGEN_H

/*
 * celltype          :  tTalkerSelector
 * global name       :  tTalkerSelector
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
#include "sTalkerSelector_tecsgen.h"
#include "sHello_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell CB type definition #_CCTPO_# */
typedef struct tag_tTalkerSelector_CB {
    /* call port #_TCP_# */
    struct tag_sHello_VDES *const*cHello; /* TCP_2 */
    int_t n_cHello;  /* TCP_3 */
    /* call port #_NEP_# */ 
    /* attribute #_AT_# */ 
    char_t*        name;
}  tTalkerSelector_CB;
/* singleton cell CB prototype declaration #_MCPB_# */
extern tTalkerSelector_CB  tTalkerSelector_CB_tab[];

/* celltype IDX type #_CTIX_# */
typedef struct tag_tTalkerSelector_CB *tTalkerSelector_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sTalkerSelector */
void         tTalkerSelector_eTalkerSelector_getTalker(tTalkerSelector_IDX idx, Descriptor( sHello )* talker, int_t i);
void         tTalkerSelector_eTalkerSelector_getNTalker(tTalkerSelector_IDX idx, int_t* n);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

#define tTalkerSelector_ID_BASE        (1)  /* ID Base  #_NIDB_# */
#define tTalkerSelector_N_CELL        (2)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tTalkerSelector_VALID_IDX(IDX) (1)

/* call port array size macro #_NCPA_# */
#define N_CP_cHello(p_that)  ((p_that)->n_cHello)
#define NCP_cHello           (N_CP_cHello(p_cellcb))
/* optional call port test macro #_TOCP_# */
#define tTalkerSelector_is_cHello_joined(p_that,subscript) \
	  (((p_that)->cHello!=0)\
	  &&((p_that)->cHello[subscript]!=0))

/* celll CB macro #_GCB_# */
#define tTalkerSelector_GET_CELLCB(idx) (idx)

/* attr access  #_AAM_# */
#define tTalkerSelector_ATTR_name( p_that )	((p_that)->name)

#define tTalkerSelector_GET_name(p_that)	((p_that)->name)



#ifndef TECSFLOW
 /* call port function macro #_CPM_# */
#define tTalkerSelector_cHello_hello( p_that, subscript ) \
	  (p_that)->cHello[subscript]->VMT->hello__T( \
	   (p_that)->cHello[subscript] )

#else  /* TECSFLOW */
#define tTalkerSelector_cHello_hello( p_that, subscript ) \
	  (p_that)->cHello[subscript].hello__T( \
 )

#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */

#ifndef TOPPERS_CB_TYPE_ONLY

/* refer to descriptor function #_CRD_# */
/* [ref_desc] cHello */
Inline Descriptor( sHello )
tTalkerSelector_cHello_refer_to_descriptor( tTalkerSelector_CB  *p_that, int_t  i  )
{
    Descriptor( sHello )  des;
    tTalkerSelector_CB *p_cellcb = p_that;
    /* cast is ncecessary for removing 'const'  */
    assert( 0 <= i && i < NCP_cHello );
    des.vdes = (struct tag_sHello_VDES *)p_cellcb->cHello[ i ];
    return des;
}

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* IDX validation macro (abbrev.) #_CVIA_# */
#define VALID_IDX(IDX)  tTalkerSelector_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tTalkerSelector_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tTalkerSelector_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tTalkerSelector_IDX


/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_name            tTalkerSelector_ATTR_name( p_cellcb )


/* call port function macro (abbrev) #_CPMA_# */
#define cHello_hello( subscript ) \
          tTalkerSelector_cHello_hello( p_cellcb, subscript )


/* refer to descriptor macro (abbrev) #_CRDA_# */
#define cHello_refer_to_descriptor( i )\
          tTalkerSelector_cHello_refer_to_descriptor( p_cellcb, i )
#define cHello_ref_desc( i )\
          cHello_refer_to_descriptor( i )


/* optional call port test macro (abbrev) #_TOCPA_# */
#define is_cHello_joined(subscript)\
		tTalkerSelector_is_cHello_joined(p_cellcb,subscript)

/* entry port function macro (abbrev) #_EPM_# */
#define eTalkerSelector_getTalker tTalkerSelector_eTalkerSelector_getTalker
#define eTalkerSelector_getNTalker tTalkerSelector_eTalkerSelector_getNTalker

/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < tTalkerSelector_N_CELL; (i)++ ){ \
       (p_cb) = &tTalkerSelector_CB_tab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#define INITIALIZE_CB(p_that)	(void)(p_that);
#define SET_CB_INIB_POINTER(i,p_that)\
	/* empty */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tTalkerSelector_TECSGENH */
