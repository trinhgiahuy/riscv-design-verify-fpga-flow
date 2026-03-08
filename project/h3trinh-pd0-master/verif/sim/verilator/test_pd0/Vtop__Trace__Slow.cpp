// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__traceInitSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vtop___024root__traceInitTop(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vtop___024root__traceInitSub0(vlSelf, tracep);
    }
}

void Vtop___024root__traceInitSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+23,"top clock", false,-1);
        tracep->declBit(c+1,"top reset", false,-1);
        tracep->declBus(c+19,"top counter", false,-1, 31,0);
        tracep->declBus(c+26,"top errors", false,-1, 31,0);
        tracep->declBit(c+2,"top reset_done", false,-1);
        tracep->declBit(c+3,"top reset_neg", false,-1);
        tracep->declBit(c+4,"top reset_reg", false,-1);
        tracep->declBus(c+5,"top reset_counter", false,-1, 31,0);
        tracep->declBit(c+6,"top assign_and_x", false,-1);
        tracep->declBit(c+7,"top assign_and_y", false,-1);
        tracep->declBit(c+8,"top assign_and_z", false,-1);
        tracep->declBit(c+9,"top reg_and_arst_arst", false,-1);
        tracep->declBit(c+10,"top reg_and_arst_x_and_y", false,-1);
        tracep->declBit(c+27,"top reg_and_arst_z", false,-1);
        tracep->declBit(c+11,"top reg_and_arst_x", false,-1);
        tracep->declBit(c+12,"top reg_and_arst_y", false,-1);
        tracep->declBus(c+13,"top reg_and_reg_x", false,-1, 1,0);
        tracep->declBus(c+14,"top reg_and_reg_y", false,-1, 1,0);
        tracep->declBit(c+28,"top reg_and_reg_z", false,-1);
        tracep->declBit(c+23,"top clkg clk", false,-1);
        tracep->declBit(c+1,"top clkg rst", false,-1);
        tracep->declBus(c+15,"top clkg counter", false,-1, 31,0);
        tracep->declBit(c+23,"top dut clock", false,-1);
        tracep->declBit(c+1,"top dut reset", false,-1);
        tracep->declBit(c+23,"top dut core clock", false,-1);
        tracep->declBit(c+1,"top dut core reset", false,-1);
        tracep->declBit(c+20,"top dut core assign_and_x", false,-1);
        tracep->declBit(c+21,"top dut core assign_and_y", false,-1);
        tracep->declBit(c+22,"top dut core assign_and_z", false,-1);
        tracep->declBit(c+20,"top dut core reg_and_arst_x", false,-1);
        tracep->declBit(c+21,"top dut core reg_and_arst_y", false,-1);
        tracep->declBit(c+24,"top dut core reg_and_arst_reset", false,-1);
        tracep->declBit(c+25,"top dut core reg_and_arst_z", false,-1);
        tracep->declBit(c+20,"top dut core reg_and_reg_x", false,-1);
        tracep->declBit(c+21,"top dut core reg_and_reg_y", false,-1);
        tracep->declBit(c+16,"top dut core reg_and_reg_z", false,-1);
        tracep->declBit(c+20,"top dut core assign_and_0 x", false,-1);
        tracep->declBit(c+21,"top dut core assign_and_0 y", false,-1);
        tracep->declBit(c+22,"top dut core assign_and_0 z", false,-1);
        tracep->declBit(c+23,"top dut core reg_and_arst_0 clock", false,-1);
        tracep->declBit(c+24,"top dut core reg_and_arst_0 areset", false,-1);
        tracep->declBit(c+20,"top dut core reg_and_arst_0 x", false,-1);
        tracep->declBit(c+21,"top dut core reg_and_arst_0 y", false,-1);
        tracep->declBit(c+25,"top dut core reg_and_arst_0 z", false,-1);
        tracep->declBit(c+29,"top dut core reg_and_arst_0 out", false,-1);
        tracep->declBit(c+23,"top dut core reg_and_reg_0 clock", false,-1);
        tracep->declBit(c+1,"top dut core reg_and_reg_0 reset", false,-1);
        tracep->declBit(c+20,"top dut core reg_and_reg_0 x", false,-1);
        tracep->declBit(c+21,"top dut core reg_and_reg_0 y", false,-1);
        tracep->declBit(c+16,"top dut core reg_and_reg_0 z", false,-1);
        tracep->declBit(c+17,"top dut core reg_and_reg_0 x_tmp", false,-1);
        tracep->declBit(c+18,"top dut core reg_and_reg_0 y_tmp", false,-1);
    }
}

