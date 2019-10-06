package fabrica;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;

import cajero.CajeroAutomatico;
import cajero.CajeroBasico;
import cajero.CajeroDeposito;

public class FabricaCajero {
	public static String getTipoCajero() {
		// define un valor por defecto
		String opcionConfigurada = "CajeroBasico";  
		
		try {
			// lee el archivo de configuración
			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory
			        .newInstance();
			DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
			Document document = documentBuilder.parse("./configs/default.xml");
			for(int i = 0; i < document.getElementsByTagName("feature").getLength(); i++) {
				String opcion = document.getElementsByTagName("feature").item(i).getAttributes().getNamedItem("name").getTextContent();
				
				if(opcion.equalsIgnoreCase("CajeroDeposito"))
					opcionConfigurada = opcion;
			}
		
		} catch (Exception e) {
			// ignora cualquier error leyendo el archivo
		} 
		
		return opcionConfigurada;
	}
	
	public static CajeroAutomatico  getCajeroAutomatico() {
				
		// obtiene la opción configurada
		String opcion = FabricaCajero.getTipoCajero();
		
		// crea el objeto de acuerdo a la opción configurada
		CajeroAutomatico cajero = null;
		switch(opcion) {
		
		case "CajeroBasico":
			cajero = new CajeroBasico();
			break;
		
		case "CajeroDeposito":
			cajero = new CajeroDeposito();
			break;
		}
		
		return cajero;
	}

}
