// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vtop__Syms.h"
#include "Vtop.h"
#include "Vtop___024root.h"

void Vtop___024root____Vdpiexp_top__DOT__clkg__DOT__toggleClock_TOP(Vtop__Syms* __restrict vlSymsp);

// FUNCTIONS
Vtop__Syms::~Vtop__Syms()
{
}

Vtop__Syms::Vtop__Syms(VerilatedContext* contextp, const char* namep,Vtop* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp(modelp)
    // Setup module instances
    , TOP(namep)
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(this, true);
    // Setup scopes
    __Vscope_top.configure(this, name(), "top", "top", -12, VerilatedScope::SCOPE_OTHER);
    __Vscope_top__assign_and_test.configure(this, name(), "top.assign_and_test", "assign_and_test", -12, VerilatedScope::SCOPE_OTHER);
    __Vscope_top__clkg.configure(this, name(), "top.clkg", "clkg", -12, VerilatedScope::SCOPE_OTHER);
    __Vscope_top__reg_and_arst_test.configure(this, name(), "top.reg_and_arst_test", "reg_and_arst_test", -12, VerilatedScope::SCOPE_OTHER);
    __Vscope_top__reg_and_reg_test.configure(this, name(), "top.reg_and_reg_test", "reg_and_reg_test", -12, VerilatedScope::SCOPE_OTHER);
    // Setup export functions
    for (int __Vfinal=0; __Vfinal<2; __Vfinal++) {
        __Vscope_top__clkg.exportInsert(__Vfinal, "toggleClock", (void*)(&Vtop___024root____Vdpiexp_top__DOT__clkg__DOT__toggleClock_TOP));
    }
}
