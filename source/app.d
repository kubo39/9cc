import core.stdc.stdio;
import core.stdc.stdlib;

extern (C) int main(size_t argc, const(char)** argv)
{
    if (argc != 2)
    {
        fprintf(stderr, "引数の個数が正しくありません\n");
        exit(EXIT_FAILURE);
    }

    printf(".intel_syntax noprefix\n");
    printf(".global main\n");
    printf("main:\n");
    printf("  mov rax, %d\n", atoi(argv[1]));
    printf("  ret\n");

    return EXIT_SUCCESS;
}
