#include <string.h>
#include "des.h"

const unsigned char S_box[8][4][16] = {
    {{14,  4, 13,  1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9,  0,  7},
     { 0, 15,  7,  4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5,  3,  8},
     { 4,  1, 14,  8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10,  5,  0},
     {15, 12,  8,  2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0,  6, 13}
    },
    {{15,  1,  8, 14,  6, 11,  3,  4,  9,  7,  2, 13, 12,  0,  5, 10},
     { 3, 13,  4,  7, 15,  2,  8, 14, 12,  0,  1, 10,  6,  9, 11,  5},
     { 0, 14,  7, 11, 10,  4, 13,  1,  5,  8, 12,  6,  9,  3,  2, 15},
     {13,  8, 10,  1,  3, 15,  4,  2, 11,  6,  7, 12,  0,  5, 14,  9}
    },
    {{10,  0,  9, 14,  6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8},
     {13,  7,  0,  9,  3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1},
     {13,  6,  4,  9,  8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7},
     { 1, 10, 13,  0,  6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12}
    },
    {{ 7, 13, 14,  3,  0,  6,  9, 10,  1,  2,  8,  5, 11, 12,  4, 15},
     {13,  8, 11,  5,  6, 15,  0,  3,  4,  7,  2, 12,  1, 10, 14,  9},
     {10,  6,  9,  0, 12, 11,  7, 13, 15,  1,  3, 14,  5,  2,  8,  4},
     { 3, 15,  0,  6, 10,  1, 13,  8,  9,  4,  5, 11, 12,  7,  2, 14}
    },
    {{ 2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13,  0, 14,  9},
     {14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3,  9,  8,  6},
     { 4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6,  3,  0, 14},
     {11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10,  4,  5,  3}
    },
    {{12,  1, 10, 15,  9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11},
     {10, 15,  4,  2,  7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8},
     { 9, 14, 15,  5,  2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6},
     { 4,  3,  2, 12,  9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13}
    },
    {{ 4, 11,  2, 14, 15,  0,  8, 13,  3, 12,  9,  7,  5, 10,  6,  1},
     {13,  0, 11,  7,  4,  9,  1, 10, 14,  3,  5, 12,  2, 15,  8,  6},
     { 1,  4, 11, 13, 12,  3,  7, 14, 10, 15,  6,  8,  0,  5,  9,  2},
     { 6, 11, 13,  8,  1,  4, 10,  7,  9,  5,  0, 15, 14,  2,  3, 12}
    },
    {{13,  2,  8,  4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0, 12,  7},
     { 1, 15, 13,  8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2},
     { 7, 11,  4,  1,  9, 12, 14,  2,  0,  6, 10, 13, 15,  3,  5,  8},
     { 2,  1, 14,  7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6, 11}
    }
  };





static void conv_8to64(const unsigned char *src, unsigned char *dst)
{
  int i, j;
  unsigned char *ptr = dst;
  for (i = 0; i < 8; i++)
	 for (j = 0; j < 8; j++)
		*ptr++ = (src[i] >> (7 - j)) & 0x01;
}

static void IP(const unsigned char *src, unsigned char *dst)
{
  int i;
  const unsigned char IP_table[] = {
	 57, 49, 41, 33, 25, 17,  9,  1,
	 59, 51, 43, 35, 27, 19, 11,  3,
	 61, 53, 45, 37, 29, 21, 13,  5,
	 63, 55, 47, 39, 31, 23, 15,  7,
	 56, 48, 40, 32, 24, 16,  8,  0,
	 58, 50, 42, 34, 26, 18, 10,  2,
	 60, 52, 44, 36, 28, 20, 12,  4,
	 62, 54, 46, 38, 30, 22, 14,  6
  };
  for (i = 0; i < 64; i++)
	 dst[i] = src[IP_table[i]];
}

static void PC_1(const unsigned char *src, unsigned char *dst)
{
  int i;
  const unsigned char PC_table[] = {
    56, 48, 40, 32, 24, 16,  8,
     0, 57, 49, 41, 33, 25, 17,
     9,  1, 58, 50, 42, 34, 26,
	 18, 10,  2, 59, 51, 43, 35,
	 62, 54, 46, 38, 30, 22, 14,
	  6, 61, 53, 45, 37, 29, 21,
	 13,  5, 60, 52, 44, 36, 28,
	 20, 12,  4, 27, 19, 11,  3
  };
  for (i = 0; i < 56; i++)
	 dst[i] = src[PC_table[i]];
}

static void LS(unsigned char *src,unsigned char *dst, unsigned char num)
{
  unsigned char i; 
  
  for(i = 0; i + num < 28; i++)  
	dst[i] = src[i + num];
  for(;i< 28;i ++)
	dst[i] = src[i + num - 28];	
    
}

