/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tMainSingleArray_TECSGEN_H
#define tMainSingleArray_TECSGEN_H

/*
 * celltype          :  tMainSingleArray
 * global name       :  tMainSingleArray
 * multi-domain      :  no
 * idx_is_id(actual) :  no(no)
 * singleton         :  yes
 * has_CB            :  no
 * has_INIB          :  yes
 * rom               :  yes
 * CB initializer    :  no
 */

/* global header #_IGH_# */
#include "global_tecsgen.h"

/* signature header #_ISH_# */
#include "sTaskBody_tecsgen.h"
#include "sHello_tecsgen.h"
#include "sTalkerSelector_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell INIB type definition #_CIP_# */
typedef const struct tag_tMainSingleArray_INIB {
    /* call port #_TCP_# */
    struct tag_sHello_VDES const*cDefaultTalker; /* TCP_2 */
    struct tag_sHello_VDES **cTalker; /* TCP_2 */
    int_t n_cTalker;  /* TCP_3 */
    struct tag_sHello_VDES **cTalker2; /* TCP_2 */
    /* call port #_NEP_# */ 
}  tMainSingleArray_INIB;

/* CB not exist. CB corresponding to INIB #_DCI_# */
#define tMainSingleArray_SINGLE_CELL_CB   tMainSingleArray_SINGLE_CELL_INIB
#define tMainSingleArray_CB               tMainSingleArray_INIB
#define tag_tMainSingleArray_CB           tag_tMainSingleArray_INIB

/* singleton cell CB prototype declaration #_SCP_# */
extern  tMainSingleArray_INIB  tMainSingleArray_SINGLE_CELL_INIB;


/* celltype IDX type #_CTIX_# */
typedef const struct tag_tMainSingleArray_INIB *tMainSingleArray_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sTaskBody */
void         tMainSingleArray_eMain_main();
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

/* to get the definition of CB type of referenced celltype for optimization #_ICT_# */
#ifndef  TOPPERS_CB_TYPE_ONLY
#define  tMainSingleArray_CB_TYPE_ONLY
#define TOPPERS_CB_TYPE_ONLY
#endif  /* TOPPERS_CB_TYPE_ONLY */
#include "tTalkerSelector_tecsgen.h"
#ifdef  tMainSingleArray_CB_TYPE_ONLY
#undef TOPPERS_CB_TYPE_ONLY
#endif /* tMainSingleArray_CB_TYPE_ONLY */
#ifndef TOPPERS_CB_TYPE_ONLY

/* call port array size macro #_NCPA_# */
#define N_CP_cTalker  (tMainSingleArray_SINGLE_CELL_INIB.n_cTalker)
#define NCP_cTalker   (tMainSingleArray_SINGLE_CELL_INIB.n_cTalker)
#define N_CP_cTalker2    (2)
#define NCP_cTalker2     (2)
/* optional call port test macro #_TOCP_# */
#define tMainSingleArray_is_cTalker2_joined(subscript) \
	  ((tMainSingleArray_SINGLE_CELL_CB.cTalker2!=0) \
	  &&(tMainSingleArray_SINGLE_CELL_CB.cTalker2[subscript]!=0))

/* celll CB macro #_GCB_# */
#define tMainSingleArray_GET_CELLCB(idx) ((void *)0)
#ifndef TECSFLOW
 /* call port function macro #_CPM_# */
#define tMainSingleArray_cDefaultTalker_hello( ) \
	  tMainSingleArray_SINGLE_CELL_INIB.cDefaultTalker->VMT->hello__T( \
	  tMainSingleArray_SINGLE_CELL_INIB.cDefaultTalker )
#define tMainSingleArray_cTalker_hello( subscript ) \
	  tMainSingleArray_SINGLE_CELL_INIB.cTalker[subscript]->VMT->hello__T( \
	  tMainSingleArray_SINGLE_CELL_INIB.cTalker[subscript] )
#define tMainSingleArray_cTalker2_hello( subscript ) \
	  tMainSingleArray_SINGLE_CELL_INIB.cTalker2[subscript]->VMT->hello__T( \
	  tMainSingleArray_SINGLE_CELL_INIB.cTalker2[subscript] )
#define tMainSingleArray_cTalkerSelector_getTalker( talker, i ) \
	  tTalkerSelector_eTalkerSelector_getTalker( \
	   &tTalkerSelector_INIB_tab[0], (talker), (i) )
