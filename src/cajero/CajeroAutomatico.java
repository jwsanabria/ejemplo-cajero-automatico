package cajero;

import java.util.List;

import ejemplo.cajero.control.Comando;

public abstract class CajeroAutomatico {
	protected List<Comando> comandos;
	
	public abstract List<Comando> cargaComandos();
	
	public void muestraMenuConComandos() {
		// muestra los nombres de los comandos
		for (int i = 0; i < comandos.size(); i++) {
			System.out.println(i + ".-" + comandos.get(i).getNombre());
		}
	}

	public Comando retornaComandoSeleccionado(String valorIngresado) {
		Comando comandoSeleccionado = null;

		// el valorIngresado es un número ?
		if (valorIngresado.matches("[0-9]")) {
			int valorSeleccionado = Integer.valueOf(valorIngresado);
			// es un índice válido para la lista de comandos
			if (valorSeleccionado < comandos.size()) {
				comandoSeleccionado = comandos.get(valorSeleccionado);
			}
		}

		return comandoSeleccionado;
	}

	public List<Comando> getComandos() {
		return comandos;
	}

	public void setComandos(List<Comando> comandos) {
		this.comandos = comandos;
	}
	
	

}
