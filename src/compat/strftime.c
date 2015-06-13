/*
 * strftime.c
 *   Portable strftime implementation. Uses GNU's strftime().
 *
 */

#include "strftime.h"

#ifndef HAVE_STRFTIME
#  undef emacs
#  undef _LIBC
#  define strftime	strftime

#  include "gnu_strftime.c"
#endif	/* !HAVE_STRFTIME */
/* vim: set sts=2 sw=2 ts=8 et: */
