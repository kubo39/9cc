module cc.lexer;

import core.stdc.ctype;
import core.stdc.stdio;
import core.stdc.stdlib;

import cc.tokens;

// FIXME(kubo39)
__gshared Token[100] tokens;

void tokenizer(const(char)* p)
{
    int i = 0;
    while (*p)
    {
        if (isspace(*p))
        {
            p++;
            continue;
        }

        if (*p == '+')
        {
            tokens[i].value = TOK.ADD;
            tokens[i].ptr = p;
            i++;
            p++;
            continue;
        }
        else if (*p == '-')
        {
            tokens[i].value = TOK.MIN;
            tokens[i].ptr = p;
            i++;
            p++;
            continue;
        }
        else if (*p == '*')
        {
            tokens[i].value = TOK.MUL;
            tokens[i].ptr = p;
            i++;
            p++;
            continue;
        }
        else if (*p == '/')
        {
            tokens[i].value = TOK.DIV;
            tokens[i].ptr = p;
            i++;
            p++;
            continue;
        }

        if (isdigit(*p))
        {
            tokens[i].value = TOK.NUM;
            tokens[i].ptr = p;
            tokens[i].intvalue = strtol(p, &p, 10);
            i++;
            continue;
        }

        fprintf(stderr, "トークナイズできません: %s\n", *p);
        exit(EXIT_FAILURE);
    }
    tokens[i].value = TOK.EOF;
    tokens[i].ptr = p;
}
