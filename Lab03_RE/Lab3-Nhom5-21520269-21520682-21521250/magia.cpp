
#include <iostream>

using namespace std;
#include<string.h>
int main()
{
  size_t v0; // ebx@2

  char v4[9]; // [sp+Ah] [bp-2Eh]@6
  char v5[10]; // [sp+13h] [bp-25h]@1
  char s[10]; // [sp+1Dh] [bp-1Bh]@1
  char v7[5]; // [sp+27h] [bp-11h]@1
  unsigned int i; // [sp+2Ch] [bp-Ch]@4

  v7[0] = 96;
  v7[1] = 69;
  v7[2] = 116;
  v7[3] = 45;
  v7[4] = 45;
  
  cout<<"Enter your username:";
  cin>> s;

  cout<<"Enter your password:";
  cin>> v5;
  printf("Your input username: %s and password: %s\n", s, v5);
  if ( strlen(s) == 9 && (v0 = strlen(s), v0 == strlen(v5)) )
  {
    for ( i = 0; (signed int)i <= 8; ++i )
    {
      if ( (signed int)i > 1 )
      {
        if ( (signed int)i > 3 )
          v4[i] = v7[i - 4];
        else
          v4[i] = s[i + 5];
      }
      else
      {
        v4[i] = s[i + 2];
      }
    }
    for(i=0;i<=8;++i)
    {
        cout<<v4[i];
    }
    
  }

    return 0;
}