#ifndef _RVMODEL_MACROS_H
#define _RVMODEL_MACROS_H

// STANDARD_SM_SUPPORTED is deliberately undefined: rv32i and rv64i have no Zicsr and no M-mode CSRs,
// so the tests boot and run without touching any CSR.
#define RVMODEL_DATA_SECTION

##### STARTUP #####

# Perform boot operations. Can be empty or left undefined unless needed for
# DUT-specific behavior such as turning on a memory controller or
# initializing custom state.
//#define RVMODEL_BOOT

// Custom RVMODEL_BOOT_TO_MMODE overrides default RVTEST_BOOT_TO_MMODE
// if defined.  For most DUTs, the default should work and this macro
// should not be defined.  If the DUT has no standard M-mode CSRs, do not
// define STANDARD_SM_SUPPORTED.  If a nonconforming
// M-mode is implemented, define this macro to set up the necessary
// state in a fashion similar to RVTEST_BOOT_TO_MMODE.
//#define RVMODEL_BOOT_TO_MMODE

##### TERMINATION #####

# Terminate test with a pass indication.
# When the test is run in simulation, this should end the simulation.
#define RVMODEL_HALT_PASS   \
  self_loop_pass:	;\
	li x1, 0xFFFFFFFF	;\
    	ebreak                 ;\
    	j self_loop_pass       ;\

# Terminate test with a fail indication.
# When the test is run in simulation, this should end the simulation.
#define RVMODEL_HALT_FAIL   \
  self_loop_fail:	   ;\
    	li x1, 0x11111111 ; \
	ebreak               ;\
    j self_loop_fail       ;\

##### IO #####
#define RVMODEL_IO_WRITE_STR(_R1, _R2, _R3, _STR_PTR) \
	nop

##### Access Fault #####

#define RVMODEL_ACCESS_FAULT_ADDRESS 0x00000000

// No CLINT, PLIC or interrupts in this configuration, and no M-mode CSRs to take them, so no interrupt macros.

#endif // _RVMODEL_MACROS_H
