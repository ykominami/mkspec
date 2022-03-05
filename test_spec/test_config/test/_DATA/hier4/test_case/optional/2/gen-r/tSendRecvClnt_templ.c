/*
 * This file was automatically generated by tecsgen.
 * Move and rename like below before editing,
 *   gen/tSendRecvClnt_templ.c => src/tSendRecvClnt.c
 * to avoid to be overwritten by tecsgen.
 */
/* #[<PREAMBLE>]#
 * Don't edit the comments between #[<...>]# and #[</...>]#
 * These comment are used by tecsmerege when merging.
 *
 * call port function #_TCPF_#
 * call port: cCall signature: sSigSendRecv context:task optional:true
 *   bool_t     is_cCall_joined()                     check if joined
 *   ER             cCall_snd( ST_VAL* st_val );
 *   ER             cCall_rcv( ST_VAL** st_val );
 * allocator port for call port:cCall func:snd param: st_val
 *   ER             cCall_snd_st_val_alloc( int32_t size, void** p );
 *   ER             cCall_snd_st_val_dealloc( const void* p );
 * allocator port for call port:cCall func:rcv param: st_val
 *   ER             cCall_rcv_st_val_alloc( int32_t size, void** p );
 *   ER             cCall_rcv_st_val_dealloc( const void* p );
 *
 * #[</PREAMBLE>]# */

/* Put prototype declaration and/or variale definition here #_PAC_# */
#include "tSendRecvClnt_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* entry port function #_TEPF_# */
/* #[<ENTRY_PORT>]# eMain
 * entry port: eMain
 * signature:  sTaskBody
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eMain_main
 * name:         eMain_main
 * global_name:  tSendRecvClnt_eMain_main
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eMain_main(CELLIDX idx)
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
