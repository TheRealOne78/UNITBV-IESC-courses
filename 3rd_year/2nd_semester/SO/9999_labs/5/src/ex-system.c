#include <stdio.h>
#include <stdlib.h>

int main()
{
    char dir[100], cmd[150];
    int i;
    
    printf("Directorul:");
    scanf("%99s",dir);
    snprintf(cmd,149,"ls -a %s",dir);
    i=system(cmd);
    if(i!=0){
        fprintf(stderr,"Cod de retur: %d\n",i);
        exit(1);
    }
    return 0;
}
