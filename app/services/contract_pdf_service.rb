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

      @contract.content.split("\n").each do |line|
        if line.strip.empty?
          pdf.move_down 10
        else
          pdf.text line.strip, size: 11, leading: 4, align: :justify
        end
      end

      pdf.move_down 40
      pdf.stroke_horizontal_rule
      pdf.move_down 5
      pdf.text "Documento generado por ContratoFácil", size: 8, color: "999999", align: :center
    end.render
  end
end
