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
    const(char)* ptr;
    TOK value;
    long intvalue; // signed
}
