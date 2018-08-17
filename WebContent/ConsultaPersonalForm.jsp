<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Registro de usuario</title>
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
	<%
		Class.forName("com.mysql.jdbc.Driver");
	
	String query="select PUESTO from PUESTO;";
	ResultSet rs;
	
	Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");

	Statement getList=auditoriodbConexion.createStatement();
		
	rs = getList.executeQuery(query);
	
	%>

	<h1 style="text-align: center">Consulta tus eventos</h1>
	<form action="ConsultaPersonal.jsp" method="post">

		<table	width="30%">
			<tr>
				<td width="25%"><label for="nombre">Nombre: </label></td>
				<td width="75%"><input type="text" name="nombre" id="nombre"></td>
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
				<td colspan="2" align="center"><input type="submit"
					name="button" id="button" value="Consultar"></td>
			</tr>
		</table>
		<p>
			<br>
		</p>
	</form>
</body>
</html>