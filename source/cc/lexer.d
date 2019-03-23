module cc.lexer;

import core.stdc.ctype;
import core.stdc.stdio;
import core.stdc.stdlib;

import cc.identifier;
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
        else if (*p == '=')
        {
            token.value = TOK.ASSIGN;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if (*p == ';')
        {
            token.value = TOK.SEMICOLON;
            token.ptr = p;
            token = token.next = allocateToken();
            p++;
            continue;
        }
        else if ('a' <= *p && *p <= 'z')
        {
            token.value = TOK.IDENT;
            token.ptr = p;
            token.ident = new Identifier(p[0 .. 1], TOK.IDENT);
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
