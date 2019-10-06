package ejemplo.cajero;

import java.util.Scanner;

import cajero.CajeroAutomatico;
import ejemplo.cajero.control.Comando;
import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;
import fabrica.FabricaCajero;

public class MainCajero {

	public static void main(String ...agrs) {
		// crea el banco
				Banco banco = new Banco();
				
				// crea unas cuentas, para la prueba
				banco.agregarCuenta(new Cuenta("1", "clave", 1000));
				banco.agregarCuenta(new Cuenta("2", "clave", 2000));
				banco.agregarCuenta(new Cuenta("3", "clave", 3000));
				
				
				
				// crea los comandos que se van a usar en la aplicación
				CajeroAutomatico cajero = FabricaCajero.getCajeroAutomatico();
				cajero.cargaComandos();
				
				
				// Ciclo del Programa
				// ==================

				System.out.println("Cajero Automático");
				System.out.println("=================");
				System.out.println();
				
				boolean fin = false;
				do {
					
					// muestra los nombres de los comandos
					cajero.muestraMenuConComandos();
					System.out.println("X.- Salir");
					
					// la clase Console no funciona bien en Eclipse
					Scanner console = new Scanner(System.in);			
					String valorIngresado = console.nextLine();
					
					// obtiene el comando a ejecutar
					Comando comandoSeleccionado = cajero.retornaComandoSeleccionado(valorIngresado);
					if (comandoSeleccionado != null) {
						
						// intenta ejecutar el comando
						try {
							comandoSeleccionado.ejecutar(banco);
							
						} catch (Exception e) {
							// si hay una excepción, muestra el mensaje
							System.err.println(e.getMessage());
						}
						
					} 
					// si no se obtuvo un comando, puede ser la opción de salir
					else if (valorIngresado.equalsIgnoreCase("X")) {
						fin = true;
					}
					
					System.out.println();
				} while ( !fin );
				
				System.out.println("Gracias por usar el programa.");
	}
}
