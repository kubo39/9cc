module cc.tokens;

import cc.identifier;

@nogc:
@safe:
nothrow:
pure:

enum TOK
{
    NUM = 256,  // 整数トークン
    LEFTPARENT,
    RIGHTPARENT,
    SEMICOLON,
    IDENT,
    ADD,
    MIN,
    MUL,
    DIV,
    UNARY,
    ASSIGN,
    IF,
    ELSE,
    RETURN,
    EOF,
}

struct Token
{
    Token* next;
    const(char)* ptr;
    TOK value;
    long intvalue; // signed

    Identifier ident;
}
