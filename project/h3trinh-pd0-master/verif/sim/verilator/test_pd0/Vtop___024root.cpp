// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop___024root.h"
#include "Vtop__Syms.h"

#include "verilated_dpi.h"

//==========

void Vtop___024root____Vdpiexp_top__DOT__clkg__DOT__toggleClock_TOP(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root____Vdpiexp_top__DOT__clkg__DOT__toggleClock_TOP\n"); );
    // Variables
    // Body
    vlSymsp->TOP.top__DOT__clock = (1U & (~ (IData)(vlSymsp->TOP.top__DOT__clock)));
}

VL_INLINE_OPT void Vtop___024root___sequent__TOP__1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__1\n"); );
    // Variables
    CData/*1:0*/ __Vdly__top__DOT__reg_and_reg_x;
    CData/*1:0*/ __Vdly__top__DOT__reg_and_reg_y;
    IData/*31:0*/ __Vdly__top__DOT__reset_counter;
    IData/*31:0*/ __Vdly__top__DOT__clkg__DOT__counter;
    // Body
    __Vdly__top__DOT__clkg__DOT__counter = vlSelf->top__DOT__clkg__DOT__counter;
    vlSelf->__Vdly__top__DOT__counter = vlSelf->top__DOT__counter;
    __Vdly__top__DOT__reset_counter = vlSelf->top__DOT__reset_counter;
    __Vdly__top__DOT__reg_and_reg_y = vlSelf->top__DOT__reg_and_reg_y;
    __Vdly__top__DOT__reg_and_reg_x = vlSelf->top__DOT__reg_and_reg_x;
    if (vlSelf->top__DOT__reset_done) {
        if (VL_UNLIKELY((((IData)(vlSelf->top__DOT__assign_and_x) 
                          & (IData)(vlSelf->top__DOT__assign_and_y)) 
                         != (IData)(vlSelf->top__DOT__assign_and_z)))) {
            VL_WRITEF("[%0t] %%Error: test_pd0.v:51: Assertion failed in %Ntop.assign_and_test: \n[PD0] assign_and_test: x=%b, y=%b, z=%b\n",
                      64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name(),
                      1,(IData)(vlSelf->top__DOT__assign_and_x),
                      1,vlSelf->top__DOT__assign_and_y,
                      1,(IData)(vlSelf->top__DOT__assign_and_z));
            VL_STOP_MT("/home/h3trinh/h3trinh-pd0/verif/tests/test_pd0.v", 51, "");
        }
    }
    if (vlSelf->top__DOT__reset_done) {
        if (vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset) {
            if (VL_UNLIKELY(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_z)) {
                VL_WRITEF("[%0t] %%Error: test_pd0.v:87: Assertion failed in %Ntop.reg_and_arst_test: \n[PD0] Exercise 3.3: reset is incorrect\n",
                          64,VL_TIME_UNITED_Q(1),-12,
                          vlSymsp->name());
                VL_STOP_MT("/home/h3trinh/h3trinh-pd0/verif/tests/test_pd0.v", 87, "");
            }
        } else if (VL_UNLIKELY(((IData)(vlSelf->top__DOT__reg_and_arst_x_and_y) 
                                != (IData)(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_z)))) {
            VL_WRITEF("[%0t] %%Error: test_pd0.v:91: Assertion failed in %Ntop.reg_and_arst_test: \n[PD0] Exercise 3.3: arst=%b, x=%b, y=%b, z=%b, z should be %b\n",
                      64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name(),
                      1,(IData)(vlSelf->top__DOT__reg_and_arst_arst),
                      1,vlSelf->top__DOT__reg_and_arst_x,
                      1,(IData)(vlSelf->top__DOT__reg_and_arst_y),
                      1,vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_z,
                      1,(IData)(vlSelf->top__DOT__reg_and_arst_x_and_y));
            VL_STOP_MT("/home/h3trinh/h3trinh-pd0/verif/tests/test_pd0.v", 91, "");
        }
    }
    vlSelf->__Vdly__top__DOT__counter = ((IData)(1U) 
                                         + vlSelf->top__DOT__counter);
    if (VL_UNLIKELY((0x64U == vlSelf->top__DOT__counter))) {
        VL_WRITEF("[PD0] No error encountered\n");
        VL_FINISH_MT("/home/h3trinh/h3trinh-pd0/verif/tests/test_pd0.v", 19, "");
    }
    __Vdly__top__DOT__reg_and_reg_x = ((2U & (IData)(__Vdly__top__DOT__reg_and_reg_x)) 
                                       | (1U & vlSelf->top__DOT__counter));
    __Vdly__top__DOT__reg_and_reg_y = ((2U & (IData)(__Vdly__top__DOT__reg_and_reg_y)) 
                                       | (1U & (vlSelf->top__DOT__counter 
                                                >> 1U)));
    __Vdly__top__DOT__reg_and_reg_x = ((1U & (IData)(__Vdly__top__DOT__reg_and_reg_x)) 
                                       | (2U & ((IData)(vlSelf->top__DOT__reg_and_reg_x) 
                                                << 1U)));
    __Vdly__top__DOT__reg_and_reg_y = ((1U & (IData)(__Vdly__top__DOT__reg_and_reg_y)) 
                                       | (2U & ((IData)(vlSelf->top__DOT__reg_and_reg_y) 
                                                << 1U)));
    if (vlSelf->top__DOT__reset_done) {
        if (VL_UNLIKELY(((1U & (((IData)(vlSelf->top__DOT__reg_and_reg_x) 
                                 & (IData)(vlSelf->top__DOT__reg_and_reg_y)) 
                                >> 1U)) != (IData)(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_z)))) {
            VL_WRITEF("[%0t] %%Error: test_pd0.v:123: Assertion failed in %Ntop.reg_and_reg_test: \n[PD0] Exercise 3.4: x=%b, y=%b, z=%b, z should be %b\n",
                      64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name(),
                      1,(1U & ((IData)(vlSelf->top__DOT__reg_and_reg_x) 
                               >> 1U)),1,(1U & ((IData)(vlSelf->top__DOT__reg_and_reg_y) 
                                                >> 1U)),
                      1,(IData)(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_z),
                      1,(1U & (((IData)(vlSelf->top__DOT__reg_and_reg_x) 
                                & (IData)(vlSelf->top__DOT__reg_and_reg_y)) 
                               >> 1U)));
            VL_STOP_MT("/home/h3trinh/h3trinh-pd0/verif/tests/test_pd0.v", 123, "");
        }
    }
    vlSelf->top__DOT__reg_and_reg_x = __Vdly__top__DOT__reg_and_reg_x;
    vlSelf->top__DOT__reg_and_reg_y = __Vdly__top__DOT__reg_and_reg_y;
    vlSelf->top__DOT__assign_and_x = (1U & vlSelf->top__DOT__counter);
    vlSelf->top__DOT__assign_and_y = (1U & (vlSelf->top__DOT__counter 
                                            >> 1U));
    vlSelf->top__DOT__assign_and_z = (IData)((3U == 
                                              (3U & vlSelf->top__DOT__counter)));
    vlSelf->top__DOT__reg_and_arst_x = (1U & vlSelf->top__DOT__counter);
    vlSelf->top__DOT__reg_and_arst_y = (1U & (vlSelf->top__DOT__counter 
                                              >> 1U));
    vlSelf->top__DOT__reg_and_arst_arst = vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    vlSelf->top__DOT__reg_and_arst_x_and_y = (1U & 
                                              ((vlSelf->top__DOT__counter 
                                                & (vlSelf->top__DOT__counter 
                                                   >> 1U)) 
                                               & (~ (IData)(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset))));
    __Vdly__top__DOT__reset_counter = ((IData)(vlSelf->top__DOT__reset)
                                        ? 0U : ((IData)(1U) 
                                                + vlSelf->top__DOT__reset_counter));
    if (((IData)(vlSelf->top__DOT__reset_neg) & VL_LTES_III(1,32,32, 3U, vlSelf->top__DOT__reset_counter))) {
        vlSelf->top__DOT__reset_done = 1U;
    }
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_z 
        = ((~ (IData)(vlSelf->top__DOT__reset)) & ((IData)(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__x_tmp) 
                                                   & (IData)(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__y_tmp)));
    vlSelf->top__DOT__reset_counter = __Vdly__top__DOT__reset_counter;
    if (((IData)(vlSelf->top__DOT__reset_reg) & (~ (IData)(vlSelf->top__DOT__reset)))) {
        vlSelf->top__DOT__reset_neg = 1U;
    }
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__x_tmp 
        = (1U & ((~ (IData)(vlSelf->top__DOT__reset)) 
                 & vlSelf->top__DOT__counter));
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__y_tmp 
        = (1U & ((~ (IData)(vlSelf->top__DOT__reset)) 
                 & (vlSelf->top__DOT__counter >> 1U)));
    vlSelf->top__DOT__reset_reg = vlSelf->top__DOT__reset;
    __Vdly__top__DOT__clkg__DOT__counter = ((IData)(1U) 
                                            + vlSelf->top__DOT__clkg__DOT__counter);
    vlSelf->top__DOT__reset = VL_GTS_III(1,32,32, 5U, vlSelf->top__DOT__clkg__DOT__counter);
    if (VL_UNLIKELY((0x186a0U == vlSelf->top__DOT__clkg__DOT__counter))) {
        VL_FINISH_MT("/home/h3trinh/h3trinh-pd0/verif/tests/clockgen.v", 40, "");
    }
    vlSelf->top__DOT__clkg__DOT__counter = __Vdly__top__DOT__clkg__DOT__counter;
}