static void PC_2(unsigned char *src, unsigned char *dst)
{
  int i;
  const unsigned char PC2_table[] = {
	 13, 16, 10, 23,  0,  4,
	  2, 27, 14,  5, 20,  9,
	 22, 18, 11,  3, 25,  7,
	 15,  6, 26, 19, 12,  1,
	 40, 51, 30, 36, 46, 54,
	 29, 39, 50, 44, 32, 47,
    	 43, 48, 38, 55, 33, 52,
         45, 41, 49, 35, 28, 31
  };
  for (i = 0; i < 48; i++)
    dst[i] = src[PC2_table[i]];
}

static void get_key(unsigned char *src, unsigned char *dst,unsigned char index)
{
  unsigned char buf[56];
  const unsigned char LS_table[] = {
	 1, 2, 4, 6, 8,10,12,14,
	15,17,19,21,23,25,27,28
	};
     
    /* ѭ������ */
    LS(src,buf,LS_table[index]);
    LS(src+28,buf + 28,LS_table[index]);
    /* ����ѡ��2 */
    PC_2(buf, dst);
  
}

static void expand(unsigned char *src, unsigned char *dst)
{
  int i;
  const unsigned char E_table[] = {
    31,  0,  1,  2,  3,  4,
     3,  4,  5,  6,  7,  8,
     7,  8,  9, 10, 11, 12,
    11, 12, 13, 14, 15, 16,
    15, 16, 17, 18, 19, 20,
    19, 20, 21, 22, 23, 24,
    23, 24, 25, 26, 27, 28,
    27, 28, 29, 30, 31,  0
  };
  for (i = 0; i < 48; i++)
    dst[i] = src[E_table[i]];
}

static void do_xor(unsigned char *src1, unsigned char *src2, int num)
{
  int i;
  for (i = 0; i < num; i++)
	 src1[i] ^= src2[i];
}

static void compress(unsigned char *data)
{
  int i, j, k;
  unsigned char buf[48], ch;
  
  memcpy(buf, data, 48);
  for (i = 0; i < 8; i++) {
	 j = (buf[6*i] << 1) | buf[6*i+5];
	 k = (buf[6*i+1] << 3) | (buf[6*i+2] << 2) | (buf[6*i+3] << 1) | buf[6*i+4];
	 ch = S_box[i][j][k];
	 data[4*i] = (ch >> 3) & 0x01;
    data[4*i+1] = (ch >> 2) & 0x01;
    data[4*i+2] = (ch >> 1) & 0x01;
    data[4*i+3] = ch & 0x01;
  }
}

static void P_sort(unsigned char *data)
{
  unsigned char buf[32];
  int i;
  const unsigned char P_table[] = {
    15,  6, 19, 20,
    28, 11, 27, 16,
     0, 14, 22, 25,
     4, 17, 30,  9,
     1,  7, 23, 13,
    31, 26,  2,  8,
    18, 12, 29,  5,
    21, 10,  3, 24
  };

  memcpy(buf, data, 32);
  for (i = 0; i < 32; i++)
    data[i] = buf[P_table[i]];
}

static void IP_1(unsigned char *src, unsigned char *dst)
{
  int i;
  const unsigned char RIP_table[] = {
    39,  7, 47, 15, 55, 23, 63, 31,
    38,  6, 46, 14, 54, 22, 62, 30,
    37,  5, 45, 13, 53, 21, 61, 29,
    36,  4, 44, 12, 52, 20, 60, 28,
    35,  3, 43, 11, 51, 19, 59, 27,
    34,  2, 42, 10, 50, 18, 58, 26,
    33,  1, 41,  9, 49, 17, 57, 25,
    32,  0, 40,  8, 48, 16, 56, 24
  };
  for (i = 0; i < 64; i++)
    dst[i] = src[RIP_table[i]];
}

static void conv_64to8(unsigned char *src, unsigned char *dst)
{
  int i, j;

  memset(dst, 0, 8);
  for (i = 0; i < 8; i++) {
    for (j = 0; j < 8; j++) {
		dst[i] |= src[8*i+j] << (7-j);
    }
  }
}

