/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tTask_tecsgen.h"
#include "tTask_factory.h"

/* entry port descriptor type #_EDT_# */
/* eTask */
struct tag_tTask_eTask_DES {
    const struct tag_sTask_VMT *vmt;
    tTask_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eTask */
ER             tTask_eTask_activate_skel( const struct tag_sTask_VDES *epd)
{
    struct tag_tTask_eTask_DES *lepd
        = (struct tag_tTask_eTask_DES *)epd;
    return tTask_eTask_activate( lepd->idx );
}
ER             tTask_eTask_suspend_skel( const struct tag_sTask_VDES *epd)
{
    struct tag_tTask_eTask_DES *lepd
        = (struct tag_tTask_eTask_DES *)epd;
    return tTask_eTask_suspend( lepd->idx );
}
ER             tTask_eTask_resume_skel( const struct tag_sTask_VDES *epd)
{
    struct tag_tTask_eTask_DES *lepd
        = (struct tag_tTask_eTask_DES *)epd;
    return tTask_eTask_resume( lepd->idx );
}

/* entry port skelton function table #_EPSFT_# */
/* eTask */
const struct tag_sTask_VMT tTask_eTask_MT_ = {
    tTask_eTask_activate_skel,
    tTask_eTask_suspend_skel,
    tTask_eTask_resume_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */

/* call port array #_CPA_# */

/* array of attr/var #_AVAI_# */
/* cell INIB #_INIB_# */
tTask_INIB tTask_INIB_tab[] = {
    /* cell: tTask_CB_tab[0]:  Task id=1 */
    {
        /* entry port #_EP_# */ 
        /* attribute(RO) */ 
        TA_ACT,                                  /* attribute */
        11,                                      /* priority */
        4096,                                    /* stackSize */
        "tTask_rTEMP_Task",                      /* name */
    },
};

/* cell CB #_CB_# */
struct tag_tTask_CB tTask_CB_tab[1];
/* entry port descriptor #_EPD_# */
extern const struct tag_tTask_eTask_DES rTEMP_Task_eTask_des;
const struct tag_tTask_eTask_DES rTEMP_Task_eTask_des = {
    &tTask_eTask_MT_,
    &tTask_CB_tab[0],      /* CB 3 */
};
/* CB initialize code #_CIC_# */
void
tTask_CB_initialize()
{
    tTask_CB	*p_cb;
    int		i;
    FOREACH_CELL(i,p_cb)
        SET_CB_INIB_POINTER(i,p_cb)
        INITIALIZE_CB(p_cb)
    END_FOREACH_CELL
}
