module cc.tokens;

enum TOK
{
    NUM = 256,  // 整数トークン
    PLUS,
    MINUS,
    EOF,
}

struct Token
{
    const(char)* ptr;
    TOK value;
    long intvalue; // signed
}
