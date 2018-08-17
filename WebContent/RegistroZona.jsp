<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registro de evento</title>
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

table.blueTable {
width: 40%;
vertical-align: middle;
  text-align: right;
  border-collapse: collapse;
  margin: 0 auto;
}


table.blueTable td + td{
text-align: left;
    width: 100%;
    height: 40px;
    padding: 12px 20px;
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
		String sesion = (String) session.getAttribute("Sesion"); 
		String evento = request.getParameter("evento");
		String button = request.getParameter("buttonOpt");
		
		  if (sesion == null){
			  response.sendRedirect("UserLogin.jsp");
		  }else{
		
		if (evento == null){
			response.sendRedirect("Eventos.jsp");
		}else{
		
			
		Class.forName("com.mysql.jdbc.Driver");
		
		String query="select EVENTO, from_unixtime(FECHA_EVENTO, '%m-%d-%Y'), from_unixtime(FECHA_EVENTO, '%H:%i:%s') from EVENTO where EVENTO='"+ evento +"';";
		ResultSet rs;
		
		Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");

		Statement getList=auditoriodbConexion.createStatement();
			
		rs = getList.executeQuery(query);
		rs.first();
		
		String fecha = rs.getString(2);
		String hora = rs.getString(3);
		
		String queryzona="select ID_ZONA from ZONA;";
		ResultSet rsZona;

		Statement getZona=auditoriodbConexion.createStatement();
			
		rsZona = getZona.executeQuery(queryzona);
		
		session.setAttribute("Evento", evento);
		session.setAttribute("Fecha", fecha);
		session.setAttribute("Hora", hora);
		
		if (button.equals("Comprar Boleto")){
	%>
<h1 style="text-align: center">Registro de zona</h1>
		<form action="RegistroAsiento.jsp" method="post">
		<input type="hidden" id="evento" name="accion" value="Comprar Boleto">
			<table class="blueTable">
				<tr>
					<td><label for="evento">Evento: </label></td>
					<td><label for="evento"><%out.println(evento);%></label></td>
				</tr>
				<tr>
					<td><label for="evento">Fecha: </label></td>
					<td><label for="fecha"><%out.println(fecha);%> </label></td>
				</tr>
				<tr>
				<td><label for="evento">Hora: </label></td>
					<td><label for="hora"><%out.println(hora);%></label></td>
				</tr>
			</table>
		<table>
			<tr>
				<td><label for="zona">zona:</label></td>
				<td><select name="zona" id="zona">
					<%while (rsZona.next()) { %>
					<option value="<%=rsZona.getInt(1) %>"><%=rsZona.getInt(1) %></option>
						<%} %>
				</select></td>
			</tr>
		</table>
		<img class="center" src="images/zonas.gif">
		<table width="%80" >
			<tr>
			<td align="center" width="33%"><input type="submit"
					name="buttonOpt" id="button" value="Comprar"></td>
			<td align="center" width="33%"><input type="submit"
					name="buttonOpt" id="button" value="Cancelar"></td>
			</tr>
		</table>
		</form>
		
		<!--  <<< RESERVACION >>>  -->
		
		<%}else if(button.equals("Reservar Boleto")) { %>
		<form action="RegistroAsiento.jsp" method="post">
		<input type="hidden" id="evento" name="accion" value="Reservar Boleto">
			<table class="blueTable">
				<tr>
					<td><label for="evento">Evento: </label></td>
					<td><label for="evento"><%out.println(evento);%></label></td>
				</tr>
				<tr>
					<td><label for="evento">Fecha: </label></td>
					<td><label for="fecha"><%out.println(fecha);%> </label></td>
				</tr>
				<tr>
				<td><label for="evento">Hora: </label></td>
					<td><label for="hora"><%out.println(hora);%></label></td>
				</tr>
			</table>
		<table>
			<tr>
				<td><label for="zona">zona:</label></td>
				<td><select name="zona" id="zona">
					<%while (rsZona.next()) { %>
					<option value="<%=rsZona.getInt(1) %>"><%=rsZona.getInt(1) %></option>
						<%} %>
				</select></td>
			</tr>
		</table>
		<img class="center" src="images/zonas.gif">
		<table width="%80" >
			<tr>
			<td align="center" width="33%"><input type="submit"
					name="buttonOpt" id="button" value="Reservar"></td>
			<td align="center" width="33%"><input type="submit"
					name="buttonOpt" id="button" value="Cancelar"></td>
			</tr>
		</table>
		</form>
		
		
		<%
		}
		}
		}
		%>
</body>
</html>
	