#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include "core.h"

int main() {
    int fd_req, fd_res;
    char request[MAX_BUF], buffer[MAX_BUF];
    ssize_t n;

    printf("Nume fisier: ");
    if (fgets(request, MAX_BUF, stdin) == NULL) return 1;

    fd_req = open(FIFO_REQ, O_WRONLY);
    write(fd_req, request, strlen(request) + 1);
    close(fd_req);

    fd_res = open(FIFO_RES, O_RDONLY);
    while ((n = read(fd_res, buffer, MAX_BUF)) > 0) {
        write(STDOUT_FILENO, buffer, n);
    }
    close(fd_res);

    return 0;
}
