#ifndef _STRING_TO_FLOAT_WRAPPER_H
#define _STRING_TO_FLOAT_WRAPPER_H
 
#define fts_syscall(str, len) syscall(440, str, len);
extern float getFloat(char* str, int len);
 
#endif
