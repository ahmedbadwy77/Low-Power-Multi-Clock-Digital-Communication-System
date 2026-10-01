import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.path import Path
import numpy as np
import os

os.makedirs('assets', exist_ok=True)

# Styling Constants
FONT_NAME = 'DejaVu Sans'
C_BG = '#FFFFFF'
C_TEXT = '#0F172A'
C_MUTED = '#64748B'
C_WIRE = '#1E293B'
C_BUS = '#0F172A'
C_CLK = '#D97706'        # Amber for clocks
C_RST = '#DC2626'        # Red for resets
C_DATA = '#2563EB'       # Blue for data
C_SYNC = '#059669'       # Emerald for synchronizers
C_CTRL = '#7C3AED'       # Purple for control

def create_canvas(w=12, h=7, dpi=220):
    fig, ax = plt.subplots(figsize=(w, h), dpi=dpi)
    fig.patch.set_facecolor(C_BG)
    ax.set_facecolor(C_BG)
    ax.set_xlim(0, w)
    ax.set_ylim(0, h)
    ax.axis('off')
    return fig, ax

def draw_header(ax, x, y, title, subtitle):
    ax.text(x, y, title, ha='center', va='bottom', fontsize=14, fontweight='bold', color=C_TEXT)
    ax.text(x, y - 0.35, subtitle, ha='center', va='top', fontsize=9.5, color=C_MUTED)

def draw_wire(ax, points, color=C_WIRE, lw=1.6, ls='-', bus=False, bus_w=''):
    xs = [p[0] for p in points]
    ys = [p[1] for p in points]
    ax.plot(xs, ys, color=color, lw=lw, ls=ls, zorder=3)
    if bus and len(points) >= 2:
        mx = (points[-2][0] + points[-1][0]) / 2
        my = (points[-2][1] + points[-1][1]) / 2
        ax.plot([mx - 0.08, mx + 0.08], [my - 0.12, my + 0.12], color=color, lw=lw, zorder=4)
        if bus_w:
            ax.text(mx + 0.05, my + 0.12, bus_w, fontsize=8, color=color, fontweight='bold', zorder=5)

def draw_arrow_pin(ax, x1, y1, x2, y2, label='', label_pos='top', color=C_WIRE, lw=1.6, bus=False, bus_w=''):
    ax.annotate('', xy=(x2, y2), xytext=(x1, y1),
                arrowprops=dict(arrowstyle="->,head_length=0.35,head_width=0.25",
                                color=color, lw=lw, shrinkA=0, shrinkB=0),
                zorder=4)
    if bus:
        mx, my = (x1 + x2)/2, (y1 + y2)/2
        ax.plot([mx - 0.08, mx + 0.08], [my - 0.12, my + 0.12], color=color, lw=lw, zorder=5)
        if bus_w:
            ax.text(mx + 0.05, my + 0.12, bus_w, fontsize=8, color=color, fontweight='bold', zorder=6)
    if label:
        lx, ly = (x1 + x2)/2, (y1 + y2)/2
        offset_y = 0.14 if label_pos == 'top' else -0.18
        va = 'bottom' if label_pos == 'top' else 'top'
        ax.text(lx, ly + offset_y, label, ha='center', va=va, fontsize=8.5, color=C_TEXT, fontweight='bold', zorder=6)
def draw_box(ax, x, y, w, h, title='', fill='#F8FAFC', border='#334155', 
             radius=0.12, lw=1.8, title_color=C_TEXT, title_size=10, bold=True):
    box = patches.FancyBboxPatch((x, y), w, h, boxstyle=f"round,pad=0.02,rounding_size={radius}",
                                 facecolor=fill, edgecolor=border, linewidth=lw, zorder=2)
    ax.add_patch(box)
    if title:
        weight = 'bold' if bold else 'normal'
        ax.text(x + w/2, y + h/2, title, ha='center', va='center',
                fontsize=title_size, fontweight=weight, color=title_color, zorder=3)
    return box

def draw_dff(ax, x, y, w=1.6, h=2.2, label="DFF", fill='#EFF6FF', border='#2563EB'):
    # Main Box
    box = patches.FancyBboxPatch((x, y), w, h, boxstyle="round,pad=0.02,rounding_size=0.08",
                                 facecolor=fill, edgecolor=border, lw=1.8, zorder=2)
    ax.add_patch(box)
    ax.text(x + w/2, y + h*0.82, label, ha='center', va='center', fontsize=9.5, fontweight='bold', color=border)
    # Pins text
    ax.text(x + 0.2, y + h*0.62, "D", ha='left', va='center', fontsize=9, fontweight='bold')
    ax.text(x + w - 0.2, y + h*0.62, "Q", ha='right', va='center', fontsize=9, fontweight='bold')
    # Clock triangle (chevron <)
    cy = y + h*0.28
    ax.plot([x, x + 0.25, x], [cy + 0.15, cy, cy - 0.15], color=border, lw=1.6, zorder=3)
    # Reset pin bubble
    rx = x + w/2
    circle = patches.Circle((rx, y - 0.1), 0.1, facecolor='#FFFFFF', edgecolor='#DC2626', lw=1.5, zorder=3)
    ax.add_patch(circle)
    ax.text(rx, y + 0.22, "CLR#", ha='center', va='center', fontsize=7.5, fontweight='bold', color='#DC2626')

def draw_and_gate(ax, x, y, w=1.5, h=1.4, fill='#F8FAFC', border='#334155'):
    # Standard IEEE AND Gate: flat back, straight top/bottom, curved front
    p1 = (x, y)
    p2 = (x + w*0.5, y)
    p3 = (x + w, y + h*0.5)
    p4 = (x + w*0.5, y + h)
    p5 = (x, y + h)
    verts = [p1, p2, (x+w, y), p3, (x+w, y+h), p4, p5, p1]
    codes = [Path.MOVETO, Path.LINETO, Path.CURVE3, Path.CURVE3, Path.CURVE3, Path.CURVE3, Path.LINETO, Path.CLOSEPOLY]
    path = Path(verts, codes)
    patch = patches.PathPatch(path, facecolor=fill, edgecolor=border, lw=1.8, zorder=2)
    ax.add_patch(patch)
    ax.text(x + w*0.35, y + h*0.5, "&", ha='center', va='center', fontsize=12, fontweight='bold', color=border)

def draw_inv_gate(ax, x, y, w=1.2, h=1.0, fill='#F8FAFC', border='#334155'):
    # Triangle + Bubble
    poly = patches.Polygon([(x, y), (x + w*0.8, y + h/2), (x, y + h)], facecolor=fill, edgecolor=border, lw=1.8, zorder=2)
    ax.add_patch(poly)
    bubble = patches.Circle((x + w*0.8 + 0.1, y + h/2), 0.1, facecolor='#FFFFFF', edgecolor=border, lw=1.6, zorder=3)
    ax.add_patch(bubble)

