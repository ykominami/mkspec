/*
 * This file was automatically generated by tecsgen.
 * This file is not intended to be edited.
 */
#include "tTalker_tecsgen.h"
#include "tTalker_factory.h"

/* entry port descriptor type #_EDT_# */
/* eHello */
struct tag_tTalker_eHello_DES {
    const struct tag_sHello_VMT *vmt;
    tTalker_IDX  idx;
};

/* entry port skelton function #_EPSF_# */
/* eHello */
void           tTalker_eHello_hello_skel( const struct tag_sHello_VDES *epd)
{
    struct tag_tTalker_eHello_DES *lepd
        = (struct tag_tTalker_eHello_DES *)epd;
    tTalker_eHello_hello( lepd->idx );
}

/* entry port skelton function table #_EPSFT_# */
/* eHello */
const struct tag_sHello_VMT tTalker_eHello_MT_ = {
    tTalker_eHello_hello_skel,
};

/* entry port descriptor referenced by call port (differ from actual definition) #_CPEPD_# */










/* call port array #_CPA_# */










/* array of attr/var #_AVAI_# */
/* cell CB #_CB_# */
struct tag_tTalker_CB tTalker_CB_tab[] = {
    /* cell: tTalker_CB_tab[0]:  Talker0 id=1 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "Talker0",                               /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[1]:  Talker1 id=2 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "Talker1",                               /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[2]:  Talker2 id=3 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "Talker2",                               /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[3]:  Talker3 id=4 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "Talker3",                               /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[4]:  Talker4 id=5 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "Talker4",                               /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[5]:  Talker0 id=6 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "rComposite_Talker0",                    /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[6]:  Talker1 id=7 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "rComposite_Talker1",                    /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[7]:  Talker2 id=8 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "rComposite_Talker2",                    /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[8]:  Talker3 id=9 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "rComposite_Talker3",                    /* name */
        "hello",                                 /* message */
    },
    /* cell: tTalker_CB_tab[9]:  Talker4 id=10 */
    {
        /* entry port #_EP_# */ 
        /* attribute */ 
        "rComposite_Talker4",                    /* name */
        "hello",                                 /* message */
    },
};

/* entry port descriptor #_EPD_# */
extern const struct tag_tTalker_eHello_DES Talker0_eHello_des;
const struct tag_tTalker_eHello_DES Talker0_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[0],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES Talker1_eHello_des;
const struct tag_tTalker_eHello_DES Talker1_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[1],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES Talker2_eHello_des;
const struct tag_tTalker_eHello_DES Talker2_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[2],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES Talker3_eHello_des;
const struct tag_tTalker_eHello_DES Talker3_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[3],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES Talker4_eHello_des;
const struct tag_tTalker_eHello_DES Talker4_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[4],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES rComposite_Talker0_eHello_des;
const struct tag_tTalker_eHello_DES rComposite_Talker0_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[5],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES rComposite_Talker1_eHello_des;
const struct tag_tTalker_eHello_DES rComposite_Talker1_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[6],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES rComposite_Talker2_eHello_des;
const struct tag_tTalker_eHello_DES rComposite_Talker2_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[7],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES rComposite_Talker3_eHello_des;
const struct tag_tTalker_eHello_DES rComposite_Talker3_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[8],      /* CB 3 */
};
extern const struct tag_tTalker_eHello_DES rComposite_Talker4_eHello_des;
const struct tag_tTalker_eHello_DES rComposite_Talker4_eHello_des = {
    &tTalker_eHello_MT_,
    &tTalker_CB_tab[9],      /* CB 3 */
};
