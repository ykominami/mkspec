/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef sTaskExceptionBody_TECSGEN_H
#define sTaskExceptionBody_TECSGEN_H

/*
 * signature   :  sTaskExceptionBody
 * global name :  sTaskExceptionBody
 * context     :  task
 */

#ifndef TOPPERS_MACRO_ONLY

/* signature descriptor #_SD_# */
struct tag_sTaskExceptionBody_VDES {
    struct tag_sTaskExceptionBody_VMT *VMT;
};

/* signature function table #_SFT_# */
struct tag_sTaskExceptionBody_VMT {
    void           (*main__T)( const struct tag_sTaskExceptionBody_VDES *edp, TEXPTN pattern );
};

/* signature descriptor #_SDES_# for dynamic join */
#ifndef Descriptor_of_sTaskExceptionBody_Defined
#define  Descriptor_of_sTaskExceptionBody_Defined
typedef struct { struct tag_sTaskExceptionBody_VDES *vdes; } Descriptor( sTaskExceptionBody );
#endif
#endif /* TOPPERS_MACRO_ONLY */

/* function id */
#define	FUNCID_STASKEXCEPTIONBODY_MAIN         (1)

#endif /* sTaskExceptionBody_TECSGEN_H */
