class ContractPdfService
  BODY_FONT_SIZE = 9.5
  BODY_LEADING = 2
  PARAGRAPH_SPACING = 5
  TITLE_FONT_SIZE = 14
  SIGNATURE_LINE_PATTERN = /_{5,}/

  def initialize(contract)
    @contract = contract
  end

  def call
    Prawn::Document.new(page_size: "A4", margin: [ 40, 50, 40, 50 ]) do |pdf|
      pdf.font "Helvetica"

      pdf.text @contract.title, size: TITLE_FONT_SIZE, style: :bold, align: :center
      pdf.move_down 10

      pdf.text "Fecha de generación: #{I18n.l(@contract.created_at.to_date, format: :long)}", size: 8, color: "666666"
      pdf.move_down 12

      lines = @contract.content.split("\n")
      signature_block = detect_signature_block(lines)

      lines.each_with_index do |line, index|
        if signature_block && index >= signature_block[:start]
          next
        elsif line.strip.empty?
          pdf.move_down PARAGRAPH_SPACING
        else
          pdf.text line.strip, size: BODY_FONT_SIZE, leading: BODY_LEADING, align: :justify
        end
      end

      if signature_block
        render_signatures(pdf, signature_block[:groups])
      end

      render_footer(pdf)
    end.render
  end

  private

  def detect_signature_block(lines)
    first_sig_index = lines.index { |l| l.match?(SIGNATURE_LINE_PATTERN) }
    return nil unless first_sig_index

    start_index = first_sig_index

    groups = []
    current_group = nil

    lines[first_sig_index..].each do |line|
      if line.match?(SIGNATURE_LINE_PATTERN)
        columns = split_signature_columns(line)
        current_group = { line_count: columns.size, labels: [] }
        groups << current_group
      elsif current_group && line.strip.present?
        labels = split_signature_columns(line)
        current_group[:labels] << labels
      end
    end

    { start: start_index, groups: groups }
  end

  def split_signature_columns(line)
    parts = line.strip.split(/\s{4,}/).map(&:strip).reject(&:blank?)
    parts.presence || [ line.strip ]
  end

  def render_signatures(pdf, groups)
    pdf.move_down 20

    content_width = pdf.bounds.width

    groups.each_with_index do |group, i|
      if group[:line_count] == 1
        render_single_signature(pdf, group, content_width)
      else
        render_dual_signature(pdf, group, content_width)
      end

      pdf.move_down 15 unless i == groups.size - 1
    end
  end

  def render_single_signature(pdf, group, content_width)
    col_width = 180
    x_offset = (content_width - col_width) / 2

    pdf.bounding_box([x_offset, pdf.cursor], width: col_width) do
      pdf.stroke_horizontal_rule
      pdf.move_down 4
      group[:labels].each do |label_row|
        pdf.text(label_row.first || "", size: BODY_FONT_SIZE, align: :center)
      end
    end
  end

  def render_dual_signature(pdf, group, content_width)
    col_width = 180
    gap = content_width - (col_width * 2)
    left_x = 0
    right_x = col_width + gap

    label_height = 4 + (group[:labels].size * 14)
    cursor_start = pdf.cursor

    pdf.bounding_box([left_x, cursor_start], width: col_width, height: label_height) do
      pdf.stroke_horizontal_rule
      pdf.move_down 4
      group[:labels].each do |label_row|
        pdf.text(label_row[0] || "", size: BODY_FONT_SIZE, align: :center)
      end
    end

    pdf.bounding_box([right_x, cursor_start], width: col_width, height: label_height) do
      pdf.stroke_horizontal_rule
      pdf.move_down 4
      group[:labels].each do |label_row|
        pdf.text(label_row[1] || label_row[0] || "", size: BODY_FONT_SIZE, align: :center)
      end
    end
  end

  def render_footer(pdf)
    pdf.move_down 15
    pdf.stroke_horizontal_rule
    pdf.move_down 4
    pdf.text "Documento generado por ContratoFácil", size: 7, color: "999999", align: :center
  end
end
