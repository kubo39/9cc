import core.stdc.stdio;
import core.stdc.stdlib;

import cc.errors;
//import cc.memory;
import cc.parse;
import cc.tokens;
import cc.visitor;

void gen(Expression exp)
{
    printf(".intel_syntax noprefix\n");
    printf(".global main\n");
    printf("main:\n");

    exp.accept(new Visitor());

    printf("  pop rax\n");
    printf("  ret\n");
}

extern (C) int main(size_t argc, const(char)** argv)
{
    if (argc != 2)
    {
        fprintf(stderr, "引数の個数が正しくありません\n");
        fatal();
    }

    auto exp = parse(argv[1]);
    gen(exp);

    return EXIT_SUCCESS;
}
