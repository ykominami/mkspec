/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef sSysLog_TECSGEN_H
#define sSysLog_TECSGEN_H

/*
 * signature   :  sSysLog
 * global name :  sSysLog
 * context     :  task
 */

#ifndef TOPPERS_MACRO_ONLY

/* signature descriptor #_SD_# */
struct tag_sSysLog_VDES {
    struct tag_sSysLog_VMT *VMT;
};

/* signature function table #_SFT_# */
struct tag_sSysLog_VMT {
    ER             (*write__T)( const struct tag_sSysLog_VDES *edp, uint_t prio, const SYSLOG* p_syslog );
    ER_UINT        (*read__T)( const struct tag_sSysLog_VDES *edp, SYSLOG* p_syslog );
    ER             (*mask__T)( const struct tag_sSysLog_VDES *edp, uint_t logmask, uint_t lowmask );
    ER             (*refer__T)( const struct tag_sSysLog_VDES *edp, T_SYSLOG_RLOG* pk_rlog );
};

/* signature descriptor #_SDES_# for dynamic join */
#ifndef Descriptor_of_sSysLog_Defined
#define  Descriptor_of_sSysLog_Defined
typedef struct { struct tag_sSysLog_VDES *vdes; } Descriptor( sSysLog );
#endif
#endif /* TOPPERS_MACRO_ONLY */

/* function id */
#define	FUNCID_SSYSLOG_WRITE                   (1)
#define	FUNCID_SSYSLOG_READ                    (2)
#define	FUNCID_SSYSLOG_MASK                    (3)
#define	FUNCID_SSYSLOG_REFER                   (4)

#endif /* sSysLog_TECSGEN_H */
