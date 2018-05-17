#include <stdio.h>

void to_binary(int vec[16],int nr)
{
    for(int i=0;i<16;i++)
    {
        vec[i]=nr%2;
        nr/=2;
    }
    for(int i=0;i<8;i++)
    {
        int aux=vec[i];
        vec[i]=vec[15-i];
        vec[15-i]=aux;
    }
}

int main()
{
    FILE *F=fopen("Memorie_rom.txt","w");
    char line[17];
    int vec[16];
    for(int i=0;i<256;i++)
    {   to_binary(vec,i);
        for(int j=0;j<16;j++)
            fprintf(F,"%d",vec[j]);
        fprintf(F,"\n");
    }
    fclose(F);
}
