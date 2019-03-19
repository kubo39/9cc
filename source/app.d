import core.stdc.stdio;
import core.stdc.stdlib;

import cc.errors;
import cc.parse;
import cc.tokens;
import cc.visitor;

void gen(ASTNode node)
{
    printf(".intel_syntax noprefix\n");
    printf(".global main\n");
    printf("main:\n");

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

    auto node = parse(argv[1]);
    gen(node);

    return EXIT_SUCCESS;
}
