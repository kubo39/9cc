module cc.tokens;

import cc.identifier;

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
