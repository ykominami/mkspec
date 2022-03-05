/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tCell3_TECSGEN_H
#define tCell3_TECSGEN_H

/*
 * celltype          :  tCell3
 * global name       :  tCell3
 * multi-domain      :  no
 * idx_is_id(actual) :  no(no)
 * singleton         :  no
 * has_CB            :  no
 * has_INIB          :  yes
 * rom               :  yes
 * CB initializer    :  no
 */

/* global header #_IGH_# */
#include "global_tecsgen.h"

/* signature header #_ISH_# */
#include "sSig3_tecsgen.h"
#include "sSig4_tecsgen.h"
#include "sSigB_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell INIB type definition #_CIP_# */
typedef const struct tag_tCell3_INIB {
    /* call port #_TCP_# */
    const struct tag_tCell4_INIB * const cCall3;  /* TCP_4 */
    const struct tag_tCell2_INIB * const cCallB;  /* TCP_4 */
    /* call port #_NEP_# */ 
    /* attribute(RO) #_ATO_# */ 
    char*          name;
    int32_t        a;
}  tCell3_INIB;

/* CB not exist. CB corresponding to INIB #_DCI_# */
#define tCell3_CB_tab           tCell3_INIB_tab
#define tCell3_CB               tCell3_INIB
#define tag_tCell3_CB           tag_tCell3_INIB

/* singleton cell CB prototype declaration #_MCPB_# */
extern tCell3_INIB  tCell3_INIB_tab[];

/* celltype IDX type #_CTIX_# */
typedef const struct tag_tCell3_INIB *tCell3_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sSig3 */
int32_t      tCell3_eEntry3_func1(tCell3_IDX idx, int_t subscript, int32_t a);
int32_t      tCell3_eEntry3_func2(tCell3_IDX idx, int_t subscript, int32_t a);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

/* to get the definition of CB type of referenced celltype for optimization #_ICT_# */
#ifndef  TOPPERS_CB_TYPE_ONLY
#define  tCell3_CB_TYPE_ONLY
#define TOPPERS_CB_TYPE_ONLY
#endif  /* TOPPERS_CB_TYPE_ONLY */
#include "tCell4_tecsgen.h"
#include "tCell2_tecsgen.h"
#ifdef  tCell3_CB_TYPE_ONLY
#undef TOPPERS_CB_TYPE_ONLY
#endif /* tCell3_CB_TYPE_ONLY */
#ifndef TOPPERS_CB_TYPE_ONLY

#define tCell3_ID_BASE              (1)  /* ID Base  #_NIDB_# */
#define tCell3_N_CELL               (4)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tCell3_VALID_IDX(IDX) (1)

/* entry port array size macro #_NEPA_# */
#define NEP_eEntry3     (2)

/* celll CB macro #_GCB_# */
#define tCell3_GET_CELLCB(idx) (idx)

/* attr access  #_AAM_# */
#define tCell3_ATTR_name( p_that )	((p_that)->name)
#define tCell3_ATTR_a( p_that )	((p_that)->a)

#define tCell3_GET_name(p_that)	((p_that)->name)
#define tCell3_GET_a(p_that)	((p_that)->a)



#ifndef TECSFLOW
 /* call port function macro #_CPM_# */
#define tCell3_cCall3_func1( p_that, a ) \
	  tCell4_eEntry4_func1( \
	   (p_that)->cCall3, (a) )
#define tCell3_cCall3_func2( p_that, a ) \
	  tCell4_eEntry4_func2( \
	   (p_that)->cCall3, (a) )
#define tCell3_cCallB_func1( p_that, a ) \
	  tCell2_eEntryB_func1( \
	   (p_that)->cCallB, (a) )
#define tCell3_cCallB_func2( p_that, a ) \
	  tCell2_eEntryB_func2( \
	   (p_that)->cCallB, (a) )

#else  /* TECSFLOW */
#define tCell3_cCall3_func1( p_that, a ) \
	  (p_that)->cCall3.func1__T( \
 (a) )
#define tCell3_cCall3_func2( p_that, a ) \
	  (p_that)->cCall3.func2__T( \
 (a) )
#define tCell3_cCallB_func1( p_that, a ) \
	  (p_that)->cCallB.func1__T( \
 (a) )
#define tCell3_cCallB_func2( p_that, a ) \
	  (p_that)->cCallB.func2__T( \
 (a) )

#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */
/* eEntry3 */
int32_t        tCell3_eEntry3_func1_skel( const struct tag_sSig3_VDES *epd, int32_t a);
int32_t        tCell3_eEntry3_func2_skel( const struct tag_sSig3_VDES *epd, int32_t a);

#ifndef TOPPERS_CB_TYPE_ONLY

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* IDX validation macro (abbrev.) #_CVIA_# */
#define VALID_IDX(IDX)  tCell3_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tCell3_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tCell3_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tCell3_IDX


/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_name            tCell3_ATTR_name( p_cellcb )
#define ATTR_a               tCell3_ATTR_a( p_cellcb )


/* call port function macro (abbrev) #_CPMA_# */
#define cCall3_func1( a ) \
          ((void)p_cellcb, tCell3_cCall3_func1( p_cellcb, a ))
#define cCall3_func2( a ) \
          ((void)p_cellcb, tCell3_cCall3_func2( p_cellcb, a ))
#define cCallB_func1( a ) \
          ((void)p_cellcb, tCell3_cCallB_func1( p_cellcb, a ))
#define cCallB_func2( a ) \
          ((void)p_cellcb, tCell3_cCallB_func2( p_cellcb, a ))




/* entry port function macro (abbrev) #_EPM_# */
#define eEntry3_func1    tCell3_eEntry3_func1
#define eEntry3_func2    tCell3_eEntry3_func2

/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < tCell3_N_CELL; (i)++ ){ \
       //(p_cb) = &tCell3_CB_tab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tCell3_TECSGENH */
