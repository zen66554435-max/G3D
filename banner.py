#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
G3D Banner Module
"""

from rich.console import Console
from rich.panel import Panel
from rich.text import Text
from rich import box

console = Console()

ORANGE = "#FF6B35"
CYAN = "#00D4FF"

def show_banner():
    banner = """
[bold {ORANGE}]   ██████╗  ██████╗ ██████╗ [/bold {ORANGE}]
[bold {ORANGE}]  ██╔════╝ ██╔═══██╗╚════██╗[/bold {ORANGE}]
[bold {ORANGE}]  ██║  ███╗██║   ██║ █████╔╝[/bold {ORANGE}]
[bold {ORANGE}]  ██║   ██║██║   ██║ ╚═══██╗[/bold {ORANGE}]
[bold {ORANGE}]  ╚██████╔╝╚██████╔╝██████╔╝[/bold {ORANGE}]
[bold {ORANGE}]   ╚═════╝  ╚═════╝ ╚═════╝ [/bold {ORANGE}]
    """

    info = Panel(
        "[bold {CYAN}]G3D v3.0 Ultimate[/bold {CYAN}]\n"
        "[bold {ORANGE}]المطور: الجنرال[/bold {ORANGE}]\n"
        "[bold {CYAN}]OSINT Information Gathering Tool[/bold {CYAN}]",
        border_style=ORANGE,
        box=box.DOUBLE,
        padding=(1, 2)
    )

    console.print(banner)
    console.print(info)
