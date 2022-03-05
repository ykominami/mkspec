/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tAttribute5_TECSGEN_H
#define tAttribute5_TECSGEN_H

/*
 * celltype          :  tAttribute5
 * global name       :  tAttribute5
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

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell INIB type definition #_CIP_# */
typedef const struct tag_tAttribute5_INIB {
    /* attribute(RO) #_ATO_# */ 
    int32_t        size;
    char(*         buf)[4];
}  tAttribute5_INIB;

/* CB not exist. CB corresponding to INIB #_DCI_# */
#define tAttribute5_CB_tab           tAttribute5_INIB_tab
#define tAttribute5_CB               tAttribute5_INIB
#define tag_tAttribute5_CB           tag_tAttribute5_INIB

/* singleton cell CB prototype declaration #_MCPB_# */
extern tAttribute5_INIB  tAttribute5_INIB_tab[];

/* celltype IDX type #_CTIX_# */
typedef const struct tag_tAttribute5_INIB *tAttribute5_IDX;
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

#define tAttribute5_ID_BASE         (1)  /* ID Base  #_NIDB_# */
#define tAttribute5_N_CELL          (1)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tAttribute5_VALID_IDX(IDX) (1)


/* celll CB macro #_GCB_# */
#define tAttribute5_GET_CELLCB(idx) (idx)

/* attr access  #_AAM_# */
#define tAttribute5_ATTR_size( p_that )	((p_that)->size)

#define tAttribute5_GET_size(p_that)	((p_that)->size)


/* var access macro #_VAM_# */
#define tAttribute5_VAR_buf(p_that)	((p_that)->buf)

#define tAttribute5_GET_buf(p_that)	((p_that)->buf)
#define tAttribute5_SET_buf(p_that,val)	((p_that)->buf=(val))

#ifndef TECSFLOW
#else  /* TECSFLOW */
#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

#ifndef TOPPERS_CB_TYPE_ONLY

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* IDX validation macro (abbrev.) #_CVIA_# */
#define VALID_IDX(IDX)  tAttribute5_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tAttribute5_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tAttribute5_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tAttribute5_IDX


/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_size            tAttribute5_ATTR_size( p_cellcb )


/* var access macro (abbrev) #_VAMA_# */
#define VAR_buf              tAttribute5_VAR_buf( p_cellcb )



/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < tAttribute5_N_CELL; (i)++ ){ \
       //(p_cb) = &tAttribute5_CB_tab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tAttribute5_TECSGENH */
