<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Consulta de eventos</title>
<style>
table.blueTable {
  border: 1px solid #1C6EA4;
  background-color: #EEEEEE;
  text-align: center;
  border-collapse: collapse;

}
table.blueTable td, table.blueTable th {
  border: 1px solid #AAAAAA;
  padding: 3px 2px;
}
table.blueTable tbody td {
  font-size: 16px;
}
table.blueTable tr:nth-child(even) {
  background: #D0E4F5;
}
table.blueTable thead {
  background: #1C6EA4;
  background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
  background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
  background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
  border-bottom: 2px solid #444444;
}
table.blueTable thead th {
  font-size: 15px;
  font-weight: bold;
  color: #FFFFFF;
  border-left: 2px solid #D0E4F5;
}
table.blueTable thead th:first-child {
  border-left: none;
}

table.blueTable tfoot {
  font-size: 14px;
  font-weight: bold;
  color: #FFFFFF;
  background: #D0E4F5;
  background: -moz-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
  background: -webkit-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
  background: linear-gradient(to bottom, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
  border-top: 2px solid #444444;
}
table.blueTable tfoot td {
  font-size: 14px;
}
table.blueTable tfoot .links {
  text-align: right;
}
table.blueTable tfoot .links a{
  display: inline-block;
  background: #1C6EA4;
  color: #FFFFFF;
  padding: 2px 8px;
  border-radius: 5px;
}
</style>
</head>
<body>
<%@page import="com.auditorio.date.*"%>
<%@page import="java.sql.*" %>
	<% 
	String sesion= (String) session.getAttribute("Sesion"); 
	  if (sesion == null){
		  response.sendRedirect("UserLogin.jsp");
	  }else{
	%>
	
	
	<jsp:include page="Header.jsp"></jsp:include><br/>
	<jsp:include page="BuscaEvento.html"></jsp:include><br/>

	<%
	long timeI;
	long timeF;
	String evento=request.getParameter("evento");
	String fechaI = request.getParameter("fechaInicial");
	String fechaF = request.getParameter("fechaFinal");
	ResultSet rs;
	timeI=0;
	timeF=0;
	
	
	if (evento == null){
	
	}else{
		
	if (fechaI.equals("")){
		timeI=0;
	}else{
		fechaI = fechaI + " 00:00:00";
		timeI = epochTime.convert(fechaI);
	}
	
	if (fechaF.equals("")){
		timeF = System.currentTimeMillis() / 1000L;
	}else{
		fechaF = fechaF + " 23:59:59";
		timeF = epochTime.convert(fechaF);
	}
	
	if (timeF < timeI){
		response.sendRedirect("Eventos.jsp");
	}else{
		
		// Database
		Class.forName("com.mysql.jdbc.Driver");
		//String query = "select EVENTO, from_unixtime(FECHA_EVENTO, '%m-%d-%Y'), from_unixtime(FECHA_EVENTO, '%H:%i:%s') from EVENTO where FECHA_EVENTO between " + timeI + " AND "+ timeF +";";
		String query = SetQueryConsulta.getEventos(evento, timeI, timeF);
		
		Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");
		// creaPersonal(in newUsuario ,Pnombre , APaterno , AMaterno , dom , tel ,Ppuesto , contraseña)
		
		Statement stmp=auditoriodbConexion.createStatement();
		rs = stmp.executeQuery(query);
			
	%>
	
	<form action="RegistroZona.jsp" method="post">
		<table border="1"  class="blueTable">
			<thead>
			<tr>
				<th>Evento</th>
				<th>Fecha</th>
				<th>Hora</th>
			</tr>
			</thead>
			<%
			while (rs.next()) { 
			%>
			<tr>
				<td><input type="radio" name="evento"
					value="<%=rs.getString(1) %>" id="evento_0"><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
			</tr>
			<%} %>		
			</table>
		<table width="%80" >
			<tr>
			<td align="center" width="33%"><input type="submit"
					name="buttonOpt" id="button" value="Comprar Boleto"></td>
			<td align="center" width="33%"><input type="submit"
					name="buttonOpt" id="button" value="Reservar Boleto"></td>
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