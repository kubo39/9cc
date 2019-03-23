module cc.identifier;

import core.stdc.string;

import cc.tokens;

class Identifier
{
    const int value;
    const char[] name;

    this(const(char)* name, size_t length, int value) nothrow
    {
        this.name = name[0 .. length];
        this.value = value;
    }

    this(const(char)[] name, int value) nothrow
    {
        this.name = name;
        this.value = value;
    }

    this(const(char)* name) nothrow
    {
        this(name[0 .. strlen(name)], TOK.IDENT);
    }
}
