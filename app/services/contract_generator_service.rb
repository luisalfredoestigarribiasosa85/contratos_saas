class ContractGeneratorService
  def initialize(template:, data:)
    @template = template
    @data = data.stringify_keys
  end

  def call
    content = @template.body.dup
    @template.placeholders.each do |placeholder|
      content.gsub!("{{#{placeholder}}}", @data.fetch(placeholder, ""))
    end
    content
  end
end
