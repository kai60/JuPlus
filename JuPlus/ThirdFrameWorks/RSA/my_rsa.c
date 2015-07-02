#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "polarssl/my_rsa.h"
#include "polarssl/rsa.h"
#include "polarssl/bignum.h"
#include "sha1.h"

#define KEY_LEN 192
#define RSA_E   "10001"

static int myrand( void *rng_state, unsigned char *output, size_t len )
{
	size_t i;
	if( rng_state != NULL )
		rng_state  = NULL;

	for( i = 0; i < len; ++i )
    {
        output[i] = rand();
        if (output[i]==0x00)
        {
            i--;
        }

    }
        
		    
	return( 0 );
}

int RSAencrypt(const unsigned char* in_data,int in_len,
               int in_radix,char* in_N,
               unsigned char* ou_data,int* out_len)
{
    srand(time(0));
	rsa_context rsa;
	rsa_init(&rsa,RSA_PKCS_V15,0);
	rsa.len = KEY_LEN;
	mpi_read_string( &rsa.N , in_radix, in_N );
	mpi_read_string( &rsa.E , 16, RSA_E  );
	if( rsa_check_pubkey(  &rsa ) != 0)
		return 0;
	if(rsa_pkcs1_encrypt( &rsa, &myrand, NULL, RSA_PUBLIC, in_len,
		in_data, ou_data ) != 0 )
	{
		return 0;
	}
	*out_len = KEY_LEN;
	return 1;
}

int  RSASHA1verify(const unsigned char* in_data,int in_len,
                   int in_radix,char* in_N,
                   const unsigned char* sig_data)
{
    //    srand((unsigned int)time(0));
    unsigned char sha1sum[20];
    sha1( in_data, in_len, sha1sum);
	rsa_context rsa;
	rsa_init(&rsa,RSA_PKCS_V15,0);
	rsa.len = KEY_LEN;
	mpi_read_string( &rsa.N , in_radix, in_N );
	mpi_read_string( &rsa.E , 16, RSA_E  );
	if( rsa_check_pubkey(  &rsa ) != 0)
		return 0;
    int ret=rsa_pkcs1_verify(&rsa, RSA_PUBLIC, SIG_RSA_SHA1, 20, sha1sum, (unsigned char *)sig_data);
    if( ret!= 0 )
	{
		return 0;
	}
	return 1;
    
}
