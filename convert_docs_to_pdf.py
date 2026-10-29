
from pathlib import Path
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_CENTER
from reportlab.lib import colors
from reportlab.lib.units import mm
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer,
    PageBreak, Preformatted
)
from xml.sax.saxutils import escape
import re

PROJECT = Path(__file__).resolve().parent
DOCS = PROJECT / "Database" / "PBL_Submission" / "Documentation"
OUTPUT = PROJECT / "Database" / "PBL_Submission" / "PDF_Documentation"

styles = getSampleStyleSheet()
styles.add(ParagraphStyle(
    name="DocTitle", parent=styles["Title"],
    alignment=TA_CENTER, textColor=colors.HexColor("#0759ce"),
    spaceAfter=18
))
styles.add(ParagraphStyle(
    name="CodeText", parent=styles["Code"],
    fontName="Courier", fontSize=7, leading=9,
    wordWrap="CJK"
))

def footer(canvas, document):
    canvas.saveState()
    canvas.setFont("Helvetica", 8)
    canvas.setFillColor(colors.grey)
    canvas.drawString(20 * mm, 12 * mm, "IBI Bank | PBL Documentation")
    canvas.drawRightString(190 * mm, 12 * mm, f"Page {document.page}")
    canvas.restoreState()

def convert(md_file, pdf_file):
    text = md_file.read_text(encoding="utf-8")
    story = []
    in_code = False
    code_lines = []

    for line in text.splitlines():
        if line.strip().startswith("```"):
            if in_code:
                story.append(Preformatted(
                    escape("\n".join(code_lines)),
                    styles["CodeText"]
                ))
                story.append(Spacer(1, 6))
                code_lines = []
            in_code = not in_code
            continue

        if in_code:
            code_lines.append(line)
            continue

        if not line.strip():
            story.append(Spacer(1, 5))
            continue

        if line.strip() == "---":
            story.append(Spacer(1, 10))
            continue

        heading = re.match(r"^(#{1,3})\s+(.+)$", line)
        if heading:
            level = len(heading.group(1))
            content = escape(heading.group(2))
            style = styles["DocTitle"] if level == 1 else (
                styles["Heading2"] if level == 2 else styles["Heading3"]
            )
            story.append(Paragraph(content, style))
            continue

        if line.lstrip().startswith(("- ", "* ")):
            content = escape(line.lstrip()[2:])
            story.append(Paragraph("• " + content, styles["BodyText"]))
            continue

        content = escape(line)
        content = re.sub(r"\*\*(.+?)\*\*", r"<b>\1</b>", content)
        content = re.sub(r"\*(.+?)\*", r"<i>\1</i>", content)
        story.append(Paragraph(content, styles["BodyText"]))

    pdf_file.parent.mkdir(parents=True, exist_ok=True)
    doc = SimpleDocTemplate(
        str(pdf_file), pagesize=A4,
        rightMargin=20 * mm, leftMargin=20 * mm,
        topMargin=18 * mm, bottomMargin=20 * mm
    )
    doc.build(story, onFirstPage=footer, onLaterPages=footer)

if not DOCS.exists():
    print(f"Documentation folder not found: {DOCS}")
else:
    files = sorted(DOCS.glob("*.md"))
    if not files:
        print("No Markdown files found in Documentation.")
    else:
        for file in files:
            destination = OUTPUT / f"{file.stem}.pdf"
            convert(file, destination)
            print(f"Created: {destination.relative_to(PROJECT)}")

        print(f"\nFinished. Converted {len(files)} Markdown file(s).")
