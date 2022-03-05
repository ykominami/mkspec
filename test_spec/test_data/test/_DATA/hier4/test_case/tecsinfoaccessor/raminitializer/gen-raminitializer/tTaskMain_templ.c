/*
 * This file was automatically generated by tecsgen.
 * Move and rename like below before editing,
 *   gen/tTaskMain_templ.c => src/tTaskMain.c
 * to avoid to be overwritten by tecsgen.
 */
/* #[<PREAMBLE>]#
 * Don't edit the comments between #[<...>]# and #[</...>]#
 * These comment are used by tecsmerege when merging.
 *
 * attr access macro #_CAAM_#
 * NAME_LEN         int16_t          ATTR_NAME_LEN   
 * name             char_t*          VAR_name        
 * name2            char_t*          VAR_name2       
 *
 * call port function #_TCPF_#
 * call port: cAccessor signature: nTECSInfo_sAccessor context:task
 *   ER             cAccessor_selectNamespaceInfoByName( const char_t* namespacePath );
 *   ER             cAccessor_selectCelltypeInfoByName( const char_t* celltypePath );
 *   ER             cAccessor_selectSignatureInfoByName( const char_t* signaturePath );
 *   ER             cAccessor_selectRegionInfoByName( const char_t* regionPath );
 *   ER             cAccessor_selectCellInfoByName( const char_t* cellPath );
 *   ER             cAccessor_getSignatureNameOfCellEntry( const char_t* cellEntryPath, char_t* signatureGlobalName, int_t max_len );
 *   ER             cAccessor_getSelectedNamespaceInfo( char_t* name, int_t max_len, int_t* num_namespace, int_t* num_celltype, int_t* num_signature );
 *   ER             cAccessor_selectCelltypeInfo( int_t ith );
 *   ER             cAccessor_selectSignatureInfo( int_t ith );
 *   ER             cAccessor_selectNamespaceInfo( int_t ith );
 *   ER             cAccessor_getSelectedCelltypeInfo( char_t* name, int_t max_len, int_t* num_attr, int_t* num_var, int_t* num_call, int_t* num_entry );
 *   ER             cAccessor_selectCallInfo( int_t ith );
 *   ER             cAccessor_selectEntryInfo( int_t ith );
 *   ER             cAccessor_selectAttrInfo( int_t ith );
 *   ER             cAccessor_selectVarInfo( int_t ith );
 *   ER             cAccessor_getSelectedAttrInfo( char_t* name, int_t max_len );
 *   ER             cAccessor_getSizeIsExprOfAttr( char_t* expr_str, int32_t max_len );
 *   ER             cAccessor_selectTypeInfoOfAttr( );
 *   ER             cAccessor_getSelectedVarInfo( char_t* name, int_t max_len );
 *   ER             cAccessor_getSizeIsExprOfVar( char_t* expr_str, int32_t max_len );
 *   ER             cAccessor_selectTypeInfoOfVar( );
 *   ER             cAccessor_getSelectedCallInfo( char_t* name, int_t max_len, int_t* array_size );
 *   ER             cAccessor_selectSignatureOfCall( );
 *   ER             cAccessor_getSelectedCallSpecifierInfo( bool_t* b_optional, bool_t* b_dynamic, bool_t* b_ref_desc, bool_t* b_omit );
 *   ER             cAccessor_getSelectedCallInternalInfo( bool_t* b_allocator_port, bool_t* b_require_port );
 *   ER             cAccessor_getSelectedCallLocationInfo( uint32_t* offset, int8_t* place );
 *   ER             cAccessor_getSelectedCallOptimizeInfo( bool_t* b_VMT_useless, bool_t* b_skelton_useless, bool_t* b_cell_unique );
 *   ER             cAccessor_getSelectedEntryInfo( char_t* name, int_t max_len, int_t* array_size );
 *   ER             cAccessor_selectSignatureOfEntry( );
 *   ER             cAccessor_getSelectedEntryInlineInfo( bool_t* b_inline );
 *   ER             cAccessor_getSelectedSignatureInfo( char_t* name, int_t max_len, int_t* num_function );
 *   ER             cAccessor_selectFunctionInfoByIndex( int_t ith );
 *   ER             cAccessor_getSelectedFunctionInfo( char_t* name, int_t max_len, int_t* num_args );
 *   ER             cAccessor_selectTypeInfoOfReturn( );
 *   ER             cAccessor_getSelectedParamInfo( char_t* name, int_t max_len, int8_t* dir );
 *   ER             cAccessor_selectParamInfo( int_t ith );
 *   ER             cAccessor_selectTypeInfoOfParam( );
 *   ER             cAccessor_getSelectedTypeInfo( char_t* name, int_t max_len, int8_t* kind );
 *   ER             cAccessor_selectTypeInfoOfType( );
 *   ER             cAccessor_getSelectedRegionInfo( char_t* name, int_t max_len, int_t* num_cell, int_t* num_region );
 *   ER             cAccessor_selectCellInfo( int_t ith );
 *   ER             cAccessor_selectRegionInfo( int_t ith );
 *   ER             cAccessor_getSelectedCellInfo( char_t* name, int_t max_len );
 *   ER             cAccessor_selectCelltypeInfoOfCell( );
 *   ER             cAccessor_getAttrValueInStr( char_t* buf, int_t max_len );
 *   ER             cAccessor_getAttrSizeIsValue( );
 *   ER             cAccessor_getVarValueInStr( char_t* buf, int_t max_len );
 *   ER             cAccessor_getVarSizeIsValue( );
 *
 * #[</PREAMBLE>]# */

/* Put prototype declaration and/or variale definition here #_PAC_# */
#include "tTaskMain_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* entry port function #_TEPF_# */
/* #[<ENTRY_PORT>]# eBody
 * entry port: eBody
 * signature:  sTaskBody
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eBody_main
 * name:         eBody_main
 * global_name:  tTaskMain_eBody_main
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eBody_main(CELLIDX idx)
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