VL_INLINE_OPT void Vtop___024root___sequent__TOP__3(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__3\n"); );
    // Body
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_z 
        = (1U & ((~ (IData)(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset)) 
                 & (vlSelf->top__DOT__counter & (vlSelf->top__DOT__counter 
                                                 >> 1U))));
}

VL_INLINE_OPT void Vtop___024root___sequent__TOP__5(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__5\n"); );
    // Body
    vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset 
        = (1U & ((~ (IData)(vlSelf->top__DOT__clock)) 
                 & (vlSelf->top__DOT__counter >> 2U)));
}

VL_INLINE_OPT void Vtop___024root___sequent__TOP__6(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__6\n"); );
    // Body
    vlSelf->top__DOT__counter = vlSelf->__Vdly__top__DOT__counter;
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->__VinpClk__TOP__top__DOT__clock) 
         & (~ (IData)(vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__clock)))) {
        Vtop___024root___sequent__TOP__1(vlSelf);
    }
    if ((((IData)(vlSelf->__VinpClk__TOP__top__DOT__clock) 
          & (~ (IData)(vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__clock))) 
         | ((IData)(vlSelf->__VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset) 
            & (~ (IData)(vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset))))) {
        Vtop___024root___sequent__TOP__3(vlSelf);
    }
    if (((IData)(vlSelf->__VinpClk__TOP__top__DOT__clock) 
         ^ (IData)(vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__clock))) {
        Vtop___024root___sequent__TOP__5(vlSelf);
    }
    if (((IData)(vlSelf->__VinpClk__TOP__top__DOT__clock) 
         & (~ (IData)(vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__clock)))) {
        Vtop___024root___sequent__TOP__6(vlSelf);
    }
    // Final
    vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__clock 
        = vlSelf->__VinpClk__TOP__top__DOT__clock;
    vlSelf->__Vclklast__TOP____VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset 
        = vlSelf->__VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    vlSelf->__VinpClk__TOP__top__DOT__clock = vlSelf->top__DOT__clock;
    vlSelf->__VinpClk__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset 
        = vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
}

