#include <stdio.h>   /* Standard input/output definitions */
#include <unistd.h>  /* UNIX standard function definitions */
#include <pthread.h>
#include <ctype.h>    /* For tolower() function */
#include <math.h>
#include <stdlib.h>

#include "vbatcontrol.h"
#include "vbat.h"

static struct vbat_struct vbat;

int getVoltage() {
	char tmp[100];
	vbat_read(&vbat);
	sprintf(tmp,"%5.2f",vbat.vbat);
	return atoi(tmp);
}
