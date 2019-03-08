import core.stdc.stdio;
import core.stdc.stdlib;

extern (C) int main(size_t argc, const(char)** argv)
{
    if (argc != 2)
    {
        fprintf(stderr, "引数の個数が正しくありません\n");
        exit(EXIT_FAILURE);
    }

    const(char)* p = argv[1];

    printf(".intel_syntax noprefix\n");
    printf(".global main\n");
    printf("main:\n");
    printf("  mov rax, %d\n", strtol(p, &p, 10));

    while (*p)
    {
        if (*p == '+')
        {
            p++;
            printf("  add rax, %ld\n", strtol(p, &p, 10));
            continue;
        }
        if (*p == '-')
        {
            p++;
            printf("  sub rax, %ld\n", strtol(p, &p, 10));
            continue;
        }

        fprintf(stderr, "予期しない文字です: '%c'\n", *p);
        exit(EXIT_FAILURE);
    }

    printf("  ret\n");
    return EXIT_SUCCESS;
}
