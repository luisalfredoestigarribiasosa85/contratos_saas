class ContractPdfService
  def initialize(contract)
    @contract = contract
  end

  def call
    Prawn::Document.new(page_size: "A4", margin: 50) do |pdf|
      pdf.font "Helvetica"

      pdf.text @contract.title, size: 18, style: :bold, align: :center
      pdf.move_down 20

      pdf.text "Fecha de generación: #{I18n.l(@contract.created_at.to_date, format: :long)}", size: 10, color: "666666"
      pdf.move_down 20

      lines = @contract.content.split("\n")
      signature_block = detect_signature_block(lines)

      lines.each_with_index do |line, index|
        if signature_block && index >= signature_block[:start]
          # Skip — rendered separately below
          next
        elsif line.strip.empty?
          pdf.move_down 10
        else
          pdf.text line.strip, size: 11, leading: 4, align: :justify
        end
      end

      if signature_block
        render_signatures(pdf, signature_block[:groups])
      end

      pdf.move_down 40
      pdf.stroke_horizontal_rule
      pdf.move_down 5
      pdf.text "Documento generado por ContratoFácil", size: 8, color: "999999", align: :center
    end.render
  end

  private

  SIGNATURE_LINE_PATTERN = /_{5,}/

  def detect_signature_block(lines)
    # Find the first line containing underscores (signature lines)
    first_sig_index = lines.index { |l| l.match?(SIGNATURE_LINE_PATTERN) }
    return nil unless first_sig_index

    # Walk backwards to include preceding blank lines as spacing
    start_index = first_sig_index
    start_index -= 1 while start_index > 0 && lines[start_index - 1].strip.empty?

    # Extract signature groups: each group starts with a line containing underscores
    groups = []
    current_group = nil

    lines[first_sig_index..].each do |line|
      if line.match?(SIGNATURE_LINE_PATTERN)
        # This line may contain one or two signature columns (separated by spaces)
        columns = split_signature_columns(line)
        current_group = { line_count: columns.size, labels: [] }
        groups << current_group
      elsif current_group && line.strip.present?
        # Label lines below the signature line
        labels = split_signature_columns(line)
        current_group[:labels] << labels
      end
    end

    { start: start_index, groups: groups }
  end

  def split_signature_columns(line)
    # Split a line into columns when there are 4+ spaces between non-empty parts
    parts = line.strip.split(/\s{4,}/).map(&:strip).reject(&:blank?)
    parts.presence || [ line.strip ]
  end

  def render_signatures(pdf, groups)
    pdf.move_down 40

    content_width = pdf.bounds.width

    groups.each do |group|
      columns = group[:line_count]

      if columns == 1
        # Single signature — centered
        render_single_signature(pdf, group, content_width)
      else
        # Two signatures — side by side
        render_dual_signature(pdf, group, content_width)
      end

      pdf.move_down 30
    end
  end

  def render_single_signature(pdf, group, content_width)
    col_width = 200
    x_offset = (content_width - col_width) / 2

    pdf.bounding_box([x_offset, pdf.cursor], width: col_width) do
      pdf.stroke_horizontal_rule
      pdf.move_down 5
      group[:labels].each do |label_row|
        text = label_row.first || ""
        pdf.text text, size: 11, align: :center
      end
    end
  end

  def render_dual_signature(pdf, group, content_width)
    col_width = 200
    gap = content_width - (col_width * 2)
    left_x = 0
    right_x = col_width + gap

    cursor_start = pdf.cursor

    # Left signature
    pdf.bounding_box([left_x, cursor_start], width: col_width) do
      pdf.stroke_horizontal_rule
      pdf.move_down 5
      group[:labels].each do |label_row|
        text = label_row[0] || ""
        pdf.text text, size: 11, align: :center
      end
    end

    # Right signature
    pdf.bounding_box([right_x, cursor_start], width: col_width) do
      pdf.stroke_horizontal_rule
      pdf.move_down 5
      group[:labels].each do |label_row|
        text = label_row[1] || label_row[0] || ""
        pdf.text text, size: 11, align: :center
      end
    end
  end
end
