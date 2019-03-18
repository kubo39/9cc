module cc.tokens;

enum TOK
{
    NUM = 256,  // 整数トークン
    LEFTPARENT,
    RIGHTPARENT,
    ADD,
    MIN,
    MUL,
    DIV,
    UNARY, // FIXME
    EOF,
}

struct Token
{
    Token* next;
    const(char)* ptr;
    TOK value;
    long intvalue; // signed
}
