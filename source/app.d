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

    // プロローグ
    // 変数26個分の領域を確保する
    printf("  push rbp\n");
    printf("  mov rbp, rsp\n");
    printf("  sub rsp, 208\n");

    foreach (node; nodes)
    {
        node.accept(new Visitor());

        // 式の評価結果としてスタックに一つの値が残っている
        // はずなので、スタックが溢れないようにpopしておく
        printf("  pop rax\n");
    }

    // エピローグ
    // 最後の式の結果が残っているのでそれが返り値になる
    printf("  mov rsp, rbp\n");
    printf("  pop rbp\n");
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
