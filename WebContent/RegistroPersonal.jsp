<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Registro de vendedor</title>
<style>
.center {
    display: block;
    margin-left: auto;
    margin-right: auto;
}

table {
	  margin: 0 auto;
	  width: 40%;
	  text-align: right;	  
}

input[type=text]	 {
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
    background-color: #1a53ff;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type=submit]:hover {
    background-color: #45a049;
}

input[type=password], select {
    width: 100%;
    height: 40px;
    padding-left: 10px;
    padding-right: 10px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

</style>
</head>

<body>
<%@page import="java.sql.*" %>
<jsp:include page="Header.jsp"></jsp:include><br/>
	<%
	int puesto = (int) session.getAttribute("Puesto"); 
	if (puesto != 10 ){
		response.sendRedirect("UserLogin.jsp");
	}else{
	
	
	Class.forName("com.mysql.jdbc.Driver");
	
	String query="select PUESTO from PUESTO;";
	ResultSet rs;
	
	Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");

	Statement getList=auditoriodbConexion.createStatement();
		
	rs = getList.executeQuery(query);
	
	%>
	<h1 style="text-align: center">Registro</h1>
	<form action="RegistroPersonalDB.jsp" method="post">

		<table width="30%">
			<tr>
				<td width="25%"><label for="nombre">Nombre: </label></td>
				<td width="75%"><input type="text" name="nombre" id="nombre"></td>
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
				<td><label for="usuario">Usuario: </label></td>
				<td><input type="text" name="usuario" id="usuario"></td>
			</tr>			
			<tr>
				<td><label for="puesto">Puesto:</label></td>
				<td><select name="puesto" id="puesto">
					<%while (rs.next()) { %>
					<option value="<%=rs.getString(1) %>"><%=rs.getString(1) %></option>
						<%} %>
				</select></td>
			</tr>
			<tr>
				<td><label for="contra">Contraseña: </label></td>
				<td><input type="password" name="contra" id="contra"></td>
			</tr>
			<tr>			
				<td><label for="contra">Confirmar Contraseña: </label></td>
				<td><input type="password" name="contraConf" id="contraConf"></td>
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
	<%} %>
</body>
</html>