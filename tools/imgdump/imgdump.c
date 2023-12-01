#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

char buff[100];
char rbuff[1024];

struct ImgHead {
    uint64_t app_num;
};

struct AppHead {
    uint64_t app_size;
};

void get_tmp_name(char *filename)
{
    strcpy(buff, filename);
    strcat(buff, "/tmp_head");
}

void get_file_name(char *filename)
{
    strcpy(buff, filename);
    int len = strlen(filename);
    while (--len != -1 && filename[len] != '/');
    strcat(buff, "/");
    strcat(buff, &filename[len + 1]);
    strcat(buff, ".bin");
}

int main(int argc, char *argv[]) {
    if (--argc == 0) return 0;

    struct ImgHead img_head = {
        .app_num = argc,
    };
    struct AppHead *app_heads = (struct AppHead *)malloc(sizeof(struct AppHead) * argc);

    for (int i = 1; i <= argc; i++) {
        // get_file_name(argv[i]);
        FILE *file = fopen(argv[i], "rb+");
        if (file == NULL) {
            perror("Error opening file");
            return 1;
        }

        fseek(file, 0, SEEK_END);
        long file_size = ftell(file);
        fclose(file);

        app_heads[i - 1].app_size = file_size;
        printf("size of %s is %ld\n", buff, file_size);
    }

    FILE *tmp_file = fopen("./tmp_file", "wb");
    if (tmp_file == NULL) {
        perror("Error opening file");
        return 1;
    }
    fwrite(&img_head, sizeof(struct ImgHead), 1, tmp_file);
    fwrite(app_heads, sizeof(struct AppHead), argc, tmp_file);

    for (int i = 1; i <= argc; i++) {
        // get_file_name(argv[i]);
        FILE *file = fopen(argv[i], "rb+");
        if (file == NULL) {
            perror("Error opening file");
            return 1;
        }

        unsigned long readn;
        do {
            readn = fread(rbuff, sizeof(char), 1024, file);
            printf("write %lu bytes of %s\n", readn, buff);
            fwrite(rbuff, sizeof(char), readn, tmp_file);
        } while (readn == 1024);
        fclose(file);
        printf("write %s to temp image file\n", buff);
    }

    fclose(tmp_file);

    free(app_heads);
    printf("Header added successfully!\n");

    return 0;
}
