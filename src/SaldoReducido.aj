import java.util.Date;
import java.util.Scanner;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;

import ejemplo.cajero.control.ComandoRetirar;
import ejemplo.cajero.control.ComandoTransferir;
import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

public aspect SaldoReducido {
	pointcut metodoSaldoReducidoRetirar() : call (* ejemplo.cajero.control..ejecutar(..) throws Exception);
	
	
	public static boolean getOpcionHabilitada() {
		// define un valor por defecto
		String opcionConfigurada = "SaldoReducido"; 
		boolean resultado = false;
		
		try {
			// lee el archivo de configuración
			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory
			        .newInstance();
			DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
			Document document = documentBuilder.parse("./configs/default.xml");
			for(int i = 0; i < document.getElementsByTagName("feature").getLength(); i++) {
				String opcion = document.getElementsByTagName("feature").item(i).getAttributes().getNamedItem("name").getTextContent();
				
				if(opcion.equalsIgnoreCase(opcionConfigurada))
					resultado = true;
			}
		
		} catch (Exception e) {
			// ignora cualquier error leyendo el archivo
		} 
		
		return resultado;
	}

	void around() throws Exception : metodoSaldoReducidoRetirar() {

		Object obj = thisJoinPoint.getTarget();
		if (!(obj instanceof ComandoRetirar)||!getOpcionHabilitada()) {
			proceed();
			return;
		}

		System.out.println("Retiro de Dinero");
		System.out.println();

		Object arg = null;
		if (thisJoinPoint.getArgs().length > 0) {
			arg = thisJoinPoint.getArgs()[0];
		}
		Banco contexto = (Banco) arg;

		// la clase Console no funciona bien en Eclipse
		Scanner console = new Scanner(System.in);

		// Ingresa los datos
		System.out.println("Ingrese el nÃºmero de cuenta");
		String numeroDeCuenta = console.nextLine();

		Cuenta cuenta = contexto.buscarCuenta(numeroDeCuenta);
		if (cuenta == null) {
			throw new Exception("No existe cuenta con el nÃºmero " + numeroDeCuenta);
		}

		if (cuenta.getSaldo() < 200) {
			throw new Exception("El saldo de la cuenta no puede ser menor a 200 ");
		}

		System.out.println("Ingrese el valor a retirar");
		String valor = console.nextLine();

		try {
			long valorNumerico = Long.parseLong(valor);

			if ((cuenta.getSaldo() - valorNumerico) < 200) {
				throw new Exception("El saldo de la cuenta no puede ser menor a 200 ");
			}

			cuenta.retirar(valorNumerico);
			contexto.agregarOperacion(new Date() + " : Se retiran " + valorNumerico + " de la cuenta No. " + numeroDeCuenta);

		} catch (NumberFormatException e) {
			throw new Exception("Valor a retirar no vÃ¡lido : " + valor);
		}
	}

	void around() throws Exception : metodoSaldoReducidoRetirar() {

		Object obj = thisJoinPoint.getTarget();
		if (!(obj instanceof ComandoTransferir)||!getOpcionHabilitada()) {
			proceed();
			return;
		}
		System.out.println("Transferencia de Dinero");
		System.out.println();
		Object arg = null;
		if (thisJoinPoint.getArgs().length > 0) {
			arg = thisJoinPoint.getArgs()[0];
		}
		Banco contexto = (Banco) arg;

		// la clase Console no funciona bien en Eclipse
		Scanner console = new Scanner(System.in);

		// Ingresa los datos
		System.out.println("Ingrese el nÃºmero de cuenta origen");
		String numeroCuentaOrigen = console.nextLine();

		Cuenta cuentaOrigen = contexto.buscarCuenta(numeroCuentaOrigen);
		if (cuentaOrigen == null) {
			throw new Exception("No existe cuenta con el nÃºmero " + numeroCuentaOrigen);
		}
		if (cuentaOrigen.getSaldo() < 200) {
			throw new Exception("El saldo de la cuenta no puede ser menor a 200 ");
		}

		System.out.println("Ingrese el nÃºmero de cuenta destino");
		String numeroCuentaDestino = console.nextLine();

		Cuenta cuentaDestino = contexto.buscarCuenta(numeroCuentaDestino);
		if (cuentaDestino == null) {
			throw new Exception("No existe cuenta con el nÃºmero " + numeroCuentaDestino);
		}

		System.out.println("Ingrese el valor a transferir");
		String valor = console.nextLine();

		try {

			// se retira primero y luego se consigna
			// si no se puede retirar, no se hace la consignaciÃ³n

			long valorNumerico = Long.parseLong(valor);
			if ((cuentaOrigen.getSaldo() - valorNumerico) < 200) {
				throw new Exception("El saldo de la cuenta no puede ser menor a 200 ");
			}
			cuentaOrigen.retirar(valorNumerico);
			cuentaDestino.consignar(valorNumerico);
			contexto.agregarOperacion(new Date() + " : Se transfieren " + valorNumerico + " de la cuenta No. "
					+ numeroCuentaOrigen + " a la cuenta No. " + numeroCuentaDestino);
		} catch (NumberFormatException e) {
			throw new Exception("Valor a transferir no vÃ¡lido : " + valor);
		}
	}
}
