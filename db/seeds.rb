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
  t.field_config = {
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_locador" => { "label" => "Nombre del locador" },
    "ci_locador" => { "label" => "Cédula de identidad del locador", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_locador" => { "label" => "Domicilio del locador" },
    "nombre_locatario" => { "label" => "Nombre del locatario" },
    "ci_locatario" => { "label" => "Cédula de identidad del locatario", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_locatario" => { "label" => "Domicilio del locatario" },
    "direccion_inmueble" => { "label" => "Dirección del inmueble" },
    "destino_inmueble" => { "label" => "Destino del inmueble", "hint" => "Ej: vivienda, comercio, oficina" },
    "plazo_meses" => { "label" => "Plazo (meses)", "hint" => "Cantidad de meses (ej: 12)" },
    "fecha_inicio" => { "label" => "Fecha de inicio", "hint" => "Formato: dd/mm/aaaa (ej: 01/03/2026)" },
    "fecha_fin" => { "label" => "Fecha de fin", "hint" => "Formato: dd/mm/aaaa (ej: 01/03/2027)" },
    "monto_alquiler" => { "label" => "Monto del alquiler", "hint" => "Solo números, sin puntos ni comas (ej: 2500000)" },
    "monto_garantia" => { "label" => "Monto de garantía", "hint" => "Solo números, sin puntos ni comas (ej: 5000000)" },
    "servicios_a_cargo" => { "label" => "Servicios a cargo del locatario", "hint" => "Ej: agua, luz y teléfono" },
    "dia_pago" => { "label" => "Día de pago", "hint" => "Ingrese solo un número del 1 al 31 (ej: 5)" },
    "dias_preaviso" => { "label" => "Días de preaviso", "hint" => "Cantidad de días (ej: 30)" }
  }
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
  t.field_config = {
    "monto" => { "label" => "Monto", "hint" => "Solo números, sin puntos ni comas (ej: 5000000)" },
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_deudor" => { "label" => "Nombre del deudor" },
    "ci_deudor" => { "label" => "Cédula del deudor", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_deudor" => { "label" => "Domicilio del deudor" },
    "nombre_acreedor" => { "label" => "Nombre del acreedor" },
    "ci_acreedor" => { "label" => "Cédula del acreedor", "hint" => "Sin puntos (ej: 1234567)" },
    "ciudad_pago" => { "label" => "Ciudad de pago" },
    "fecha_vencimiento" => { "label" => "Fecha de vencimiento", "hint" => "Formato: dd/mm/aaaa (ej: 01/06/2026)" },
    "tasa_interes" => { "label" => "Tasa de interés mensual (%)", "hint" => "Solo el número (ej: 2.5)" }
  }
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
  t.field_config = {
    "numero_recibo" => { "label" => "Número de recibo" },
    "monto" => { "label" => "Monto", "hint" => "Solo números, sin puntos ni comas (ej: 5000000)" },
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_receptor" => { "label" => "Nombre del receptor" },
    "ci_receptor" => { "label" => "Cédula del receptor", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_receptor" => { "label" => "Domicilio del receptor" },
    "nombre_pagador" => { "label" => "Nombre del pagador" },
    "ci_pagador" => { "label" => "Cédula del pagador", "hint" => "Sin puntos (ej: 1234567)" },
    "concepto" => { "label" => "Concepto", "hint" => "Ej: pago de alquiler mes de marzo" },
    "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: efectivo, transferencia bancaria, cheque" }
  }
end

ContractTemplate.find_or_create_by!(name: "Contrato de Compraventa de Inmueble") do |t|
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
  t.field_config = {
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_vendedor" => { "label" => "Nombre del vendedor" },
    "ci_vendedor" => { "label" => "Cédula del vendedor", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_vendedor" => { "label" => "Domicilio del vendedor" },
    "nombre_comprador" => { "label" => "Nombre del comprador" },
    "ci_comprador" => { "label" => "Cédula del comprador", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_comprador" => { "label" => "Domicilio del comprador" },
    "direccion_inmueble" => { "label" => "Dirección del inmueble" },
    "numero_finca" => { "label" => "Número de finca", "hint" => "Número de inscripción en Registros Públicos" },
    "distrito" => { "label" => "Distrito" },
    "precio_total" => { "label" => "Precio total", "hint" => "Solo números, sin puntos ni comas (ej: 150000000)" },
    "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: contado, cuotas mensuales" },
    "fecha_entrega" => { "label" => "Fecha de entrega", "hint" => "Formato: dd/mm/aaaa (ej: 01/06/2026)" },
    "responsable_gastos" => { "label" => "Responsable de gastos", "hint" => "Ej: el comprador, ambas partes por mitades" }
  }
end

ContractTemplate.find_or_create_by!(name: "Contrato de Compraventa de Autovehículo") do |t|
  t.category = "Automotor"
  t.description = "Contrato de compraventa de vehículo automotor para uso en Paraguay."
  t.body = <<~BODY
    CONTRATO DE COMPRAVENTA DE AUTOVEHÍCULO

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente contrato de compraventa entre:

    VENDEDOR: {{nombre_vendedor}}, con Cédula de Identidad Nº {{ci_vendedor}}, con domicilio en {{domicilio_vendedor}}, en adelante denominado "EL VENDEDOR".

    COMPRADOR: {{nombre_comprador}}, con Cédula de Identidad Nº {{ci_comprador}}, con domicilio en {{domicilio_comprador}}, en adelante denominado "EL COMPRADOR".

    CLÁUSULA PRIMERA - OBJETO: EL VENDEDOR vende y transfiere a EL COMPRADOR, quien acepta y adquiere, el vehículo con las siguientes características:
    - Marca: {{marca_vehiculo}}
    - Modelo: {{modelo_vehiculo}}
    - Año: {{anio_vehiculo}}
    - Color: {{color_vehiculo}}
    - Chapa Nº: {{chapa_vehiculo}}
    - Chasis Nº: {{chasis_vehiculo}}
    - Motor Nº: {{motor_vehiculo}}

    CLÁUSULA SEGUNDA - PRECIO: El precio total de la compraventa se fija en la suma de Guaraníes {{precio_total}} (Gs. {{precio_total}}), que será pagado de la siguiente forma: {{forma_pago}}.

    CLÁUSULA TERCERA - ESTADO: EL COMPRADOR declara conocer el estado actual del vehículo y lo acepta en las condiciones en que se encuentra.

    CLÁUSULA CUARTA - TRANSFERENCIA: EL VENDEDOR se compromete a realizar la transferencia del vehículo ante la Municipalidad correspondiente dentro de los {{dias_transferencia}} días hábiles siguientes a la firma del presente contrato.

    CLÁUSULA QUINTA - GRAVÁMENES: EL VENDEDOR declara que el vehículo se encuentra libre de todo gravamen, prenda, embargo o cualquier otro tipo de restricción. En caso contrario, será responsable de los daños y perjuicios que esto ocasione a EL COMPRADOR.

    CLÁUSULA SEXTA - JURISDICCIÓN: Para todos los efectos legales derivados del presente contrato, las partes se someten a la jurisdicción de los Tribunales de la ciudad de {{ciudad}}.

    En prueba de conformidad, las partes firman el presente contrato en dos ejemplares de un mismo tenor y a un solo efecto.


    _________________________          _________________________
    EL VENDEDOR                        EL COMPRADOR
    {{nombre_vendedor}}                {{nombre_comprador}}
  BODY
  t.field_config = {
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_vendedor" => { "label" => "Nombre del vendedor" },
    "ci_vendedor" => { "label" => "Cédula del vendedor", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_vendedor" => { "label" => "Domicilio del vendedor" },
    "nombre_comprador" => { "label" => "Nombre del comprador" },
    "ci_comprador" => { "label" => "Cédula del comprador", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_comprador" => { "label" => "Domicilio del comprador" },
    "marca_vehiculo" => { "label" => "Marca del vehículo", "hint" => "Ej: Toyota, Hyundai, Kia" },
    "modelo_vehiculo" => { "label" => "Modelo del vehículo", "hint" => "Ej: Hilux, Tucson, Sportage" },
    "anio_vehiculo" => { "label" => "Año del vehículo", "hint" => "Ej: 2020" },
    "color_vehiculo" => { "label" => "Color del vehículo" },
    "chapa_vehiculo" => { "label" => "Número de chapa" },
    "chasis_vehiculo" => { "label" => "Número de chasis" },
    "motor_vehiculo" => { "label" => "Número de motor" },
    "precio_total" => { "label" => "Precio total", "hint" => "Solo números, sin puntos ni comas (ej: 80000000)" },
    "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: contado, cuotas mensuales" },
    "dias_transferencia" => { "label" => "Días para transferencia", "hint" => "Cantidad de días hábiles (ej: 15)" }
  }
end

ContractTemplate.find_or_create_by!(name: "Contrato de Préstamo entre Personas") do |t|
  t.category = "Financiero"
  t.description = "Contrato de préstamo de dinero entre personas físicas para uso en Paraguay."
  t.body = <<~BODY
    CONTRATO DE PRÉSTAMO DE DINERO ENTRE PERSONAS

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente contrato de préstamo entre:

    PRESTAMISTA: {{nombre_prestamista}}, con Cédula de Identidad Nº {{ci_prestamista}}, con domicilio en {{domicilio_prestamista}}, en adelante denominado "EL PRESTAMISTA".

    PRESTATARIO: {{nombre_prestatario}}, con Cédula de Identidad Nº {{ci_prestatario}}, con domicilio en {{domicilio_prestatario}}, en adelante denominado "EL PRESTATARIO".

    CLÁUSULA PRIMERA - OBJETO: EL PRESTAMISTA entrega en este acto a EL PRESTATARIO la suma de Guaraníes {{monto_prestamo}} (Gs. {{monto_prestamo}}) en concepto de préstamo de dinero.

    CLÁUSULA SEGUNDA - PLAZO: EL PRESTATARIO se compromete a devolver la totalidad del préstamo en un plazo de {{plazo_meses}} meses, contados a partir de la fecha de firma del presente contrato, venciendo el {{fecha_vencimiento}}.

    CLÁUSULA TERCERA - INTERÉS: Las partes acuerdan una tasa de interés del {{tasa_interes}} por ciento mensual sobre el saldo adeudado. El interés se pagará {{periodicidad_interes}}.

    CLÁUSULA CUARTA - FORMA DE PAGO: EL PRESTATARIO realizará los pagos de la siguiente forma: {{forma_pago}}.

    CLÁUSULA QUINTA - MORA: En caso de mora en el pago de cualquier cuota, se aplicará un interés moratorio adicional del {{tasa_mora}} por ciento mensual sobre el monto en mora.

    CLÁUSULA SEXTA - PAGO ANTICIPADO: EL PRESTATARIO podrá realizar pagos anticipados sin penalidad, los cuales se aplicarán al capital adeudado.

    CLÁUSULA SÉPTIMA - GARANTÍA: Como garantía del presente préstamo, EL PRESTATARIO ofrece {{garantia}}.

    CLÁUSULA OCTAVA - JURISDICCIÓN: Para todos los efectos legales derivados del presente contrato, las partes se someten a la jurisdicción de los Tribunales de la ciudad de {{ciudad}}.

    En prueba de conformidad, las partes firman el presente contrato en dos ejemplares de un mismo tenor y a un solo efecto.


    _________________________          _________________________
    EL PRESTAMISTA                     EL PRESTATARIO
    {{nombre_prestamista}}             {{nombre_prestatario}}
  BODY
  t.field_config = {
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_prestamista" => { "label" => "Nombre del prestamista" },
    "ci_prestamista" => { "label" => "Cédula del prestamista", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_prestamista" => { "label" => "Domicilio del prestamista" },
    "nombre_prestatario" => { "label" => "Nombre del prestatario" },
    "ci_prestatario" => { "label" => "Cédula del prestatario", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_prestatario" => { "label" => "Domicilio del prestatario" },
    "monto_prestamo" => { "label" => "Monto del préstamo", "hint" => "Solo números, sin puntos ni comas (ej: 10000000)" },
    "plazo_meses" => { "label" => "Plazo (meses)", "hint" => "Cantidad de meses (ej: 12)" },
    "fecha_vencimiento" => { "label" => "Fecha de vencimiento", "hint" => "Formato: dd/mm/aaaa (ej: 01/03/2027)" },
    "tasa_interes" => { "label" => "Tasa de interés mensual (%)", "hint" => "Solo el número (ej: 2.5)" },
    "periodicidad_interes" => { "label" => "Periodicidad del interés", "hint" => "Ej: mensualmente, junto con cada cuota" },
    "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: 12 cuotas mensuales de Gs. 900.000" },
    "tasa_mora" => { "label" => "Tasa de interés moratorio (%)", "hint" => "Solo el número (ej: 1)" },
    "garantia" => { "label" => "Garantía", "hint" => "Ej: un pagaré por el monto total, un vehículo marca X" }
  }
end

ContractTemplate.find_or_create_by!(name: "Contrato de Trabajo Informal") do |t|
  t.category = "Laboral"
  t.description = "Contrato de trabajo para relaciones laborales informales en Paraguay."
  t.body = <<~BODY
    CONTRATO DE TRABAJO

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente contrato de trabajo entre:

    EMPLEADOR: {{nombre_empleador}}, con Cédula de Identidad Nº {{ci_empleador}}, con domicilio en {{domicilio_empleador}}, en adelante denominado "EL EMPLEADOR".

    TRABAJADOR: {{nombre_trabajador}}, con Cédula de Identidad Nº {{ci_trabajador}}, con domicilio en {{domicilio_trabajador}}, en adelante denominado "EL TRABAJADOR".

    CLÁUSULA PRIMERA - OBJETO: EL EMPLEADOR contrata los servicios de EL TRABAJADOR para desempeñar las funciones de {{cargo}} en {{lugar_trabajo}}.

    CLÁUSULA SEGUNDA - PLAZO: El presente contrato tendrá una duración de {{plazo_meses}} meses, comenzando a regir desde el {{fecha_inicio}}.

    CLÁUSULA TERCERA - JORNADA: La jornada laboral será de {{horas_diarias}} horas diarias, de {{horario_inicio}} a {{horario_fin}}, de {{dias_laborales}}.

    CLÁUSULA CUARTA - REMUNERACIÓN: EL EMPLEADOR pagará a EL TRABAJADOR la suma de Guaraníes {{salario}} (Gs. {{salario}}) en forma {{periodicidad_pago}}, por los servicios prestados.

    CLÁUSULA QUINTA - OBLIGACIONES DEL TRABAJADOR: EL TRABAJADOR se obliga a: a) Cumplir con las funciones asignadas con diligencia y responsabilidad; b) Respetar el horario establecido; c) Cuidar los materiales y herramientas de trabajo.

    CLÁUSULA SEXTA - OBLIGACIONES DEL EMPLEADOR: EL EMPLEADOR se obliga a: a) Pagar puntualmente la remuneración acordada; b) Proporcionar los materiales necesarios para el trabajo; c) Respetar la dignidad del trabajador.

    CLÁUSULA SÉPTIMA - RESCISIÓN: Cualquiera de las partes podrá rescindir el presente contrato con un preaviso de {{dias_preaviso}} días.

    En prueba de conformidad, las partes firman el presente contrato en dos ejemplares de un mismo tenor y a un solo efecto.


    _________________________          _________________________
    EL EMPLEADOR                       EL TRABAJADOR
    {{nombre_empleador}}               {{nombre_trabajador}}
  BODY
  t.field_config = {
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_empleador" => { "label" => "Nombre del empleador" },
    "ci_empleador" => { "label" => "Cédula del empleador", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_empleador" => { "label" => "Domicilio del empleador" },
    "nombre_trabajador" => { "label" => "Nombre del trabajador" },
    "ci_trabajador" => { "label" => "Cédula del trabajador", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_trabajador" => { "label" => "Domicilio del trabajador" },
    "cargo" => { "label" => "Cargo o función", "hint" => "Ej: empleada doméstica, jardinero, albañil" },
    "lugar_trabajo" => { "label" => "Lugar de trabajo" },
    "plazo_meses" => { "label" => "Plazo (meses)", "hint" => "Cantidad de meses (ej: 6)" },
    "fecha_inicio" => { "label" => "Fecha de inicio", "hint" => "Formato: dd/mm/aaaa (ej: 01/03/2026)" },
    "horas_diarias" => { "label" => "Horas diarias", "hint" => "Ej: 8" },
    "horario_inicio" => { "label" => "Horario de inicio", "hint" => "Ej: 07:00" },
    "horario_fin" => { "label" => "Horario de fin", "hint" => "Ej: 15:00" },
    "dias_laborales" => { "label" => "Días laborales", "hint" => "Ej: lunes a viernes, lunes a sábado" },
    "salario" => { "label" => "Salario", "hint" => "Solo números, sin puntos ni comas (ej: 2800000)" },
    "periodicidad_pago" => { "label" => "Periodicidad de pago", "hint" => "Ej: mensual, quincenal, semanal" },
    "dias_preaviso" => { "label" => "Días de preaviso", "hint" => "Cantidad de días (ej: 30)" }
  }
end

ContractTemplate.find_or_create_by!(name: "Contrato de Prestación de Servicios") do |t|
  t.category = "Servicios"
  t.description = "Contrato de prestación de servicios profesionales para uso en Paraguay."
  t.body = <<~BODY
    CONTRATO DE PRESTACIÓN DE SERVICIOS

    En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente contrato de prestación de servicios entre:

    CONTRATANTE: {{nombre_contratante}}, con Cédula de Identidad Nº {{ci_contratante}}, con domicilio en {{domicilio_contratante}}, en adelante denominado "EL CONTRATANTE".

    PRESTADOR: {{nombre_prestador}}, con Cédula de Identidad Nº {{ci_prestador}}, con domicilio en {{domicilio_prestador}}, en adelante denominado "EL PRESTADOR".

    CLÁUSULA PRIMERA - OBJETO: EL PRESTADOR se compromete a realizar los siguientes servicios: {{descripcion_servicio}}.

    CLÁUSULA SEGUNDA - PLAZO: El servicio será realizado en un plazo de {{plazo_dias}} días, contados a partir de la fecha de firma del presente contrato, debiendo completarse a más tardar el {{fecha_entrega}}.

    CLÁUSULA TERCERA - HONORARIOS: EL CONTRATANTE pagará a EL PRESTADOR la suma de Guaraníes {{monto_honorarios}} (Gs. {{monto_honorarios}}) por los servicios prestados, que será pagado de la siguiente forma: {{forma_pago}}.

    CLÁUSULA CUARTA - OBLIGACIONES DEL PRESTADOR: EL PRESTADOR se obliga a: a) Realizar el servicio con la debida diligencia y profesionalismo; b) Cumplir con los plazos establecidos; c) Utilizar materiales de buena calidad cuando corresponda.

    CLÁUSULA QUINTA - OBLIGACIONES DEL CONTRATANTE: EL CONTRATANTE se obliga a: a) Pagar puntualmente los honorarios acordados; b) Proporcionar la información y accesos necesarios para la ejecución del servicio; c) Recibir el servicio conforme a lo acordado.

    CLÁUSULA SEXTA - CONFIDENCIALIDAD: Ambas partes se comprometen a mantener la confidencialidad de toda información intercambiada durante la ejecución del presente contrato.

    CLÁUSULA SÉPTIMA - RESCISIÓN: Cualquiera de las partes podrá rescindir el presente contrato con un preaviso de {{dias_preaviso}} días. En caso de rescisión, se pagarán los servicios efectivamente prestados hasta la fecha.

    CLÁUSULA OCTAVA - JURISDICCIÓN: Para todos los efectos legales derivados del presente contrato, las partes se someten a la jurisdicción de los Tribunales de la ciudad de {{ciudad}}.

    En prueba de conformidad, las partes firman el presente contrato en dos ejemplares de un mismo tenor y a un solo efecto.


    _________________________          _________________________
    EL CONTRATANTE                     EL PRESTADOR
    {{nombre_contratante}}             {{nombre_prestador}}
  BODY
  t.field_config = {
    "ciudad" => { "label" => "Ciudad" },
    "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
    "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
    "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
    "nombre_contratante" => { "label" => "Nombre del contratante" },
    "ci_contratante" => { "label" => "Cédula del contratante", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_contratante" => { "label" => "Domicilio del contratante" },
    "nombre_prestador" => { "label" => "Nombre del prestador de servicios" },
    "ci_prestador" => { "label" => "Cédula del prestador", "hint" => "Sin puntos (ej: 1234567)" },
    "domicilio_prestador" => { "label" => "Domicilio del prestador" },
    "descripcion_servicio" => { "label" => "Descripción del servicio", "hint" => "Describa detalladamente el servicio a realizar" },
    "plazo_dias" => { "label" => "Plazo (días)", "hint" => "Cantidad de días (ej: 30)" },
    "fecha_entrega" => { "label" => "Fecha de entrega", "hint" => "Formato: dd/mm/aaaa (ej: 01/06/2026)" },
    "monto_honorarios" => { "label" => "Monto de honorarios", "hint" => "Solo números, sin puntos ni comas (ej: 5000000)" },
    "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: 50% al inicio, 50% al finalizar" },
    "dias_preaviso" => { "label" => "Días de preaviso", "hint" => "Cantidad de días (ej: 15)" }
  }
end

# Test user for local development
test_user = User.find_or_create_by!(email: "test@contratofacil.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
end
puts "Usuario de prueba: #{test_user.email} / password123 (Plan: #{test_user.plan_name})"

puts "Seed completado: #{ContractTemplate.count} plantillas disponibles."