def draw_mux_trapezoid(ax, x, y, w=1.2, h=2.8, fill='#FEF3C7', border='#D97706', label="MUX"):
    # Classic MUX trapezoid: Taller on left, narrower on right
    poly = patches.Polygon([(x, y), (x + w, y + h*0.2), (x + w, y + h*0.8), (x, y + h)],
                           facecolor=fill, edgecolor=border, lw=1.8, zorder=2)
    ax.add_patch(poly)
    ax.text(x + w*0.45, y + h/2, label, ha='center', va='center', fontsize=9.5, fontweight='bold', color=border)

def draw_alu_symbol(ax, x, y, w=3.6, h=3.0, fill='#EFF6FF', border='#2563EB'):
    # Classic IEEE ALU symbol with center V-notch
    v = [
        (x, y + h),                 # Top Left
        (x + w*0.4, y + h),         # Notch left
        (x + w*0.5, y + h*0.72),    # Notch bottom
        (x + w*0.6, y + h),         # Notch right
        (x + w, y + h),             # Top Right
        (x + w*0.8, y),             # Bottom Right
        (x + w*0.2, y)              # Bottom Left
    ]
    poly = patches.Polygon(v, facecolor=fill, edgecolor=border, lw=2.0, zorder=2)
    ax.add_patch(poly)
    ax.text(x + w*0.5, y + h*0.35, "16-BIT ALU", ha='center', va='center', fontsize=11, fontweight='bold', color=border)

