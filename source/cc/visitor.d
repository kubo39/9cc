module cc.visitor;

import core.stdc.stdio;

import cc.errors;
import cc.parse;
import cc.tokens;

class Visitor
{
    void visit(Expression e)
    {
        fatal();
    }

    void visit(IntegerExp e)
    {
        printf("  push %ld\n", e.value);
    }

    void visit(UnaryExp e)
    {
        assert(e.e1);

        if (e.e1.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e1).accept(this);
            return;
        }
        else if (e.e1.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e1).accept(this);
            return;
        }
        if (e.e1.op == TOK.ADD)
        {
            (cast(AddExp) e.e1).accept(this);
            return;
        }
        if (e.e1.op == TOK.MIN)
        {
            (cast(MinExp) e.e1).accept(this);
            return;
        }
        else if (e.e1.op == TOK.MUL)
        {
            (cast(MulExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.DIV)
        {
            (cast(DivExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e1).accept(this);
        }
        assert(false);
    }

    void visit(BinExp e)
    {
        import cc.errors;
        fatal();
    }

    void visit(MulExp e)
    {
        assert(e.e1);
        assert(e.e2);

        if (e.e1.op == TOK.UNARY)
        {
            (cast(UnaryExp)e.e1).accept(this);
        }
        else if (e.e1.op == TOK.ADD)
        {
            (cast(AddExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MIN)
        {
            (cast(MinExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MUL)
        {
            (cast(MulExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.DIV)
        {
            (cast(DivExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e1).accept(this);
        }
        else assert (false);

        if (e.e2.op == TOK.UNARY)
        {
            (cast(UnaryExp)e.e2).accept(this);
        }
        else if (e.e2.op == TOK.ADD)
        {
            (cast(AddExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MIN)
        {
            (cast(MinExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MUL)
        {
            (cast(MulExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.DIV)
        {
            (cast(DivExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e2).accept(this);
        }
        else assert (false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  mul rdi\n");
        printf("  push rax\n");
    }

    void visit(DivExp e)
    {
        assert(e.e1);
        assert(e.e2);

        if (e.e1.op == TOK.UNARY)
        {
            (cast(UnaryExp)e.e1).accept(this);
        }
        else if (e.e1.op == TOK.ADD)
        {
            (cast(AddExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MIN)
        {
            (cast(MinExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MUL)
        {
            (cast(MulExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.DIV)
        {
            (cast(DivExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e1).accept(this);
        }
        else assert (false);

        if (e.e2.op == TOK.UNARY)
        {
            (cast(UnaryExp)e.e2).accept(this);
        }
        else if (e.e2.op == TOK.ADD)
        {
            (cast(AddExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MIN)
        {
            (cast(MinExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MUL)
        {
            (cast(MulExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.DIV)
        {
            (cast(DivExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e2).accept(this);
        }
        else assert (false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  mov rdx, 0\n");
        printf("  div rdi\n");
        printf("  push rax\n");
    }

    void visit(AddExp e)
    {
        assert(e.e1);
        assert(e.e2);

        if (e.e1.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.ADD)
        {
            (cast(AddExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MIN)
        {
            (cast(MinExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MUL)
        {
            (cast(MulExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.DIV)
        {
            (cast(DivExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e1).accept(this);
        }
        else assert(false);

        if (e.e2.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.ADD)
        {
            (cast(AddExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MIN)
        {
            (cast(MinExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MUL)
        {
            (cast(MulExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.DIV)
        {
            (cast(DivExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e2).accept(this);
        }
        else assert(false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  add rax, rdi\n");
        printf("  push rax\n");
    }

    void visit(MinExp e)
    {
        if (e.e1.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.ADD)
        {
            (cast(AddExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MIN)
        {
            (cast(MinExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.MUL)
        {
            (cast(MulExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.DIV)
        {
            (cast(DivExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e1).accept(this);
        }
        else assert(false);

        if (e.e2.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.ADD)
        {
            (cast(AddExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MIN)
        {
            (cast(MinExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MUL)
        {
            (cast(MulExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.DIV)
        {
            (cast(DivExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e2).accept(this);
        }
        else assert(false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  sub rax, rdi\n");
        printf("  push rax\n");
    }

    void visit(AssignExp e)
    {
        assert(e.e1);

        // lvalue
        // if (e.e1.op)

        // rvalue
        if (e.e2.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.ADD)
        {
            (cast(AddExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MIN)
        {
            (cast(MinExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.MUL)
        {
            (cast(MulExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.DIV)
        {
            (cast(DivExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e2).accept(this);
        }
    }
}