QData Vtop___024root___change_request_1(Vtop___024root* vlSelf);

VL_INLINE_OPT QData Vtop___024root___change_request(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___change_request\n"); );
    // Body
    return (Vtop___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData Vtop___024root___change_request_1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___change_request_1\n"); );
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    __req |= ((vlSelf->top__DOT__clock ^ vlSelf->__Vchglast__TOP__top__DOT__clock)
         | (vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset ^ vlSelf->__Vchglast__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset));
    VL_DEBUG_IF( if(__req && ((vlSelf->top__DOT__clock ^ vlSelf->__Vchglast__TOP__top__DOT__clock))) VL_DBG_MSGF("        CHANGE: /home/h3trinh/h3trinh-pd0/verif/tests/test_pd0.v:3: top.clock\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset ^ vlSelf->__Vchglast__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset))) VL_DBG_MSGF("        CHANGE: /home/h3trinh/h3trinh-pd0/design/code/pd0.v:17: top.dut.core.reg_and_arst_reset\n"); );
    // Final
    vlSelf->__Vchglast__TOP__top__DOT__clock = vlSelf->top__DOT__clock;
    vlSelf->__Vchglast__TOP__top__DOT__dut__DOT__core__DOT__reg_and_arst_reset 
        = vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset;
    return __req;
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
