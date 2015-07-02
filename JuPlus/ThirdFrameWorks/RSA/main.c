#include <stdio.h>
#include <stdlib.h>
#include "polarssl/rsa.h"
#include "polarssl/bignum.h"
#include "polarssl/my_rsa.h"

#define KEY_LEN 128

#define RSA_N  "d195ac45f41b0a136c61f1bcf88381bbe349a8329960b8f082e2424470550d7bb2d01f499f776edfe28b90a74572cd32aae623a21846aacdf0bf6af814ad71b5107ccadaef14d97a54d09f103f29007e7d203ca5aeff1821c97f74068f7f9ea77d35df315a5e531286b16dcac22ad22346169fd12cd2542dfa543bf812e642c5"

#define RSA_E   "10001"

#define RSA_D   "c84d0d4a05d3d9bb5a77f8faab5fb39b87cb9b6e505bba2452523f16fd6cabe82eaaed5c0585b5774f22276b55da33f65a927c37ac8fcd29e90e6803146ff71c64006a95c45adcc139d2fa18c40eb7453236d3b79bbf55f7ecf54837381c3a66d503b810147ea7626c91e6c3c6fcc747404e820b2e3fbcf636f8abed29bcad79"

#define RSA_P   "e30a517f4d752c3f783f1e2e627f503617595a2e747b627b541f713f497f55397849767e187f5b3f111f2d57177f646d083c332b3c773066015f7c5d4c7342ab"

#define RSA_Q   "ec515d73147f3e7727764a7b717f63716f7f0a1a1b6e6876314f3737326f063b336f191b2f6f3d67193f5956137b007c043b7a7f3d5f4567277f751a657e104f"

#define RSA_DP  "841d64ff271b9ffbef050b93024e0366f67f5032e82544516fca3c240fa8c0f7083ff76bb8e5a33b37c364a6e14d882aca37fdae9328e848f3539512d581dcb1"

#define RSA_DQ  "01258bec8906ed08aafa59f62b60d0dcb60bc9c2c2ab507a7256ce0fc880dd68e02103e02be4c04985c7d6e9220310c78945b89c7171cae66b3ca516d1b340e5"

#define RSA_QP  "74ff06647b2c9967195956251660c56413515471d08fd5e2faca39e6004a332f23f434bbeef21ca71d35d149d4ee8ebc9ed1d21163defdd6fec088fa55998452"

#define PT_LEN  24
#define RSA_PT  "\xAA\xBB\xCC\x03\x02\x01\x00\xFF\xFF\xFF\xFF\xFF" \
	"\x11\x22\x33\x0A\x0B\x0C\xCC\xDD\xDD\xDD\xDD\xDD"

static int myrand( void *rng_state, unsigned char *output, size_t len )
{
	size_t i;
	if( rng_state != NULL )
		rng_state  = NULL;

	for( i = 0; i < len; ++i )
		output[i] = rand();

	return( 0 );
}

int main111()
{
	//rsa_self_test(1);
	rsa_context rsa;
	mpi P1, Q1, H;
	size_t i;
	size_t len;
	unsigned char rsa_plaintext[PT_LEN];
	unsigned char rsa_decrypted[PT_LEN];
	unsigned char rsa_ciphertext[KEY_LEN];
	mpi_init( &P1 ); mpi_init( &Q1 ); mpi_init( &H );

	rsa_init(&rsa,RSA_PKCS_V15,0);
	rsa.len = KEY_LEN;
	mpi_read_string( &rsa.N , 16, RSA_N  );
	mpi_read_string( &rsa.E , 16, RSA_E  );
	mpi_read_string( &rsa.D , 16, RSA_D  );
	mpi_read_string( &rsa.P , 16, RSA_P  );
	mpi_read_string( &rsa.Q , 16, RSA_Q  );
	mpi_read_string( &rsa.DP, 16, RSA_DP );
	mpi_read_string( &rsa.DQ, 16, RSA_DQ );
	mpi_read_string( &rsa.QP, 16, RSA_QP );

	/* // 生成D的过程
	if( mpi_cmp_mpi( &rsa.P, &rsa.Q ) < 0 )
		mpi_swap( &rsa.P, &rsa.Q );

	mpi_mul_mpi( &rsa.N, &rsa.P, &rsa.Q );
	mpi_sub_int( &P1, &rsa.P, 1 );
	mpi_sub_int( &Q1, &rsa.Q, 1 );
	mpi_mul_mpi( &H, &P1, &Q1 );
	mpi_inv_mod( &rsa.D , &rsa.E, &H  );
	*/
	if( rsa_check_pubkey(  &rsa ) != 0)
		printf("check public key fail\n");
	else 
		printf("check public key success\n");
	if( rsa_check_privkey( &rsa ) != 0 )
		printf("check private key fail\n");
	else
	{
		printf("check private key success\n");
		//mpi_write_file(NULL,&rsa.D,16,NULL);
	}
	memcpy(rsa_plaintext,RSA_PT,PT_LEN);

	if( rsa_pkcs1_encrypt( &rsa, &myrand, NULL, RSA_PUBLIC, PT_LEN,
		rsa_plaintext, rsa_ciphertext ) != 0 )
	{
		printf("encrypt fail\n");
	}
	else
	{
		printf("encrypt success\n");
		for(i = 0;i < KEY_LEN; i ++)
			printf("%02x",rsa_ciphertext[i]);
		printf("\n");
	}

	if( rsa_pkcs1_decrypt( &rsa, RSA_PRIVATE, &len,
		rsa_ciphertext, rsa_decrypted,
		sizeof(rsa_decrypted) ) != 0 )
	{
		printf("decrypt fail\n");
	}
	else
	{
		printf("decrypt success\n");
		for(i = 0; i < len;i ++)
		{
			printf("%02x",rsa_decrypted[i]);
		}
		printf("\n");
	}
	if( memcmp( rsa_decrypted, rsa_plaintext, len ) != 0 )
	{
		printf("the result of decryption is different from the plaintext");
	}
	else
	{
		printf("the result of decryption is same as the plaintext");
	}
	return 0;
}

/*int main()
{
	int result = 0;
	unsigned char in_data[] = "\xAA\xBB\xCC\x03\x02\x01\x00\xFF\xFF\xFF\xFF\xFF\x11\x22\x33\x0A\x0B\x0C\xCC\xDD\xDD\xDD\xDD\xDD";
	int in_len = 24;
	unsigned char out_data[129] = {0};
	int out_len;
	int i;

	char in_N[] = "d195ac45f41b0a136c61f1bcf88381bbe349a8329960b8f082e2424470550d7bb2d01f499f776edfe28b90a74572cd32aae623a21846aacdf0bf6af814ad71b5107ccadaef14d97a54d09f103f29007e7d203ca5aeff1821c97f74068f7f9ea77d35df315a5e531286b16dcac22ad22346169fd12cd2542dfa543bf812e642c5";
	result = encrypt(in_data,24,16,in_N,out_data,&out_len);
	printf("%d",result);

	if(result == 1)
	{
		for(i = 0; i < out_len;i ++)
		{
			printf("%02x",out_data[i]);
		}
	}
	return 0;
}*/