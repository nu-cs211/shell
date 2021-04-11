#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char const*
argv0;

static void
ubgrepv(char const* line, FILE* input, FILE* output);

static int
xgetc(FILE* input);

static void
xputc(char c, FILE* output);

static void
xfwrite(char const* buf, size_t count, FILE* output);

int
main(int argc, char const* argv[])
{
    argv0 = argv[0];

    if (argc != 2) {
        fprintf(stderr, "%s: too many arguments\n", argv0);
        fprintf(stderr, "Usage: %s LINE\n", argv0);
        return 1;
    }

    ubgrepv(argv[1], stdin, stdout);
}

static void
ubgrepv(char const* line, FILE* input, FILE* output)
{
    int c;
    size_t count;

    setvbuf(input, (char*)0, _IONBF, 0);
    setvbuf(output, (char*)0, _IONBF, 0);

line_start:
    count = 0;

    while ((c = xgetc(input)) != EOF) {
        if (line[count] == 0) {
            if (c == '\n') {
                count = 0;
                goto line_start;
            }

            break;
        }

        if (line[count] != c) {
            break;
        }

        ++count;
    }

    xfwrite(line, count, output);

    if (c == EOF) {
        return;
    }

    do {
        xputc(c, output);

        if (c == '\n') {
            goto line_start;
        }
    } while ((c = xgetc(input)) != EOF);
}

static int
xgetc(FILE* input)
{
    int c = getc(input);

    if (c == EOF && ferror(input)) {
        perror(argv0);
        exit(2);
    }

    return c;
}

static void
xputc(char c, FILE* output)
{
    int res = putc(c, output);

    if (res == EOF && ferror(output)) {
        perror(argv0);
        exit(3);
    }
}

static void
xfwrite(char const* buf, size_t count, FILE* output) {
    size_t res = fwrite(buf, 1, count, output);

    if (res < count && ferror(output)) {
        perror(argv0);
        exit(3);
    }
}

