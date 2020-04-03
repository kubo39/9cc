module cc.errors;

import core.stdc.stdio;
import core.stdc.stdlib;

@nogc:
nothrow:

void error(const(char)* p)
{
    fprintf(stderr, "予期しないトークンです: %s", *p);
    fputc('\n', stderr);
    fflush(stderr);
}

void fatal()
{
    exit(EXIT_FAILURE);
}
