#include <stdio.h>

int main()
{
    char x = 'a';
    for(int i = 1; i<=26;i++){
        printf("%c ",x++);
        if(i == 13)
            printf("\n");
    }
    return 0;
}