//************************************************************************
// �������� Syd_SoftDes
// ����  �� ��׼Syd_SoftDes�㷨
// ����  �� src: ԭ�룬 dst: Ŀ����, key: ���ܵ���Կ
//          flag:  'D'��'d': ����, 'E' �� 'e': ����
// ʱ�䣺   1998.3.24
//------------------------------------------------------------------------
static void Syd_SoftDes(const unsigned char *src, unsigned char *dst, const 
unsigned char *key, unsigned char flag)
{
  unsigned char buf[64], buf1[64],key1[56];
  unsigned char subkey[48];
  int i;
  /* �õ�16����Կ */
//  get_key(key, kbuf);
  
  conv_8to64(key, buf);  
  /*64bit Key  ��ѡ��λPC-1 ��56bit Key1*/
  PC_1(buf, key1);

  conv_8to64(src, buf);
  /* ��һ��: ��ʼ����IP(Initial Permutation), Ŀ���ǽ����ĵ�˳����� */
  IP(buf, buf1);
  /* �ڶ���: �˻��任, ΪSyd_SoftDes�㷨�ĺ��� */
  for (i = 0; i < 16; i++) {
    /* ��չ�û�, ��32λ��չΪ48λ */
    expand(buf1+32, buf);
	 /* ������Կ������� */
    if (flag == 'e' || flag == 'E')
	{
	  get_key(key1,subkey,i);
      do_xor(buf, subkey, 48);
	}
    else
	{
	  get_key(key1,subkey,15-i);
      do_xor(buf, subkey, 48);
	}
    /* ѹ������, 48λ�任Ϊ32λ */
    compress(buf);
    /* P���� */
    P_sort(buf);
	 do_xor(buf, buf1, 32);
    memcpy(buf1, buf1+32, 32);
    memcpy(buf1+32, buf, 32);
  }
  /* ������: �������� */
  memcpy(buf, buf1+32, 32);
  memcpy(buf+32, buf1, 32);
  IP_1(buf, buf1);
  conv_64to8(buf1, dst);
}

int DES(unsigned char *dst, unsigned char *src, int len, const unsigned char *key)
{
	int nLen=0;
	int i;
	int j;
	int count=0;
	unsigned char srcTemp[8];
	unsigned char dstTemp[8];
	if(len%8==0)
	{
		nLen=len;
	}
	else
	{
		nLen=(len/8+1)*8;
	}
	count=nLen/8;

	for(i=0;i<count;i++)
	{
		if(i<count-1)
		{
			Syd_SoftDes(src+8*i,dst+8*i,key,'e');
		}
		else
		{
			for(j=0;j<8;j++)
			{
				if(8*i+j>=len)
				{
					srcTemp[j]=0x00;
				}
				else
				{
					srcTemp[j]=src[8*i+j];
				}
			}
			Syd_SoftDes(srcTemp,dstTemp,key,'e');
			memcpy(dst+8*i,dstTemp,8);
		}	
	}
    return nLen;
	//Syd_SoftDes(src,dst,key,'e');
}

void UNDES(unsigned char *dst, unsigned char *src, int len,const unsigned char *key)
{
	int nLen=len;
	int count=nLen/8;
	int i;
	//unsigned char srcTemp[8];
	//unsigned char dstTemp[8];
	for(i=0;i<count;i++)
	{
		Syd_SoftDes(src+8*i,dst+8*i,key,'d');
	}

	//Syd_SoftDes(src,dst,key,'d');
}

int TDES(unsigned char *dst, unsigned char *src,int len, const unsigned char *key)
{
	unsigned char temp[8];
	int i;
	int nLen=0;
	int count=0;
	unsigned char srcTemp[8];
	unsigned char dstTemp[8];
	int j;

	if(len%8==0)
	{
		nLen=len;
	}
	else
	{
		nLen=(len/8+1)*8;
	}
	count=nLen/8;
	
	for(i=0;i<count;i++)
	{
		if(i<count-1)
		{
			Syd_SoftDes(src+8*i,temp,key,'e');
			Syd_SoftDes(temp,temp,key+8,'d');
			Syd_SoftDes(temp,dst+8*i,key,'e');
		}
		else
		{
			for(j=0;j<8;j++)
			{
				if(8*i+j>=len)
				{
					srcTemp[j]=0x00;
				}
				else
				{
					srcTemp[j]=src[8*i+j];
				}
			}
			memset(dstTemp,0,8);
			Syd_SoftDes(srcTemp,temp,key,'e');
			Syd_SoftDes(temp,temp,key+8,'d');
			Syd_SoftDes(temp,dstTemp,key,'e');
			memcpy(dst+8*i,dstTemp,8);
		}	
	}

    return nLen;
	//unsigned char temp[8];
	//Syd_SoftDes(src,temp,key,'e');
	//Syd_SoftDes(temp,temp,key+8,'d');
	//Syd_SoftDes(temp,dst,key,'e');
}

void UNTDES(unsigned char *dst, unsigned char *src,int len,  const unsigned char *key)
{
	unsigned char temp[8];

	int nLen=len;
	int count=nLen/8;
	int i;
	//unsigned char srcTemp[8];
	//unsigned char dstTemp[8];
	for(i=0;i<count;i++)
	{
		Syd_SoftDes(src+8*i,temp,key,'d');
		Syd_SoftDes(temp,temp,key+8,'e');
		Syd_SoftDes(temp,dst+8*i,key,'d');
	}

	//unsigned char temp[8];
	//Syd_SoftDes(src,temp,key,'d');
	//Syd_SoftDes(temp,temp,key+8,'e');
	//Syd_SoftDes(temp,dst,key,'d');
}
