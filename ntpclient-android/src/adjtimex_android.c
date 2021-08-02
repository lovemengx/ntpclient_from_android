#define _GNU_SOURCE         /* See feature_test_macros(7) */
#include <unistd.h>
#include <sys/syscall.h>   /* For SYS_xxx definitions */

#include <linux/timex.h>

/* if it's not already defined, be sure to check this:
   syscall numbering is different on every architecture */
//#define SYS_adjtimex 124

int adjtimex(struct timex *txc) {
    return syscall(SYS_adjtimex, (void *)txc);
}
