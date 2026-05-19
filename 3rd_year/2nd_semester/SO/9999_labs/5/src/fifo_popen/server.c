#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "core.h"

int main() {
    int fd_req, fd_res;
    char cmd[MAX_BUF], request[MAX_BUF], buffer[MAX_BUF];
    FILE *fp;

    mkfifo(FIFO_REQ, 0666);
    mkfifo(FIFO_RES, 0666);

    printf("Server pornit...\n");

    while (1) {
        fd_req = open(FIFO_REQ, O_RDONLY);
        if (read(fd_req, request, MAX_BUF) <= 0) {
            close(fd_req);
            continue;
        }
        close(fd_req);

        request[strcspn(request, "\n")] = 0;
        printf("Cerere primită: %s\n", request);

        snprintf(cmd, sizeof(cmd), "cat %s 2>&1", request);
        fp = popen(cmd, "r");
        
        fd_res = open(FIFO_RES, O_WRONLY);
        while (fgets(buffer, MAX_BUF, fp) != NULL) {
            write(fd_res, buffer, strlen(buffer));
        }
        pclose(fp);
        close(fd_res);
    }

    return 0;
}
