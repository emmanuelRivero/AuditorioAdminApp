package com.auditorio.date;

public class SetQueryConsulta {
	

	public static String getVendedor(String nombre, String Usuario, int puesto) {
		String query;
		int firstString=1;
		
		query = "select NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, USUARIO,  DOMICILIO, TELEFONO from PERSONAL";
		
		if (!nombre.equals("") || !Usuario.equals("") || puesto != 0) {
			query = query + " where";
		
			if (!nombre.equals("") || nombre == null){
				if (firstString == 1) {
					query = query + " NOMBRE like '%" + nombre+"%'";
					firstString=0;
				}else {
				query = query + " AND NOMBRE like '%" + nombre+"%'";
				}
			}
		
			if (!Usuario.equals("") || Usuario == null){
				if (firstString == 1) {
					query = query + " USUARIO like '%" + Usuario+"%'";
					firstString=0;
				}else {
				query = query + " AND USUARIO like '%" + Usuario+"%'";
				}
			}
		
			if (puesto != 0){
				if (firstString ==1) {
					query = query +  " ID_PUESTO = " + puesto;
					firstString=0;
				}else {
				query = query + " AND ID_PUESTO = " + puesto;
				}
				
			}
		}
		query = query + ";";
		return query;
	}
	
	public static String getVenta(String evento, String Personal, long fechaI, long fechaF) {
		String query;
		int firstString = 1;
		
		query = "select V.ID_VENTA, V.MONTO, U.USUARIO, from_unixtime(V.FECHA, '%m-%d-%Y %H:%i:%s'), E.EVENTO, from_unixtime(E.FECHA_EVENTO, '%m-%d-%Y %H:%i:%s'), V.ID_ZONA, V.ASIENTO_NUM FROM VENTA AS V JOIN PERSONAL AS U ON U.ID_PERSONAL=V.ID_PERSONAL JOIN EVENTO AS E ON V.ID_EVENTO=E.ID_EVENTO where";
		
		if (!evento.equals("") || !Personal.equals("")) {
		
			if (!evento.equals("") || evento == null){
				if (firstString == 1) {
					query = query + " E.EVENTO like '%" + evento+"%'";
					firstString=0;
				}else {
				query = query + " AND E.EVENTO like '%" + evento+"%'";
				}
			}
			
			if (!Personal.equals("") || Personal == null){
				if (firstString == 1) {
					query = query + " U.USUARIO like '%" + Personal+"%'";
					firstString=0;
				}else {
				query = query + " AND U.USUARIO like '%" + Personal+"%'";
				}
			}
		}
	
	if (firstString == 0) {
		query = query + " AND";
	}
		
		
	query = query + " E.FECHA_EVENTO between "+fechaI+" AND "+fechaF+";";
		return query;
	}
	
	public static String getEventos(String evento, long fechaI, long fechaF) {
		String query;
		
		if (evento.equals("") && fechaI !=0){
			query = "select EVENTO, from_unixtime(FECHA_EVENTO, '%m-%d-%Y'), from_unixtime(FECHA_EVENTO, '%H:%i:%s') from EVENTO where FECHA_EVENTO between " + fechaI + " AND "+ fechaF +";";
			return query;
		}else if (evento.equals("") && fechaI == 0){
			query = "select EVENTO, from_unixtime(FECHA_EVENTO, '%m-%d-%Y'), from_unixtime(FECHA_EVENTO, '%H:%i:%s') from EVENTO where FECHA_EVENTO between " + fechaI + " AND "+ fechaF +";";
			return query;
		}else if (!evento.equals("") && fechaI !=0){
			query = "select EVENTO, from_unixtime(FECHA_EVENTO, '%m-%d-%Y'), from_unixtime(FECHA_EVENTO, '%H:%i:%s') from EVENTO where EVENTO = '"+evento+"' AND FECHA_EVENTO between " + fechaI + " AND "+ fechaF +";";
			return query;
		}else if (!evento.equals("") && fechaI ==0){
			query = "select EVENTO, from_unixtime(FECHA_EVENTO, '%m-%d-%Y'), from_unixtime(FECHA_EVENTO, '%H:%i:%s') from EVENTO where EVENTO = '"+evento+"' AND FECHA_EVENTO between " + fechaI + " AND "+ fechaF +";";
			return query;
		}
		return "";
	}
}
			
