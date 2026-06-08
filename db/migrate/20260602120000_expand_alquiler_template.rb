class ExpandAlquilerTemplate < ActiveRecord::Migration[8.1]
  def up
    body = <<~BODY
      CONTRATO DE LOCACIÓN DE INMUEBLE

      En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, entre las partes que a continuación se individualizan, se celebra el presente CONTRATO DE LOCACIÓN DE INMUEBLE, que se regirá por las cláusulas siguientes y, en lo no previsto, por las disposiciones del Código Civil Paraguayo (Ley N° 1183/85) y normas concordantes.

      EL LOCADOR: {{nombre_locador}}, con Cédula de Identidad Nº {{ci_locador}}, con domicilio en {{domicilio_locador}}, en adelante denominado "EL LOCADOR".

      EL LOCATARIO: {{nombre_locatario}}, con Cédula de Identidad Nº {{ci_locatario}}, con domicilio en {{domicilio_locatario}}, en adelante denominado "EL LOCATARIO".

      CLÁUSULA PRIMERA - OBJETO Y DESTINO: EL LOCADOR da en locación a EL LOCATARIO, quien acepta de conformidad, el inmueble ubicado en {{direccion_inmueble}}, de la ciudad de {{ciudad}}, el cual será destinado exclusivamente a {{destino_inmueble}}. El destino aquí indicado es esencial; su modificación sin autorización escrita de EL LOCADOR será causal de rescisión del presente contrato por culpa de EL LOCATARIO.

      CLÁUSULA SEGUNDA - PLAZO: El presente contrato se celebra por un plazo de {{plazo_meses}} meses, comenzando a regir el día {{fecha_inicio}} y venciendo indefectiblemente el día {{fecha_fin}}. Vencido el plazo sin que medie renovación expresa por escrito, EL LOCATARIO deberá restituir el inmueble dentro de los cinco (5) días corridos siguientes.

      CLÁUSULA TERCERA - PRECIO Y FORMA DE PAGO: EL LOCATARIO abonará a EL LOCADOR, en concepto de precio del alquiler, la suma mensual de Guaraníes {{monto_alquiler}} (Gs. {{monto_alquiler}}), pagadera por adelantado dentro de los primeros {{dia_pago}} días de cada mes, mediante {{forma_pago}}. La sola falta de pago en el plazo pactado constituirá en mora de pleno derecho a EL LOCATARIO, sin necesidad de interpelación judicial o extrajudicial alguna (art. 424 inc. b del Código Civil).

      CLÁUSULA CUARTA - REAJUSTE: El monto del alquiler se reajustará a partir del mes de {{mes_reajuste}} de cada año en un {{reajuste_anual}}, manteniéndose dicho reajuste por períodos sucesivos durante toda la vigencia del contrato y sus eventuales prórrogas.

      CLÁUSULA QUINTA - INTERESES MORATORIOS Y CLÁUSULA PENAL: En caso de mora en el pago de los alquileres o de cualquier obligación pecuniaria emergente del presente contrato, EL LOCATARIO deberá abonar un interés moratorio del {{tasa_mora}}% mensual sobre el monto adeudado, computado desde la fecha de mora hasta su efectiva cancelación. Asimismo, en caso de no restituir el inmueble en tiempo y forma a la finalización del contrato, EL LOCATARIO se obliga a pagar, en concepto de cláusula penal, la suma de Guaraníes {{clausula_penal}} (Gs. {{clausula_penal}}) por cada mes o fracción de retraso, sin perjuicio de las acciones de desalojo y daños y perjuicios correspondientes.

      CLÁUSULA SEXTA - DEPÓSITO DE GARANTÍA: EL LOCATARIO entrega en este acto a EL LOCADOR, en concepto de depósito de garantía, la suma de Guaraníes {{monto_garantia}} (Gs. {{monto_garantia}}), que será restituida al finalizar el contrato dentro de los treinta (30) días corridos siguientes a la efectiva restitución del inmueble, previa verificación de su estado y de la inexistencia de deudas por servicios, impuestos, alquileres o daños. El depósito no podrá ser imputado por EL LOCATARIO al pago de alquileres impagos.

      CLÁUSULA SÉPTIMA - FIADOR SOLIDARIO: {{nombre_garante}}, con Cédula de Identidad Nº {{ci_garante}}, con domicilio en {{domicilio_garante}}, se constituye por el presente acto en fiador, codeudor solidario, liso, llano y principal pagador de todas y cada una de las obligaciones asumidas por EL LOCATARIO en el presente contrato, sus prórrogas y eventuales reajustes, renunciando expresamente a los beneficios de excusión, división e interpelación previa (arts. 1456 y concordantes del Código Civil).

      CLÁUSULA OCTAVA - ESTADO DEL INMUEBLE: EL LOCATARIO declara recibir el inmueble en el siguiente estado: {{estado_inmueble}}; manifestando su plena conformidad con el mismo. EL LOCATARIO se obliga a restituir el inmueble en idéntico estado, salvo el deterioro propio del uso regular y prudente (art. 814 del Código Civil).

      CLÁUSULA NOVENA - INVENTARIO: Forma parte integrante del presente contrato el siguiente inventario de bienes muebles, instalaciones, artefactos y accesorios entregados conjuntamente con el inmueble: {{inventario}}. EL LOCATARIO se obliga a restituirlos en idénticas condiciones, respondiendo por su deterioro o desaparición.

      CLÁUSULA DÉCIMA - REPARACIONES: Las reparaciones locativas y de conservación, tales como cerraduras, vidrios, grifería, pintura, limpieza de cañerías, mantenimiento de artefactos y aquellas derivadas del uso regular, estarán íntegramente a cargo de EL LOCATARIO. Las reparaciones estructurales, las derivadas de caso fortuito, vicios o defectos de construcción serán a cargo de EL LOCADOR (arts. 821 a 823 del Código Civil).

      CLÁUSULA DÉCIMA PRIMERA - MEJORAS: EL LOCATARIO no podrá introducir mejoras, modificaciones ni transformaciones de naturaleza alguna en el inmueble sin previa autorización escrita de EL LOCADOR. Las mejoras autorizadas quedarán en beneficio del inmueble sin derecho a indemnización ni a su retiro, salvo pacto expreso en contrario.

      CLÁUSULA DÉCIMA SEGUNDA - SUBARRIENDO Y CESIÓN: Queda expresamente {{permite_subarriendo}} a EL LOCATARIO subarrendar total o parcialmente el inmueble, así como ceder el presente contrato a cualquier título, sin previa autorización escrita de EL LOCADOR. Su transgresión será causal de rescisión inmediata.

      CLÁUSULA DÉCIMA TERCERA - SERVICIOS, IMPUESTOS Y TASAS: Los servicios de {{servicios_a_cargo}} estarán a cargo exclusivo de EL LOCATARIO, quien deberá exhibir los comprobantes de pago a requerimiento de EL LOCADOR. El impuesto inmobiliario y demás tasas municipales que graven el inmueble serán a cargo de {{impuesto_inmobiliario_a_cargo}}.

      CLÁUSULA DÉCIMA CUARTA - INSPECCIONES: EL LOCADOR, por sí o por persona autorizada, podrá inspeccionar el inmueble previa notificación con al menos cuarenta y ocho (48) horas de anticipación, en horario razonable, con el objeto de verificar su estado de conservación, sin perturbar el uso pacífico por parte de EL LOCATARIO.

      CLÁUSULA DÉCIMA QUINTA - CAUSALES DE RESCISIÓN: Serán causales de rescisión del presente contrato por culpa de EL LOCATARIO, sin perjuicio de otras previstas en la ley: a) la falta de pago de dos (2) mensualidades consecutivas; b) el uso del inmueble para un destino distinto al pactado; c) los daños graves al inmueble o a sus instalaciones; d) el subarriendo o cesión no autorizados; e) cualquier incumplimiento sustancial del presente contrato.

      CLÁUSULA DÉCIMA SEXTA - PREAVISO: Para la rescisión anticipada sin causa imputable, cualquiera de las partes deberá comunicar a la otra su voluntad de rescindir con un preaviso no menor a {{dias_preaviso}} días corridos, por medio fehaciente.

      CLÁUSULA DÉCIMA SÉPTIMA - RESTITUCIÓN DEL INMUEBLE: Producido el vencimiento o la rescisión del contrato, EL LOCATARIO deberá restituir el inmueble libre de ocupantes, bienes y de toda deuda por servicios, impuestos y alquileres, y en el estado de conservación referido en la cláusula octava. La ocupación posterior generará, además de la cláusula penal pactada, todas las consecuencias derivadas de los procesos de desalojo correspondientes.

      CLÁUSULA DÉCIMA OCTAVA - DOMICILIOS Y NOTIFICACIONES: A todos los efectos del presente contrato, las partes constituyen como domicilios especiales los indicados en el encabezamiento, donde se tendrán por válidas todas las notificaciones judiciales y extrajudiciales que se cursen, hasta tanto se comunique fehacientemente su modificación a la contraparte.

      CLÁUSULA DÉCIMA NOVENA - JURISDICCIÓN: Para toda cuestión judicial derivada de la interpretación, ejecución o resolución del presente contrato, las partes se someten expresamente a la jurisdicción de los Tribunales Ordinarios de la ciudad de {{ciudad_jurisdiccion}}, renunciando a cualquier otro fuero o jurisdicción que pudiera corresponderles.

      CLÁUSULA VIGÉSIMA - LEY APLICABLE: El presente contrato se rige por las disposiciones del Código Civil Paraguayo (Ley N° 1183/85) y demás normas complementarias de la República del Paraguay.

      En prueba de conformidad, leído íntegramente el presente, las partes firman tres (3) ejemplares de un mismo tenor y a un solo efecto, en el lugar y fecha indicados.


      _________________________     _________________________     _________________________
      EL LOCADOR                    EL LOCATARIO                  EL FIADOR SOLIDARIO
      {{nombre_locador}}            {{nombre_locatario}}          {{nombre_garante}}
      C.I. Nº {{ci_locador}}        C.I. Nº {{ci_locatario}}      C.I. Nº {{ci_garante}}
    BODY

    field_config = {
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
      "forma_pago" => { "label" => "Forma de pago", "hint" => "Ej: transferencia bancaria, efectivo con recibo" },
      "servicios_a_cargo" => { "label" => "Servicios a cargo del locatario", "hint" => "Ej: agua, luz, internet y ESSAP" },
      "dia_pago" => { "label" => "Día de pago", "hint" => "Ingrese solo un número del 1 al 31 (ej: 5)" },
      "dias_preaviso" => { "label" => "Días de preaviso", "hint" => "Cantidad de días (ej: 30)" },
      "mes_reajuste" => { "label" => "Mes de reajuste anual", "hint" => "Ej: Marzo (aniversario del contrato)" },
      "reajuste_anual" => { "label" => "Reajuste anual", "hint" => "Ej: 10%, o IPC publicado por el BCP" },
      "tasa_mora" => { "label" => "Tasa de interés moratorio mensual (%)", "hint" => "Solo el número (ej: 2.5)" },
      "clausula_penal" => { "label" => "Cláusula penal por restitución tardía (Gs.)", "hint" => "Solo números (ej: 500000)" },
      "estado_inmueble" => { "label" => "Estado del inmueble al entregar", "hint" => "Describa: pintura, pisos, instalaciones, etc." },
      "inventario" => { "label" => "Inventario de bienes", "hint" => "Liste muebles y artefactos, o escriba 'Sin inventario' si no aplica" },
      "permite_subarriendo" => { "label" => "Subarriendo permitido", "hint" => "Escriba 'PROHIBIDO' o 'PERMITIDO' (recomendado: PROHIBIDO)" },
      "impuesto_inmobiliario_a_cargo" => { "label" => "Impuesto inmobiliario a cargo de", "hint" => "Ej: EL LOCADOR (lo habitual)" },
      "nombre_garante" => { "label" => "Nombre del fiador solidario", "hint" => "Deje vacío si no hay garante" },
      "ci_garante" => { "label" => "Cédula del fiador", "hint" => "Sin puntos (ej: 1234567). Vacío si no aplica" },
      "domicilio_garante" => { "label" => "Domicilio del fiador", "hint" => "Vacío si no aplica" },
      "ciudad_jurisdiccion" => { "label" => "Ciudad de jurisdicción", "hint" => "Ciudad de los tribunales competentes (ej: Asunción)" }
    }

    template = ContractTemplate.find_by(name: "Contrato de Alquiler")
    return unless template

    template.update!(
      category: "Inmobiliario",
      description: "Contrato de locación de inmueble conforme al Código Civil Paraguayo (Ley N° 1183/85).",
      body: body,
      field_config: field_config
    )
  end

  def down
    # Restore the previous (short) version of the template
    body = <<~BODY
      CONTRATO DE ALQUILER

      En la ciudad de {{ciudad}}, República del Paraguay, a los {{dia}} días del mes de {{mes}} del año {{anio}}, se celebra el presente contrato de alquiler entre:

      EL LOCADOR: {{nombre_locador}}, con cédula de identidad N° {{ci_locador}}, domiciliado en {{domicilio_locador}}.
      EL LOCATARIO: {{nombre_locatario}}, con cédula de identidad N° {{ci_locatario}}, domiciliado en {{domicilio_locatario}}.

      CLÁUSULA PRIMERA - OBJETO: EL LOCADOR da en alquiler a EL LOCATARIO el inmueble ubicado en {{direccion_inmueble}}, para ser destinado a {{destino_inmueble}}.

      CLÁUSULA SEGUNDA - PLAZO: El presente contrato se celebra por un plazo de {{plazo_meses}} meses, comenzando el {{fecha_inicio}} y finalizando el {{fecha_fin}}.

      CLÁUSULA TERCERA - PRECIO: EL LOCATARIO abonará en concepto de alquiler la suma de {{monto_alquiler}} guaraníes mensuales, más una garantía de {{monto_garantia}} guaraníes.

      CLÁUSULA CUARTA - SERVICIOS: Los servicios de {{servicios_a_cargo}} estarán a cargo de EL LOCATARIO.

      CLÁUSULA QUINTA - PAGO: El pago del alquiler se realizará el día {{dia_pago}} de cada mes.

      CLÁUSULA SEXTA - PREAVISO: Para la rescisión del contrato, cualquiera de las partes deberá dar un preaviso de {{dias_preaviso}} días.

      En prueba de conformidad, las partes firman el presente contrato.


      _________________________          _________________________
      EL LOCADOR                        EL LOCATARIO
    BODY

    field_config = {
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

    template = ContractTemplate.find_by(name: "Contrato de Alquiler")
    return unless template

    template.update!(body: body, field_config: field_config)
  end
end
