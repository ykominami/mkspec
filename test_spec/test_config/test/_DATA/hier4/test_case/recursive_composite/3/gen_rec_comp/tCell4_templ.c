/*
 * This file was automatically generated by tecsgen.
 * Move and rename like below before editing,
 *   gen/tCell4_templ.c => src/tCell4.c
 * to avoid to be overwritten by tecsgen.
 */
/* #[<PREAMBLE>]#
 * Don't edit the comments between #[<...>]# and #[</...>]#
 * These comment are used by tecsmerege when merging.
 *
 * attr access macro #_CAAM_#
 * name             char*            ATTR_name       
 * a                int32_t          ATTR_a          
 *
 * call port function #_TCPF_#
 * call port: cCall4 signature: sSig5 context:task
 *   int32_t        cCall4_func1( int32_t a );
 *   int32_t        cCall4_func2( int32_t a );
 *
 * #[</PREAMBLE>]# */

/* Put prototype declaration and/or variale definition here #_PAC_# */
#include "tCell4_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* entry port function #_TEPF_# */
/* #[<ENTRY_PORT>]# eEntry4
 * entry port: eEntry4
 * signature:  sSig4
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEntry4_func1
 * name:         eEntry4_func1
 * global_name:  tCell4_eEntry4_func1
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
int32_t
eEntry4_func1(CELLIDX idx, int32_t a)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* Write error processing code here */
	} /* end if VALID_IDX(idx) */

	/* Put statements here #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eEntry4_func2
 * name:         eEntry4_func2
 * global_name:  tCell4_eEntry4_func2
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
int32_t
eEntry4_func2(CELLIDX idx, int32_t a)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* Write error processing code here */
	} /* end if VALID_IDX(idx) */

	/* Put statements here #_TEFB_# */

}

/* #[<POSTAMBLE>]#
 *   Put non-entry functions below.
 * #[</POSTAMBLE>]#*/
