#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

void term_handler(int);

int main() {
    signal(SIGTERM, term_handler);
    signal(SIGINT,  term_handler);

    printf("Haaaiiii! I'm currently going in an infinite loop, until you're going to send a SIGTERM, SIGINT or SIGKILL signal.\n");
    fflush(stdout);

    while(1)
        sleep(1);
}

void term_handler(int _) {
    const char msg[] = "Bye :3\n";
    write(STDOUT_FILENO, msg, sizeof(msg) - 1);
    _exit(0);
}
