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
    LESS_OR_EQUAL,
    LESS_THAN,
    GREATER_OR_EQUAL,
    GREATER_THAN,
    EQUAL,
    NOTEQUAL,
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
