ContractTemplate.find_or_create_by!(name: "Contrato de Alquiler") do |t|
  t.category = "Inmobiliario"
  t.description = "Contrato estándar de alquiler de inmueble para uso en Paraguay."
  t.body = <<~BODY
    CONTRATO DE ALQUILER DE INMUEBLE

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente contrato de alquiler entre:

    LOCADOR: {{nombre_locador}}, con Cédula de Identidad Nº {{ci_locador}}, con domicilio en {{domicilio_locador}}, en adelante denominado "EL LOCADOR".

    LOCATARIO: {{nombre_locatario}}, con Cédula de Identidad Nº {{ci_locatario}}, con domicilio en {{domicilio_locatario}}, en adelante denominado "EL LOCATARIO".

    CLÁUSULA PRIMERA - OBJETO: EL LOCADOR da en alquiler a EL LOCATARIO el inmueble ubicado en {{direccion_inmueble}}, de la ciudad de {{ciudad}}, que será destinado exclusivamente para {{destino_inmueble}}.

    CLÁUSULA SEGUNDA - PLAZO: El plazo del presente contrato es de {{plazo_meses}} meses, comenzando a regir desde el {{fecha_inicio}} hasta el {{fecha_fin}}.

    CLÁUSULA TERCERA - PRECIO: El precio del alquiler mensual se fija en la suma de Guaraníes {{monto_alquiler}} (Gs. {{monto_alquiler}}), que EL LOCATARIO se compromete a pagar dentro de los primeros {{dia_pago}} días de cada mes.

    CLÁUSULA CUARTA - GARANTÍA: EL LOCATARIO entrega en este acto la suma de Guaraníes {{monto_garantia}} (Gs. {{monto_garantia}}) en concepto de depósito de garantía, que será devuelta al finalizar el contrato, previa verificación del estado del inmueble.

    CLÁUSULA QUINTA - OBLIGACIONES DEL LOCATARIO: EL LOCATARIO se obliga a: a) Mantener el inmueble en buen estado de conservación; b) No realizar modificaciones sin autorización escrita del LOCADOR; c) Pagar puntualmente los servicios de {{servicios_a_cargo}}.

    CLÁUSULA SEXTA - RESCISIÓN: Cualquiera de las partes podrá rescindir el presente contrato con un preaviso de {{dias_preaviso}} días.

    En prueba de conformidad, las partes firman el presente contrato en dos ejemplares de un mismo tenor y a un solo efecto.


    _________________________          _________________________
    EL LOCADOR                         EL LOCATARIO
    {{nombre_locador}}                 {{nombre_locatario}}
  BODY
end

ContractTemplate.find_or_create_by!(name: "Pagaré") do |t|
  t.category = "Financiero"
  t.description = "Documento de pagaré conforme a la legislación paraguaya."
  t.body = <<~BODY
    PAGARÉ

    Monto: Guaraníes {{monto}} (Gs. {{monto}})

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}.

    Por el presente PAGARÉ, yo, {{nombre_deudor}}, con Cédula de Identidad Nº {{ci_deudor}}, con domicilio en {{domicilio_deudor}}, me obligo a pagar incondicionalmente a la orden de {{nombre_acreedor}}, con Cédula de Identidad Nº {{ci_acreedor}}, la suma de GUARANÍES {{monto}} (Gs. {{monto}}), en la ciudad de {{ciudad_pago}}, el día {{fecha_vencimiento}}.

    En caso de mora, se aplicará un interés del {{tasa_interes}} por ciento mensual sobre el saldo adeudado.

    El presente pagaré se rige por las disposiciones del Código Civil Paraguayo y leyes complementarias.


    _________________________
    DEUDOR
    {{nombre_deudor}}
    C.I. Nº {{ci_deudor}}
  BODY
end

ContractTemplate.find_or_create_by!(name: "Recibo de Dinero") do |t|
  t.category = "Financiero"
  t.description = "Recibo estándar de dinero para uso general en Paraguay."
  t.body = <<~BODY
    RECIBO DE DINERO

    Recibo Nº: {{numero_recibo}}
    Monto: Guaraníes {{monto}} (Gs. {{monto}})

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}.

    Yo, {{nombre_receptor}}, con Cédula de Identidad Nº {{ci_receptor}}, con domicilio en {{domicilio_receptor}}, declaro haber recibido de {{nombre_pagador}}, con Cédula de Identidad Nº {{ci_pagador}}, la suma de GUARANÍES {{monto}} (Gs. {{monto}}), en concepto de {{concepto}}.

    Forma de pago: {{forma_pago}}

    El presente recibo se expide como constancia de pago a los efectos legales correspondientes.


    _________________________
    RECEPTOR
    {{nombre_receptor}}
    C.I. Nº {{ci_receptor}}
  BODY
end

ContractTemplate.find_or_create_by!(name: "Contrato de Compraventa") do |t|
  t.category = "Inmobiliario"
  t.description = "Contrato de compraventa de inmueble para uso en Paraguay."
  t.body = <<~BODY
    CONTRATO DE COMPRAVENTA DE INMUEBLE

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente contrato de compraventa entre:

    VENDEDOR: {{nombre_vendedor}}, con Cédula de Identidad Nº {{ci_vendedor}}, con domicilio en {{domicilio_vendedor}}, en adelante denominado "EL VENDEDOR".

    COMPRADOR: {{nombre_comprador}}, con Cédula de Identidad Nº {{ci_comprador}}, con domicilio en {{domicilio_comprador}}, en adelante denominado "EL COMPRADOR".

    CLÁUSULA PRIMERA - OBJETO: EL VENDEDOR vende y transfiere a EL COMPRADOR, quien acepta y adquiere, el inmueble ubicado en {{direccion_inmueble}}, de la ciudad de {{ciudad}}, inscrito en la Dirección General de los Registros Públicos bajo la Finca Nº {{numero_finca}}, del Distrito de {{distrito}}.

    CLÁUSULA SEGUNDA - PRECIO: El precio total de la compraventa se fija en la suma de Guaraníes {{precio_total}} (Gs. {{precio_total}}), que será pagado de la siguiente forma: {{forma_pago}}.

    CLÁUSULA TERCERA - ENTREGA: EL VENDEDOR se compromete a entregar el inmueble en la fecha {{fecha_entrega}}, libre de todo gravamen, hipoteca, embargo o cualquier otro tipo de restricción.

    CLÁUSULA CUARTA - GASTOS: Los gastos de escrituración, impuestos y tasas serán a cargo de {{responsable_gastos}}.

    CLÁUSULA QUINTA - EVICCIÓN Y VICIOS: EL VENDEDOR garantiza la evicción y saneamiento del inmueble conforme a las disposiciones del Código Civil Paraguayo.

    CLÁUSULA SEXTA - JURISDICCIÓN: Para todos los efectos legales derivados del presente contrato, las partes se someten a la jurisdicción de los Tribunales de la ciudad de {{ciudad}}.

    En prueba de conformidad, las partes firman el presente contrato en dos ejemplares de un mismo tenor y a un solo efecto.


    _________________________          _________________________
    EL VENDEDOR                        EL COMPRADOR
    {{nombre_vendedor}}                {{nombre_comprador}}
  BODY
end

puts "Seed completado: #{ContractTemplate.count} plantillas creadas."
