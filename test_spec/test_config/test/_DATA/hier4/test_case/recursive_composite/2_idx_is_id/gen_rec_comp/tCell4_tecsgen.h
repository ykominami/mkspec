/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tCell4_TECSGEN_H
#define tCell4_TECSGEN_H

/*
 * celltype          :  tCell4
 * global name       :  tCell4
 * multi-domain      :  yes
 * idx_is_id(actual) :  yes(yes)
 * singleton         :  no
 * has_CB            :  no
 * has_INIB          :  yes
 * rom               :  yes
 * CB initializer    :  no
 */

/* global header #_IGH_# */
#include "global_tecsgen.h"

/* signature header #_ISH_# */
#include "sSig4_tecsgen.h"
#include "sSig5_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell INIB type definition #_CIP_# */
typedef const struct tag_tCell4_INIB {
    /* call port #_TCP_# */
    /* call port #_NEP_# */ 
    /* attribute(RO) #_ATO_# */ 
    int32_t        a;
}  tCell4_INIB;

/* CB not exist. CB corresponding to INIB #_DCI_# */
#define tCell4_CB_ptab           tCell4_INIB_ptab
#define tCell4_CB               tCell4_INIB
#define tag_tCell4_CB           tag_tCell4_INIB

/* singleton cell CB prototype declaration #_MCPP_# */
extern tCell4_INIB  *const tCell4_INIB_ptab[];
extern tCell4_INIB  comp1_comp12_cell4_INIB;
extern tCell4_INIB  comp2_comp12_cell4_INIB;

/* celltype IDX type #_CTIX_# */
typedef ID tCell4_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sSig4 */
int32_t      tCell4_eEntry4_func1(tCell4_IDX idx, int32_t a);
int32_t      tCell4_eEntry4_func2(tCell4_IDX idx, int32_t a);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

/* to get the definition of CB type of referenced celltype for optimization #_ICT_# */
#ifndef  TOPPERS_CB_TYPE_ONLY
#define  tCell4_CB_TYPE_ONLY
#define TOPPERS_CB_TYPE_ONLY
#endif  /* TOPPERS_CB_TYPE_ONLY */
#include "tCell_serv_tecsgen.h"
#ifdef  tCell4_CB_TYPE_ONLY
#undef TOPPERS_CB_TYPE_ONLY
#endif /* tCell4_CB_TYPE_ONLY */
#ifndef TOPPERS_CB_TYPE_ONLY

#define tCell4_ID_BASE              (7)  /* ID Base  #_NIDB_# */
#define tCell4_N_CELL               (2)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tCell4_VALID_IDX(IDX) (tCell4_ID_BASE <= (IDX) && (IDX) < tCell4_ID_BASE+tCell4_N_CELL)


/* celll CB macro #_GCB_# */
#define tCell4_GET_CELLCB(idx) (tCell4_CB_ptab[(idx) - tCell4_ID_BASE])

/* attr access  #_AAM_# */
#define tCell4_ATTR_a( p_that )	((p_that)->a)

#define tCell4_GET_a(p_that)	((p_that)->a)



#ifndef TECSFLOW
 /* call port function macro #_CPM_# */
#define tCell4_cCall4_func1( p_that, a ) \
	  tCell_serv_eEntry_func1( \
	   9, (a) )
#define tCell4_cCall4_func2( p_that, a ) \
	  tCell_serv_eEntry_func2( \
	   9, (a) )

#else  /* TECSFLOW */
#define tCell4_cCall4_func1( p_that, a ) \
	  (p_that)->cCall4.func1__T( \
 (a) )
#define tCell4_cCall4_func2( p_that, a ) \
	  (p_that)->cCall4.func2__T( \
 (a) )

#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */

#ifndef TOPPERS_CB_TYPE_ONLY

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* IDX validation macro (abbrev.) #_CVIA_# */
#define VALID_IDX(IDX)  tCell4_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tCell4_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tCell4_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tCell4_IDX


/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_a               tCell4_ATTR_a( p_cellcb )


/* call port function macro (abbrev) #_CPMA_# */
#define cCall4_func1( a ) \
          ((void)p_cellcb, tCell4_cCall4_func1( p_cellcb, a ))
#define cCall4_func2( a ) \
          ((void)p_cellcb, tCell4_cCall4_func2( p_cellcb, a ))




/* entry port function macro (abbrev) #_EPM_# */
#define eEntry4_func1    tCell4_eEntry4_func1
#define eEntry4_func2    tCell4_eEntry4_func2

/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < tCell4_N_CELL; (i)++ ){ \
       //(p_cb) = tCell4_CB_ptab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tCell4_TECSGENH */
