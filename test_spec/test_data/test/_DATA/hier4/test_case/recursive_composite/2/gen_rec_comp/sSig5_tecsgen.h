/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef sSig5_TECSGEN_H
#define sSig5_TECSGEN_H

/*
 * signature   :  sSig5
 * global name :  sSig5
 * context     :  task
 */

#ifndef TOPPERS_MACRO_ONLY

/* signature descriptor #_SD_# */
struct tag_sSig5_VDES {
    struct tag_sSig5_VMT *VMT;
};

/* signature function table #_SFT_# */
struct tag_sSig5_VMT {
    int32_t        (*func1__T)( const struct tag_sSig5_VDES *edp, int32_t a );
    int32_t        (*func2__T)( const struct tag_sSig5_VDES *edp, int32_t a );
};

/* signature descriptor #_SDES_# for dynamic join */
#ifndef Descriptor_of_sSig5_Defined
#define  Descriptor_of_sSig5_Defined
typedef struct { struct tag_sSig5_VDES *vdes; } Descriptor( sSig5 );
#endif
#endif /* TOPPERS_MACRO_ONLY */

/* function id */
#define	FUNCID_SSIG5_FUNC1                     (1)
#define	FUNCID_SSIG5_FUNC2                     (2)

#endif /* sSig5_TECSGEN_H */
