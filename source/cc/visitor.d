module cc.visitor;

import core.stdc.stdio;

import cc.errors;
import cc.parse;
import cc.tokens;

class Visitor
{
    void visit(Expression e) @nogc nothrow
    {
        fatal();
    }

    void visit(IntegerExp e) @nogc nothrow
    {
        printf("  push %ld\n", e.value);
    }

    void visit(IdentifierExp e) @nogc nothrow
    {
        int offset = e.id.getOffset();
        printf("  mov rax, rbp\n");
        printf("  sub rax, %d\n", offset);
        printf("  push rax\n");
    }

    void visit(UnaryExp e) @nogc
    in
    {
        assert(e.e1);
    }
    do
    {
        if (e.e1.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.NUM)
        {
            (cast(IntegerExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e1).accept(this);
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
    }

    void visit(BinExp e) @nogc nothrow
    {
        fatal();
    }

    void visit(MulExp e) @nogc
    in
    {
        assert(e.e1);
        assert(e.e2);
    }
    do
    {
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
        else if (e.e1.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e1).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
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
        else if (e.e2.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e2).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
        }
        else assert (false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  imul rax, rdi\n");
        printf("  push rax\n");
    }

    void visit(DivExp e) @nogc
    in
    {
        assert(e.e1);
        assert(e.e2);
    }
    do
    {
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
        else if (e.e1.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e1).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
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
        else if (e.e2.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e2).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
        }
        else assert (false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  cqo\n");
        printf("  idiv rdi\n");
        printf("  push rax\n");
    }

    void visit(AddExp e) @nogc
    in
    {
        assert(e.e1);
        assert(e.e2);
    }
    do
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
        else if (e.e1.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e1).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
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
        else if (e.e2.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e2).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
        }
        else assert(false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  add rax, rdi\n");
        printf("  push rax\n");
    }

    void visit(MinExp e) @nogc
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
        else if (e.e1.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e1).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
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
        else if (e.e2.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e2).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
        }
        else assert(false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  sub rax, rdi\n");
        printf("  push rax\n");
    }

    void visit(CmpExp e) @nogc
    in
    {
        assert(e.e1);
        assert(e.e2);
    }
    do
    {
        if (e.e1.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e1).accept(this);
        }
        else if (e.e1.op == TOK.EQUAL || e.e1.op == TOK.NOTEQUAL
                || e.e1.op == TOK.LESS_THAN || e.e1.op == TOK.LESS_OR_EQUAL)
        {
            (cast(CmpExp) e.e1).accept(this);
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
        else if (e.e1.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e1).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
        }
        else assert(false);

        if (e.e2.op == TOK.UNARY)
        {
            (cast(UnaryExp) e.e2).accept(this);
        }
        else if (e.e2.op == TOK.EQUAL || e.e2.op == TOK.NOTEQUAL
                || e.e2.op == TOK.LESS_THAN || e.e2.op == TOK.LESS_OR_EQUAL)
        {
            (cast(CmpExp) e.e1).accept(this);
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
        else if (e.e2.op == TOK.IDENT)
        {
            (cast(IdentifierExp) e.e2).accept(this);
            printf("  pop rax\n");
            printf("  mov rax, [rax]\n");
            printf("  push rax\n");
        }
        else assert(false);

        printf("  pop rdi\n");
        printf("  pop rax\n");
        printf("  cmp rax, rdi\n");

        if (e.op == TOK.EQUAL)
        {
            printf("  sete al\n");
        }
        else if (e.op == TOK.NOTEQUAL)
        {
            printf("  setne al\n");
        }
        else if (e.op == TOK.LESS_THAN)
        {
            printf("  setl al\n");
        }
        else if (e.op == TOK.LESS_OR_EQUAL)
        {
            printf("  setle al\n");
        }
        else
        {
            assert(false);
        }

        printf("  movzb rax, al\n");
        printf("  push rax\n");
    }

    void visit(AssignExp e) @nogc
    in
    {
        assert(e);
        assert(e.e1);
    }
    do
    {
        if (e.e2 !is null)
        {
            assert(e.e1.op == TOK.IDENT);

            (cast(IdentifierExp) e.e1).accept(this);

            if (e.e2.op == TOK.UNARY)
            {
                (cast(UnaryExp) e.e2).accept(this);
            }
            else if (e.e2.op == TOK.EQUAL || e.e2.op == TOK.NOTEQUAL
                || e.e2.op == TOK.LESS_THAN || e.e2.op == TOK.LESS_OR_EQUAL)
            {
                (cast(CmpExp) e.e1).accept(this);
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
            else if (e.e2.op == TOK.IDENT)
            {
                (cast(IdentifierExp) e.e2).accept(this);
            }
            else if (e.e2.op == TOK.ASSIGN)
            {
                (cast(AssignExp) e.e2).accept(this);
            }
            else
            {
                printf("??: %d\n", e.e2.op);
                assert(false);
            }

            printf("  pop rdi\n");
            printf("  pop rax\n");
            printf("  mov [rax], rdi\n");
            printf("  push rdi\n");
        }
        else
        {
            assert(!e.e2);

            if (e.e1.op == TOK.UNARY)
            {
                (cast(UnaryExp) e.e1).accept(this);
            }
            else if (e.e1.op == TOK.EQUAL ||
                     e.e1.op == TOK.NOTEQUAL ||
                     e.e1.op == TOK.LESS_THAN ||
                     e.e1.op == TOK.LESS_OR_EQUAL)
            {
                (cast(CmpExp) e.e1).accept(this);
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
            else if (e.e1.op == TOK.IDENT)
            {
                (cast(IdentifierExp) e.e1).accept(this);
                printf("  pop rax\n");
                printf("  mov rax, [rax]\n");
                printf("  push rax\n");
            }
            else assert(false);

        }
    }

    void visit(Statement s) @nogc nothrow pure
    {
        assert(false);
    }

    void visit(ExpStatement s) @nogc
    in
    {
        assert(s.exp);
    }
    do
    {
        (cast(AssignExp) s.exp).accept(this);
    }

    void visit(IfStatement s) @nogc
    in
    {
        assert(s.condition);
        assert(s.ifbody);
    }
    do
    {
        (cast(AssignExp) s.condition).accept(this);
        printf("  pop rax\n");
        printf("  cmp rax, 0\n");

        if (s.elsebody !is null)
        {
            printf("  je .LelseXXX\n");
        }

        s.ifbody.accept(this);
        printf("  jmp .LendXXX\n");

        if (s.elsebody !is null)
        {
            printf(".LelseXXX:\n");
            s.elsebody.accept(this);
        }

        printf(".LendXXX:\n");
    }

    void visit(ReturnStatement s) @nogc
    {
        if (s.exp)
        {
            (cast(AssignExp) s.exp).accept(this);
            printf("  pop rax\n");
            printf("  mov rsp, rbp\n");
            printf("  pop rbp\n");
        }
        printf("  ret\n");
    }
}
