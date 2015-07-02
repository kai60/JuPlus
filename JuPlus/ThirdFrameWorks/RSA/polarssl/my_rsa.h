
#ifndef  MY_RSA_H
#define  MY_RSA_H

/**
	1024Î»µÄRSA¼ÓÃÜ
*/
int RSAencrypt(const unsigned char* in_data,int in_len,
			int in_radix,char* in_N,
			unsigned char* ou_data,int* out_len);
int  RSASHA1verify(const unsigned char* in_data,int in_len,
                   int in_radix,char* in_N,
                   const unsigned char* sig_data);

#endif