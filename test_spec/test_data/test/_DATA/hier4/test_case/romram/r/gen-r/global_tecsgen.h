/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#ifndef GLOBAL_TECSGEN_H
#define GLOBAL_TECSGEN_H


/* header imported by import_C #_IMP_# */
#include "tecs.h"
/**/

#ifndef TOPPERS_MACRO_ONLY


#define INITIALIZE_TECS() 
#define INITIALZE_TECSGEN() INITIALIZE_TECS()  /* for backward compatibility */

/* Descriptor for dynamic join */
#define Descriptor( signature_global_name )  DynDesc__ ## signature_global_name
#define is_descriptor_unjoined( desc )  ((desc).vdes==NULL)

#endif /* TOPPERS_MACRO_ONLY */

#define const_int      ((const int32_t)32)

#endif /* GLOBAL_TECSGEN_H */
