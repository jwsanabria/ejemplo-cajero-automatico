package ejemplo.cajero.control;

import ejemplo.cajero.modelo.Banco;

public class ComandoListarOperaciones implements Comando {

	@Override
	public String getNombre() {
		return "Listar Operaciones";
	}

	@Override
	public void ejecutar(Banco contexto) throws Exception {
		
		System.out.println("**************************************************************");
		System.out.println("Operaciones Realizadas");
		System.out.println();
		
		for(String operacion : contexto.getOperaciones()) {
			System.out.println(operacion);
		}
		
		System.out.println("**************************************************************");
		
	}

}
