/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tMainSingleton_TECSGEN_H
#define tMainSingleton_TECSGEN_H

/*
 * celltype          :  tMainSingleton
 * global name       :  tMainSingleton
 * multi-domain      :  no
 * idx_is_id(actual) :  no(no)
 * singleton         :  yes
 * has_CB            :  yes
 * has_INIB          :  no
 * rom               :  no
 * CB initializer    :  yes
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
/* cell CB type definition #_CCTPO_# */
typedef struct tag_tMainSingleton_CB {
    /* call port #_TCP_# */
    struct tag_sHello_VDES const*cDefaultTalker; /* TCP_2 */
    struct tag_sHello_VDES *cTalker; /* TCP_2 */
    /* call port #_NEP_# */ 
}  tMainSingleton_CB;
/* singleton cell CB prototype declaration #_SCP_# */
extern  tMainSingleton_CB  tMainSingleton_SINGLE_CELL_CB;


/* celltype IDX type #_CTIX_# */
typedef struct tag_tMainSingleton_CB *tMainSingleton_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sTaskBody */
void         tMainSingleton_eMain_main();
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

/* to get the definition of CB type of referenced celltype for optimization #_ICT_# */
#ifndef  TOPPERS_CB_TYPE_ONLY
#define  tMainSingleton_CB_TYPE_ONLY
#define TOPPERS_CB_TYPE_ONLY
#endif  /* TOPPERS_CB_TYPE_ONLY */
#include "tTalkerSelector_tecsgen.h"
#ifdef  tMainSingleton_CB_TYPE_ONLY
#undef TOPPERS_CB_TYPE_ONLY
#endif /* tMainSingleton_CB_TYPE_ONLY */
#ifndef TOPPERS_CB_TYPE_ONLY

/* optional call port test macro #_TOCP_# */
#define tMainSingleton_is_cTalker_joined() \
	  (tMainSingleton_SINGLE_CELL_CB.cTalker!=0)

/* celll CB macro #_GCB_# */
#define tMainSingleton_GET_CELLCB(idx) ((void *)0)
#ifndef TECSFLOW
 /* call port function macro #_CPM_# */
#define tMainSingleton_cDefaultTalker_hello( ) \
	  tMainSingleton_SINGLE_CELL_CB.cDefaultTalker->VMT->hello__T( \
	  tMainSingleton_SINGLE_CELL_CB.cDefaultTalker )
#define tMainSingleton_cTalker_hello( ) \
	  tMainSingleton_SINGLE_CELL_CB.cTalker->VMT->hello__T( \
	  tMainSingleton_SINGLE_CELL_CB.cTalker )
#define tMainSingleton_cTalkerSelector_getTalker( talker, i ) \
	  tTalkerSelector_eTalkerSelector_getTalker( \
	   &tTalkerSelector_CB_tab[0], (talker), (i) )
#define tMainSingleton_cTalkerSelector_getNTalker( n ) \
	  tTalkerSelector_eTalkerSelector_getNTalker( \
	   &tTalkerSelector_CB_tab[0], (n) )

#else  /* TECSFLOW */
#define tMainSingleton_cDefaultTalker_hello( ) \
	  (p_that)->cDefaultTalker.hello__T( \
 )
#define tMainSingleton_cTalker_hello( ) \
	  (p_that)->cTalker.hello__T( \
 )
#define tMainSingleton_cTalkerSelector_getTalker( talker, i ) \
	  (p_that)->cTalkerSelector.getTalker__T( \
 (talker), (i) )
#define tMainSingleton_cTalkerSelector_getNTalker( n ) \
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
void           tMainSingleton_eMain_main_skel( const struct tag_sTaskBody_VDES *epd);

#ifndef TOPPERS_CB_TYPE_ONLY

/* refer to descriptor function #_CRD_# */
/* [ref_desc] cDefaultTalker */
Inline Descriptor( sHello )
tMainSingleton_cDefaultTalker_refer_to_descriptor(  )
{
    Descriptor( sHello )  des;
    /* cast is ncecessary for removing 'const'  */
    des.vdes = (struct tag_sHello_VDES *)tMainSingleton_SINGLE_CELL_CB.cDefaultTalker;
    return des;
}

/* set descriptor function #_SDF_# */
/* [dynamic] cTalker */
Inline void
tMainSingleton_cTalker_set_descriptor( Descriptor( sHello ) des )
{
    assert( des.vdes != NULL );
    tMainSingleton_SINGLE_CELL_CB.cTalker = des.vdes;
}

/* [dynamic,optional] cTalker */
Inline void
tMainSingleton_cTalker_unjoin(  )
{
    tMainSingleton_SINGLE_CELL_CB.cTalker = NULL;
}

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tMainSingleton_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tMainSingleton_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tMainSingleton_IDX

/* call port function macro (abbrev) #_CPMA_# */
#define cDefaultTalker_hello( ) \
          tMainSingleton_cDefaultTalker_hello( )
#define cTalker_hello( ) \
          tMainSingleton_cTalker_hello( )
#define cTalkerSelector_getTalker( talker, i ) \
          tMainSingleton_cTalkerSelector_getTalker( talker, i )
#define cTalkerSelector_getNTalker( n ) \
          tMainSingleton_cTalkerSelector_getNTalker( n )


/* refer to descriptor macro (abbrev) #_CRDA_# */
#define cDefaultTalker_refer_to_descriptor()\
          tMainSingleton_cDefaultTalker_refer_to_descriptor(  )
#define cDefaultTalker_ref_desc()\
          cDefaultTalker_refer_to_descriptor()


/* set descriptor macro (abbrev) #_SDMA_# */
#define cTalker_set_descriptor( desc )\
          tMainSingleton_cTalker_set_descriptor( desc )
#define cTalker_unjoin(  )\
          tMainSingleton_cTalker_unjoin(  )

/* optional call port test macro (abbrev) #_TOCPA_# */
#define is_cTalker_joined()\
		tMainSingleton_is_cTalker_joined()

/* entry port function macro (abbrev) #_EPM_# */
#define eMain_main       tMainSingleton_eMain_main

/* CB initialize macro #_CIM_# */
#define INITIALIZE_CB()
#define SET_CB_INIB_POINTER(i,p_that)\
	/* empty */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tMainSingleton_TECSGENH */
