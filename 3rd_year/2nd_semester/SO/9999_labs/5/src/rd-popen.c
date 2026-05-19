#include <stdio.h>
#include <stdlib.h>

int main()
{
    FILE* f;
    char buf[200];
    int i;
    
    f=popen("ls -l","r");
    if(f==0){
        fprintf(stderr,"Eroare popen()\n");
        exit(1);
    }
    while(!feof(f)){
        i=fread(buf,1,200,f);
        fwrite(buf,1,i,stdout);
    }
    pclose(f);
    return 0;
}
