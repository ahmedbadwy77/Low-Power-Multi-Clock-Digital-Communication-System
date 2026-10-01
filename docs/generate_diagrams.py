"""
generate_diagrams.py
Generates clean, high-resolution, modern engineering schematics and block diagrams
for the Low-Power Multi-Clock Digital Communication System project.
"""

import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch, Arrow, ConnectionPatch
import numpy as np
import os

os.makedirs('assets', exist_ok=True)

# Common styling constants
FONT_FAMILY = 'sans-serif'
COLOR_BG = '#FFFFFF'
COLOR_TEXT = '#0F172A'
COLOR_MUTED = '#64748B'
COLOR_REF_FILL = '#EFF6FF'       # Soft Blue (REF_CLK domain)
COLOR_REF_BORDER = '#2563EB'
COLOR_UART_FILL = '#FAF5FF'      # Soft Purple (UART_CLK domain)
COLOR_UART_BORDER = '#7C3AED'
COLOR_CDC_FILL = '#F0FDF4'       # Soft Green (CDC / Synchronizers)
COLOR_CDC_BORDER = '#059669'
COLOR_BLOCK_FILL = '#F8FAFC'     # General block fill
COLOR_BLOCK_BORDER = '#334155'
COLOR_ACCENT = '#D97706'         # Amber/Orange for highlights
COLOR_WIRE = '#1E293B'

def setup_canvas(width=12, height=7, dpi=200):
    fig, ax = plt.subplots(figsize=(width, height), dpi=dpi)
    fig.patch.set_facecolor(COLOR_BG)
    ax.set_facecolor(COLOR_BG)
    ax.set_xlim(0, width)
    ax.set_ylim(0, height)
    ax.axis('off')
    return fig, ax

def draw_box(ax, x, y, w, h, title='', fill=COLOR_BLOCK_FILL, border=COLOR_BLOCK_BORDER, 
             radius=0.15, lw=1.8, title_color=COLOR_TEXT, title_size=11, bold=True):
    box = FancyBboxPatch((x, y), w, h, boxstyle=f"round,pad=0.02,rounding_size={radius}",
                         facecolor=fill, edgecolor=border, linewidth=lw, zorder=2)
    ax.add_patch(box)
    if title:
        weight = 'bold' if bold else 'normal'
        ax.text(x + w/2, y + h/2, title, ha='center', va='center',
                fontsize=title_size, fontweight=weight, color=title_color,
                family=FONT_FAMILY, zorder=3)
    return box

def draw_arrow(ax, x1, y1, x2, y2, label='', label_pos='top', color=COLOR_WIRE, lw=1.6, bus=False, bus_w=''):
    ax.annotate('', xy=(x2, y2), xytext=(x1, y1),
                arrowprops=dict(arrowstyle="->,head_length=0.35,head_width=0.25",
                                color=color, lw=lw, shrinkA=0, shrinkB=0),
                zorder=4)
    if bus:
        # draw bus slash
        mx, my = (x1 + x2)/2, (y1 + y2)/2
        ax.plot([mx - 0.08, mx + 0.08], [my - 0.12, my + 0.12], color=color, lw=lw, zorder=5)
        if bus_w:
            ax.text(mx + 0.05, my + 0.12, bus_w, fontsize=8, color=color, fontweight='bold', zorder=6)
    if label:
        lx = (x1 + x2)/2
        ly = (y1 + y2)/2
        offset_y = 0.14 if label_pos == 'top' else -0.18
        va = 'bottom' if label_pos == 'top' else 'top'
        ax.text(lx, ly + offset_y, label, ha='center', va=va, fontsize=8.5, color=COLOR_TEXT, fontweight='bold', zorder=6)

