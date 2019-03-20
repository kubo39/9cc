import core.stdc.stdio;
import core.stdc.stdlib;

import cc.errors;
import cc.parse;
import cc.tokens;
import cc.visitor;

void gen(ASTNode[] nodes)
{
    printf(".intel_syntax noprefix\n");
    printf(".global main\n");
    printf("main:\n");

    foreach (node; nodes)
        node.accept(new Visitor());

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

    auto nodes = parse(argv[1]);
    gen(nodes);

    return EXIT_SUCCESS;
}
