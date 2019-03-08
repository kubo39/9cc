import core.stdc.stdio;
import core.stdc.stdlib;

import cc.errors;
import cc.lexer;
import cc.tokens;

extern (C) int main(size_t argc, const(char)** argv)
{
    if (argc != 2)
    {
        fprintf(stderr, "引数の個数が正しくありません\n");
        fatal();
    }

    tokenizer(argv[1]);

    printf(".intel_syntax noprefix\n");
    printf(".global main\n");
    printf("main:\n");

    if (tokens[0].value != TOK.NUM)
    {
        error(tokens[0].ptr);
        fatal();
    }
    printf("  mov rax, %ld\n", tokens[0].intvalue);

    int i = 1;
    while (tokens[i].value != TOK.EOF)
    {
        if (*tokens[i].ptr == '+')
        {
            i++;
            if (tokens[i].value != TOK.NUM)
            {
                error(tokens[i].ptr);
                fatal();
            }
            printf("  add rax, %ld\n", tokens[i].intvalue);
            i++;
            continue;
        }
        if (*tokens[i].ptr == '-')
        {
            i++;
            if (tokens[i].value != TOK.NUM)
            {
                error(tokens[i].ptr);
                fatal();
            }
            printf("  sub rax, %ld\n", tokens[i].intvalue);
            i++;
            continue;
        }

        error(tokens[i].ptr);
        fatal();
    }

    printf("  ret\n");
    return EXIT_SUCCESS;
}
