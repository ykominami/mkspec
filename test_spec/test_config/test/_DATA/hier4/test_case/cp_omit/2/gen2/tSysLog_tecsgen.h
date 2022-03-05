/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef tSysLog_TECSGEN_H
#define tSysLog_TECSGEN_H

/*
 * celltype          :  tSysLog
 * global name       :  tSysLog
 * multi-domain      :  no
 * idx_is_id(actual) :  no(no)
 * singleton         :  yes
 * has_CB            :  no
 * has_INIB          :  no
 * rom               :  yes
 * CB initializer    :  yes
 */

/* global header #_IGH_# */
#include "global_tecsgen.h"

/* signature header #_ISH_# */
#include "sSysLog_tecsgen.h"

#ifndef TOPPERS_MACRO_ONLY

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
/* cell CB (dummy) type definition #_CCDP_# */
typedef struct tag_tSysLog_CB {
    int  dummy;
} tSysLog_CB;
/* singleton cell CB prototype declaration #_SCP_# */


/* celltype IDX type #_CTIX_# */
typedef int   tSysLog_IDX;

/* prototype declaration of entry port function #_EPP_# */
/* sSysLog */
ER           tSysLog_eSysLog_write( uint_t prio, const SYSLOG* p_syslog);
ER_UINT      tSysLog_eSysLog_read( SYSLOG* p_syslog);
ER           tSysLog_eSysLog_mask( uint_t logmask, uint_t lowmask);
ER           tSysLog_eSysLog_refer( T_SYSLOG_RLOG* pk_rlog);
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TOPPERS_MACRO_ONLY */

#ifndef TOPPERS_CB_TYPE_ONLY


/* celll CB macro #_GCB_# */
#define tSysLog_GET_CELLCB(idx) ((void *)0)
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


/* cell CB macro (abbrev) #_GCBA_# */
#define GET_CELLCB(idx)  tSysLog_GET_CELLCB(idx)

/* CELLCB type (abbrev) #_CCT_# */
#define CELLCB	tSysLog_CB

/* celltype IDX type (abbrev) #_CTIXA_# */
#define CELLIDX	tSysLog_IDX




/* entry port function macro (abbrev) #_EPM_# */
#define eSysLog_write    tSysLog_eSysLog_write
#define eSysLog_read     tSysLog_eSysLog_read
#define eSysLog_mask     tSysLog_eSysLog_mask
#define eSysLog_refer    tSysLog_eSysLog_refer

/* CB initialize macro #_CIM_# */
#define INITIALIZE_CB()
#define SET_CB_INIB_POINTER(i,p_that)\
	/* empty */
#endif /* TOPPERS_CB_TYPE_ONLY */

#ifndef TOPPERS_MACRO_ONLY

#endif /* TOPPERS_MACRO_ONLY */

#endif /* tSysLog_TECSGENH */
