#include <stdio.h>
#include <stdlib.h>

int main()
{
    FILE* f;
    
    f=popen("gzip >text.gz","w");
    if(f==0){
        fprintf(stderr,"Eroare popen()\n");
        exit(1);
    }
    fprintf(f,"Un text ce va fi comprimat\n");
    fprintf(f,"folosind utilitarul gzip.\n\n");
    pclose(f);
    return 0;
}
