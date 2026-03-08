// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop___024root.h"
#include "Vtop__Syms.h"

#include "verilated_dpi.h"

//==========


void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf);

Vtop___024root::Vtop___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vtop___024root___ctor_var_reset(this);
}

void Vtop___024root::__Vconfigure(Vtop__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vtop___024root::~Vtop___024root() {
}

void Vtop___024root___initial__TOP__4(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___initial__TOP__4\n"); );
    // Body
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset = 0U;
    vlSelf->top__DOT__counter = 0U;
    vlSelf->top__DOT__clock = 0U;
    vlSelf->top__DOT__reset = 1U;
    vlSelf->top__DOT__clkg__DOT__counter = 0U;
}

void Vtop___024root___eval_initial(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__clock 
        = vlSelf->__VinpClk__TOP__top__DOT__clock;
    vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset 
        = vlSelf->__VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    Vtop___024root___initial__TOP__4(vlSelf);
}

void Vtop___024root___eval_settle(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_settle\n"); );
}

void Vtop___024root___final(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___final\n"); );
}

void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->top__DOT__clock = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reset = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__counter = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__reset_done = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reset_neg = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reset_reg = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reset_counter = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__assign_and_x = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__assign_and_y = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__assign_and_z = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reg_and_arst_arst = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reg_and_arst_x_and_y = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reg_and_arst_x = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reg_and_arst_y = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__reg_and_reg_x = VL_RAND_RESET_I(2);
    vlSelf->top__DOT__reg_and_reg_y = VL_RAND_RESET_I(2);
    vlSelf->top__DOT__clkg__DOT__counter = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_z = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_z = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__x_tmp = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__y_tmp = VL_RAND_RESET_I(1);
    vlSelf->__Vdly__top__DOT__counter = VL_RAND_RESET_I(32);
    vlSelf->__VinpClk__TOP__top__DOT__clock = VL_RAND_RESET_I(1);
    vlSelf->__VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset = VL_RAND_RESET_I(1);
    vlSelf->__Vchglast__TOP__top__DOT__clock = VL_RAND_RESET_I(1);
    vlSelf->__Vchglast__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset = VL_RAND_RESET_I(1);
}
