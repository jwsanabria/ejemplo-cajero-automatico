package cajero;

import java.util.ArrayList;
import java.util.List;

import ejemplo.cajero.control.Comando;
import ejemplo.cajero.control.ComandoListarCuentas;
import ejemplo.cajero.control.ComandoListarOperaciones;
import ejemplo.cajero.control.ComandoRetirar;

public class CajeroBasico extends CajeroAutomatico{

	@Override
	public List<Comando> cargaComandos() {
		// crea los comandos que se van a usar en la aplicación
		comandos = new ArrayList<>();
		comandos.add(new ComandoListarCuentas());
		comandos.add(new ComandoListarOperaciones());
		comandos.add(new ComandoRetirar());
		

		return comandos;
	}

}
