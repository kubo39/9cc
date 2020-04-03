module cc.parse;

import cc.errors;
import cc.identifier;
import cc.lexer;
import cc.tokens;
import cc.visitor;

ASTNode[] parse(const(char)* input)
{
    tokenizer(input);
    auto parser = new Parser();
    return parser.parse();
}

abstract class ASTNode
{
    abstract void accept(Visitor v);
}

abstract class Expression : ASTNode
{
    TOK op;

    this(TOK op) @nogc nothrow pure
    {
        this.op = op;
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

final class IntegerExp : Expression
{
    long value;

    this(long intvalue) @nogc nothrow pure
    {
        super(TOK.NUM);
        this.value = intvalue;
    }

    override void accept(Visitor v)
    {
        v.visit(this);
    }
}

final class IdentifierExp : Expression
{
    Identifier id;

    this(Identifier id) @nogc nothrow pure
    {
        super(TOK.IDENT);
        this.id = id;
    }

    override void accept(Visitor v)
    {
        v.visit(this);
    }
}

class UnaryExp : Expression
{
    Expression e1;

    this(Expression e1) @nogc nothrow pure
    {
        super(TOK.UNARY); // FIXME
        this.e1 = e1;
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

class BinExp : Expression
{
    Expression e1;
    Expression e2;

    this(TOK op, Expression e1, Expression e2) @nogc nothrow pure
    {
        super(op);
        this.e1 = e1;
        this.e2 = e2;
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

final class MulExp : BinExp
{
    this(Expression e1, Expression e2) @nogc nothrow pure
    {
        super(TOK.MUL, e1, e2);
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

final class DivExp : BinExp
{
    this(Expression e1, Expression e2) @nogc nothrow pure
    {
        super(TOK.DIV, e1, e2);
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

final class AddExp : BinExp
{
    this(Expression e1, Expression e2) @nogc nothrow pure
    {
        super(TOK.ADD, e1, e2);
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

final class MinExp : BinExp
{
    this(Expression e1, Expression e2) @nogc nothrow pure
    {
        super(TOK.MIN, e1, e2);
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

final class AssignExp : BinExp
{
    this(Expression e1, Expression e2) @nogc nothrow pure
    {
        super(TOK.ASSIGN, e1, e2);
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

abstract class Statement : ASTNode
{
    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}

class ExpStatement : Statement
{
    Expression exp;

    this(Expression exp) @nogc nothrow pure
    {
        this.exp = exp;
    }

    override void accept(Visitor v) @nogc
    {
        v.visit(this);
    }
}


class Parser
{
    const(char)* p;
    Token* token;
    size_t pos;

    this() @nogc nothrow
    {
        this.token = tokens;
    }

    void nextToken() @nogc nothrow
    {
        this.token = this.token.next;
    }

    Expression parseUnaryExp()
    out(e)
    {
        assert(e);
    }
    do
    {
        Expression e;
        switch (token.value)
        {
        case TOK.LEFTPARENT:
            nextToken();
            e = parseAddExp();
            if (token.value != TOK.RIGHTPARENT)
            {
                error("開き括弧に対応する閉じ括弧がありません");
                fatal();
            }
            nextToken();
            break;
        case TOK.IDENT:
            e = new IdentifierExp(token.ident);
            nextToken();
            break;
        case  TOK.NUM:
            auto e1 = new IntegerExp(token.intvalue);
            e = new UnaryExp(e1);
            nextToken();
            break;
        default:
            error("開き括弧でも閉じ括弧でもないトークンです");
            fatal();
            assert(false);
        }
        return e;
    }

    Expression parseMulExp()
    {
        auto e = parseUnaryExp();
        while (true)
        {
            switch (token.value)
            {
            case TOK.MUL:
                nextToken();
                auto e2 = parseUnaryExp();
                e = new MulExp(e, e2);
                continue;
            case TOK.DIV:
                nextToken();
                auto e2 = parseUnaryExp();
                e = new DivExp(e, e2);
                continue;
            default:
                break;
            }
            break;
        }
        return e;
    }

    Expression parseAddExp() 
    {
        auto e = parseMulExp();
        while (true)
        {
            switch (token.value)
            {
            case TOK.ADD:
                nextToken();
                auto e2 = parseMulExp();
                e = new AddExp(e, e2);
                continue;
            case TOK.MIN:
                nextToken();
                auto e2 = parseMulExp();
                e = new MinExp(e, e2);
                continue;
            default:
                break;
            }
            break;
        }
        assert(e);
        return e;
    }

    Expression parseAssignExp()
    out(e)
    {
        assert(e);
    }
    do
    {
        Expression e1, e2;
        e1 = parseAddExp();
        switch (token.value)
        {
        case TOK.ASSIGN:
            nextToken();
            e2 = parseAssignExp();
            break;
        default:
            break;
        }
        auto e = new AssignExp(e1, e2);
        return e;
    }

    Statement parseExpStatement()
    {
        Statement s;
        auto e = parseAssignExp();
        switch (token.value)
        {
        case TOK.SEMICOLON:
            nextToken();
            goto default;
        default:
            s = new ExpStatement(e);
            break;
        }
        return s;
    }

    Statement[] parseStatement()
    {
        Statement[] statements;
        while (true)
        {
            switch (token.value)
            {
            case TOK.SEMICOLON:
                nextToken();
                break;
            case TOK.LEFTPARENT:
            case TOK.RIGHTPARENT:
            case TOK.IDENT:
            case TOK.NUM:
            case TOK.UNARY:
            case TOK.ASSIGN:
                statements ~= parseExpStatement();
                break;
            case TOK.EOF:
                return statements;
            default:
                assert(false);
            }
        }
        assert(false);
    }

    ASTNode[] parse()
    {
        return cast(ASTNode[]) parseStatement();
    }
}
