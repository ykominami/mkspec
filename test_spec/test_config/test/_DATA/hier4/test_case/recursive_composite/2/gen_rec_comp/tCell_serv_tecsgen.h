/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tCell_serv_TECSGEN_H
#define tCell_serv_TECSGEN_H

/*
 * celltype          :  tCell_serv
 * global name       :  tCell_serv
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
#include "sSig5_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell INIB type definition #_CIP_# */
typedef const struct tag_tCell_serv_INIB {
    /* call port #_NEP_# */ 
    /* attribute(RO) #_ATO_# */ 
    int32_t        a;
    char*          name;
}  tCell_serv_INIB;

/* CB not exist. CB corresponding to INIB #_DCI_# */
#define tCell_serv_CB_tab           tCell_serv_INIB_tab
#define tCell_serv_CB               tCell_serv_INIB
#define tag_tCell_serv_CB           tag_tCell_serv_INIB

/* singleton cell CB prototype declaration #_MCPB_# */
extern tCell_serv_INIB  tCell_serv_INIB_tab[];

/* celltype IDX type #_CTIX_# */
typedef const struct tag_tCell_serv_INIB *tCell_serv_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sSig5 */
int32_t      tCell_serv_eEntry_func1(tCell_serv_IDX idx, int32_t a);
int32_t      tCell_serv_eEntry_func2(tCell_serv_IDX idx, int32_t a);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

#define tCell_serv_ID_BASE          (1)  /* ID Base  #_NIDB_# */
#define tCell_serv_N_CELL           (2)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tCell_serv_VALID_IDX(IDX) (1)


/* celll CB macro #_GCB_# */
#define tCell_serv_GET_CELLCB(idx) (idx)

/* attr access  #_AAM_# */
#define tCell_serv_ATTR_a( p_that )	((p_that)->a)
#define tCell_serv_ATTR_name( p_that )	((p_that)->name)

#define tCell_serv_GET_a(p_that)	((p_that)->a)
#define tCell_serv_GET_name(p_that)	((p_that)->name)



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
#define VALID_IDX(IDX)  tCell_serv_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tCell_serv_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tCell_serv_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tCell_serv_IDX


/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_a               tCell_serv_ATTR_a( p_cellcb )
#define ATTR_name            tCell_serv_ATTR_name( p_cellcb )





/* entry port function macro (abbrev) #_EPM_# */
#define eEntry_func1     tCell_serv_eEntry_func1
#define eEntry_func2     tCell_serv_eEntry_func2

/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < tCell_serv_N_CELL; (i)++ ){ \
       //(p_cb) = &tCell_serv_CB_tab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tCell_serv_TECSGENH */
