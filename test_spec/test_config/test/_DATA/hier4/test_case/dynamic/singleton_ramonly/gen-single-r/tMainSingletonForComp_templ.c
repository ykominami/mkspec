/*
 * This file was automatically generated by tecsgen.
 * Move and rename like below before editing,
 *   gen/tMainSingletonForComp_templ.c => src/tMainSingletonForComp.c
 * to avoid to be overwritten by tecsgen.
 */
/* #[<PREAMBLE>]#
 * Don't edit the comments between #[<...>]# and #[</...>]#
 * These comment are used by tecsmerege when merging.
 *
 * call port function #_TCPF_#
 * call port: cDefaultTalker signature: sHello context:task
 *   void           cDefaultTalker_hello( );
 *   [ref_desc]
 *      Descriptor( sHello ) cDefaultTalker_refer_to_descriptor();
 *      Descriptor( sHello ) cDefaultTalker_ref_desc()      (same as above; abbreviated version);
 * call port: cTalker signature: sHello context:task optional:true
 *   bool_t     is_cTalker_joined()                     check if joined
 *   void           cTalker_hello( );
 *   [dynamic, optional]
 *      void           cTalker_set_descriptor( Descriptor( sHello ) desc );
 *      void           cTalker_unjoin(  );
 * call port: cTalkerSelector signature: sTalkerSelector context:task
 *   void           cTalkerSelector_getTalker( Descriptor( sHello )* talker, int_t i );
 *   void           cTalkerSelector_getNTalker( int_t* n );
 *
 * #[</PREAMBLE>]# */

/* Put prototype declaration and/or variale definition here #_PAC_# */
#include "tMainSingletonForComp_tecsgen.h"

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
 * global_name:  tMainSingletonForComp_eMain_main
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eMain_main()
{
}

/* #[<POSTAMBLE>]#
 *   Put non-entry functions below.
 * #[</POSTAMBLE>]#*/
