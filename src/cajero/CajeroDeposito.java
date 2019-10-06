package cajero;

import java.util.ArrayList;
import java.util.List;

import ejemplo.cajero.control.Comando;
import ejemplo.cajero.control.ComandoConsignar;
import ejemplo.cajero.control.ComandoListarCuentas;
import ejemplo.cajero.control.ComandoListarOperaciones;
import ejemplo.cajero.control.ComandoRetirar;
import ejemplo.cajero.control.ComandoTransferir;

public class CajeroDeposito extends CajeroAutomatico {

	@Override
	public List<Comando> cargaComandos() {
		// crea los comandos que se van a usar en la aplicación
		comandos = new ArrayList<>();
		comandos.add(new ComandoListarCuentas());
		comandos.add(new ComandoListarOperaciones());
		comandos.add(new ComandoRetirar());
		comandos.add(new ComandoTransferir());
		comandos.add(new ComandoConsignar());
		

		return comandos;
	}
}
