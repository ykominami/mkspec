/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tCCP5Callee_TECSGEN_H
#define tCCP5Callee_TECSGEN_H

/*
 * celltype          :  tCCP5Callee
 * global name       :  tCCP5Callee
 * multi-domain      :  no
 * idx_is_id(actual) :  no(no)
 * singleton         :  no
 * has_CB            :  no
 * has_INIB          :  no
 * rom               :  no
 * CB initializer    :  no
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
typedef struct tag_tCCP5Callee_CB {
    /* call port #_NEP_# */ 
}  tCCP5Callee_CB;
/* singleton cell CB prototype declaration #_MCPB_# */

/* celltype IDX type #_CTIX_# */
typedef int   tCCP5Callee_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sSig */
void         tCCP5Callee_eEnt_func(tCCP5Callee_IDX idx);
int32_t      tCCP5Callee_eEnt_func2(tCCP5Callee_IDX idx, int32_t arg);
struct tagST tCCP5Callee_eEnt_func3(tCCP5Callee_IDX idx, struct tagST a);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

#define tCCP5Callee_ID_BASE         (1)  /* ID Base  #_NIDB_# */
#define tCCP5Callee_N_CELL          (1)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tCCP5Callee_VALID_IDX(IDX) (1)


/* celll CB macro #_GCB_# */
#define tCCP5Callee_GET_CELLCB(idx) ((void *)0)
#ifndef TECSFLOW
#else  /* TECSFLOW */
#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */
/* eEnt */
void           tCCP5Callee_eEnt_func_skel( const struct tag_sSig_VDES *epd);
int32_t        tCCP5Callee_eEnt_func2_skel( const struct tag_sSig_VDES *epd, int32_t arg);
struct tagST   tCCP5Callee_eEnt_func3_skel( const struct tag_sSig_VDES *epd, struct tagST a);

#ifndef TOPPERS_CB_TYPE_ONLY

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* IDX validation macro (abbrev.) #_CVIA_# */
#define VALID_IDX(IDX)  tCCP5Callee_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tCCP5Callee_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tCCP5Callee_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tCCP5Callee_IDX




/* entry port function macro (abbrev) #_EPM_# */
#define eEnt_func        tCCP5Callee_eEnt_func
#define eEnt_func2       tCCP5Callee_eEnt_func2
#define eEnt_func3       tCCP5Callee_eEnt_func3

/* iteration code (FOREACH_CELL) (niether CB, nor NIB exit) #_NFEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for((i)=0;(i)<0;(i)++){

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tCCP5Callee_TECSGENH */
