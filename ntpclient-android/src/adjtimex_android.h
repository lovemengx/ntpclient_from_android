
#ifndef ADJTIMEX_ANDROID_H
#define ADJTIMEX_ANDROID_H

#include <linux/timex.h>
int adjtimex(struct timex *txc);

#endif