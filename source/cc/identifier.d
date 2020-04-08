module cc.identifier;

import core.stdc.string;

import cc.tokens;

// オフセット値を更新し続けるため
static int nextOffset = 8;


class Identifier
{
private:
    __gshared Identifier[const(char)[]] locals;

    const int value;
    const char[] name;
    const int offset;

    this(const(char)* name, size_t length, int value, int offset) nothrow pure
    {
        this.name = name[0 .. length];
        this.value = value;
        this.offset = offset;
    }

    this(const(char)[] name, int value, int offset) nothrow pure
    {
        this.name = name;
        this.value = value;
        this.offset = offset;
    }

    this(const(char)[] name, int offset) nothrow pure
    {
        this(name, TOK.IDENT, offset);
    }

    this(const(char)* name, int offset) nothrow pure
    {
        this(name[0 .. strlen(name)], TOK.IDENT, offset);
    }

public:
    static Identifier idPool(const(char)* s, uint len) nothrow
    {
        return idPool(s[0 .. len]);
    }

    static Identifier idPool(const(char)[] name) nothrow
    {
        auto p = name in locals;
        // すでに存在している場合
        if (p)
            return *p;

        // 新たに追加する場合
        auto identifier = new Identifier(name, nextOffset);
        nextOffset += 8;
        locals[name] = identifier;
        return identifier;
    }

    int getOffset() const @nogc nothrow pure
    {
        return this.offset;
    }
}
