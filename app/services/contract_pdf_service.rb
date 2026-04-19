class ContractPdfService
  BODY_FONT_SIZE = 9.5
  BODY_LEADING = 2
  PARAGRAPH_SPACING = 5
  TITLE_FONT_SIZE = 14
  SIGNATURE_LINE_PATTERN = /_{5,}/

  def initialize(contract, user: nil)
    @contract = contract
    @user = user
    @company = user&.current_company
  end

  def call
    Prawn::Document.new(page_size: "A4", margin: [ 40, 50, 40, 50 ]) do |pdf|
      pdf.font "Helvetica"

      render_watermark(pdf) if show_watermark?
      render_company_logo(pdf) if show_company_logo?

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

  def show_watermark?
    @user.nil? || @user.free?
  end

  def show_company_logo?
    @company&.logo&.attached? && @user&.can_use_business_features?
  end

  def render_company_logo(pdf)
    return unless @company&.logo&.attached?
    
    begin
      logo_data = StringIO.new(@company.logo.download)
      pdf.image logo_data, 
        width: 100, 
        position: :center,
        vposition: :top
      pdf.move_down 10
    rescue => e
      # Si hay error al cargar el logo, continuar sin él
      Rails.logger.error "Error loading company logo: #{e.message}"
    end
  end

  def render_watermark(pdf)
    pdf.canvas do
      # Configurar transparencia visible pero sutil
      pdf.transparent(0.12) do
        pdf.fill_color "AAAAAA"
        
        # Crear un patrón repetido en toda la hoja
        page_width = pdf.bounds.width
        page_height = pdf.bounds.height
        
        # Espaciado entre marcas de agua
        x_spacing = 180
        y_spacing = 120
        
        # Calcular cuántas marcas caben en la página
        x_count = (page_width / x_spacing).to_i + 1
        y_count = (page_height / y_spacing).to_i + 1
        
        # Generar la cuadrícula de marcas de agua
        x_count.times do |x|
          y_count.times do |y|
            x_pos = x * x_spacing - 50
            y_pos = y * y_spacing - 30
            
            # Solo renderizar si está dentro de los bounds de la página
            next if x_pos < -50 || x_pos > page_width || y_pos < -50 || y_pos > page_height
            
            pdf.rotate(45, origin: [ x_pos + 60, y_pos ]) do
              pdf.draw_text "ContratoFácil",
                at: [ x_pos, y_pos ],
                size: 16,
                style: :italic
            end
          end
        end
      end
    end
  end

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

    pdf.bounding_box([ x_offset, pdf.cursor ], width: col_width) do
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

    pdf.bounding_box([ left_x, cursor_start ], width: col_width, height: label_height) do
      pdf.stroke_horizontal_rule
      pdf.move_down 4
      group[:labels].each do |label_row|
        pdf.text(label_row[0] || "", size: BODY_FONT_SIZE, align: :center)
      end
    end

    pdf.bounding_box([ right_x, cursor_start ], width: col_width, height: label_height) do
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
