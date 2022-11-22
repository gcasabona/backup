#ifndef OPT_KERNEL
#define OPT_KERNEL

void opt_2dhisto(int numblocksW, int numBlocksH, int blockWidth, int blockHeight, uint32_t *inputd, uint8_t *resultd);
//global void opt_histo_kernel(uint32_t *input, uint8_t *resultopt, int width, int height);
/* Include below the function headers of any other functions that you implement */
void CopyFromDevice(uint8_t *array_device, uint8_t *array);
void CopyToDevice(uint32_t *data_Device, uint32_t **data_Host, uint8_t *result_Device, uint8_t *result_Host);
uint32_t *AllocateDeviceMemData();
uint8_t *AllocateDeviceMemResult();
void FreeCudaMemData(uint32_t *array);
void FreeCudaMemResult(uint8_t *array);

#endif
