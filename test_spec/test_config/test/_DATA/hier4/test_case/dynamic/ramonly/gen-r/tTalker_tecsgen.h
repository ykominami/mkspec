/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tTalker_TECSGEN_H
#define tTalker_TECSGEN_H

/*
 * celltype          :  tTalker
 * global name       :  tTalker
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
#include "sHello_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell CB type definition #_CCTPO_# */
typedef struct tag_tTalker_CB {
    /* call port #_NEP_# */ 
    /* attribute #_AT_# */ 
    char_t*        name;
    char_t*        message;
}  tTalker_CB;
/* singleton cell CB prototype declaration #_MCPB_# */
extern tTalker_CB  tTalker_CB_tab[];

/* celltype IDX type #_CTIX_# */
typedef struct tag_tTalker_CB *tTalker_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sHello */
void         tTalker_eHello_hello(tTalker_IDX idx);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

#define tTalker_ID_BASE             (1)  /* ID Base  #_NIDB_# */
#define tTalker_N_CELL             (10)  /*  number of cells  #_NCEL_# */

/* IDX validation macro #_CVI_# */
#define tTalker_VALID_IDX(IDX) (1)


/* celll CB macro #_GCB_# */
#define tTalker_GET_CELLCB(idx) (idx)

/* attr access  #_AAM_# */
#define tTalker_ATTR_name( p_that )	((p_that)->name)
#define tTalker_ATTR_message( p_that )	((p_that)->message)

#define tTalker_GET_name(p_that)	((p_that)->name)
#define tTalker_GET_message(p_that)	((p_that)->message)



#ifndef TECSFLOW
#else  /* TECSFLOW */
#endif /* TECSFLOW */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* prototype declaration of entry port function (referenced when VMT useless optimise enabled) #_EPSP_# */
/* eHello */
void           tTalker_eHello_hello_skel( const struct tag_sHello_VDES *epd);

#ifndef TOPPERS_CB_TYPE_ONLY

#endif /* TOPPERS_CB_TYPE_ONLY */

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY

/* IDX validation macro (abbrev.) #_CVIA_# */
#define VALID_IDX(IDX)  tTalker_VALID_IDX(IDX)


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tTalker_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tTalker_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tTalker_IDX


/* attr access macro (abbrev) #_AAMA_# */
#define ATTR_name            tTalker_ATTR_name( p_cellcb )
#define ATTR_message         tTalker_ATTR_message( p_cellcb )





/* entry port function macro (abbrev) #_EPM_# */
#define eHello_hello     tTalker_eHello_hello

/* iteration code (FOREACH_CELL) #_FEC_# */
#define FOREACH_CELL(i,p_cb)   \
    for( (i) = 0; (i) < tTalker_N_CELL; (i)++ ){ \
       (p_cb) = &tTalker_CB_tab[i];

#define END_FOREACH_CELL   }

/* CB initialize macro #_CIM_# */
#define INITIALIZE_CB(p_that)	(void)(p_that);
#define SET_CB_INIB_POINTER(i,p_that)\
	/* empty */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tTalker_TECSGENH */
