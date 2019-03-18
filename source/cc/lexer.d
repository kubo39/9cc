module cc.lexer;

import core.stdc.ctype;
import core.stdc.stdio;
import core.stdc.stdlib;

import cc.tokens;

__gshared Token* tokens;

// Returns a newly allocated Token.
Token* allocateToken()
{
    return new Token();
}

void tokenizer(const(char)* p)
{
    tokens = allocateToken();
    Token* token = tokens;

    while (*p)
    {
        if (isspace(*p))
        {
            p++;
            continue;
        }
        else if (*p == '+')
        {
            token.value = TOK.ADD;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if (*p == '-')
        {
            token.value = TOK.MIN;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if (*p == '*')
        {
            token.value = TOK.MUL;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if (*p == '/')
        {
            token.value = TOK.DIV;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if (*p == '(')
        {
            token.value = TOK.LEFTPARENT;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if (*p == ')')
        {
            token.value = TOK.RIGHTPARENT;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if (isdigit(*p))
        {
            token.value = TOK.NUM;
            token.ptr = p;
            token.intvalue = strtol(p, &p, 10);
            token = token.next = allocateToken();
            continue;
        }

        fprintf(stderr, "トークナイズできません: %s\n", *p);
        exit(EXIT_FAILURE);
    }
    token.value = TOK.EOF;
    token.ptr = p;
}
