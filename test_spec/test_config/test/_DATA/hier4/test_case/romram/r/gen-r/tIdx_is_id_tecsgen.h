/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tIdx_is_id_TECSGEN_H
#define tIdx_is_id_TECSGEN_H

/*
 * celltype          :  tIdx_is_id
 * global name       :  tIdx_is_id
 * multi-domain      :  yes
 * idx_is_id(actual) :  yes(yes)
 * singleton         :  no
 * has_CB            :  yes
 * has_INIB          :  no
 * rom               :  no
 * CB initializer    :  yes
 */

/* global header #_IGH_# */
#include "global_tecsgen.h"

/* signature header #_ISH_# */
#include "sSig_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell CB type definition #_CCTPO_# */
typedef struct tag_tIdx_is_id_CB {
    /* call port #_NEP_# */ 
    /* attribute #_AT_# */ 
    int32_t        a_init;
    int32_t        b_init;
    int32_t        c_init;
    /* var #_VA_# */ 
    int32_t        a;
    int32_t        b;
    int32_t        c;
}  tIdx_is_id_CB;
/* singleton cell CB prototype declaration #_MCPP_# */
extern tIdx_is_id_CB  *const tIdx_is_id_CB_ptab[];
extern tIdx_is_id_CB  cell_idx_is_id1_CB;
extern tIdx_is_id_CB  cell_idx_is_id2_CB;
extern tIdx_is_id_CB  cell_idx_is_id3_CB;

/* celltype IDX type #_CTIX_# */
typedef ID tIdx_is_id_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sSig */
int32_t      tIdx_is_id_eEnt_func(tIdx_is_id_IDX idx, int32_t in, int32_t* out);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

#define tIdx_is_id_ID_BASE          (5)  /* ID Base  #_NIDB_# */
#define tIdx_is_id_N_CELL           (3)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tIdx_is_id_VALID_IDX(IDX) (tIdx_is_id_ID_BASE <= (IDX) && (IDX) < tIdx_is_id_ID_BASE+tIdx_is_id_N_CELL)


/* celll CB macro #_GCB_# */
#define tIdx_is_id_GET_CELLCB(idx) (tIdx_is_id_CB_ptab[(idx) - tIdx_is_id_ID_BASE])

/* attr access  #_AAM_# */
#define tIdx_is_id_ATTR_a_init( p_that )	((p_that)->a_init)
#define tIdx_is_id_ATTR_b_init( p_that )	((p_that)->b_init)
#define tIdx_is_id_ATTR_c_init( p_that )	((p_that)->c_init)

#define tIdx_is_id_GET_a_init(p_that)	((p_that)->a_init)
#define tIdx_is_id_GET_b_init(p_that)	((p_that)->b_init)
#define tIdx_is_id_GET_c_init(p_that)	((p_that)->c_init)


/* var access macro #_VAM_# */
#define tIdx_is_id_VAR_a(p_that)	((p_that)->a)
#define tIdx_is_id_VAR_b(p_that)	((p_that)->b)
#define tIdx_is_id_VAR_c(p_that)	((p_that)->c)

#define tIdx_is_id_GET_a(p_that)	((p_that)->a)
#define tIdx_is_id_SET_a(p_that,val)	((p_that)->a=(val))
#define tIdx_is_id_GET_b(p_that)	((p_that)->b)
#define tIdx_is_id_SET_b(p_that,val)	((p_that)->b=(val))
#define tIdx_is_id_GET_c(p_that)	((p_that)->c)
#define tIdx_is_id_SET_c(p_that,val)	((p_that)->c=(val))

#ifndef TECSFLOW
#else  /* TECSFLOW */
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
#define VALID_IDX(IDX)  tIdx_is_id_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tIdx_is_id_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tIdx_is_id_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tIdx_is_id_IDX


/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_a_init          tIdx_is_id_ATTR_a_init( p_cellcb )
#define ATTR_b_init          tIdx_is_id_ATTR_b_init( p_cellcb )
#define ATTR_c_init          tIdx_is_id_ATTR_c_init( p_cellcb )


/* var access macro (abbrev) #_VAMA_# */
#define VAR_a                tIdx_is_id_VAR_a( p_cellcb )
#define VAR_b                tIdx_is_id_VAR_b( p_cellcb )
#define VAR_c                tIdx_is_id_VAR_c( p_cellcb )




/* entry port function macro (abbrev) #_EPM_# */
#define eEnt_func        tIdx_is_id_eEnt_func

/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < tIdx_is_id_N_CELL; (i)++ ){ \
       (p_cb) = tIdx_is_id_CB_ptab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#define INITIALIZE_CB(p_that)\
	(p_that)->a = tIdx_is_id_ATTR_a_init(p_that);\
	(p_that)->b = tIdx_is_id_ATTR_b_init(p_that)+1;\
	(p_that)->c = tIdx_is_id_ATTR_c_init(p_that)*2;
#define SET_CB_INIB_POINTER(i,p_that)\
	/* empty */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tIdx_is_id_TECSGENH */
