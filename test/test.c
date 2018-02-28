#include <stdint.h>

extern int printf( const char *, ... ); 
extern long atol( const char * );

#define CMWC_CYCLE 4096
#define CMWC_C_MAX 809430660
struct cmwc_state {
	uint32_t Q[CMWC_CYCLE];
	uint32_t c;
	unsigned i;
};

static void initCmwc( struct cmwc_state *state, uint32_t seed ) {
	uint32_t c = seed;
	for (int i = 0; i < CMWC_CYCLE; i++) {
		c = c * 1103515245 + 12345;
		state->Q[i] = c;
	}
	state->c = (c * 1103515245 + 12345) % 809430660;	
}

static uint32_t randCmwc( struct cmwc_state *state ) {
	uint64_t const a = 18782;
	uint32_t const m = 0xfffffffe;
	uint64_t t;
	uint32_t x;

	state->i = (state->i + 1) & (CMWC_CYCLE - 1);
	t = a * state->Q[state->i] + state->c;
	state->c = t >> 32;
	x = t + state->c;
	if (x < state->c) {
		x++;
		state->c++;
	}
	return state->Q[state->i] = m - x;
}

int main( int argc, char *argv[] ) {
	struct cmwc_state cmwc = {0};
	if ( argc > 2 ) {
		uint32_t seed = (uint32_t) atol( argv[1] );
		uint32_t n = (uint32_t) atol( argv[2] );
		initCmwc( &cmwc, seed );
		for ( int i = 0; i < n; i++ ) {
			printf("%u\n", randCmwc( &cmwc ));
		}
		return 0;
	} else {
		printf( "You must pass the seed and the count of items to generate\n" );
		return 1;
	}
}
