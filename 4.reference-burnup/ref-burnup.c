/*------------ -------------- -------- --- ----- ---   --       -            -
 *  Workshop
 *  Learning DRAGON V5 as a production code for XSs
 *  Argentinean Group of Calculation and Reactor Analysis
 *  III Annual Meeting
 *
 *  File desc.: XS extractor
 *  Ramiro Vignolo    <ramirovignolo@gmail.com>
 *
 *------------------- ------------  ----    --------  --     -       -         -
 */

#include <stdio.h>
#include "cle2000.h"
#include "lcm.h"

#define BURN_SIZE     31

int main(int argc, char **argv) {

  int i;

  FILE *input, *output;

  lcm *compo, *table, *mixs, *mixs1, *glob, *calc, *micr, *mac_res;

  int_32 istate[40];

  //parameters
  float_32 burnup[BURN_SIZE];

  //xs
  float_32 Strd[2];
  float_32 SigmaC[2];
  float_32 SigmaS[4];
  float_32 nuSigmaF[2];
  float_32 eSigmaF[2];
  float_32 SigmaF[2];

  if (argc == 2) {
    if ((input = fopen(argv[1],"r")) == NULL) {
      printf("Cannot open '%s' multicompo data structure.\n", argv[1]);
      return -1;
    }
  } else {
    printf("Provide only the data structure name as an argument.\n");
    return 0;
  }

  output = fopen("xs.dat","w");

  lcmop_c(&compo,"multicompo",0,1,0);
  lcmexp_c(&compo,0,input,2,2);
  fclose(input);

  table = lcmgid_c(&compo, "TABLE");
  lcmget_c(&table,"STATE-VECTOR",(int_32 *)istate);

  // check that the number of calculations matches the expected value
  if (istate[2] != BURN_SIZE) {
    printf("Number of calculations do not mach with expected value;\n");
    printf("istate is %d and expected value is %d.\n", istate[2], BURN_SIZE);
    return -1;
  }

  glob = lcmgid_c(&table, "GLOBAL");
  lcmget_c(&glob,"pval00000001", (int_32 *)burnup);

  mixs  = lcmgid_c(&table, "MIXTURES");
  mixs1 = lcmgil_c(&mixs, 0);
  calc  = lcmgid_c(&mixs1, "CALCULATIONS");

  for(i = 0; i < istate[2]; i++) {

    micr = lcmgil_c(&calc, i);

    mac_res = lcmgid_c(&micr, "*MAC*RES");

    lcmget_c(&mac_res,"STRD",(int_32 *)Strd);
    lcmget_c(&mac_res,"NG",(int_32 *)SigmaC);
    lcmget_c(&mac_res,"SCAT00",(int_32 *)SigmaS);
    lcmget_c(&mac_res,"NFTOT",(int_32 *)SigmaF);
    lcmget_c(&mac_res,"NUSIGF",(int_32 *)nuSigmaF);
    lcmget_c(&mac_res,"H-FACTOR",(int_32 *)eSigmaF);

    fprintf(output,"%.2e\t", burnup[i]);
    fprintf(output,"%e\t%e\t", 1.0/(3.0*Strd[0]), 1.0/(3.0*Strd[1]));
    fprintf(output,"%e\t", SigmaC[0]+SigmaF[0]);
    fprintf(output,"%e\t%e\t", SigmaS[3], SigmaS[0]);
    fprintf(output,"%e\t", SigmaC[1]+SigmaF[1]);
    fprintf(output,"%e\t%e\t", nuSigmaF[0], nuSigmaF[1]);
    fprintf(output,"%e\t%e\t", eSigmaF[0], eSigmaF[1]);
    fprintf(output,"%e\t%e\n", SigmaF[0], SigmaF[1]);

  }

  lcmcl_c(&compo, 1);
  fclose(output);

  return 0;
}