/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tMain_TECSGEN_H
#define tMain_TECSGEN_H

/*
 * celltype          :  tMain
 * global name       :  tMain
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
#include "sSig_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell CB type definition #_CCTPO_# */
typedef struct tag_tMain_CB {
    /* call port #_TCP_# */
    struct tag_sSig_VDES *const*cMain; /* TCP_2 */
    int_t n_cMain;  /* TCP_3 */
    /* call port #_NEP_# */ 
}  tMain_CB;
/* singleton cell CB prototype declaration #_SCP_# */
extern  tMain_CB  tMain_SINGLE_CELL_CB;


/* celltype IDX type #_CTIX_# */
typedef struct tag_tMain_CB *tMain_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sTaskBody */
void         tMain_eMain_main();
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* call port array size macro #_NCPA_# */
#define N_CP_cMain  (tMain_SINGLE_CELL_CB.n_cMain)
#define NCP_cMain   (tMain_SINGLE_CELL_CB.n_cMain)

/* celll CB macro #_GCB_# */
#define tMain_GET_CELLCB(idx) ((void *)0)
#ifndef TECSFLOW
 /* call port function macro #_CPM_# */
#define tMain_cMain_func( subscript ) \
	  tMain_SINGLE_CELL_CB.cMain[subscript]->VMT->func__T( \
	  tMain_SINGLE_CELL_CB.cMain[subscript] )
#define tMain_cMain_func2( subscript, arg ) \
	  tMain_SINGLE_CELL_CB.cMain[subscript]->VMT->func2__T( \
	  tMain_SINGLE_CELL_CB.cMain[subscript], (arg) )
#define tMain_cMain_func3( subscript, a ) \
	  tMain_SINGLE_CELL_CB.cMain[subscript]->VMT->func3__T( \
	  tMain_SINGLE_CELL_CB.cMain[subscript], (a) )

#else  /* TECSFLOW */
#define tMain_cMain_func( subscript ) \
	  (p_that)->cMain[subscript].func__T( \
 )
#define tMain_cMain_func2( subscript, arg ) \
	  (p_that)->cMain[subscript].func2__T( \
 (arg) )
#define tMain_cMain_func3( subscript, a ) \
	  (p_that)->cMain[subscript].func3__T( \
 (a) )

#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */
/* eMain */
void           tMain_eMain_main_skel( const struct tag_sTaskBody_VDES *epd);

#ifndef TOPPERS_CB_TYPE_ONLY

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tMain_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tMain_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tMain_IDX

/* call port function macro (abbrev) #_CPMA_# */
#define cMain_func( subscript ) \
          tMain_cMain_func( subscript )
#define cMain_func2( subscript, arg ) \
          tMain_cMain_func2( subscript, arg )
#define cMain_func3( subscript, a ) \
          tMain_cMain_func3( subscript, a )




/* entry port function macro (abbrev) #_EPM_# */
#define eMain_main       tMain_eMain_main

/* CB initialize macro #_CIM_# */
#define INITIALIZE_CB()
#define SET_CB_INIB_POINTER(i,p_that)\
	/* empty */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tMain_TECSGENH */
