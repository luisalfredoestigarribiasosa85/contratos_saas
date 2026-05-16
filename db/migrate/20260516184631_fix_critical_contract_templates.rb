class FixCriticalContractTemplates < ActiveRecord::Migration[8.1]
  def up
    # Rename "Contrato de Compraventa de Inmueble" -> "Boleto de Compraventa de Inmueble"
    execute <<~SQL
      UPDATE contract_templates
      SET name = 'Boleto de Compraventa de Inmueble'
      WHERE name = 'Contrato de Compraventa de Inmueble'
    SQL

    updates = [
      {
        name: "Pagaré",
        category: "Financiero",
        description: "Pagaré conforme a la Ley N° 805/96 del Paraguay. Incluye los requisitos formales del título ejecutivo.",
        body: <<~BODY,
          PAGARÉ

          Importe: Gs. {{monto_numeros}}
          Vencimiento: {{fecha_vencimiento}}
          Lugar de emisión: {{ciudad}}, República del Paraguay
          Fecha de emisión: {{dia}} de {{mes}} de {{anio}}

          Por el presente PAGARÉ, yo, {{nombre_deudor}}, con Cédula de Identidad N° {{ci_deudor}}, con domicilio en {{domicilio_deudor}}, me obligo a pagar incondicional, pura y simplemente, a la orden de {{nombre_acreedor}}, con Cédula de Identidad N° {{ci_acreedor}}, con domicilio en {{domicilio_acreedor}}, la suma de GUARANÍES {{monto_letras}} (Gs. {{monto_numeros}}), pagaderos en la ciudad de {{ciudad_pago}}, República del Paraguay, el día {{fecha_vencimiento}}.

          CLÁUSULA PRIMERA - INTERÉS COMPENSATORIO: La presente obligación devengará un interés compensatorio del {{tasa_interes}}% mensual desde la fecha de emisión hasta su efectivo pago, dentro de los límites establecidos por la Ley N° 2.339/03 y demás normas concordantes.

          CLÁUSULA SEGUNDA - MORA E INTERÉS MORATORIO: La mora se producirá de pleno derecho por el solo vencimiento del plazo, sin necesidad de interpelación judicial o extrajudicial alguna, conforme al artículo 424 del Código Civil Paraguayo. En caso de mora, se devengará adicionalmente un interés moratorio del {{tasa_mora}}% mensual sobre el monto adeudado, respetando los topes legales vigentes.

          CLÁUSULA TERCERA - SIN PROTESTO: El presente pagaré se libra con la cláusula "SIN PROTESTO", quedando dispensado el acreedor de levantar protesto por falta de pago para conservar sus acciones cambiarias, conforme a la Ley N° 805/96.

          CLÁUSULA CUARTA - AVAL: {{aval}}

          CLÁUSULA QUINTA - ENDOSO: El presente pagaré es libremente transmisible por endoso, conforme a las disposiciones de la Ley N° 805/96, salvo que el portador hubiere insertado la cláusula "no a la orden".

          CLÁUSULA SEXTA - JURISDICCIÓN: Para todos los efectos legales derivados del presente pagaré, el suscriptor se somete expresamente a la jurisdicción de los Tribunales Ordinarios de la ciudad de {{ciudad_pago}}, con renuncia a cualquier otro fuero o jurisdicción que pudiera corresponder.

          CLÁUSULA SÉPTIMA - GASTOS: Todos los gastos, costas y honorarios derivados del cobro judicial o extrajudicial del presente pagaré serán de exclusiva responsabilidad del suscriptor.

          Firmo el presente PAGARÉ en señal de conformidad y aceptación de todas sus cláusulas.


          _________________________
          {{nombre_deudor}}
          C.I. N° {{ci_deudor}}
          EL DEUDOR / SUSCRIPTOR
        BODY
        field_config: {
          "monto_numeros" => { "label" => "Monto en números (Gs.)", "hint" => "Solo números, sin puntos ni comas (ej: 5000000)" },
          "monto_letras" => { "label" => "Monto en letras", "hint" => "Ej: CINCO MILLONES" },
          "ciudad" => { "label" => "Ciudad de emisión" },
          "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
          "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
          "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
          "nombre_deudor" => { "label" => "Nombre del deudor" },
          "ci_deudor" => { "label" => "Cédula del deudor", "hint" => "Sin puntos (ej: 1234567)" },
          "domicilio_deudor" => { "label" => "Domicilio del deudor" },
          "nombre_acreedor" => { "label" => "Nombre del acreedor" },
          "ci_acreedor" => { "label" => "Cédula del acreedor", "hint" => "Sin puntos (ej: 1234567)" },
          "domicilio_acreedor" => { "label" => "Domicilio del acreedor" },
          "ciudad_pago" => { "label" => "Ciudad de pago" },
          "fecha_vencimiento" => { "label" => "Fecha de vencimiento", "hint" => "Formato: dd/mm/aaaa (ej: 01/06/2026)" },
          "tasa_interes" => { "label" => "Tasa de interés compensatorio mensual (%)", "hint" => "Dentro del tope legal del BCP. Solo el número (ej: 2.5)" },
          "tasa_mora" => { "label" => "Tasa de interés moratorio mensual (%)", "hint" => "Adicional al compensatorio. Solo el número (ej: 1)" },
          "aval" => { "label" => "Aval", "hint" => "Indique 'Sin aval' o describa el avalista: nombre, CI y domicilio" }
        }
      },
      {
        name: "Boleto de Compraventa de Inmueble",
        category: "Inmobiliario",
        description: "Boleto de compraventa de inmueble conforme al Código Civil Paraguayo. Genera obligación de otorgar la escritura pública traslativa de dominio.",
        body: <<~BODY,
          BOLETO DE COMPRAVENTA DE INMUEBLE

          En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, entre las partes que a continuación se identifican, se celebra el presente BOLETO DE COMPRAVENTA, que se regirá por las siguientes cláusulas y por las disposiciones pertinentes del Código Civil Paraguayo (Ley N° 1.183/85):

          VENDEDOR: {{nombre_vendedor}}, con Cédula de Identidad N° {{ci_vendedor}}, con estado civil {{estado_civil_vendedor}}, domiciliado en {{domicilio_vendedor}}, en adelante denominado "EL VENDEDOR".

          COMPRADOR: {{nombre_comprador}}, con Cédula de Identidad N° {{ci_comprador}}, con estado civil {{estado_civil_comprador}}, domiciliado en {{domicilio_comprador}}, en adelante denominado "EL COMPRADOR".

          CLÁUSULA PRIMERA - OBJETO Y NATURALEZA: EL VENDEDOR promete vender y transferir el dominio, y EL COMPRADOR promete comprar y adquirir, el inmueble descripto en la cláusula siguiente. Las partes reconocen que el presente instrumento constituye un BOLETO DE COMPRAVENTA y que la transferencia efectiva del dominio se perfeccionará mediante la respectiva ESCRITURA PÚBLICA otorgada ante Escribano Público, conforme al artículo 700 inciso a) del Código Civil Paraguayo, y su inscripción en la Dirección General de los Registros Públicos.

          CLÁUSULA SEGUNDA - IDENTIFICACIÓN DEL INMUEBLE: El inmueble objeto del presente boleto se encuentra ubicado en {{direccion_inmueble}}, del distrito de {{distrito}}, departamento de {{departamento}}, individualizado como Finca N° {{numero_finca}}, Padrón N° {{padron}}, Cuenta Corriente Catastral N° {{cuenta_catastral}}, con una superficie de {{superficie}} metros cuadrados, y los siguientes linderos: {{linderos}}.

          CLÁUSULA TERCERA - PRECIO: El precio total y convenido de la compraventa se fija en la suma de GUARANÍES {{precio_letras}} (Gs. {{precio_numeros}}), que EL COMPRADOR pagará a EL VENDEDOR según la siguiente forma: {{forma_pago}}.

          CLÁUSULA CUARTA - SEÑA / ARRAS: En este acto, EL COMPRADOR entrega a EL VENDEDOR, quien recibe de plena conformidad, la suma de GUARANÍES {{sena_letras}} (Gs. {{sena_numeros}}) en concepto de {{tipo_sena}}, conforme a los artículos 723 y siguientes del Código Civil Paraguayo. Dicha suma se imputará a cuenta del precio total pactado.

          CLÁUSULA QUINTA - ESCRITURA PÚBLICA: Las partes se obligan a otorgar la Escritura Pública traslativa de dominio dentro del plazo de {{plazo_escritura_dias}} días corridos contados desde la firma del presente, ante el Escribano Público {{escribano}}. La falta de comparecencia injustificada de cualquiera de las partes al acto de escrituración facultará a la otra a exigir su cumplimiento por vía judicial conforme a lo previsto en el Código Civil Paraguayo.

          CLÁUSULA SEXTA - GASTOS E IMPUESTOS: Los gastos de la escritura pública, honorarios del Escribano, impuestos a la transferencia (IVA inmobiliario conforme Ley N° 6.380/19 cuando corresponda), tasas de inscripción en la Dirección General de los Registros Públicos y demás gastos derivados del otorgamiento de la escritura, serán a cargo de {{responsable_gastos}}.

          CLÁUSULA SÉPTIMA - GARANTÍA DE EVICCIÓN Y VICIOS REDHIBITORIOS: EL VENDEDOR declara bajo juramento que el inmueble: a) es de su exclusiva propiedad; b) se encuentra libre de todo gravamen, hipoteca, embargo, prohibición de innovar o cualquier otra restricción al dominio; c) no registra deudas por impuesto inmobiliario, tasas municipales ni servicios públicos al día de la fecha. EL VENDEDOR responde por evicción y vicios redhibitorios conforme a los artículos 1759 a 1798 del Código Civil Paraguayo.

          CLÁUSULA OCTAVA - POSESIÓN: La posesión del inmueble será entregada a EL COMPRADOR el día {{fecha_entrega}}, libre de ocupantes y en las condiciones declaradas. A partir de dicha fecha, todos los gastos, impuestos y tasas del inmueble corren por cuenta de EL COMPRADOR.

          CLÁUSULA NOVENA - INCUMPLIMIENTO: Si EL COMPRADOR no abona el saldo del precio en los términos convenidos, EL VENDEDOR podrá optar por exigir el cumplimiento o resolver el contrato, con derecho a retener la seña como indemnización mínima de daños y perjuicios. Si EL VENDEDOR se negare injustificadamente a otorgar la escritura, deberá restituir a EL COMPRADOR el doble de la seña recibida, conforme al artículo 724 del Código Civil Paraguayo, sin perjuicio del derecho de éste a exigir el cumplimiento del contrato.

          CLÁUSULA DÉCIMA - JURISDICCIÓN: Para todos los efectos legales del presente, las partes se someten a la jurisdicción de los Tribunales Ordinarios de la ciudad de {{ciudad}}, con renuncia a cualquier otro fuero.

          En prueba de conformidad, las partes firman el presente Boleto de Compraventa en dos ejemplares de un mismo tenor y a un solo efecto.


          _________________________          _________________________
          EL VENDEDOR                       EL COMPRADOR
          {{nombre_vendedor}}               {{nombre_comprador}}
          C.I. N° {{ci_vendedor}}           C.I. N° {{ci_comprador}}
        BODY
        field_config: {
          "ciudad" => { "label" => "Ciudad" },
          "dia" => { "label" => "Día", "hint" => "Ingrese solo el número del día (ej: 15)" },
          "mes" => { "label" => "Mes", "hint" => "Ingrese el nombre del mes (ej: Marzo)" },
          "anio" => { "label" => "Año", "hint" => "Ingrese el año con 4 dígitos (ej: 2026)" },
          "nombre_vendedor" => { "label" => "Nombre del vendedor" },
          "ci_vendedor" => { "label" => "Cédula del vendedor", "hint" => "Sin puntos (ej: 1234567)" },
          "estado_civil_vendedor" => { "label" => "Estado civil del vendedor", "hint" => "Ej: soltero/a, casado/a en primeras nupcias con..." },
          "domicilio_vendedor" => { "label" => "Domicilio del vendedor" },
          "nombre_comprador" => { "label" => "Nombre del comprador" },
          "ci_comprador" => { "label" => "Cédula del comprador", "hint" => "Sin puntos (ej: 1234567)" },
          "estado_civil_comprador" => { "label" => "Estado civil del comprador", "hint" => "Ej: soltero/a, casado/a en primeras nupcias con..." },
          "domicilio_comprador" => { "label" => "Domicilio del comprador" },
          "direccion_inmueble" => { "label" => "Dirección del inmueble" },
          "distrito" => { "label" => "Distrito" },
          "departamento" => { "label" => "Departamento", "hint" => "Ej: Central, Asunción, Alto Paraná" },
          "numero_finca" => { "label" => "Número de finca", "hint" => "Inscripción en Registros Públicos" },
          "padron" => { "label" => "Padrón", "hint" => "Número de padrón inmobiliario" },
          "cuenta_catastral" => { "label" => "Cuenta Corriente Catastral", "hint" => "Número de C.C.C. municipal" },
          "superficie" => { "label" => "Superficie (m²)", "hint" => "Ej: 360" },
          "linderos" => { "label" => "Linderos", "hint" => "Describa los linderos norte, sur, este, oeste" },
          "precio_numeros" => { "label" => "Precio total en números", "hint" => "Solo números, sin puntos ni comas (ej: 350000000)" },
          "precio_letras" => { "label" => "Precio total en letras", "hint" => "Ej: TRESCIENTOS CINCUENTA MILLONES" },
          "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: el saldo al momento de la escrituración mediante transferencia bancaria" },
          "sena_numeros" => { "label" => "Seña en números", "hint" => "Solo números (ej: 35000000)" },
          "sena_letras" => { "label" => "Seña en letras", "hint" => "Ej: TREINTA Y CINCO MILLONES" },
          "tipo_sena" => { "label" => "Tipo de seña", "hint" => "Ej: seña, principio de ejecución del contrato y a cuenta del precio" },
          "plazo_escritura_dias" => { "label" => "Plazo para escrituración (días)", "hint" => "Cantidad de días corridos (ej: 60)" },
          "escribano" => { "label" => "Escribano interviniente", "hint" => "Nombre del Escribano. Si no está definido, indique 'a designar de común acuerdo'" },
          "responsable_gastos" => { "label" => "Responsable de gastos", "hint" => "Ej: EL COMPRADOR, ambas partes por mitades iguales" },
          "fecha_entrega" => { "label" => "Fecha de entrega de la posesión", "hint" => "Formato: dd/mm/aaaa" }
        }
      },
      {
        name: "Contrato de Compraventa de Autovehículo",
        category: "Automotor",
        description: "Contrato de compraventa de vehículo automotor conforme a la Ley N° 608/95 y Ley N° 1.969/2002 del Paraguay.",
        body: <<~BODY,
          CONTRATO DE COMPRAVENTA DE AUTOVEHÍCULO

          En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente CONTRATO DE COMPRAVENTA DE AUTOVEHÍCULO, que se regirá por las disposiciones del Código Civil Paraguayo (Ley N° 1.183/85), la Ley N° 608/95, la Ley N° 1.969/2002 y demás normas aplicables, entre:

          VENDEDOR: {{nombre_vendedor}}, con Cédula de Identidad Nº {{ci_vendedor}}, con domicilio en {{domicilio_vendedor}}, en adelante denominado "EL VENDEDOR".

          COMPRADOR: {{nombre_comprador}}, con Cédula de Identidad Nº {{ci_comprador}}, con domicilio en {{domicilio_comprador}}, en adelante denominado "EL COMPRADOR".

          CLÁUSULA PRIMERA - OBJETO: EL VENDEDOR vende y transfiere a EL COMPRADOR, quien acepta y adquiere, el vehículo automotor con las siguientes características:
          - Tipo: {{tipo_vehiculo}}
          - Marca: {{marca_vehiculo}}
          - Modelo: {{modelo_vehiculo}}
          - Año de fabricación: {{anio_vehiculo}}
          - Color: {{color_vehiculo}}
          - Chapa Nº: {{chapa_vehiculo}}
          - Chasis Nº: {{chasis_vehiculo}}
          - Motor Nº: {{motor_vehiculo}}
          - Kilometraje al momento de la entrega: {{kilometraje}} km
          - Título de propiedad N°: {{numero_titulo}}

          CLÁUSULA SEGUNDA - PRECIO Y FORMA DE PAGO: El precio total de la compraventa se fija en la suma de GUARANÍES {{precio_letras}} (Gs. {{precio_numeros}}), que será pagado de la siguiente forma: {{forma_pago}}.

          CLÁUSULA TERCERA - ESTADO DEL VEHÍCULO: EL COMPRADOR declara conocer el estado físico, mecánico y jurídico del vehículo, haber realizado las verificaciones que consideró pertinentes y aceptarlo en el estado en que se encuentra. EL VENDEDOR garantiza que el vehículo no ha sido siniestrado de manera grave (salvo lo expresamente declarado: {{declaracion_siniestros}}), no se encuentra reportado como robado o hurtado, y que la documentación es auténtica.

          CLÁUSULA CUARTA - GARANTÍA DE EVICCIÓN Y VICIOS REDHIBITORIOS: EL VENDEDOR responde por evicción y vicios redhibitorios conforme a los artículos 1759 a 1798 del Código Civil Paraguayo, salvo en lo referente a desgaste natural por el uso y al estado declarado en la cláusula anterior.

          CLÁUSULA QUINTA - TRANSFERENCIA E INSCRIPCIÓN: EL VENDEDOR se obliga a suscribir todos los documentos necesarios y a comparecer ante Escribano Público para la formalización de la transferencia de dominio mediante escritura pública, y su posterior inscripción en la DIRECCIÓN GENERAL DE LOS REGISTROS PÚBLICOS - REGISTRO DEL AUTOMOTOR, dentro de los {{dias_transferencia}} días hábiles contados desde la firma del presente contrato, conforme a la Ley N° 608/95 y la Ley N° 1.969/2002.

          CLÁUSULA SEXTA - DOCUMENTACIÓN ENTREGADA: En este acto, EL VENDEDOR entrega a EL COMPRADOR, quien recibe de plena conformidad, la siguiente documentación: a) Título de propiedad del vehículo; b) Cédula del automotor (cédula verde); c) Certificado de no adeudar patente municipal expedido por la Municipalidad correspondiente; d) Certificado de no registrar multas e infracciones de tránsito; e) Constancia de inscripción y libre de gravámenes expedida por la Dirección General de los Registros Públicos; f) Verificación policial vigente.

          CLÁUSULA SÉPTIMA - GRAVÁMENES Y DEUDAS: EL VENDEDOR declara bajo juramento que el vehículo se encuentra libre de todo gravamen, prenda, embargo, prohibición de transferir, multas, deudas por patente municipal o cualquier otro tipo de restricción. En caso de existir alguna de las situaciones mencionadas con posterioridad a la firma y de origen anterior a ella, EL VENDEDOR será exclusivamente responsable y deberá resarcir a EL COMPRADOR los daños y perjuicios ocasionados.

          CLÁUSULA OCTAVA - GASTOS DE TRANSFERENCIA: Los gastos derivados de la transferencia, incluyendo honorarios del Escribano Público, aranceles de inscripción en el Registro del Automotor, certificaciones, timbrados fiscales y demás gastos administrativos, serán de cargo de {{responsable_gastos}}.

          CLÁUSULA NOVENA - ENTREGA DEL VEHÍCULO: EL VENDEDOR entrega en este acto el vehículo a EL COMPRADOR, quien lo recibe de plena conformidad. A partir de la fecha del presente contrato, EL COMPRADOR asume la responsabilidad civil y penal por el uso del vehículo, así como los gastos por combustible, mantenimiento, seguros, patente y demás cargas.

          CLÁUSULA DÉCIMA - JURISDICCIÓN: Para todos los efectos legales derivados del presente contrato, las partes se someten a la jurisdicción de los Tribunales Ordinarios de la ciudad de {{ciudad}}, con renuncia a cualquier otro fuero.

          En prueba de conformidad, las partes firman el presente contrato en dos ejemplares de un mismo tenor y a un solo efecto.


          _________________________          _________________________
          EL VENDEDOR                        EL COMPRADOR
          {{nombre_vendedor}}                {{nombre_comprador}}
          C.I. N° {{ci_vendedor}}            C.I. N° {{ci_comprador}}
        BODY
        field_config: {
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
          "tipo_vehiculo" => { "label" => "Tipo de vehículo", "hint" => "Ej: automóvil, camioneta, motocicleta" },
          "marca_vehiculo" => { "label" => "Marca del vehículo", "hint" => "Ej: Toyota, Hyundai, Kia" },
          "modelo_vehiculo" => { "label" => "Modelo del vehículo", "hint" => "Ej: Hilux, Tucson, Sportage" },
          "anio_vehiculo" => { "label" => "Año del vehículo", "hint" => "Ej: 2020" },
          "color_vehiculo" => { "label" => "Color del vehículo" },
          "chapa_vehiculo" => { "label" => "Número de chapa" },
          "chasis_vehiculo" => { "label" => "Número de chasis" },
          "motor_vehiculo" => { "label" => "Número de motor" },
          "kilometraje" => { "label" => "Kilometraje", "hint" => "Solo números (ej: 85000)" },
          "numero_titulo" => { "label" => "Número de título de propiedad" },
          "precio_numeros" => { "label" => "Precio total en números", "hint" => "Solo números, sin puntos ni comas (ej: 80000000)" },
          "precio_letras" => { "label" => "Precio total en letras", "hint" => "Ej: OCHENTA MILLONES" },
          "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: contado en este acto mediante transferencia bancaria" },
          "declaracion_siniestros" => { "label" => "Declaración de siniestros", "hint" => "Indique 'ninguno' o describa siniestros previos conocidos" },
          "dias_transferencia" => { "label" => "Días para transferencia", "hint" => "Cantidad de días hábiles (ej: 15)" },
          "responsable_gastos" => { "label" => "Responsable de gastos de transferencia", "hint" => "Ej: EL COMPRADOR, ambas partes por mitades" }
        }
      }
    ]

    updates.each do |attrs|
      template = ContractTemplate.find_or_initialize_by(name: attrs[:name])
      template.update!(
        category: attrs[:category],
        description: attrs[:description],
        body: attrs[:body],
        field_config: attrs[:field_config]
      )
    end
  end

  def down
    # Restore the previous "Contrato de Compraventa de Inmueble" name
    execute <<~SQL
      UPDATE contract_templates
      SET name = 'Contrato de Compraventa de Inmueble'
      WHERE name = 'Boleto de Compraventa de Inmueble'
    SQL

    # Re-run the prior populate migration's content for the three affected templates
    # to restore their previous body and field_config.
    PopulateAllContractTemplates.new.up
  end
end
