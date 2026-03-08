// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop.h for the primary calling header

#ifndef VERILATED_VTOP___024ROOT_H_
#define VERILATED_VTOP___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vtop__Syms;

//----------

VL_MODULE(Vtop___024root) {
  public:

    // LOCAL SIGNALS
    CData/*0:0*/ top__DOT__clock;
    CData/*0:0*/ top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    CData/*0:0*/ top__DOT__reset;
    CData/*0:0*/ top__DOT__reset_done;
    CData/*0:0*/ top__DOT__reset_neg;
    CData/*0:0*/ top__DOT__reset_reg;
    CData/*0:0*/ top__DOT__assign_and_x;
    CData/*0:0*/ top__DOT__assign_and_y;
    CData/*0:0*/ top__DOT__assign_and_z;
    CData/*0:0*/ top__DOT__reg_and_arst_arst;
    CData/*0:0*/ top__DOT__reg_and_arst_x_and_y;
    CData/*0:0*/ top__DOT__reg_and_arst_x;
    CData/*0:0*/ top__DOT__reg_and_arst_y;
    CData/*1:0*/ top__DOT__reg_and_reg_x;
    CData/*1:0*/ top__DOT__reg_and_reg_y;
    CData/*0:0*/ top__DOT__dut__DOT__core__DOT__reg_and_arst_z;
    CData/*0:0*/ top__DOT__dut__DOT__core__DOT__reg_and_reg_z;
    CData/*0:0*/ top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__x_tmp;
    CData/*0:0*/ top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__y_tmp;
    IData/*31:0*/ top__DOT__counter;
    IData/*31:0*/ top__DOT__reset_counter;
    IData/*31:0*/ top__DOT__clkg__DOT__counter;

    // LOCAL VARIABLES
    CData/*0:0*/ __VinpClk__TOP__top__DOT__clock;
    CData/*0:0*/ __VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    CData/*0:0*/ __Vclklast__TOP____VinpClk__TOP__top__DOT__clock;
    CData/*0:0*/ __Vclklast__TOP____VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    CData/*0:0*/ __Vchglast__TOP__top__DOT__clock;
    CData/*0:0*/ __Vchglast__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    IData/*31:0*/ __Vdly__top__DOT__counter;

    // INTERNAL VARIABLES
    Vtop__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vtop___024root);  ///< Copying not allowed
  public:
    Vtop___024root(const char* name);
    ~Vtop___024root();

    // INTERNAL METHODS
    void __Vconfigure(Vtop__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