#define tMainSingleArray_cTalkerSelector_getNTalker( n ) \
	  tTalkerSelector_eTalkerSelector_getNTalker( \
	   &tTalkerSelector_INIB_tab[0], (n) )

#else  /* TECSFLOW */
#define tMainSingleArray_cDefaultTalker_hello( ) \
	  (p_that)->cDefaultTalker.hello__T( \
 )
#define tMainSingleArray_cTalker_hello( subscript ) \
	  (p_that)->cTalker[subscript].hello__T( \
 )
#define tMainSingleArray_cTalker2_hello( subscript ) \
	  (p_that)->cTalker2[subscript].hello__T( \
 )
#define tMainSingleArray_cTalkerSelector_getTalker( talker, i ) \
	  (p_that)->cTalkerSelector.getTalker__T( \
 (talker), (i) )
#define tMainSingleArray_cTalkerSelector_getNTalker( n ) \
	  (p_that)->cTalkerSelector.getNTalker__T( \
 (n) )

#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */
/* eMain */
void           tMainSingleArray_eMain_main_skel( const struct tag_sTaskBody_VDES *epd);

#ifndef TOPPERS_CB_TYPE_ONLY

/* refer to descriptor function #_CRD_# */
/* [ref_desc] cDefaultTalker */
Inline Descriptor( sHello )
tMainSingleArray_cDefaultTalker_refer_to_descriptor(  )
{
    Descriptor( sHello )  des;
    /* cast is ncecessary for removing 'const'  */
    des.vdes = (struct tag_sHello_VDES *)tMainSingleArray_SINGLE_CELL_INIB.cDefaultTalker;
    return des;
}

/* set descriptor function #_SDF_# */
/* [dynamic] cTalker */
Inline void
tMainSingleArray_cTalker_set_descriptor( int_t  i, Descriptor( sHello ) des )
{
    assert( des.vdes != NULL );
    assert( 0 <= i && i < NCP_cTalker );
    tMainSingleArray_SINGLE_CELL_INIB.cTalker[ i ] = des.vdes;
}

/* [dynamic] cTalker2 */
Inline void
tMainSingleArray_cTalker2_set_descriptor( int_t  i, Descriptor( sHello ) des )
{
    assert( des.vdes != NULL );
    assert( 0 <= i && i < NCP_cTalker2 );
    tMainSingleArray_SINGLE_CELL_INIB.cTalker2[ i ] = des.vdes;
}

/* [dynamic,optional] cTalker2 */
Inline void
tMainSingleArray_cTalker2_unjoin(  int_t  i  )
{
    tMainSingleArray_SINGLE_CELL_INIB.cTalker2[ i ] = NULL;
}

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tMainSingleArray_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tMainSingleArray_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tMainSingleArray_IDX

/* call port function macro (abbrev) #_CPMA_# */
#define cDefaultTalker_hello( ) \
          tMainSingleArray_cDefaultTalker_hello( )
#define cTalker_hello( subscript ) \
          tMainSingleArray_cTalker_hello( subscript )
#define cTalker2_hello( subscript ) \
          tMainSingleArray_cTalker2_hello( subscript )
#define cTalkerSelector_getTalker( talker, i ) \
          tMainSingleArray_cTalkerSelector_getTalker( talker, i )
#define cTalkerSelector_getNTalker( n ) \
          tMainSingleArray_cTalkerSelector_getNTalker( n )


/* refer to descriptor macro (abbrev) #_CRDA_# */
#define cDefaultTalker_refer_to_descriptor()\
          tMainSingleArray_cDefaultTalker_refer_to_descriptor(  )
#define cDefaultTalker_ref_desc()\
          cDefaultTalker_refer_to_descriptor()


/* set descriptor macro (abbrev) #_SDMA_# */
#define cTalker_set_descriptor( i, desc )\
          tMainSingleArray_cTalker_set_descriptor( i, desc )
#define cTalker_unjoin( i )\
          tMainSingleArray_cTalker_unjoin( i )
#define cTalker2_set_descriptor( i, desc )\
          tMainSingleArray_cTalker2_set_descriptor( i, desc )
#define cTalker2_unjoin( i )\
          tMainSingleArray_cTalker2_unjoin( i )

/* optional call port test macro (abbrev) #_TOCPA_# */
#define is_cTalker2_joined(subscript)\
		tMainSingleArray_is_cTalker2_joined(subscript)

/* entry port function macro (abbrev) #_EPM_# */
#define eMain_main       tMainSingleArray_eMain_main

/* CB initialize macro #_CIM_# */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tMainSingleArray_TECSGENH */
