/*
 * This file was automatically generated by tecsgen.
 * Move and rename like below before editing,
 *   gen/tSingle_templ.c => src/tSingle.c
 * to avoid to be overwritten by tecsgen.
 */
/* #[<PREAMBLE>]#
 * Don't edit the comments between #[<...>]# and #[</...>]#
 * These comment are used by tecsmerege when merging.
 *
 * attr access macro #_CAAM_#
 * a                int32_t          ATTR_a          
 * b                int32_t          VAR_b           
 *
 * call port function #_TCPF_#
 * call port: cCall signature: sSig context:task
 *   int32_t        cCall_func( subscript, int32_t in, int32_t* out );
 *       subscript:  0...(NCP_cCall-1)
 *
 * #[</PREAMBLE>]# */

/* Put prototype declaration and/or variale definition here #_PAC_# */
#include "tSingle_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* entry port function #_TEPF_# */
/* #[<ENTRY_PORT>]# eSig
 * entry port: eSig
 * signature:  sSig
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eSig_func
 * name:         eSig_func
 * global_name:  tSingle_eSig_func
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
int32_t
eSig_func(int32_t in, int32_t* out)
{
}

/* #[<POSTAMBLE>]#
 *   Put non-entry functions below.
 * #[</POSTAMBLE>]#*/
