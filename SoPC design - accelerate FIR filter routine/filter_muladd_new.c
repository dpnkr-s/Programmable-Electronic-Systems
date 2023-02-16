#include "sys/alt_stdio.h"
#include "altera_avalon_performance_counter.h"
#include "system.h"

int filter_muladd()
{

  int input[85] ={0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  1,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  0,
				  -6754,
				  -15687,
				  -31716,
				  -6518,
				  7301,
				  -10850,
				  31710,
				  -2341,
				  999,
				  -30678,
				  24927,
				  6725,
				  -12612,
				  -7333,
				  2755,
				  25075,
				  24101,
				  -7305,
				  10859,
				  26998,
				  26665,
				  152,
				  -6149,
				  -17218,
				  -7584,
				  16591,
				  -31878,
				  32457,
				  23096,
				  26618,
				  27595,
				  -16927,
				  -16990,
				  29897,
				  24311,
				  -3735,
				  -10177,
				  23941,
				  -16392,
				  -11137,
				  29304,
				  -5486,
				  19224,
				  12300,
				  -28414,
				  -24613,
				  -18685,
				  11771,
				  -13118,
				  -7813,
				  -25070};
  int coeff[17]= {-282,
				 -369,
				 -307,
				 -67,
				 326,
				 803,
				 1259,
				 1587,
				 1706,
				 1587,
				 1259,
				 803,
				 326,
				 -67,
				 -307,
				 -369,
				 -282};
  int output[85];
  int state[17]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  int i,j;
  int temp;
  int temp2;
  // reset performance counter
  PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
  // start performance counter
  PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);

  for(i=0;i<85;i++)
  {
	  temp = 0;
	  for(j=16;j>0;j--)
	  {
		  state[j]=state[j-1];
		  //temp = temp + state[j]*coeff[j];
		  temp2 = state[j] | (coeff[j] & 0x0000FFFF); // coefficient MSBs are always 0 (pos) or 1 (neg)
		  temp = ALT_CI_MULADD2_INST(temp2,temp);
	  }
	  state[0]=input[i] << 16; // moving to the 16 MSBs
	  temp2 = state[0] | (coeff[0] & 0x0000FFFF);
	  temp = ALT_CI_MULADD2_INST(temp2,temp);
	  output[i] = temp >> 13;
  }
  // stop performance counter
  PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);

  return 0;
}
