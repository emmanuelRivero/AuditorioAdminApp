<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
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
    height: 40px%;
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
    height: 40px;
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

</style>
<body>

<jsp:include page="Header.jsp"></jsp:include><br/>

	<h1 style="text-align: center">Login</h1>
	<br>
	<form action="UserLogin.jsp" method="post">

		<table align="center">
			<tr>
				<td><label for="usuario">Usuario: </label></td>
				<td><input type="text" name="usuario" id="usuario"></td>
			</tr>
			<tr>
			<tr>			
			
				<td><label for="contra">Contraseña: </label></td>
				<td><input type="password" name="contra" id="contra"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					name="button" id="button" value="Entrar"></td>
			</tr>
		</table>
		<p>
			<br>
		</p>
<%@page import="java.sql.*" %>
	<%
	
	String sesion= (String) session.getAttribute("Sesion");
	if (session != null){
		
	}
	
	
	String usuario=request.getParameter("usuario");
	String contra=request.getParameter("contra");
	
	if (usuario != null && contra != null){
		

	// Database
		Class.forName("com.mysql.jdbc.Driver");
		ResultSet rs;
		ResultSet rs2;
		PreparedStatement stmt;
		int autenticacion;
		
		try{
		
		Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");
		// autentica(usuario,password) returns 0,1,2,
		Statement getPuesto =auditoriodbConexion.createStatement();
		String queryPuesto="select ID_PUESTO from PERSONAL where USUARIO='"+usuario+"';";
		
		
		stmt = auditoriodbConexion.prepareStatement("select autenticaPersonal(?,?) AS result");
		stmt.setString(1, usuario);
		stmt.setString(2, contra);
		
		
		
		rs = stmt.executeQuery();
		
		rs.first();
		if (rs.getInt("result") == 1){
			
			rs2 = getPuesto.executeQuery(queryPuesto);
			rs2.first();
			int puesto=rs2.getInt(1);
			session.setAttribute("Sesion", usuario);
			session.setAttribute("Puesto", puesto);
			response.sendRedirect("Home.jsp");
			
		}else if(rs.getInt("result") == 2){
			out.println("usuario No valido");
		}else{
			out.println("Contraseña invalida");	
		} 
		
		}catch(Exception e){
			String cause = e.toString();
			String msg = e.getMessage();
			out.println("Ha habido un error en la base de datos: "+msg+" Cuasa: " +cause);
			
		}
	}
	
	%>

</body>
</html>