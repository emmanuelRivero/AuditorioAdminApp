<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Actualizar Datos</title>
</head>
<style>
input[type=text], select {
    width: 100%;
    height: 40px;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=submit] {
    width: 100%;
    height: 40px;
    background-color: #1a53ff;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type=password], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=submit]:hover {
    background-color: #45a049;
}

table {
magin: 0px auto;
}

</style>
<body>
<%@page import="java.sql.*" %>
<jsp:include page="Header.jsp"></jsp:include><br/>
	<h1 style="text-align: center">Actualización de datos</h1>
	<form action="ActualizarUsuario.jsp" method="post">

		<table width="50%" align="center">
			<tr>
				<td width="35%"><label for="nombre">Nombre: </label></td>
				<td width="65%"><input type="text" name="nombre" id="nombre"></td>
			</tr>
			<tr>
				<td><label for="apellidoP">Apellido Paterno: </label></td>
				<td><input type="text" name="apellidoP" id="apellidoP"></td>
			</tr>
			<tr>
				<td><label for="apellidoM">Apellido Materno: </label></td>
				<td><input type="text" name="apellidoM" id="apellidoM"></td>
			</tr>
			<tr>
			<tr>
				<td><label for="domicilio">Domicilio: </label></td>
				<td><input type="text" name="domicilio" id="domicilio"></td>
			</tr>
			<tr>
				<td><label for="telefono">Teléfono: </label></td>
				<td><input type="text" name="telefono" id="telefono"></td>
			</tr>
			<tr>			
				<td><label for="contra">Contraseña: </label></td>
				<td><input type="password" name="contra" id="contra"></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center"><input type="submit"
					name="button" id="button" value="Enviar"></td>
			</tr>
		</table>
		<p>
			<br>
		</p>
	</form>
	
	<%
	
	String sesion = (String) session.getAttribute("Sesion"); 
	String nombre = request.getParameter("nombre");
	String apellidoP = request.getParameter("apellidoP");
	String apellidoM = request.getParameter("apellidoM");
	String domicilio = request.getParameter("domicilio");
	String telefono = request.getParameter("telefono");
	String contra = request.getParameter("contra");
	int IDU;
	int IDC;
	
	  if (sesion == null){
		  response.sendRedirect("UserLogin.jsp");
	  }else{
	
	
	if (sesion != null){
	// Database
			Class.forName("com.mysql.jdbc.Driver");
			String queryID="select ID_PERSONAL, ID_CONTRASEÑA from PERSONAL where USUARIO='"+ sesion +"';";

			ResultSet rs1;

			Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");
			// creaUsuario(usuario,nombre,apellidoP,apellidoM,domicilio,telefono,contra)
			
			Statement stmt=auditoriodbConexion.createStatement();
			PreparedStatement update;
			
			rs1 = stmt.executeQuery(queryID);
			rs1.first();
			IDU=rs1.getInt(1);
			IDC=rs1.getInt(2);
			
			String queryNombre="update PERSONAL set NOMBRE=? where ID_PERSONAL=?;";
			String queryApellidoP="update PERSONAL set APELLIDO_PATERNO=? where ID_PERSONAL=?;";
			String queryApellidoM="update PERSONAL set APELLIDO_MATERNO=? where ID_PERSONAL=?;";
			String queryDomicilio="update PERSONAL set DOMICILIO=? where ID_PERSONAL=?;";
			String queryTelefono="update PERSONAL set TELEFONO=? where ID_PERSONAL=?;";
			String queryContra="update CONTRASEÑA set CONTRASEÑA=sha1(?) where ID_CONTRASEÑA=?;";
			
			
			
			if (nombre != null && !nombre.isEmpty()){
				update=auditoriodbConexion.prepareStatement(queryNombre);
				update.setString(1, nombre);
				update.setInt(2, IDU);
				update.executeUpdate();
				out.print(nombre+"<br>");
			}
			
			if (apellidoP !=null && !apellidoP.isEmpty()){
				update=auditoriodbConexion.prepareStatement(queryApellidoP);
				update.setString(1, apellidoP);
				update.setInt(2, IDU);
				update.executeUpdate();
				out.print(apellidoP+"<br>");
			}
			
			if (apellidoM !=null && !apellidoM.isEmpty()){
				update=auditoriodbConexion.prepareStatement(queryApellidoM);
				update.setString(1, apellidoM);
				update.setInt(2, IDU);
				update.executeUpdate();
				out.print(apellidoM+"<br>");
			}
			
			if (domicilio !=null && !domicilio.isEmpty()){
				update=auditoriodbConexion.prepareStatement(queryDomicilio);
				update.setString(1, domicilio);
				update.setInt(2, IDC);
				update.executeUpdate();
				out.print(domicilio+"<br>");
			}
			
			if (telefono !=null && !telefono.isEmpty()){
				update=auditoriodbConexion.prepareStatement(queryDomicilio);
				update.setString(1, telefono);
				update.setInt(2, IDU);
				update.executeUpdate();
				out.print(telefono+"<br>");
			}
			if (contra !=null && !contra.isEmpty()){
				update=auditoriodbConexion.prepareStatement(queryContra);
				update.setString(1, contra);
				update.setInt(2, IDC);
				update.executeUpdate();
				out.print(contra+"<br>");
			} 
			
	}
	  }
	%>
	
	
	
</body>
</html>