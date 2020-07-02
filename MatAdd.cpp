#include <cstdio>
#include <cstdlib>
#include <iostream>
#define SIZE 1024

void vectoradd(int *a, int *b, int *c,int n)
{
    int i;
    for(i=0;i<=n;i++)
    {
        c[i]=a[i]+b[i];
    }
}

int main()
{
    int *a,*b,*c;
    a=(int *)malloc(SIZE * sizeof(int));
    b=(int *)malloc(SIZE * sizeof(int));
    c=(int *)malloc(SIZE * sizeof(int));


    for(int i=0;i<=SIZE;i++)
    {
        a[i]=i;
        b[i]=i;
        c[i]=0;
    }

    vectoradd(a,b,c,SIZE);

    for(int i=0;i<=5;i++)
    {
        std::cout<<c[i]<<std::endl;
    }

    return 0;
}