# ==============================================================================
# 1. Reset Synchronizer (RST_SYNC) with Timing Diagram
# ==============================================================================
def make_rst_sync():
    fig, ax = create_canvas(11, 6)
    draw_header(ax, 5.5, 5.7, "Reset Synchronizer Architecture (RST_SYNC)",
                "Asynchronous Assertion, Synchronous Deassertion (Double-Flop Metastability Filter)")

    # Schematic Area
    draw_dff(ax, 3.0, 3.2, 1.8, 2.0, label="DFF 1", fill='#EFF6FF', border='#2563EB')
    draw_dff(ax, 6.2, 3.2, 1.8, 2.0, label="DFF 2", fill='#EFF6FF', border='#2563EB')

    # Wiring
    draw_arrow_pin(ax, 1.4, 4.45, 3.0, 4.45, label="1'b1 (VCC)", label_pos='top')
    draw_arrow_pin(ax, 4.8, 4.45, 6.2, 4.45, label="q1", label_pos='top')
    draw_arrow_pin(ax, 8.0, 4.45, 9.8, 4.45, label="SYNC_RST", label_pos='top', color='#059669', lw=2.2)

    # Clock tree
    draw_wire(ax, [(1.4, 3.75), (2.4, 3.75), (2.4, 3.75)])
    draw_arrow_pin(ax, 2.4, 3.75, 3.0, 3.75)
    draw_wire(ax, [(2.4, 3.75), (5.6, 3.75)])
    draw_arrow_pin(ax, 5.6, 3.75, 6.2, 3.75)
    ax.text(1.3, 3.75, "CLK", ha='right', va='center', fontsize=9, fontweight='bold', color=C_CLK)

    # Reset line (Asynchronous Active-Low)
    draw_wire(ax, [(1.4, 2.8), (3.9, 2.8), (3.9, 3.0)], color='#DC2626')
    draw_wire(ax, [(3.9, 2.8), (7.1, 2.8), (7.1, 3.0)], color='#DC2626')
    ax.text(1.3, 2.8, "RST (Async)", ha='right', va='center', fontsize=9, fontweight='bold', color='#DC2626')

    # Waveform Section (Bottom)
    ax.text(1.2, 2.2, "Timing Waveform Analysis:", fontsize=9.5, fontweight='bold', color=C_TEXT)
    
    # Grid lines
    t_clk = [2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5]
    for tc in t_clk:
        ax.plot([tc, tc], [0.3, 2.0], color='#E2E8F0', lw=1, ls=':')

    # 1. CLK Waveform
    ax.text(2.2, 1.8, "CLK", ha='right', fontsize=8.5, fontweight='bold', color=C_CLK)
    clk_x = [2.0, 2.5, 2.5, 3.0, 3.0, 3.5, 3.5, 4.0, 4.0, 4.5, 4.5, 5.0, 5.0, 5.5, 5.5, 6.0, 6.0, 6.5, 6.5, 7.0, 7.0, 7.5, 7.5, 8.0, 8.0, 8.5, 8.5, 9.0, 9.0, 9.5]
    clk_y = [1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6]
    ax.plot(clk_x, clk_y, color=C_CLK, lw=1.5)

    # 2. RST Waveform (Asynchronously drops at 3.2, releases at 5.2)
    ax.text(2.2, 1.3, "RST_N", ha='right', fontsize=8.5, fontweight='bold', color='#DC2626')
    rst_x = [2.0, 3.2, 3.2, 5.2, 5.2, 9.5]
    rst_y = [1.5, 1.5, 1.1, 1.1, 1.5, 1.5]
    ax.plot(rst_x, rst_y, color='#DC2626', lw=1.8)
    ax.text(3.25, 0.95, "Async Assert", fontsize=7.5, color='#DC2626', fontweight='bold')
    ax.text(5.25, 0.95, "Async Deassert", fontsize=7.5, color='#DC2626', fontweight='bold')

    # 3. SYNC_RST Waveform (Asserts instantly at 3.2, deasserts synchronously after 2 clock edges at 7.5)
    ax.text(2.2, 0.5, "SYNC_RST", ha='right', fontsize=8.5, fontweight='bold', color='#059669')
    sync_x = [2.0, 3.2, 3.2, 7.5, 7.5, 9.5]
    sync_y = [0.7, 0.7, 0.3, 0.3, 0.7, 0.7]
    ax.plot(sync_x, sync_y, color='#059669', lw=2.2)
    ax.text(7.55, 0.5, "Synchronous Release (2 Cycles Later)", fontsize=8, color='#059669', fontweight='bold')

    plt.tight_layout()
    plt.savefig('assets/rst_sync_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/rst_sync_diagram.png")

# ==============================================================================
# 2. Integrated Clock Gating (ICG) with Glitch-Free Waveform
# ==============================================================================
def make_clk_gate():
    fig, ax = create_canvas(11, 6)
    draw_header(ax, 5.5, 5.7, "Integrated Clock Gating (ICG) Cell Architecture",
                "TSMC 130nm TLATNCAX2M: Low-Level Latch + AND Gate for Glitch-Free Dynamic Power Savings")

    # Cell Boundary
    box = patches.FancyBboxPatch((2.2, 2.7), 6.6, 2.6, boxstyle="round,pad=0.03,rounding_size=0.15",
                                 facecolor='#FFFBEB', edgecolor='#D97706', lw=2.0)
    ax.add_patch(box)
    ax.text(5.5, 5.05, "Standard Cell: TLATNCAX2M (TSMC 130nm)", ha='center', fontsize=9.5, fontweight='bold', color='#B45309')

    # Latch
    latch_box = patches.FancyBboxPatch((2.8, 3.2), 2.2, 1.6, boxstyle="round,pad=0.02,rounding_size=0.06",
                                       facecolor='#EFF6FF', edgecolor='#2563EB', lw=1.8)
    ax.add_patch(latch_box)
    ax.text(3.9, 4.45, "Active-Low Latch", ha='center', fontsize=9, fontweight='bold', color='#1E40AF')
    ax.text(3.0, 3.9, "E", ha='left', fontsize=9, fontweight='bold')
    ax.text(4.8, 3.9, "Q", ha='right', fontsize=9, fontweight='bold')
    # Inverted clock on latch
    circle = patches.Circle((2.7, 3.45), 0.1, facecolor='#FFFFFF', edgecolor='#2563EB', lw=1.5, zorder=4)
    ax.add_patch(circle)
    ax.text(3.1, 3.45, "CLK", ha='left', fontsize=8, color=C_MUTED)

    # AND Gate
    draw_and_gate(ax, 6.2, 3.3, 1.8, 1.4, fill='#F8FAFC', border='#334155')

    # Connections
    draw_arrow_pin(ax, 1.0, 3.9, 2.8, 3.9, label="clk_en", label_pos='top')
    # Clock input
    draw_wire(ax, [(1.0, 3.45), (1.8, 3.45)])
    draw_arrow_pin(ax, 1.8, 3.45, 2.6, 3.45)
    draw_wire(ax, [(1.8, 3.45), (1.8, 2.9), (5.8, 2.9), (5.8, 3.6)])
    draw_arrow_pin(ax, 5.8, 3.6, 6.2, 3.6)
    ax.text(0.9, 3.45, "clk", ha='right', va='center', fontsize=9, fontweight='bold', color=C_CLK)

    # Latch Q to AND
    draw_arrow_pin(ax, 5.0, 3.9, 6.2, 4.35, label="latch_out", label_pos='top')
    # Gated clock output
    draw_arrow_pin(ax, 8.0, 4.0, 10.0, 4.0, label="gated_clk", label_pos='top', color='#D97706', lw=2.4)

    # Waveform Section
    ax.text(1.2, 2.3, "Glitch-Free Clock Gating Operation Waveforms:", fontsize=9.5, fontweight='bold', color=C_TEXT)
    
    # 1. CLK
    ax.text(2.0, 1.8, "clk", ha='right', fontsize=8.5, fontweight='bold', color=C_CLK)
    cx = [2.2, 2.7, 2.7, 3.2, 3.2, 3.7, 3.7, 4.2, 4.2, 4.7, 4.7, 5.2, 5.2, 5.7, 5.7, 6.2, 6.2, 6.7, 6.7, 7.2, 7.2, 7.7, 7.7, 8.2, 8.2, 8.7, 8.7, 9.2, 9.2, 9.7]
    cy = [1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6, 2.0, 2.0, 1.6, 1.6]
    ax.plot(cx, cy, color=C_CLK, lw=1.4)

    # 2. clk_en (rises asynchronously while clk is high)
    ax.text(2.0, 1.3, "clk_en", ha='right', fontsize=8.5, fontweight='bold', color='#2563EB')
    en_x = [2.2, 4.0, 4.0, 7.5, 7.5, 9.7]
    en_y = [1.1, 1.1, 1.45, 1.45, 1.1, 1.1]
    ax.plot(en_x, en_y, color='#2563EB', lw=1.6)

    # 3. latch_out (only updates when clk is low at 4.2)
    ax.text(2.0, 0.8, "latch_out", ha='right', fontsize=8.5, fontweight='bold', color='#1E40AF')
    l_x = [2.2, 4.2, 4.2, 8.2, 8.2, 9.7]
    l_y = [0.65, 0.65, 1.0, 1.0, 0.65, 0.65]
    ax.plot(l_x, l_y, color='#1E40AF', lw=1.6, ls='--')
    ax.text(4.25, 0.85, "Latched when CLK=0", fontsize=7.5, color='#1E40AF')

    # 4. gated_clk (passes clean pulses without glitches)
    ax.text(2.0, 0.25, "gated_clk", ha='right', fontsize=8.5, fontweight='bold', color='#D97706')
    gc_x = [2.2, 4.7, 4.7, 5.2, 5.2, 5.7, 5.7, 6.2, 6.2, 6.7, 6.7, 7.2, 7.2, 7.7, 7.7, 8.2, 8.2, 9.7]
    gc_y = [0.1, 0.1, 0.45, 0.45, 0.1, 0.1, 0.45, 0.45, 0.1, 0.1, 0.45, 0.45, 0.1, 0.1, 0.45, 0.45, 0.1, 0.1]
    ax.plot(gc_x, gc_y, color='#D97706', lw=2.2)

    plt.tight_layout()
    plt.savefig('assets/clk_gate_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/clk_gate_diagram.png")

# ==============================================================================
# 3. 16-Bit Arithmetic Logic Unit (ALU)
# ==============================================================================
def make_alu():
    fig, ax = create_canvas(11.5, 6.5)
    draw_header(ax, 5.75, 6.1, "16-Bit Arithmetic Logic Unit (ALU) Architecture",
                "Parameterized High-Performance Compute Engine with 14 Parallel Math/Logic Cores & Output Register")

    # Main ALU Chevron Symbol
    draw_alu_symbol(ax, 3.8, 1.5, 4.2, 3.8, fill='#EFF6FF', border='#2563EB')

    # Sub-blocks inside or feed
    draw_dff(ax, 8.6, 2.2, 1.6, 2.2, label="Output Reg\n[15:0]", fill='#FFFFFF', border='#2563EB')

    # Inputs to ALU
    draw_arrow_pin(ax, 1.0, 4.7, 4.4, 4.7, label="Operand A [7:0] (REG0)", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 1.0, 3.9, 4.6, 3.9, label="Operand B [7:0] (REG1)", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 1.0, 3.1, 5.0, 3.1, label="ALU_FUN [3:0]", label_pos='top', bus=True, bus_w='4', color='#7C3AED')
    draw_arrow_pin(ax, 1.0, 2.3, 5.4, 2.3, label="Enable (EN)", label_pos='top')
    draw_arrow_pin(ax, 1.0, 1.5, 5.6, 1.5, label="CLK (GATED_CLK)", label_pos='top', color=C_CLK)

    # ALU to Output Reg
    draw_arrow_pin(ax, 7.8, 3.3, 8.6, 3.3, label="ALU_COMB", label_pos='top', bus=True, bus_w='16')

    # Output Reg to Top
    draw_arrow_pin(ax, 10.2, 3.3, 11.2, 3.3, label="ALU_OUT [15:0]", label_pos='top', bus=True, bus_w='16', color='#2563EB', lw=2.2)
    draw_arrow_pin(ax, 10.2, 2.5, 11.2, 2.5, label="OUT_VALID", label_pos='top', color='#059669', lw=1.8)

    # Core Operations breakdown box
    op_box = patches.FancyBboxPatch((1.2, 0.4), 9.6, 0.8, boxstyle="round,pad=0.02,rounding_size=0.08",
                                    facecolor='#F8FAFC', edgecolor='#CBD5E1', lw=1.2)
    ax.add_patch(op_box)
    ax.text(6.0, 0.85, "Hardware Cores: [Arithmetic] Add, Sub, Mult, Div | [Logic] AND, OR, NAND, NOR, XOR, XNOR",
            ha='center', fontsize=8.5, fontweight='bold', color=C_TEXT)
    ax.text(6.0, 0.55, "[Comparators] CMP A=B, CMP A>B | [Shifters] Shift Right (>>1), Shift Left (<<1)",
            ha='center', fontsize=8.5, color=C_MUTED)

    plt.tight_layout()
    plt.savefig('assets/alu_block_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/alu_block_diagram.png")

# ==============================================================================
# 4. UART Transmitter (UART_TX) with MUX Trapezoid
# ==============================================================================
def make_uart_tx():
    fig, ax = create_canvas(11.5, 6)
    draw_header(ax, 5.75, 5.7, "UART Transmitter Subsystem (UART_TX)",
                "Hardware Serializer with Parallel-to-Serial Shift Register, Parity Core & Output Multiplexer")

    # Outer Frame
    draw_box(ax, 1.8, 0.8, 7.8, 4.4, title="", fill='#FAF5FF', border='#7C3AED', lw=2)

    # 1. FSM Controller
    draw_box(ax, 2.2, 1.4, 2.0, 3.2, title="FSM_TX\nController\n\n(IDLE, START,\nDATA, PARITY,\nSTOP)",
             fill='#FFFFFF', border='#A855F7', title_size=9)

    # 2. Serializer Shift Register
    draw_box(ax, 4.8, 3.2, 2.2, 1.4, title="8-Bit Serializer\n(Shift Register)", fill='#FFFFFF', border='#A855F7', title_size=9)

    # 3. Parity Generator
    draw_box(ax, 4.8, 1.4, 2.2, 1.4, title="Parity_Calc\n(Even / Odd XOR)", fill='#FFFFFF', border='#A855F7', title_size=9)

    # 4. 4:1 Multiplexer Trapezoid
    draw_mux_trapezoid(ax, 7.6, 1.8, 1.4, 2.8, fill='#FEF3C7', border='#D97706', label="4:1\nMUX")

    # Inputs
    draw_arrow_pin(ax, 0.4, 4.2, 4.8, 4.2, label="P_DATA [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 0.4, 3.4, 2.2, 3.4, label="DATA_VALID", label_pos='top')
    draw_arrow_pin(ax, 0.4, 2.6, 4.8, 2.6, label="PAR_EN / TYP", label_pos='top')
    draw_arrow_pin(ax, 0.4, 1.8, 2.2, 1.8, label="TX_CLK", label_pos='top', color=C_CLK)

    # FSM to MUX select
    draw_wire(ax, [(3.2, 1.4), (3.2, 1.1), (8.3, 1.1), (8.3, 1.8)], color='#7C3AED')
    draw_arrow_pin(ax, 8.3, 1.8, 8.3, 1.8)
    ax.text(5.75, 0.95, "MUX_SEL [1:0] (Start=0, Data=1, Parity=2, Stop=3)", ha='center', fontsize=8, color='#7C3AED', fontweight='bold')

    # Serializer to MUX (input 1)
    draw_arrow_pin(ax, 7.0, 3.8, 7.6, 3.8, label="ser_data", label_pos='top')
    # Parity to MUX (input 2)
    draw_arrow_pin(ax, 7.0, 2.2, 7.6, 2.5, label="par_bit", label_pos='top')

    # Output TX_OUT
    draw_arrow_pin(ax, 9.0, 3.2, 11.0, 3.2, label="TX_OUT (Serial)", label_pos='top', color='#7C3AED', lw=2.4)
    draw_arrow_pin(ax, 4.2, 2.0, 11.0, 1.4, label="Busy Flag", label_pos='top', color='#DC2626', lw=1.8)

    plt.tight_layout()
    plt.savefig('assets/uart_tx_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/uart_tx_diagram.png")

# ==============================================================================
# 5. UART Receiver (UART_RX) with Majority Voting Filter
# ==============================================================================
def make_uart_rx():
    fig, ax = create_canvas(12, 6.5)
    draw_header(ax, 6, 6.1, "UART Receiver Subsystem (UART_RX)",
                "3-Sample Majority Voting Filter, Bit-Edge Tracker & Frame Deserializer")

    draw_box(ax, 1.6, 0.6, 8.8, 5.0, title="", fill='#FAF5FF', border='#7C3AED', lw=2)

    # Submodules
    draw_box(ax, 2.0, 3.2, 2.2, 1.8, title="data_sampling\n\n(3-Sample\nMajority Vote)", fill='#FFFFFF', border='#A855F7', title_size=9)
    draw_box(ax, 2.0, 1.0, 2.2, 1.8, title="edge_bit_counter\n\n(Edge & Bit\nPrescaler)", fill='#FFFFFF', border='#A855F7', title_size=9)

    draw_box(ax, 4.8, 3.2, 2.2, 1.8, title="deserializer\n\n(Serial-to-Parallel\nShift Register)", fill='#FFFFFF', border='#A855F7', title_size=9)
    draw_box(ax, 4.8, 1.0, 2.2, 1.8, title="FSM_RX\n\n(Frame\nSequencer)", fill='#FFFFFF', border='#A855F7', title_size=9)

    draw_box(ax, 7.6, 3.8, 2.2, 1.2, title="parity_checker\n(Even / Odd)", fill='#FFFFFF', border='#A855F7', title_size=8.5)
    draw_box(ax, 7.6, 2.3, 2.2, 1.1, title="stop_checker\n(Framing)", fill='#FFFFFF', border='#A855F7', title_size=8.5)
    draw_box(ax, 7.6, 1.0, 2.2, 0.9, title="strt_checker", fill='#FFFFFF', border='#A855F7', title_size=8.5)

    # Inputs
    draw_arrow_pin(ax, 0.4, 4.1, 2.0, 4.1, label="RX_IN", label_pos='top', lw=2)
    draw_arrow_pin(ax, 0.4, 2.4, 2.0, 2.4, label="Prescale [5:0]", label_pos='top', bus=True, bus_w='6')
    draw_arrow_pin(ax, 0.4, 1.5, 2.0, 1.5, label="RX_CLK", label_pos='top', color=C_CLK)

    # Connections
    draw_arrow_pin(ax, 4.2, 4.1, 4.8, 4.1, label="sampled_bit", label_pos='top')
    draw_arrow_pin(ax, 4.2, 1.9, 4.8, 1.9, label="edge / bit_cnt", label_pos='top')
    draw_arrow_pin(ax, 7.0, 4.1, 7.6, 4.1)

    # Outputs
    draw_arrow_pin(ax, 7.0, 4.4, 11.2, 4.4, label="P_DATA [7:0]", label_pos='top', bus=True, bus_w='8', color='#7C3AED', lw=2.2)
    draw_arrow_pin(ax, 7.0, 1.9, 11.2, 1.9, label="DATA_VLD", label_pos='top', color='#059669', lw=2)
    draw_arrow_pin(ax, 9.8, 4.4, 11.2, 5.0, label="PAR_ERR", label_pos='top', color='#DC2626')
    draw_arrow_pin(ax, 9.8, 2.85, 11.2, 2.85, label="STP_ERR", label_pos='top', color='#DC2626')

    plt.tight_layout()
    plt.savefig('assets/uart_rx_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/uart_rx_diagram.png")

# ==============================================================================
# 6. Pulse Generator (Pulse_Gen)
# ==============================================================================
def make_pulse_gen():
    fig, ax = create_canvas(10, 5.5)
    draw_header(ax, 5, 5.1, "Pulse Generator Subsystem (Falling Edge Detector)",
                "Converts Falling Edge of UART_TX Busy to a Single-Cycle R_INC FIFO Read Pulse")

    # DFF
    draw_dff(ax, 2.6, 2.2, 1.8, 2.0, label="Delay DFF", fill='#EFF6FF', border='#2563EB')
    # Inverter
    draw_inv_gate(ax, 4.8, 1.4, 1.2, 0.9, fill='#F8FAFC', border='#334155')
    # AND Gate
    draw_and_gate(ax, 6.8, 2.1, 1.6, 1.4, fill='#F8FAFC', border='#334155')

    # Input signal LVL_SIG
    draw_wire(ax, [(0.8, 3.45), (1.8, 3.45)])
    draw_arrow_pin(ax, 1.8, 3.45, 2.6, 3.45)
    draw_wire(ax, [(1.8, 3.45), (1.8, 1.85)])
    draw_arrow_pin(ax, 1.8, 1.85, 4.8, 1.85)
    ax.text(0.7, 3.45, "LVL_SIG (Busy)", ha='right', va='center', fontsize=9, fontweight='bold')

    # Q to AND input 1
    draw_arrow_pin(ax, 4.4, 3.45, 6.8, 3.1, label="q_reg (Delayed)", label_pos='top')
    # Inv to AND input 2
    draw_arrow_pin(ax, 6.1, 1.85, 6.8, 2.4)

    # Output PULSE_SIG
    draw_arrow_pin(ax, 8.4, 2.8, 9.8, 2.8, label="PULSE_SIG", label_pos='top', color='#059669', lw=2.2)

    # Waveforms below
    ax.text(1.2, 1.6, "Waveform Analysis:", fontsize=9, fontweight='bold', color=C_TEXT)
    # CLK
    ax.text(2.0, 1.2, "CLK", ha='right', fontsize=8, fontweight='bold', color=C_CLK)
    ax.plot([2.2, 2.6, 2.6, 3.0, 3.0, 3.4, 3.4, 3.8, 3.8, 4.2, 4.2, 4.6, 4.6, 5.0, 5.0, 5.4, 5.4, 5.8, 5.8, 6.2, 6.2, 6.6, 6.6, 7.0, 7.0, 7.4],
            [1.0, 1.0, 1.35, 1.35, 1.0, 1.0, 1.35, 1.35, 1.0, 1.0, 1.35, 1.35, 1.0, 1.0, 1.35, 1.35, 1.0, 1.0, 1.35, 1.35, 1.0, 1.0, 1.35, 1.35, 1.0, 1.0],
            color=C_CLK, lw=1.3)

    # LVL_SIG (drops at 4.2)
    ax.text(2.0, 0.7, "LVL_SIG", ha='right', fontsize=8, fontweight='bold')
    ax.plot([2.2, 4.2, 4.2, 7.4], [0.85, 0.85, 0.55, 0.55], color=C_TEXT, lw=1.6)

    # PULSE_SIG (pulses high for exactly 1 cycle from 4.2 to 5.0)
    ax.text(2.0, 0.2, "PULSE_SIG", ha='right', fontsize=8, fontweight='bold', color='#059669')
    ax.plot([2.2, 4.2, 4.2, 5.0, 5.0, 7.4], [0.05, 0.05, 0.35, 0.35, 0.05, 0.05], color='#059669', lw=2.0)
    ax.text(4.6, 0.42, "1-Cycle Pop Pulse", ha='center', fontsize=7.5, color='#059669', fontweight='bold')

    plt.tight_layout()
    plt.savefig('assets/pulse_gen_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/pulse_gen_diagram.png")

# ==============================================================================
# 7. Multi-Bit Data Synchronizer (DATA_SYNC)
# ==============================================================================
def make_data_sync():
    fig, ax = create_canvas(11, 5.5)
    draw_header(ax, 5.5, 5.1, "Multi-Bit Data Synchronizer Architecture (DATA_SYNC)",
                "Coordinated Enable-Pulse Handshaking to Prevent Multi-Bit Bus Skew Metastability")

    draw_box(ax, 2.0, 0.8, 6.8, 3.8, title="", fill='#F0FDF4', border='#059669', lw=2)

    # 2-Flop Sync on Enable
    draw_box(ax, 2.4, 2.8, 2.6, 1.4, title="2-Flop Synchronizer\n(bus_enable)", fill='#FFFFFF', border='#10B981', title_size=9)
    # Pulse Gen
    draw_box(ax, 5.4, 2.8, 1.8, 1.4, title="Pulse Gen\n(enable_pulse)", fill='#FFFFFF', border='#10B981', title_size=9)
    # Holding Register
    draw_box(ax, 3.4, 1.2, 4.6, 1.2, title="8-Bit Bus Holding Register\n(Latching when pulse is asserted)", fill='#EFF6FF', border='#2563EB', title_size=9)

    # Inputs
    draw_arrow_pin(ax, 0.6, 3.5, 2.4, 3.5, label="bus_enable", label_pos='top')
    draw_arrow_pin(ax, 0.6, 1.8, 3.4, 1.8, label="unsync_bus [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 0.6, 1.0, 2.0, 1.0, label="dest_clk / rst", label_pos='top')

    # Internal Connections
    draw_arrow_pin(ax, 5.0, 3.5, 5.4, 3.5)
    draw_arrow_pin(ax, 6.3, 2.8, 6.3, 2.4, label="en_pulse", label_pos='top', color='#059669')

    # Outputs
    draw_arrow_pin(ax, 7.2, 3.5, 10.2, 3.5, label="enable_pulse_d", label_pos='top', color='#059669', lw=1.8)
    draw_arrow_pin(ax, 8.0, 1.8, 10.2, 1.8, label="sync_bus [7:0]", label_pos='top', bus=True, bus_w='8', color='#2563EB', lw=2.2)

    ax.text(5.5, 0.35, "* Critical Design Rule: unsync_bus must remain stable while bus_enable traverses the 2-flop sync.",
            ha='center', fontsize=8.5, style='italic', color=C_MUTED)

    plt.tight_layout()
    plt.savefig('assets/data_sync_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/data_sync_diagram.png")

# ==============================================================================
# 8. Dual-Clock Asynchronous FIFO
# ==============================================================================
def make_async_fifo():
    fig, ax = create_canvas(12, 6.8)
    draw_header(ax, 6, 6.4, "Dual-Clock Asynchronous FIFO Architecture (8 Words × 8-Bit)",
                "Full Dual-Clock Domain Crossing with Gray-Coded Pointer Counters and 2-Stage Synchronizers")

    # Center Dual Port RAM
    draw_box(ax, 4.6, 2.0, 2.8, 3.4, title="Dual-Port SRAM\n(8 Words × 8-Bit)\n\nDual Clock Ports:\n- WCLK (Write)\n- RCLK (Read)",
             fill='#FEF3C7', border='#D97706', lw=2, title_size=9.5)

    # Write Domain (Left)
    draw_box(ax, 1.4, 1.2, 2.6, 4.5, title="", fill='#EFF6FF', border='#2563EB', lw=2)
    ax.text(2.7, 5.35, "WRITE DOMAIN\n(REF_CLK = 50 MHz)", ha='center', fontsize=9.5, fontweight='bold', color='#1E40AF')
    draw_box(ax, 1.6, 3.6, 2.2, 1.3, title="FIFO_WR\nwptr_bin & wptr_gray\nFull Logic", fill='#FFFFFF', border='#3B82F6', title_size=8)
    draw_box(ax, 1.6, 1.6, 2.2, 1.3, title="DF_SYNC (r2w)\n(2-Stage Flops\nrptr_gray -> wclk)", fill='#F0FDF4', border='#059669', title_size=8)

    # Read Domain (Right)
    draw_box(ax, 8.0, 1.2, 2.6, 4.5, title="", fill='#FAF5FF', border='#7C3AED', lw=2)
    ax.text(9.3, 5.35, "READ DOMAIN\n(UART_CLK = 3.68 MHz)", ha='center', fontsize=9.5, fontweight='bold', color='#7C3AED')
    draw_box(ax, 8.2, 3.6, 2.2, 1.3, title="FIFO_RD\nrptr_bin & rptr_gray\nEmpty Logic", fill='#FFFFFF', border='#8B5CF6', title_size=8)
    draw_box(ax, 8.2, 1.6, 2.2, 1.3, title="DF_SYNC (w2r)\n(2-Stage Flops\nwptr_gray -> rclk)", fill='#F0FDF4', border='#059669', title_size=8)

    # Inputs & Outputs
    draw_arrow_pin(ax, 0.2, 4.3, 1.6, 4.3, label="W_INC", label_pos='top')
    draw_arrow_pin(ax, 0.2, 3.6, 4.6, 3.6, label="WR_DATA [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 1.6, 4.6, 0.2, 4.6, label="FULL Flag", label_pos='top', color='#DC2626')

    draw_arrow_pin(ax, 11.8, 4.3, 10.4, 4.3, label="R_INC", label_pos='top')
    draw_arrow_pin(ax, 7.4, 3.6, 11.8, 3.6, label="RD_DATA [7:0]", label_pos='top', bus=True, bus_w='8', color='#7C3AED', lw=2.2)
    draw_arrow_pin(ax, 10.4, 4.6, 11.8, 4.6, label="EMPTY Flag", label_pos='top', color='#DC2626')

    # Gray Pointer crossing lines
    draw_wire(ax, [(3.8, 4.1), (4.2, 4.1), (4.2, 0.9), (7.6, 0.9), (7.6, 2.2)], color='#059669', lw=1.5, ls='--')
    draw_arrow_pin(ax, 7.6, 2.2, 8.2, 2.2)
    ax.text(6.0, 0.75, "wptr_gray -> 2-Stage Sync -> Read Domain", ha='center', fontsize=8, color='#059669', fontweight='bold')

    draw_wire(ax, [(8.2, 4.1), (7.8, 4.1), (7.8, 0.5), (4.4, 0.5), (4.4, 2.2)], color='#059669', lw=1.5, ls=':')
    draw_arrow_pin(ax, 4.4, 2.2, 3.8, 2.2)
    ax.text(6.0, 0.35, "rptr_gray -> 2-Stage Sync -> Write Domain", ha='center', fontsize=8, color='#059669', fontweight='bold')

    plt.tight_layout()
    plt.savefig('assets/async_fifo_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/async_fifo_diagram.png")

# ==============================================================================
# 9. Register File (regfile)
# ==============================================================================
def make_regfile():
    fig, ax = create_canvas(11.5, 6.2)
    draw_header(ax, 5.75, 5.8, "Register File Internal Organization (16 × 8-Bit)",
                "Host Addressable Memory Matrix with Dedicated Hardware Configuration Interfaces")

    # Main Chip
    draw_box(ax, 2.6, 0.8, 5.8, 4.5, title="", fill='#EFF6FF', border='#2563EB', lw=2)

    # Address Decoder
    draw_box(ax, 3.0, 1.2, 1.4, 3.8, title="4-to-16\nAddress\nDecoder", fill='#FFFFFF', border='#3B82F6', title_size=9)

    # Memory Bank Representation
    draw_box(ax, 4.8, 4.2, 3.2, 0.65, title="REG0 (0x0): ALU Operand A [7:0]", fill='#FEF3C7', border='#D97706', title_size=8)
    draw_box(ax, 4.8, 3.4, 3.2, 0.65, title="REG1 (0x1): ALU Operand B [7:0]", fill='#FEF3C7', border='#D97706', title_size=8)
    draw_box(ax, 4.8, 2.6, 3.2, 0.65, title="REG2 (0x2): UART Prescale & Parity", fill='#EDE9FE', border='#7C3AED', title_size=8)
    draw_box(ax, 4.8, 1.8, 3.2, 0.65, title="REG3 (0x3): TX Clock Division Ratio", fill='#EDE9FE', border='#7C3AED', title_size=8)
    draw_box(ax, 4.8, 1.0, 3.2, 0.65, title="REG4 - REG15: General Purpose", fill='#F8FAFC', border='#64748B', title_size=8)

    # Inputs
    draw_arrow_pin(ax, 0.6, 4.5, 3.0, 4.5, label="Address [3:0]", label_pos='top', bus=True, bus_w='4')
    draw_arrow_pin(ax, 0.6, 3.7, 4.8, 3.7, label="WrData [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 0.6, 2.9, 3.0, 2.9, label="WrEn", label_pos='top')
    draw_arrow_pin(ax, 0.6, 2.1, 3.0, 2.1, label="RdEn", label_pos='top')
    draw_arrow_pin(ax, 0.6, 1.3, 2.6, 1.3, label="CLK (REF_CLK)", label_pos='top', color=C_CLK)

    # Outputs
    draw_arrow_pin(ax, 8.4, 4.5, 10.8, 4.5, label="REG0 -> ALU A", label_pos='top', bus=True, bus_w='8', color='#D97706')
    draw_arrow_pin(ax, 8.4, 3.7, 10.8, 3.7, label="REG1 -> ALU B", label_pos='top', bus=True, bus_w='8', color='#D97706')
    draw_arrow_pin(ax, 8.4, 2.9, 10.8, 2.9, label="REG2 -> UART Config", label_pos='top', bus=True, bus_w='8', color='#7C3AED')
    draw_arrow_pin(ax, 8.4, 2.1, 10.8, 2.1, label="REG3 -> TX_CLK_DIV", label_pos='top', bus=True, bus_w='8', color='#7C3AED')
    draw_arrow_pin(ax, 8.4, 1.3, 10.8, 1.3, label="RdData [7:0] & Valid", label_pos='top', bus=True, bus_w='8', color='#2563EB')

    plt.tight_layout()
    plt.savefig('assets/regfile_block_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/regfile_block_diagram.png")

# ==============================================================================
# 10. Clock Divider (CLK_DIV)
# ==============================================================================
def make_clk_div():
    fig, ax = create_canvas(10.5, 5.5)
    draw_header(ax, 5.25, 5.1, "Dynamic Clock Divider Subsystem (CLK_DIV)",
                "Even/Odd Integer Divider with 50% Output Duty Cycle")

    draw_box(ax, 2.0, 1.8, 6.2, 2.6, title="", fill='#FAF5FF', border='#7C3AED', lw=2)

    # Sub-blocks
    draw_box(ax, 2.4, 2.4, 1.8, 1.4, title="Counter Core\n(count[7:0])", fill='#FFFFFF', border='#A855F7', title_size=9)
    draw_box(ax, 4.6, 2.4, 1.8, 1.4, title="Comparator\n(Half Cycle Match)", fill='#FFFFFF', border='#A855F7', title_size=9)
    draw_dff(ax, 6.8, 2.1, 1.2, 1.8, label="T-FF", fill='#FFFFFF', border='#A855F7')

    # Inputs
    draw_arrow_pin(ax, 0.6, 3.8, 2.4, 3.8, label="i_ref_clk", label_pos='top', color=C_CLK)
    draw_arrow_pin(ax, 0.6, 3.1, 2.0, 3.1, label="i_clk_en", label_pos='top')
    draw_arrow_pin(ax, 0.6, 2.4, 4.6, 2.4, label="i_div_ratio [7:0]", label_pos='top', bus=True, bus_w='8')

    draw_arrow_pin(ax, 4.2, 3.1, 4.6, 3.1)
    draw_arrow_pin(ax, 6.4, 3.1, 6.8, 3.1)

    # Output
    draw_arrow_pin(ax, 8.0, 3.1, 10.0, 3.1, label="o_div_clk (50% Duty)", label_pos='top', color='#7C3AED', lw=2.2)

    # Waveform below
    ax.text(1.2, 1.3, "Waveform (Div Ratio = 4):", fontsize=9, fontweight='bold', color=C_TEXT)
    # Ref clk (fast)
    ax.text(2.0, 0.9, "ref_clk", ha='right', fontsize=8, fontweight='bold', color=C_CLK)
    rx = [2.2, 2.5, 2.5, 2.8, 2.8, 3.1, 3.1, 3.4, 3.4, 3.7, 3.7, 4.0, 4.0, 4.3, 4.3, 4.6, 4.6, 4.9, 4.9, 5.2, 5.2, 5.5, 5.5, 5.8, 5.8, 6.1, 6.1, 6.4, 6.4, 6.7]
    ry = [0.75, 0.75, 1.05, 1.05, 0.75, 0.75, 1.05, 1.05, 0.75, 0.75, 1.05, 1.05, 0.75, 0.75, 1.05, 1.05, 0.75, 0.75, 1.05, 1.05, 0.75, 0.75, 1.05, 1.05, 0.75, 0.75, 1.05, 1.05, 0.75, 0.75]
    ax.plot(rx, ry, color=C_CLK, lw=1.3)

    # Div clk (divided by 4)
    ax.text(2.0, 0.3, "div_clk", ha='right', fontsize=8, fontweight='bold', color='#7C3AED')
    dx = [2.2, 2.8, 2.8, 4.0, 4.0, 5.2, 5.2, 6.4, 6.4, 6.7]
    dy = [0.15, 0.15, 0.5, 0.5, 0.15, 0.15, 0.5, 0.5, 0.15, 0.15]
    ax.plot(dx, dy, color='#7C3AED', lw=2.2)

    plt.tight_layout()
    plt.savefig('assets/clk_div_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/clk_div_diagram.png")

# ==============================================================================
# 11. System Controller (SYS_CTRL)
# ==============================================================================
def make_sys_ctrl():
    fig, ax = create_canvas(11.5, 6.5)
    draw_header(ax, 5.75, 6.1, "System Controller (SYS_CTRL) FSM & Interface Core",
                "Central Command Interpreter, Control Signal Multiplexing & Handshake Execution Engine")

    draw_box(ax, 2.6, 0.6, 6.2, 4.8, title="", fill='#EFF6FF', border='#2563EB', lw=2)

    # FSM Bubble Flow visual
    fsm_outer = patches.FancyBboxPatch((3.0, 1.2), 5.4, 3.8, boxstyle="round,pad=0.03,rounding_size=0.1",
                                       facecolor='#FFFFFF', edgecolor='#93C5FD', lw=1.5)
    ax.add_patch(fsm_outer)
    ax.text(5.7, 4.5, "Master Controller FSM States", ha='center', fontsize=10.5, fontweight='bold', color='#1E40AF')

    # States
    draw_box(ax, 3.3, 3.4, 1.8, 0.7, title="IDLE\n(Wait RX_VLD)", fill='#DBEAFE', border='#3B82F6', title_size=8)
    draw_box(ax, 6.3, 3.4, 1.8, 0.7, title="CMD_DECODE\n(0xAA, 0xBB, etc.)", fill='#DBEAFE', border='#3B82F6', title_size=8)
    draw_box(ax, 3.3, 2.2, 1.8, 0.7, title="RF_OPS\n(Read / Write)", fill='#FEF3C7', border='#D97706', title_size=8)
    draw_box(ax, 6.3, 2.2, 1.8, 0.7, title="ALU_OPS\n(Load Op, Calc)", fill='#FEF3C7', border='#D97706', title_size=8)
    draw_box(ax, 4.8, 1.4, 2.2, 0.6, title="FIFO_WR (Push Result)", fill='#F0FDF4', border='#059669', title_size=8)

    # Transitions
    draw_arrow_pin(ax, 5.1, 3.75, 6.3, 3.75)
    draw_arrow_pin(ax, 7.2, 3.4, 7.2, 2.9)
    draw_arrow_pin(ax, 4.2, 3.4, 4.2, 2.9)
    draw_arrow_pin(ax, 6.3, 2.2, 5.9, 2.0)
    draw_arrow_pin(ax, 4.2, 2.2, 4.8, 2.0)

    # External Interface Arrows
    draw_arrow_pin(ax, 0.6, 4.5, 2.6, 4.5, label="RX_P_DATA [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 0.6, 3.7, 2.6, 3.7, label="RX_D_VLD", label_pos='top')
    draw_arrow_pin(ax, 0.6, 2.9, 2.6, 2.9, label="CLK (REF_CLK)", label_pos='top', color=C_CLK)
    draw_arrow_pin(ax, 0.6, 2.1, 2.6, 2.1, label="FIFO_FULL", label_pos='top', color='#DC2626')

    # Outputs
    draw_arrow_pin(ax, 8.8, 4.8, 10.8, 4.8, label="Address / WrEn / RdEn", label_pos='top', bus=True, bus_w='4')
    draw_arrow_pin(ax, 8.8, 4.0, 10.8, 4.0, label="WrData [7:0]", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 8.8, 3.2, 10.8, 3.2, label="ALU_FUN [3:0] / EN", label_pos='top', bus=True, bus_w='4', color='#D97706')
    draw_arrow_pin(ax, 8.8, 2.4, 10.8, 2.4, label="CLK_EN (Clock Gate)", label_pos='top', color='#D97706')
    draw_arrow_pin(ax, 8.8, 1.6, 10.8, 1.6, label="TX_P_DATA [7:0]", label_pos='top', bus=True, bus_w='8', color='#7C3AED')
    draw_arrow_pin(ax, 8.8, 0.9, 10.8, 0.9, label="TX_D_VLD (W_INC)", label_pos='top', color='#7C3AED')

    plt.tight_layout()
    plt.savefig('assets/sys_ctrl_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/sys_ctrl_diagram.png")

# ==============================================================================
# 12. Top-Level SoC Block Diagram
# ==============================================================================
def make_system_top():
    fig, ax = create_canvas(14, 8)
    draw_header(ax, 7, 7.6, "System-on-Chip Top-Level Interconnect & Clock Domain Architecture",
                "Dual Asynchronous Clock Domains with Integrated Clock Gating, Dual-Clock FIFO & Synchronizer Bridges")

    # 1. UART Domain (Left)
    draw_box(ax, 0.8, 0.8, 3.8, 6.0, title="", fill='#FAF5FF', border='#7C3AED', lw=2)
    ax.text(2.7, 6.5, "UART DOMAIN (3.6864 MHz)", ha='center', fontsize=10.5, fontweight='bold', color='#7C3AED')
    draw_box(ax, 1.2, 5.0, 3.0, 1.1, title="UART_RX\n(Receiver Core)", fill='#FFFFFF', border='#A855F7', title_size=9)
    draw_box(ax, 1.2, 3.6, 3.0, 1.1, title="UART_TX\n(Transmitter Core)", fill='#FFFFFF', border='#A855F7', title_size=9)
    draw_box(ax, 1.2, 2.3, 1.4, 0.9, title="RX_CLK_DIV", fill='#FFFFFF', border='#A855F7', title_size=8)
    draw_box(ax, 2.8, 2.3, 1.4, 0.9, title="TX_CLK_DIV", fill='#FFFFFF', border='#A855F7', title_size=8)
    draw_box(ax, 1.2, 1.1, 1.4, 0.9, title="prescale_mux", fill='#FFFFFF', border='#A855F7', title_size=7.5)
    draw_box(ax, 2.8, 1.1, 1.4, 0.9, title="Pulse_Gen", fill='#FFFFFF', border='#A855F7', title_size=8)

    # 2. CDC Interface (Middle)
    draw_box(ax, 5.0, 0.8, 2.8, 6.0, title="", fill='#F0FDF4', border='#059669', lw=2)
    ax.text(6.4, 6.5, "CDC BRIDGE", ha='center', fontsize=10.5, fontweight='bold', color='#059669')
    draw_box(ax, 5.3, 4.4, 2.2, 1.5, title="DATA_SYNC\n(Multi-Bit Handshake\nSynchronizer)", fill='#FFFFFF', border='#10B981', title_size=8.5)
    draw_box(ax, 5.3, 1.6, 2.2, 2.0, title="ASYNC_FIFO\n(8 Words × 8-Bit\nDual Clock FIFO)", fill='#FFFFFF', border='#10B981', title_size=8.5)

    # 3. REF Clock Domain (Right)
    draw_box(ax, 8.2, 0.8, 5.0, 6.0, title="", fill='#EFF6FF', border='#2563EB', lw=2)
    ax.text(10.7, 6.5, "REFERENCE DOMAIN (50 MHz)", ha='center', fontsize=10.5, fontweight='bold', color='#2563EB')
    draw_box(ax, 8.5, 4.4, 4.4, 1.5, title="SYS_CTRL\n(Master FSM Controller)", fill='#FFFFFF', border='#3B82F6', title_size=9.5)
    draw_box(ax, 8.5, 2.6, 2.2, 1.5, title="Register File\n(16 × 8-Bit)", fill='#FFFFFF', border='#3B82F6', title_size=9)
    draw_box(ax, 11.0, 2.6, 1.9, 1.5, title="16-Bit ALU\n(Compute Core)", fill='#FFFFFF', border='#3B82F6', title_size=8.5)
    draw_box(ax, 11.0, 1.2, 1.9, 0.9, title="CLK_GATE\n(TLATNCAX2M)", fill='#FFFBEB', border='#D97706', title_size=8)
    draw_box(ax, 8.5, 1.2, 2.2, 0.9, title="RST_SYNC_1", fill='#EFF6FF', border='#3B82F6', title_size=8)

    # External I/O
    draw_arrow_pin(ax, 0.1, 5.5, 1.2, 5.5, label="RX_IN", label_pos='top', lw=2)
    draw_arrow_pin(ax, 4.2, 4.1, 0.1, 4.1, label="TX_OUT", label_pos='top', color='#7C3AED', lw=2)
    draw_arrow_pin(ax, 4.2, 5.2, 0.1, 5.2, label="parity_error / framing_error", label_pos='top', color='#DC2626')

    # Domain Crossings
    draw_arrow_pin(ax, 4.2, 5.0, 5.3, 5.0, label="RX_OUT_P", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 7.5, 5.0, 8.5, 5.0, label="sync_bus", label_pos='top', bus=True, bus_w='8')

    draw_arrow_pin(ax, 8.5, 4.6, 7.5, 3.2, label="WR_DATA", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 5.3, 2.8, 4.2, 3.8, label="FIFO_RDATA", label_pos='top', bus=True, bus_w='8')
    draw_arrow_pin(ax, 4.2, 3.6, 3.5, 2.0, label="Busy", label_pos='top')
    draw_arrow_pin(ax, 3.5, 2.0, 5.3, 2.0, label="R_INC Pulse", label_pos='top')

    # Internal Signals
    draw_arrow_pin(ax, 9.6, 4.4, 9.6, 4.1, label="Addr / WrEn", label_pos='top')
    draw_arrow_pin(ax, 11.5, 4.4, 11.5, 4.1, label="ALU_EN", label_pos='top')
    draw_arrow_pin(ax, 11.9, 2.1, 11.9, 2.6, label="gated_clk", label_pos='top', color='#D97706')

    plt.tight_layout()
    plt.savefig('assets/system_top_block_diagram.png', dpi=220, bbox_inches='tight')
    plt.close()
    print("Generated assets/system_top_block_diagram.png")

if __name__ == '__main__':
    print("Generating authentic hardware schematics with logic gates and waveforms...")
    make_rst_sync()
    make_clk_gate()
    make_alu()
    make_uart_tx()
    make_uart_rx()
    make_pulse_gen()
    make_data_sync()
    make_async_fifo()
    make_regfile()
    make_clk_div()
    make_sys_ctrl()
    make_system_top()
    print("All professional schematics generated successfully!")
