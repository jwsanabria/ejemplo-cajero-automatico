import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;

import ejemplo.cajero.control.ComandoRetirar;

public aspect GenerarAuditoria {
	// defina un pointcut con el nombre "metodosDelMundo"
	// para todas las invocaciones de los mÃ©todos
	// - mÃ©todos con cualquier tipo de retorno
	// - mÃ©todos de cualquier clase en el paquete "mundo"
	// - mÃ©todos con cualquier tipo de argumentos
	pointcut metodosDeControl() : call( * ejemplo.cajero.control..ejecutar(..));

	public static boolean getOpcionHabilitada() {
		// define un valor por defecto
		String opcionConfigurada = "GenerarAuditoria";
		boolean resultado = false;

		try {
			// lee el archivo de configuración
			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
			Document document = documentBuilder.parse("./configs/default.xml");
			for (int i = 0; i < document.getElementsByTagName("feature").getLength(); i++) {
				String opcion = document.getElementsByTagName("feature").item(i).getAttributes().getNamedItem("name")
						.getTextContent();

				if (opcion.equalsIgnoreCase(opcionConfigurada))
					resultado = true;
			}

		} catch (Exception e) {
			// ignora cualquier error leyendo el archivo
		}

		return resultado;
	}

	// ejecuciÃ³n antes de ejecutar el mÃ©todo
	before(): metodosDeControl() {

		if (getOpcionHabilitada()) {
			System.out.println("Ejectando");
			System.out.println("\t objeto     : " + thisJoinPoint.getTarget());
			System.out.println("\t método     : " + thisJoinPoint.getSignature());
			System.out.println("\t argumentos : " + thisJoinPoint.getArgs());
		}
	}

	// ejecuciÃ³n al retornar el mÃ©todo
	after() returning(Object resultado): metodosDeControl() {
		// ejecute el mÃ©todo original
		if (getOpcionHabilitada()) {
			System.out.println("Retornando");
			System.out.println("\t resultado  : " + resultado);
		}
		
	}

	// ejecuciÃ³n al retornar el mÃ©todo
	after() throwing(Exception e): metodosDeControl() {
		if (getOpcionHabilitada()) {
			System.out.println("Retornando con Excepción");
			System.out.println("\t excepciÃ³n : " + e.getMessage());
		}

	}

}
