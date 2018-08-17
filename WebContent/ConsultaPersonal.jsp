<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Consulta de personal</title>
</head>
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
<body>
<%@page import="com.auditorio.date.*"%>
<%@page import="java.sql.*" %>
	<% String sesion= (String) session.getAttribute("Sesion"); 
	  if (sesion == null){
		  response.sendRedirect("UserLogin.jsp");
	  }else{
	
	int puestoI = (int) session.getAttribute("Puesto"); 
	if (puestoI != 10 ){
		response.sendRedirect("UserLogin.jsp");
	}else{
		  
	%>
	<jsp:include page="Header.jsp"></jsp:include><br/>
	<jsp:include page="ConsultaPersonalForm.jsp"></jsp:include><br/>
	
	<%
	String nombre = request.getParameter("nombre");
	String puesto = request.getParameter("puesto");
	String usuario = request.getParameter("usuario");
	
	if (nombre == null){
		
	}else{
	
	
	String queryPersonal;
	ResultSet rs1;
	ResultSet rs2;
	
		// Database
		Class.forName("com.mysql.jdbc.Driver");		
		
		Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");
		
		
		Statement getId=auditoriodbConexion.createStatement();
		Statement getPersonal=auditoriodbConexion.createStatement();
		
		String queryID="SELECT ID_PUESTO FROM PUESTO where PUESTO = '"+puesto+"';";
		rs1= getId.executeQuery(queryID);
		rs1.first();
		int idPuesto=rs1.getInt(1);
				
		queryPersonal=SetQueryConsulta.getVendedor(nombre, usuario, idPuesto);
		
		
		rs2 = getPersonal.executeQuery(queryPersonal);
	
	%>
	<table class="blueTable">
		<thead>
		<tr>	
			<th>Nombre:</th>
			<th>Apellido Paterno:</th>
			<th>Apellido Materno:</th>
			<th>Usuario :</th>
			<th>Domicilo:</th>
			<th>Telefono:</th>
		</tr>
		</thead>
		<% 
			while(rs2.next()){
			%>
			<tr>
				<td><%=rs2.getString(1) %></td>
				<td><%=rs2.getString(2)%></td>
				<td><%=rs2.getString(3) %></td>
				<td><%=rs2.getString(4) %></td>
				<td><%=rs2.getString(5) %></td>
				<td><%=rs2.getString(6) %></td>
			</tr>
			<% 
			}
		%>		
	
	</table>
	
	<%
	}}
	}
	  

	%>
	
</body>
</html>