# ==============================================================================
# 1. Reset Synchronizer Diagram
# ==============================================================================
def gen_rst_sync():
    fig, ax = setup_canvas(10, 4.5)
    
    # Title
    ax.text(5, 4.1, "Reset Synchronizer Architecture (RST_SYNC)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5, 3.75, "Asynchronous Assertion, Synchronous Deassertion (Double Flop Recovery Protection)", ha='center', fontsize=9.5, color=COLOR_MUTED)

    # Flop 1
    f1 = draw_box(ax, 2.8, 1.2, 1.8, 2.0, fill='#EFF6FF', border='#2563EB', title="")
    ax.text(3.7, 2.7, "DFF 1", ha='center', fontsize=10, fontweight='bold', color='#1E40AF')
    ax.text(3.0, 2.1, "D", ha='left', fontsize=9, fontweight='bold')
    ax.text(4.4, 2.1, "Q", ha='right', fontsize=9, fontweight='bold')
    ax.text(3.0, 1.5, "CLK", ha='left', fontsize=8, color=COLOR_MUTED)
    ax.text(3.7, 1.35, "CLR#", ha='center', fontsize=8, color='#DC2626')

    # Flop 2
    f2 = draw_box(ax, 5.6, 1.2, 1.8, 2.0, fill='#EFF6FF', border='#2563EB', title="")
    ax.text(6.5, 2.7, "DFF 2", ha='center', fontsize=10, fontweight='bold', color='#1E40AF')
    ax.text(5.8, 2.1, "D", ha='left', fontsize=9, fontweight='bold')
    ax.text(7.2, 2.1, "Q", ha='right', fontsize=9, fontweight='bold')
    ax.text(5.8, 1.5, "CLK", ha='left', fontsize=8, color=COLOR_MUTED)
    ax.text(6.5, 1.35, "CLR#", ha='center', fontsize=8, color='#DC2626')

    # Inputs & Connections
    # VDD -> D1
    draw_arrow(ax, 1.4, 2.1, 2.8, 2.1, label="1'b1 (VCC)", label_pos='top')
    # Q1 -> D2
    draw_arrow(ax, 4.6, 2.1, 5.6, 2.1, label="q1", label_pos='top')
    # Q2 -> SYNC_RST
    draw_arrow(ax, 7.4, 2.1, 8.8, 2.1, label="SYNC_RST", label_pos='top', color='#059669', lw=2)

    # Clock line
    ax.plot([1.4, 3.0], [0.6, 0.6], color=COLOR_MUTED, lw=1.5)
    ax.plot([3.0, 3.0], [0.6, 1.5], color=COLOR_MUTED, lw=1.5)
    draw_arrow(ax, 3.0, 1.5, 3.0, 1.5)
    ax.plot([3.0, 5.8], [0.6, 0.6], color=COLOR_MUTED, lw=1.5)
    ax.plot([5.8, 5.8], [0.6, 1.5], color=COLOR_MUTED, lw=1.5)
    ax.text(1.3, 0.6, "CLK", ha='right', va='center', fontsize=9, fontweight='bold', color=COLOR_MUTED)

    # Asynch Reset line (Red)
    ax.plot([1.4, 3.7], [0.2, 0.2], color='#DC2626', lw=1.5)
    ax.plot([3.7, 3.7], [0.2, 1.2], color='#DC2626', lw=1.5)
    ax.plot([3.7, 6.5], [0.2, 0.2], color='#DC2626', lw=1.5)
    ax.plot([6.5, 6.5], [0.2, 1.2], color='#DC2626', lw=1.5)
    ax.text(1.3, 0.2, "RST (Async)", ha='right', va='center', fontsize=9, fontweight='bold', color='#DC2626')

    plt.tight_layout()
    plt.savefig('assets/rst_sync_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/rst_sync_diagram.png")

# ==============================================================================
# 2. Integrated Clock Gating (ICG) Diagram
# ==============================================================================
def gen_clk_gate():
    fig, ax = setup_canvas(10, 4.8)
    ax.text(5, 4.4, "Integrated Clock Gating (ICG) Architecture", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5, 4.05, "Negative-Level Latch + AND Gate (Glitch-Free Gating)", ha='center', fontsize=9.5, color=COLOR_MUTED)

    # Outer cell box (TSMC TLATNCAX2M)
    draw_box(ax, 2.2, 1.0, 5.8, 2.6, fill='#FFFBEB', border='#D97706', lw=2)
    ax.text(5.1, 3.3, "TSMC 130nm Cell: TLATNCAX2M", ha='center', fontsize=9, fontweight='bold', color='#B45309')

    # Latch
    draw_box(ax, 2.8, 1.5, 1.8, 1.5, fill='#EFF6FF', border='#2563EB', title="")
    ax.text(3.7, 2.6, "Level Latch", ha='center', fontsize=9, fontweight='bold', color='#1E40AF')
    ax.text(3.0, 2.1, "E", ha='left', fontsize=9, fontweight='bold')
    ax.text(3.0, 1.65, "CK#", ha='left', fontsize=8, color=COLOR_MUTED)
    ax.text(4.4, 2.1, "Q", ha='right', fontsize=9, fontweight='bold')

    # AND Gate representation
    draw_box(ax, 5.8, 1.8, 1.4, 1.1, fill='#F1F5F9', border='#334155', title="AND")

    # Inputs
    draw_arrow(ax, 1.0, 2.1, 2.8, 2.1, label="clk_en", label_pos='top')
    # Clock input
    ax.plot([1.0, 2.8], [1.3, 1.3], color=COLOR_WIRE, lw=1.6)
    ax.plot([2.5, 2.5], [1.3, 1.65], color=COLOR_WIRE, lw=1.6)
    draw_arrow(ax, 2.5, 1.65, 2.8, 1.65)
    ax.plot([2.5, 5.4], [1.3, 1.3], color=COLOR_WIRE, lw=1.6)
    ax.plot([5.4, 5.4], [1.3, 2.05], color=COLOR_WIRE, lw=1.6)
    draw_arrow(ax, 5.4, 2.05, 5.8, 2.05)
    ax.text(0.9, 1.3, "clk", ha='right', va='center', fontsize=9, fontweight='bold')

    # Latch Q to AND input
    draw_arrow(ax, 4.6, 2.1, 5.8, 2.55, label="latch", label_pos='top')

    # Gated clock output
    draw_arrow(ax, 7.2, 2.35, 9.0, 2.35, label="gated_clk", label_pos='top', color='#D97706', lw=2.2)

    # Note
    ax.text(5.1, 0.45, "* Latch transparent when CLK = 0; holds enable state during CLK = 1 to prevent runt pulses.",
            ha='center', fontsize=8.5, style='italic', color=COLOR_MUTED)

    plt.tight_layout()
    plt.savefig('assets/clk_gate_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/clk_gate_diagram.png")

# ==============================================================================
# 3. Pulse Generator Diagram
# ==============================================================================
def gen_pulse_gen():
    fig, ax = setup_canvas(9, 4.2)
    ax.text(4.5, 3.8, "Pulse Generator (Falling Edge Detector)", ha='center', fontsize=13, fontweight='bold', color=COLOR_TEXT)
    ax.text(4.5, 3.45, "Generates Single-Cycle R_INC Pulse on UART_TX Busy Falling Edge", ha='center', fontsize=9, color=COLOR_MUTED)

    # Flip Flop
    draw_box(ax, 2.6, 1.2, 1.6, 1.6, fill='#EFF6FF', border='#2563EB', title="")
    ax.text(3.4, 2.4, "Delay DFF", ha='center', fontsize=9, fontweight='bold', color='#1E40AF')
    ax.text(2.8, 1.8, "D", ha='left', fontsize=9, fontweight='bold')
    ax.text(4.0, 1.8, "Q", ha='right', fontsize=9, fontweight='bold')

    # Inverter
    draw_box(ax, 4.8, 0.7, 1.0, 0.7, fill='#F1F5F9', border='#334155', title="INV")

    # AND Gate
    draw_box(ax, 6.4, 1.2, 1.2, 1.2, fill='#F1F5F9', border='#334155', title="AND")

    # Input LVL_SIG
    ax.plot([0.8, 2.0], [1.8, 1.8], color=COLOR_WIRE, lw=1.6)
    draw_arrow(ax, 2.0, 1.8, 2.6, 1.8)
    ax.plot([2.0, 2.0], [1.8, 1.05], color=COLOR_WIRE, lw=1.6)
    draw_arrow(ax, 2.0, 1.05, 4.8, 1.05)
    ax.text(0.7, 1.8, "LVL_SIG (Busy)", ha='right', va='center', fontsize=9, fontweight='bold')

    # Q to AND input 1
    draw_arrow(ax, 4.2, 1.8, 6.4, 1.8, label="q_reg", label_pos='top')

    # Inv to AND input 2
    draw_arrow(ax, 5.8, 1.05, 6.4, 1.45)

    # Output PULSE_SIG
    draw_arrow(ax, 7.6, 1.8, 8.8, 1.8, label="PULSE_SIG", label_pos='top', color='#059669', lw=2)

    ax.text(4.5, 0.2, "Formula: PULSE_SIG = q_reg & (~LVL_SIG)", ha='center', fontsize=9, fontweight='bold', color='#059669')

    plt.tight_layout()
    plt.savefig('assets/pulse_gen_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/pulse_gen_diagram.png")

# ==============================================================================
# 4. Clock Divider Diagram
# ==============================================================================
def gen_clk_div():
    fig, ax = setup_canvas(10, 5)
    ax.text(5, 4.6, "Configurable Clock Divider Architecture (CLK_DIV)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5, 4.25, "Integer Division with 50% Duty Cycle Output", ha='center', fontsize=9.5, color=COLOR_MUTED)

    # Main block
    draw_box(ax, 2.2, 1.0, 5.6, 2.8, fill='#FAF5FF', border='#7C3AED', lw=2)

    # Internal sub-blocks
    draw_box(ax, 2.6, 1.8, 1.6, 1.4, fill='#FFFFFF', border='#A855F7', title="Counter\n(count[7:0])", title_size=9)
    draw_box(ax, 4.5, 1.8, 1.5, 1.4, fill='#FFFFFF', border='#A855F7', title="Comparator\n& Toggle", title_size=9)
    draw_box(ax, 6.3, 1.8, 1.2, 1.4, fill='#FFFFFF', border='#A855F7', title="Toggle\nFlip-Flop", title_size=9)

    # Internal arrows
    draw_arrow(ax, 4.2, 2.5, 4.5, 2.5)
    draw_arrow(ax, 6.0, 2.5, 6.3, 2.5)

    # Inputs
    draw_arrow(ax, 0.6, 3.2, 2.2, 3.2, label="i_ref_clk", label_pos='top')
    draw_arrow(ax, 0.6, 2.6, 2.2, 2.6, label="i_rst_n", label_pos='top', color='#DC2626')
    draw_arrow(ax, 0.6, 2.0, 2.2, 2.0, label="i_clk_en", label_pos='top')
    draw_arrow(ax, 0.6, 1.4, 2.2, 1.4, label="i_div_ratio", label_pos='top', bus=True, bus_w='8')

    # Output
    draw_arrow(ax, 7.8, 2.5, 9.4, 2.5, label="o_div_clk", label_pos='top', color='#7C3AED', lw=2.2)

    # Duty cycle formula
    ax.text(5, 0.45, "50% Duty Cycle Toggle Condition: count == (i_div_ratio >> 1) - 1",
            ha='center', fontsize=9, fontweight='bold', color='#7C3AED')

    plt.tight_layout()
    plt.savefig('assets/clk_div_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/clk_div_diagram.png")

# ==============================================================================
# 5. ALU Block Diagram
# ==============================================================================
def gen_alu():
    fig, ax = setup_canvas(11, 6)
    ax.text(5.5, 5.6, "16-Bit Arithmetic Logic Unit (ALU)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5.5, 5.25, "14 Arithmetic, Logical, Comparison & Shift Functions with Output Register", ha='center', fontsize=9.5, color=COLOR_MUTED)

    # Main ALU Box
    draw_box(ax, 2.6, 0.8, 5.8, 4.1, fill='#EFF6FF', border='#2563EB', lw=2)

    # Internal sub-blocks
    draw_box(ax, 3.0, 3.3, 2.2, 1.1, fill='#DBEAFE', border='#3B82F6', title="Arithmetic Core\n(Add, Sub, Mult, Div)", title_size=8.5)
    draw_box(ax, 3.0, 2.1, 2.2, 1.0, fill='#DBEAFE', border='#3B82F6', title="Bitwise Logic Core\n(AND, OR, XOR, etc.)", title_size=8.5)
    draw_box(ax, 3.0, 1.0, 2.2, 0.9, fill='#DBEAFE', border='#3B82F6', title="CMP & Shift Core\n(A=B, A>B, <<, >>)", title_size=8.5)

    # 16-to-1 MUX
    draw_box(ax, 5.7, 1.5, 1.0, 2.8, fill='#F1F5F9', border='#334155', title="MUX\n(16:1)", title_size=9)
    # Output Register
    draw_box(ax, 7.1, 2.1, 1.0, 1.5, fill='#EFF6FF', border='#2563EB', title="ALU_OUT\nReg [15:0]", title_size=8)

    # Connections to MUX
    draw_arrow(ax, 5.2, 3.8, 5.7, 3.8)
    draw_arrow(ax, 5.2, 2.6, 5.7, 2.6)
    draw_arrow(ax, 5.2, 1.45, 5.7, 1.45)
    # MUX to Reg
    draw_arrow(ax, 6.7, 2.8, 7.1, 2.8, bus=True, bus_w='16')

    # ALU inputs
    draw_arrow(ax, 0.8, 4.3, 2.6, 4.3, label="A [7:0] (REG0)", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 0.8, 3.6, 2.6, 3.6, label="B [7:0] (REG1)", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 0.8, 2.9, 2.6, 2.9, label="ALU_FUN [3:0]", label_pos='top', bus=True, bus_w='4')
    draw_arrow(ax, 0.8, 2.2, 2.6, 2.2, label="EN (Enable)", label_pos='top')
    draw_arrow(ax, 0.8, 1.5, 2.6, 1.5, label="CLK (GATED_CLK)", label_pos='top', color='#D97706')
    draw_arrow(ax, 0.8, 0.9, 2.6, 0.9, label="RST (Active Low)", label_pos='top', color='#DC2626')

    # ALU outputs
    draw_arrow(ax, 8.1, 2.8, 10.2, 2.8, label="ALU_OUT [15:0]", label_pos='top', color='#2563EB', lw=2.2, bus=True, bus_w='16')
    draw_arrow(ax, 8.4, 1.8, 10.2, 1.8, label="OUT_VALID", label_pos='top', color='#059669', lw=1.8)

    plt.tight_layout()
    plt.savefig('assets/alu_block_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/alu_block_diagram.png")

# ==============================================================================
# 6. Register File Diagram
# ==============================================================================
def gen_regfile():
    fig, ax = setup_canvas(11, 6.2)
    ax.text(5.5, 5.8, "Register File Architecture (16 x 8-Bit)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5.5, 5.45, "Memory Mapped Host Access with Dedicated Hardware Configuration Taps", ha='center', fontsize=9.5, color=COLOR_MUTED)

    # Main Box
    draw_box(ax, 2.8, 0.6, 5.4, 4.5, fill='#EFF6FF', border='#2563EB', lw=2)

    # Internal Memory Array visual
    draw_box(ax, 3.2, 1.0, 4.6, 3.8, fill='#FFFFFF', border='#93C5FD', title="")
    ax.text(5.5, 4.5, "16 × 8-Bit Internal Register Bank", ha='center', fontsize=9.5, fontweight='bold', color='#1E40AF')

    # Reserved Registers
    draw_box(ax, 3.5, 3.6, 4.0, 0.6, fill='#FEF3C7', border='#F59E0B', title="REG0 (0x0) : ALU Operand A [7:0]", title_size=8.5)
    draw_box(ax, 3.5, 2.9, 4.0, 0.6, fill='#FEF3C7', border='#F59E0B', title="REG1 (0x1) : ALU Operand B [7:0]", title_size=8.5)
    draw_box(ax, 3.5, 2.2, 4.0, 0.6, fill='#EDE9FE', border='#8B5CF6', title="REG2 (0x2) : UART Config [Prescale, Parity]", title_size=8.5)
    draw_box(ax, 3.5, 1.5, 4.0, 0.6, fill='#EDE9FE', border='#8B5CF6', title="REG3 (0x3) : Clock Division Ratio [7:0]", title_size=8.5)
    ax.text(5.5, 1.2, "... REG4 - REG15 (0x4 - 0xF) : General Purpose Registers ...", ha='center', fontsize=7.5, color=COLOR_MUTED)

    # Inputs (from SYS_CTRL)
    draw_arrow(ax, 0.8, 4.6, 2.8, 4.6, label="Address [3:0]", label_pos='top', bus=True, bus_w='4')
    draw_arrow(ax, 0.8, 3.9, 2.8, 3.9, label="WrData [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 0.8, 3.2, 2.8, 3.2, label="WrEn", label_pos='top')
    draw_arrow(ax, 0.8, 2.5, 2.8, 2.5, label="RdEn", label_pos='top')
    draw_arrow(ax, 0.8, 1.8, 2.8, 1.8, label="CLK (REF_CLK)", label_pos='top')
    draw_arrow(ax, 0.8, 1.1, 2.8, 1.1, label="RST (Active Low)", label_pos='top', color='#DC2626')

    # Read Outputs (to SYS_CTRL)
    draw_arrow(ax, 8.2, 4.4, 10.2, 4.4, label="RdData [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 8.2, 3.8, 10.2, 3.8, label="RdData_Valid", label_pos='top')

    # Dedicated Hardware Taps
    draw_arrow(ax, 8.2, 3.2, 10.2, 3.2, label="REG0 -> ALU (Op A)", label_pos='top', color='#D97706', bus=True, bus_w='8')
    draw_arrow(ax, 8.2, 2.6, 10.2, 2.6, label="REG1 -> ALU (Op B)", label_pos='top', color='#D97706', bus=True, bus_w='8')
    draw_arrow(ax, 8.2, 2.0, 10.2, 2.0, label="REG2 -> UART / Prescale", label_pos='top', color='#7C3AED', bus=True, bus_w='8')
    draw_arrow(ax, 8.2, 1.4, 10.2, 1.4, label="REG3 -> TX_CLK_DIV", label_pos='top', color='#7C3AED', bus=True, bus_w='8')

    plt.tight_layout()
    plt.savefig('assets/regfile_block_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/regfile_block_diagram.png")

# ==============================================================================
# 7. UART Transmitter Diagram
# ==============================================================================
def gen_uart_tx():
    fig, ax = setup_canvas(11, 5.5)
    ax.text(5.5, 5.1, "UART Transmitter Subsystem (UART_TX)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5.5, 4.75, "FSM Sequenced Parallel-to-Serial Frame Generator", ha='center', fontsize=9.5, color=COLOR_MUTED)

    draw_box(ax, 2.2, 0.8, 6.6, 3.6, fill='#FAF5FF', border='#7C3AED', lw=2)

    # Submodules
    draw_box(ax, 2.6, 1.2, 1.8, 2.8, fill='#FFFFFF', border='#A855F7', title="FSM_TX\n(Sequencer)", title_size=9)
    draw_box(ax, 4.8, 2.6, 1.8, 1.4, fill='#FFFFFF', border='#A855F7', title="Serializer\n(P to S Shift)", title_size=9)
    draw_box(ax, 4.8, 1.0, 1.8, 1.3, fill='#FFFFFF', border='#A855F7', title="Parity_Calc\n(Even / Odd)", title_size=9)
    draw_box(ax, 7.2, 1.6, 1.2, 2.2, fill='#F1F5F9', border='#334155', title="Output\nMUX", title_size=9)

    # Internal wiring
    draw_arrow(ax, 4.4, 3.3, 4.8, 3.3)
    draw_arrow(ax, 4.4, 1.6, 4.8, 1.6)
    draw_arrow(ax, 6.6, 3.3, 7.2, 3.3, label="ser_data", label_pos='top')
    draw_arrow(ax, 6.6, 1.6, 7.2, 2.1, label="par_bit", label_pos='top')

    # Inputs
    draw_arrow(ax, 0.6, 3.8, 2.2, 3.8, label="P_DATA [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 0.6, 3.1, 2.2, 3.1, label="DATA_VALID", label_pos='top')
    draw_arrow(ax, 0.6, 2.4, 2.2, 2.4, label="PAR_EN", label_pos='top')
    draw_arrow(ax, 0.6, 1.7, 2.2, 1.7, label="PAR_TYP", label_pos='top')
    draw_arrow(ax, 0.6, 1.0, 2.2, 1.0, label="CLK (TX_CLK)", label_pos='top')

    # Outputs
    draw_arrow(ax, 8.4, 2.7, 10.4, 2.7, label="TX_OUT (S_DATA)", label_pos='top', color='#7C3AED', lw=2.2)
    draw_arrow(ax, 4.4, 2.1, 10.4, 1.2, label="Busy Flag", label_pos='top', color='#DC2626', lw=1.8)

    plt.tight_layout()
    plt.savefig('assets/uart_tx_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/uart_tx_diagram.png")

# ==============================================================================
# 8. UART Receiver Diagram
# ==============================================================================
def gen_uart_rx():
    fig, ax = setup_canvas(11.5, 6)
    ax.text(5.75, 5.6, "UART Receiver Subsystem (UART_RX)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5.75, 5.25, "Oversampling Majority-Voting Serial-to-Parallel Frame Decoder", ha='center', fontsize=9.5, color=COLOR_MUTED)

    draw_box(ax, 2.2, 0.6, 7.0, 4.3, fill='#FAF5FF', border='#7C3AED', lw=2)

    # Submodules
    draw_box(ax, 2.6, 2.7, 1.8, 1.8, fill='#FFFFFF', border='#A855F7', title="data_sampling\n(3-Sample\nMajority Vote)", title_size=8.5)
    draw_box(ax, 2.6, 0.9, 1.8, 1.5, fill='#FFFFFF', border='#A855F7', title="edge_bit_counter\n(Edge & Bit\nTracking)", title_size=8.5)
    draw_box(ax, 5.0, 2.9, 1.8, 1.6, fill='#FFFFFF', border='#A855F7', title="deserializer\n(S to P Shift)", title_size=9)
    draw_box(ax, 5.0, 0.9, 1.8, 1.7, fill='#FFFFFF', border='#A855F7', title="FSM_RX\n(State Controller)", title_size=9)
    draw_box(ax, 7.3, 3.2, 1.6, 1.2, fill='#FFFFFF', border='#A855F7', title="parity_checker", title_size=8.5)
    draw_box(ax, 7.3, 1.8, 1.6, 1.1, fill='#FFFFFF', border='#A855F7', title="stop_checker", title_size=8.5)
    draw_box(ax, 7.3, 0.8, 1.6, 0.8, fill='#FFFFFF', border='#A855F7', title="strt_checker", title_size=8.5)

    # Inputs
    draw_arrow(ax, 0.6, 3.8, 2.6, 3.8, label="RX_IN (Serial)", label_pos='top')
    draw_arrow(ax, 0.6, 2.4, 2.2, 2.4, label="Prescale [5:0]", label_pos='top', bus=True, bus_w='6')
    draw_arrow(ax, 0.6, 1.7, 2.2, 1.7, label="PAR_EN / TYP", label_pos='top')
    draw_arrow(ax, 0.6, 1.0, 2.2, 1.0, label="CLK (RX_CLK)", label_pos='top')

    # Internal arrows
    draw_arrow(ax, 4.4, 3.6, 5.0, 3.6)
    draw_arrow(ax, 4.4, 1.6, 5.0, 1.6)

    # Outputs
    draw_arrow(ax, 6.8, 3.7, 10.8, 3.7, label="P_DATA [7:0]", label_pos='top', bus=True, bus_w='8', color='#7C3AED', lw=2)
    draw_arrow(ax, 6.8, 1.7, 10.8, 1.7, label="DATA_VLD", label_pos='top', color='#059669', lw=1.8)
    draw_arrow(ax, 8.9, 3.8, 10.8, 4.5, label="PAR_ERR", label_pos='top', color='#DC2626')
    draw_arrow(ax, 8.9, 2.3, 10.8, 2.6, label="STP_ERR", label_pos='top', color='#DC2626')

    plt.tight_layout()
    plt.savefig('assets/uart_rx_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/uart_rx_diagram.png")

# ==============================================================================
# 9. Asynchronous FIFO Diagram
# ==============================================================================
def gen_async_fifo():
    fig, ax = setup_canvas(12, 6.5)
    ax.text(6, 6.0, "Dual-Clock Asynchronous FIFO Architecture (8 Words × 8-Bit)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(6, 5.65, "Gray Pointer Crossing via 2-Stage Synchronizers for Metastability-Free Transfer", ha='center', fontsize=9.5, color=COLOR_MUTED)

    # Dual-port RAM (Center)
    draw_box(ax, 4.6, 1.8, 2.8, 3.2, fill='#FEF3C7', border='#D97706', lw=2)
    ax.text(6.0, 3.6, "Dual-Port RAM\n(8 Words × 8-Bit)", ha='center', fontsize=10, fontweight='bold', color='#B45309')
    ax.text(6.0, 2.7, "wdata [7:0] -> mem -> rdata [7:0]", ha='center', fontsize=8, color=COLOR_MUTED)

    # Write Domain (Left)
    draw_box(ax, 1.6, 1.2, 2.4, 4.0, fill='#EFF6FF', border='#2563EB', title="")
    ax.text(2.8, 4.8, "WRITE DOMAIN\n(REF_CLK)", ha='center', fontsize=9, fontweight='bold', color='#1E40AF')
    draw_box(ax, 1.8, 3.2, 2.0, 1.2, fill='#DBEAFE', border='#3B82F6', title="FIFO_WR\n(wptr_bin & gray)", title_size=8)
    draw_box(ax, 1.8, 1.5, 2.0, 1.2, fill='#F0FDF4', border='#059669', title="2-Flop Sync\n(rptr -> wclk)", title_size=8)

    # Read Domain (Right)
    draw_box(ax, 8.0, 1.2, 2.4, 4.0, fill='#FAF5FF', border='#7C3AED', title="")
    ax.text(9.2, 4.8, "READ DOMAIN\n(UART_CLK)", ha='center', fontsize=9, fontweight='bold', color='#7C3AED')
    draw_box(ax, 8.2, 3.2, 2.0, 1.2, fill='#EDE9FE', border='#8B5CF6', title="FIFO_RD\n(rptr_bin & gray)", title_size=8)
    draw_box(ax, 8.2, 1.5, 2.0, 1.2, fill='#F0FDF4', border='#059669', title="2-Flop Sync\n(wptr -> rclk)", title_size=8)

    # Inputs (Write domain)
    draw_arrow(ax, 0.2, 4.2, 1.6, 4.2, label="W_INC", label_pos='top')
    draw_arrow(ax, 0.2, 3.5, 4.6, 3.5, label="WR_DATA [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 0.2, 2.8, 1.6, 2.8, label="W_CLK (REF_CLK)", label_pos='top')
    draw_arrow(ax, 0.2, 2.1, 1.6, 2.1, label="W_RST (Active Low)", label_pos='top', color='#DC2626')

    # Flag outputs
    draw_arrow(ax, 1.8, 4.0, 0.2, 4.0, label="FULL Flag", label_pos='top', color='#DC2626')
    draw_arrow(ax, 10.2, 4.0, 11.8, 4.0, label="EMPTY Flag", label_pos='top', color='#DC2626')

    # Outputs (Read domain)
    draw_arrow(ax, 11.8, 3.2, 10.4, 3.2, label="R_INC", label_pos='top')
    draw_arrow(ax, 11.8, 2.5, 10.4, 2.5, label="R_CLK (UART_TX)", label_pos='top')
    draw_arrow(ax, 7.4, 3.5, 11.8, 3.5, label="RD_DATA [7:0]", label_pos='top', bus=True, bus_w='8', color='#7C3AED', lw=2)

    # Cross synchronizer lines
    ax.annotate('', xy=(8.2, 2.1), xytext=(3.8, 3.6),
                arrowprops=dict(arrowstyle="->", color='#059669', lw=1.5, ls='--'))
    ax.text(6.0, 1.2, "Gray W_PTR -> Sync -> R_CLK", ha='center', fontsize=8, color='#059669')

    ax.annotate('', xy=(3.8, 2.1), xytext=(8.2, 3.6),
                arrowprops=dict(arrowstyle="->", color='#059669', lw=1.5, ls='--'))
    ax.text(6.0, 0.7, "Gray R_PTR -> Sync -> W_CLK", ha='center', fontsize=8, color='#059669')

    plt.tight_layout()
    plt.savefig('assets/async_fifo_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/async_fifo_diagram.png")

# ==============================================================================
# 10. Multi-bit Data Synchronizer (DATA_SYNC)
# ==============================================================================
def gen_data_sync():
    fig, ax = setup_canvas(10.5, 4.8)
    ax.text(5.25, 4.4, "Multi-Bit Data Synchronizer (DATA_SYNC)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5.25, 4.05, "Pulse Handshake Coordination Preventing Bus Skew Metastability", ha='center', fontsize=9.5, color=COLOR_MUTED)

    draw_box(ax, 2.2, 0.8, 6.2, 2.8, fill='#F0FDF4', border='#059669', lw=2)

    # Internal elements
    draw_box(ax, 2.6, 2.2, 2.2, 1.1, fill='#FFFFFF', border='#10B981', title="2-Flop Sync\n(bus_enable)", title_size=8.5)
    draw_box(ax, 5.2, 2.2, 1.6, 1.1, fill='#FFFFFF', border='#10B981', title="Pulse Gen\n(enable_pulse)", title_size=8.5)
    draw_box(ax, 3.5, 1.0, 3.8, 0.9, fill='#EFF6FF', border='#3B82F6', title="Multi-Bit Holding Register (8-Bit)", title_size=8.5)

    # Connections
    draw_arrow(ax, 0.6, 2.7, 2.6, 2.7, label="bus_enable", label_pos='top')
    draw_arrow(ax, 0.6, 1.45, 3.5, 1.45, label="unsync_bus [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 4.8, 2.75, 5.2, 2.75)
    draw_arrow(ax, 6.8, 2.75, 9.8, 2.75, label="enable_pulse_d", label_pos='top', color='#059669')
    draw_arrow(ax, 7.3, 1.45, 9.8, 1.45, label="sync_bus [7:0]", label_pos='top', bus=True, bus_w='8', color='#2563EB', lw=2)

    # Enable line from pulse gen to holding reg
    ax.plot([6.0, 6.0], [2.2, 1.9], color='#059669', lw=1.5)
    draw_arrow(ax, 6.0, 1.9, 6.0, 1.9)

    plt.tight_layout()
    plt.savefig('assets/data_sync_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/data_sync_diagram.png")

# ==============================================================================
# 11. System Controller (SYS_CTRL) Diagram
# ==============================================================================
def gen_sys_ctrl():
    fig, ax = setup_canvas(11.5, 6.5)
    ax.text(5.75, 6.1, "System Controller FSM & Master Interconnect (SYS_CTRL)", ha='center', fontsize=14, fontweight='bold', color=COLOR_TEXT)
    ax.text(5.75, 5.75, "Finite State Machine Command Interpreter & Execution Orchestrator", ha='center', fontsize=9.5, color=COLOR_MUTED)

    draw_box(ax, 2.6, 0.6, 6.0, 4.8, fill='#EFF6FF', border='#2563EB', lw=2)

    # Central FSM
    draw_box(ax, 3.2, 1.2, 4.8, 3.6, fill='#FFFFFF', border='#93C5FD', title="")
    ax.text(5.6, 4.4, "Master FSM Controller", ha='center', fontsize=11, fontweight='bold', color='#1E40AF')

    # State Flow Bubble Boxes
    draw_box(ax, 3.6, 3.5, 1.8, 0.6, fill='#DBEAFE', border='#3B82F6', title="IDLE (Wait Vld)", title_size=8)
    draw_box(ax, 5.8, 3.5, 1.8, 0.6, fill='#DBEAFE', border='#3B82F6', title="CMD_DECODE", title_size=8)
    draw_box(ax, 3.6, 2.5, 1.8, 0.6, fill='#FEF3C7', border='#F59E0B', title="RF_WR / RD", title_size=8)
    draw_box(ax, 5.8, 2.5, 1.8, 0.6, fill='#FEF3C7', border='#F59E0B', title="ALU_OP (A, B, FUN)", title_size=8)
    draw_box(ax, 4.7, 1.5, 2.0, 0.6, fill='#F0FDF4', border='#10B981', title="FIFO_WR (Result)", title_size=8)

    # Connections between states
    draw_arrow(ax, 5.4, 3.8, 5.8, 3.8)
    draw_arrow(ax, 6.7, 3.5, 6.7, 3.1)
    draw_arrow(ax, 4.5, 3.5, 4.5, 3.1)
    draw_arrow(ax, 5.8, 2.5, 5.7, 2.1)
    draw_arrow(ax, 4.5, 2.5, 4.7, 2.1)

    # Left Inputs (UART RX through DATA_SYNC)
    draw_arrow(ax, 0.6, 4.5, 2.6, 4.5, label="RX_P_DATA [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 0.6, 3.7, 2.6, 3.7, label="RX_D_VLD", label_pos='top')
    draw_arrow(ax, 0.6, 2.9, 2.6, 2.9, label="CLK (REF_CLK)", label_pos='top')
    draw_arrow(ax, 0.6, 2.1, 2.6, 2.1, label="RST (Active Low)", label_pos='top', color='#DC2626')
    draw_arrow(ax, 0.6, 1.3, 2.6, 1.3, label="FIFO_FULL", label_pos='top', color='#DC2626')

    # Right Outputs
    # RegFile outputs
    draw_arrow(ax, 8.6, 4.8, 10.8, 4.8, label="Address [3:0] / WrEn / RdEn", label_pos='top', bus=True, bus_w='4')
    draw_arrow(ax, 8.6, 4.0, 10.8, 4.0, label="WrData [7:0] -> RegFile", label_pos='top', bus=True, bus_w='8')
    # ALU outputs
    draw_arrow(ax, 8.6, 3.2, 10.8, 3.2, label="ALU_FUN [3:0] / ALU_EN", label_pos='top', bus=True, bus_w='4', color='#D97706')
    draw_arrow(ax, 8.6, 2.4, 10.8, 2.4, label="CLK_EN -> CLK_GATE", label_pos='top', color='#D97706')
    # FIFO outputs
    draw_arrow(ax, 8.6, 1.6, 10.8, 1.6, label="TX_P_DATA [7:0] -> FIFO", label_pos='top', bus=True, bus_w='8', color='#7C3AED')
    draw_arrow(ax, 8.6, 0.9, 10.8, 0.9, label="TX_D_VLD (W_INC)", label_pos='top', color='#7C3AED')

    plt.tight_layout()
    plt.savefig('assets/sys_ctrl_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/sys_ctrl_diagram.png")

# ==============================================================================
# 12. System Top-Level Block Diagram
# ==============================================================================
def gen_system_top():
    fig, ax = setup_canvas(14, 8)
    ax.text(7, 7.6, "System-on-Chip Top-Level Interconnect & Clock Domain Architecture", ha='center', fontsize=15, fontweight='bold', color=COLOR_TEXT)
    ax.text(7, 7.25, "Dual-Clock Domain Architecture with Integrated Clock Gating and Hardware Flow Control", ha='center', fontsize=10, color=COLOR_MUTED)

    # 1. UART Clock Domain (Left)
    draw_box(ax, 0.8, 0.8, 3.8, 6.0, fill='#FAF5FF', border='#7C3AED', lw=2)
    ax.text(2.7, 6.5, "UART DOMAIN (3.6864 MHz)", ha='center', fontsize=10.5, fontweight='bold', color='#7C3AED')
    draw_box(ax, 1.2, 5.0, 3.0, 1.1, fill='#FFFFFF', border='#A855F7', title="UART_RX\n(Receiver)", title_size=9)
    draw_box(ax, 1.2, 3.6, 3.0, 1.1, fill='#FFFFFF', border='#A855F7', title="UART_TX\n(Transmitter)", title_size=9)
    draw_box(ax, 1.2, 2.3, 1.4, 0.9, fill='#FFFFFF', border='#A855F7', title="RX_CLK_DIV", title_size=8)
    draw_box(ax, 2.8, 2.3, 1.4, 0.9, fill='#FFFFFF', border='#A855F7', title="TX_CLK_DIV", title_size=8)
    draw_box(ax, 1.2, 1.1, 1.4, 0.9, fill='#FFFFFF', border='#A855F7', title="prescale_mux", title_size=7.5)
    draw_box(ax, 2.8, 1.1, 1.4, 0.9, fill='#FFFFFF', border='#A855F7', title="Pulse_Gen", title_size=8)

    # 2. CDC Interface (Middle)
    draw_box(ax, 5.0, 0.8, 2.8, 6.0, fill='#F0FDF4', border='#059669', lw=2)
    ax.text(6.4, 6.5, "CDC INTERFACE", ha='center', fontsize=10.5, fontweight='bold', color='#059669')
    draw_box(ax, 5.3, 4.4, 2.2, 1.5, fill='#FFFFFF', border='#10B981', title="DATA_SYNC\n(Multi-Bit Handshake\nSynchronizer)", title_size=8.5)
    draw_box(ax, 5.3, 1.6, 2.2, 2.0, fill='#FFFFFF', border='#10B981', title="ASYNC_FIFO\n(8 Words × 8-Bit\nDual Clock FIFO)", title_size=8.5)

    # 3. REF Clock Domain (Right)
    draw_box(ax, 8.2, 0.8, 5.0, 6.0, fill='#EFF6FF', border='#2563EB', lw=2)
    ax.text(10.7, 6.5, "REFERENCE DOMAIN (50 MHz)", ha='center', fontsize=10.5, fontweight='bold', color='#2563EB')
    draw_box(ax, 8.5, 4.4, 4.4, 1.5, fill='#FFFFFF', border='#3B82F6', title="SYS_CTRL\n(Master FSM Controller)", title_size=9.5)
    draw_box(ax, 8.5, 2.6, 2.2, 1.5, fill='#FFFFFF', border='#3B82F6', title="Register File\n(16 × 8-Bit)", title_size=9)
    draw_box(ax, 11.0, 2.6, 1.9, 1.5, fill='#FFFFFF', border='#3B82F6', title="ALU (16-Bit)\n(Arithmetic / Logic)", title_size=8.5)
    draw_box(ax, 11.0, 1.2, 1.9, 0.9, fill='#FFFBEB', border='#D97706', title="CLK_GATE\n(TLATNCAX2M)", title_size=8)
    draw_box(ax, 8.5, 1.2, 2.2, 0.9, fill='#EFF6FF', border='#3B82F6', title="RST_SYNC_1", title_size=8)

    # Top-Level External I/O Arrows
    # RX_IN
    draw_arrow(ax, 0.1, 5.5, 1.2, 5.5, label="RX_IN", label_pos='top', lw=2)
    # TX_OUT
    draw_arrow(ax, 4.2, 4.1, 0.1, 4.1, label="TX_OUT", label_pos='top', color='#7C3AED', lw=2)
    # Errors
    draw_arrow(ax, 4.2, 5.2, 0.1, 5.2, label="parity_error / framing_error", label_pos='top', color='#DC2626')

    # Domain Crossings
    # UART_RX -> DATA_SYNC -> SYS_CTRL
    draw_arrow(ax, 4.2, 5.0, 5.3, 5.0, label="RX_OUT_P", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 7.5, 5.0, 8.5, 5.0, label="sync_bus", label_pos='top', bus=True, bus_w='8')

    # SYS_CTRL -> ASYNC_FIFO -> UART_TX
    draw_arrow(ax, 8.5, 4.6, 7.5, 3.2, label="WR_DATA", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 5.3, 2.8, 4.2, 3.8, label="FIFO_RDATA", label_pos='top', bus=True, bus_w='8')
    draw_arrow(ax, 4.2, 3.6, 3.5, 2.0, label="Busy", label_pos='top')
    draw_arrow(ax, 3.5, 2.0, 5.3, 2.0, label="R_INC Pulse", label_pos='top')

    # REF Domain Internal
    draw_arrow(ax, 9.6, 4.4, 9.6, 4.1, label="Addr / WrEn", label_pos='top')
    draw_arrow(ax, 11.5, 4.4, 11.5, 4.1, label="ALU_EN", label_pos='top')
    draw_arrow(ax, 11.9, 2.1, 11.9, 2.6, label="gated_clk", label_pos='top', color='#D97706')

    # Config lines to UART domain
    ax.plot([9.6, 9.6], [2.6, 0.4], color='#7C3AED', lw=1.2, ls=':')
    ax.plot([9.6, 2.8], [0.4, 0.4], color='#7C3AED', lw=1.2, ls=':')
    ax.plot([2.8, 2.8], [0.4, 2.3], color='#7C3AED', lw=1.2, ls=':')
    ax.text(6.0, 0.25, "REG2 / REG3 Configuration Feedback", ha='center', fontsize=8, color='#7C3AED', fontweight='bold')

    plt.tight_layout()
    plt.savefig('assets/system_top_block_diagram.png', dpi=200, bbox_inches='tight')
    plt.close()
    print("Generated assets/system_top_block_diagram.png")

if __name__ == '__main__':
    print("Starting generation of modern schematics...")
    gen_rst_sync()
    gen_clk_gate()
    gen_pulse_gen()
    gen_clk_div()
    gen_alu()
    gen_regfile()
    gen_uart_tx()
    gen_uart_rx()
    gen_async_fifo()
    gen_data_sync()
    gen_sys_ctrl()
    gen_system_top()
    print("All 12 modern diagrams generated successfully!")
