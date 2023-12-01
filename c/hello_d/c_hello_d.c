#include <stdio.h>

char *str = "%c from C app\n";

int printc(char c)
{
    return putchar(c);
}

int main()
{
    printc('D');
    printf(str, 'D');
    return 0;
}

