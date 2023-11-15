#include <stdio.h>
#include <stdint.h>
#include <string.h>

char buff[100];

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

    for (int i = 1; i <= argc; i++) {
        get_file_name(argv[i]);
        printf("%s\n", buff);
        FILE *file = fopen(buff, "rb+");
        if (file == NULL) {
            perror("Error opening file");
            return 1;
        }

        fseek(file, 0, SEEK_END);
        long file_size = ftell(file);
        fclose(file);
        printf("size of %s is %ld\n", buff, file_size);

        uint64_t size_to_write = (uint64_t)file_size;
        get_tmp_name(argv[i]);
        char *tmpname = buff;
        file = fopen(tmpname, "wb");
        fwrite(&size_to_write, sizeof(uint64_t), 1, file);
    }

    printf("Header added successfully!\n");

    return 0;
}
