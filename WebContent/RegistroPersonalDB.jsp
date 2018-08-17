<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registro de usuario</title>
</head>
<body>
<%@page import="java.sql.*" %>
<jsp:include page="Header.jsp"></jsp:include><br/>

	<%
	
	String nombre = request.getParameter("nombre");
	String apellidoP = request.getParameter("apellidoP");
	String apellidoM = request.getParameter("apellidoM");
	String domicilio = request.getParameter("domicilio");
	String telefono = request.getParameter("telefono");
	String puesto = request.getParameter("puesto");
	String usuario = request.getParameter("usuario");
	String contra = request.getParameter("contra");
	String contraConf = request.getParameter("contraConf");
	
	int puestoI = (int) session.getAttribute("Puesto"); 
	if (puestoI != 10 ){
		response.sendRedirect("UserLogin.jsp");
	}else{
		
		if (nombre.equals("") || apellidoP.equals("") || apellidoM.equals("") || domicilio.equals("") || telefono.equals("") || usuario.equals("") || contra.equals("")){
			%>
			
			
			<table align="center">
			<tr>
				<td><p style="color:rgb(255,0,0);" align="center">Por favor llena la información solicitada</p><td>
				
			</tr>
			</table>
			<table align="center">
			<tr >
				<td>
					<form action="RegistroPersonal.jsp" method="get">
	    			<input type="submit" value="Regresar" name="Submit" id="frm1_submit" />
					</form>			
				</td>
			</tr>
			</table>
			<%
			
		}else{
		
		if (!contra.equals(contraConf)){
			%>
			<jsp:include page="Header.jsp"></jsp:include>
			
			
			<table align="center">
			<tr>
				<td><p style="color:rgb(255,0,0);" align="center">La contraseña no coincide, por favor ingrese las dos contraseñas correctamente</p><td>
				
			</tr>
			</table>
			<table align="center">
			<tr >
				<td>
					<form action="RegistroPersonal.jsp" method="get">
	    				<input type="submit" value="Regresar" name="Submit" id="frm1_submit" />
					</form>	
				</td>
			</tr>
			</table>
			<% 
			
		}else{
	
	

	int FromDB;
	
	// Database
		Class.forName("com.mysql.jdbc.Driver");
		String query="{CALL creaPersonal(?,?,?,?,?,?,?,?)}";
		String getIdPuesto = "select ID_PUESTO from PUESTO where PUESTO = '" + puesto + "';";
		ResultSet rs;
		try{

		Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");
		// creaPersonal(in newUsuario ,Pnombre , APaterno , AMaterno , dom , tel ,Ppuesto , contraseña)
		
		Statement IDPstmp=auditoriodbConexion.createStatement();
		rs = IDPstmp.executeQuery(getIdPuesto);

		rs.first();
		FromDB = ((Number) rs.getObject(1)).intValue();

		CallableStatement stmt=auditoriodbConexion.prepareCall(query);
		
		stmt.setString(1, usuario);
		stmt.setString(2, nombre);
		stmt.setString(3, apellidoP);
		stmt.setString(4, apellidoM);
		stmt.setString(5, domicilio);
		stmt.setString(6, telefono);
		stmt.setInt(7, FromDB);
		stmt.setString(8, contra);
		rs = stmt.executeQuery();
		out.println("personal creado exitosamente");
		}catch(Exception e){
			String msg = e.getMessage();
			out.println("Ha habido un error en la base de datos: "+msg);
			
		}
		}
	}
	}
	%>

</body>
</html>