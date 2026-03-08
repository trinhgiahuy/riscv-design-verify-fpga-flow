// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__traceChgSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep);

void Vtop___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        Vtop___024root__traceChgSub0((&vlSymsp->TOP), tracep);
    }
}

void Vtop___024root__traceChgSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
            tracep->chgBit(oldp+0,(vlSelf->top__DOT__reset));
            tracep->chgBit(oldp+1,(vlSelf->top__DOT__reset_done));
            tracep->chgBit(oldp+2,(vlSelf->top__DOT__reset_neg));
            tracep->chgBit(oldp+3,(vlSelf->top__DOT__reset_reg));
            tracep->chgIData(oldp+4,(vlSelf->top__DOT__reset_counter),32);
            tracep->chgBit(oldp+5,(vlSelf->top__DOT__assign_and_x));
            tracep->chgBit(oldp+6,(vlSelf->top__DOT__assign_and_y));
            tracep->chgBit(oldp+7,(vlSelf->top__DOT__assign_and_z));
            tracep->chgBit(oldp+8,(vlSelf->top__DOT__reg_and_arst_arst));
            tracep->chgBit(oldp+9,(vlSelf->top__DOT__reg_and_arst_x_and_y));
            tracep->chgBit(oldp+10,(vlSelf->top__DOT__reg_and_arst_x));
            tracep->chgBit(oldp+11,(vlSelf->top__DOT__reg_and_arst_y));
            tracep->chgCData(oldp+12,(vlSelf->top__DOT__reg_and_reg_x),2);
            tracep->chgCData(oldp+13,(vlSelf->top__DOT__reg_and_reg_y),2);
            tracep->chgIData(oldp+14,(vlSelf->top__DOT__clkg__DOT__counter),32);
            tracep->chgBit(oldp+15,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_z));
            tracep->chgBit(oldp+16,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__x_tmp));
            tracep->chgBit(oldp+17,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__y_tmp));
        }
        if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[2U])) {
            tracep->chgIData(oldp+18,(vlSelf->top__DOT__counter),32);
            tracep->chgBit(oldp+19,((1U & vlSelf->top__DOT__counter)));
            tracep->chgBit(oldp+20,((1U & (vlSelf->top__DOT__counter 
                                           >> 1U))));
            tracep->chgBit(oldp+21,((IData)((3U == 
                                             (3U & vlSelf->top__DOT__counter)))));
        }
        tracep->chgBit(oldp+22,(vlSelf->top__DOT__clock));
        tracep->chgBit(oldp+23,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset));
        tracep->chgBit(oldp+24,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_z));
    }
}

void Vtop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
        vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
        vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    }
}