void Vtop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) VL_ATTR_COLD;
void Vtop___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep);
void Vtop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/);

void Vtop___024root__traceRegister(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        tracep->addFullCb(&Vtop___024root__traceFullTop0, vlSelf);
        tracep->addChgCb(&Vtop___024root__traceChgTop0, vlSelf);
        tracep->addCleanupCb(&Vtop___024root__traceCleanup, vlSelf);
    }
}

void Vtop___024root__traceFullSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vtop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vtop___024root__traceFullSub0((&vlSymsp->TOP), tracep);
    }
}

void Vtop___024root__traceFullSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullBit(oldp+1,(vlSelf->top__DOT__reset));
        tracep->fullBit(oldp+2,(vlSelf->top__DOT__reset_done));
        tracep->fullBit(oldp+3,(vlSelf->top__DOT__reset_neg));
        tracep->fullBit(oldp+4,(vlSelf->top__DOT__reset_reg));
        tracep->fullIData(oldp+5,(vlSelf->top__DOT__reset_counter),32);
        tracep->fullBit(oldp+6,(vlSelf->top__DOT__assign_and_x));
        tracep->fullBit(oldp+7,(vlSelf->top__DOT__assign_and_y));
        tracep->fullBit(oldp+8,(vlSelf->top__DOT__assign_and_z));
        tracep->fullBit(oldp+9,(vlSelf->top__DOT__reg_and_arst_arst));
        tracep->fullBit(oldp+10,(vlSelf->top__DOT__reg_and_arst_x_and_y));
        tracep->fullBit(oldp+11,(vlSelf->top__DOT__reg_and_arst_x));
        tracep->fullBit(oldp+12,(vlSelf->top__DOT__reg_and_arst_y));
        tracep->fullCData(oldp+13,(vlSelf->top__DOT__reg_and_reg_x),2);
        tracep->fullCData(oldp+14,(vlSelf->top__DOT__reg_and_reg_y),2);
        tracep->fullIData(oldp+15,(vlSelf->top__DOT__clkg__DOT__counter),32);
        tracep->fullBit(oldp+16,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_z));
        tracep->fullBit(oldp+17,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__x_tmp));
        tracep->fullBit(oldp+18,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_reg_0__DOT__y_tmp));
        tracep->fullIData(oldp+19,(vlSelf->top__DOT__counter),32);
        tracep->fullBit(oldp+20,((1U & vlSelf->top__DOT__counter)));
        tracep->fullBit(oldp+21,((1U & (vlSelf->top__DOT__counter 
                                        >> 1U))));
        tracep->fullBit(oldp+22,((IData)((3U == (3U 
                                                 & vlSelf->top__DOT__counter)))));
        tracep->fullBit(oldp+23,(vlSelf->top__DOT__clock));
        tracep->fullBit(oldp+24,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_reset));
        tracep->fullBit(oldp+25,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_z));
        tracep->fullIData(oldp+26,(0U),32);
        tracep->fullBit(oldp+27,(vlSelf->top__DOT__reg_and_arst_z));
        tracep->fullBit(oldp+28,(vlSelf->top__DOT__reg_and_reg_z));
        tracep->fullBit(oldp+29,(vlSelf->top__DOT__dut__DOT__core__DOT__reg_and_arst_0__DOT__out));
    }
}
