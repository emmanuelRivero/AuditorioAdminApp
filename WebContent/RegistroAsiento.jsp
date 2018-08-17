<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registro de asiento</title>
<style>
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

table.asientos {
	  margin: 0 auto;	
}

table.asiento tr, td {
	text-align: center;
	vertical-align: center;
}

input.button-libre {

	padding-left: 15px;  
	padding-top: 1px;
	background: linear-gradient(#99e699, #196719);
	border: 3px outset #1EF13D;
    width:50px;
    height:50px;
}

div.ocupado{
	background: linear-gradient(#ff8080, #990000);
	border: 3px outset #F10101;
	width:50px;
    height:50px;
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
<jsp:include page="Header.jsp"></jsp:include><br/>
<%@page import="java.sql.*" %>
		<%
		String sesion = (String) session.getAttribute("Sesion"); 
		String evento = (String) session.getAttribute("Evento"); 
		String fecha = (String) session.getAttribute("Fecha"); 
		String hora = (String) session.getAttribute("Hora"); 
		
		String accion = request.getParameter("accion");
		String zona = request.getParameter("zona");
		session.setAttribute("Accion", accion);
		session.setAttribute("Zona", zona);
		
		String button = request.getParameter("buttonOpt");
		
		  if (sesion == null){
			  response.sendRedirect("UserLogin.jsp");
		  }else{
		
		if (accion == null || evento == null || fecha == null || hora == null){
			response.sendRedirect("Home.jsp");
		}else{
		
		if (button.equals("Cancelar")){
			response.sendRedirect("Eventos.jsp");
		}else{ 
		
		Class.forName("com.mysql.jdbc.Driver");
		
		ResultSet rsID;
		ResultSet rs1;
		ResultSet rs2;
		
		Connection auditoriodbConexion=DriverManager.getConnection("jdbc:mysql://35.196.88.143:3306/auditoriodb","auditorio","auditorio123Y#");
	
		Statement getID=auditoriodbConexion.createStatement();
		
		String queryID="select ID_EVENTO from EVENTO where EVENTO = '"+evento+"';";
		rsID = getID.executeQuery(queryID);
		rsID.first();
		int idEvento=rsID.getInt(1);		
		
		%>
		
		<form action="Registrar.jsp" method="post">
		<table class="blueTable">
			<tr>
				<td width="13%"><label for="evento">Evento: </label></td>
				<td width="87%"><Label for="evento"><%out.println(evento);%></Label></td>
			</tr>
			<tr>
				<td width="13%"><label for="fecha">Fecha: </label></td>
				<td width="87%"><Label for="fecha"><%out.println(fecha);%></Label></td>
			</tr>
			<tr>
				<td width="13%"><label for="hora">Hora: </label></td>
				<td width="87%"><Label for="hora"><%out.println(hora);%></Label></td>
			</tr>
						<tr>
				<td width="13%"><label for="zona">zona: </label></td>
				<td width="87%"><Label for="zona"><%out.println(zona);%></Label></td>
			</tr>
			<tr>
				<td colspan = "2"><label for="Asiento">Seleccione su asiento: </label></td>
			</tr>
		</table>
			
		<br>
		<table class = "asientos">
		<%
		int asiento=0;
		for (int x=0;x<10;x++){
			%>
			<tr>
			<% 
				for(int y=0;y<10;y++){
					asiento++;
					
					Statement getStatusVenta=auditoriodbConexion.createStatement();
					Statement getStatusReservacion=auditoriodbConexion.createStatement();
					String queryVenta="select V.ID_VENTA from VENTA AS V join EVENTO AS E ON V.ID_EVENTO = E.ID_EVENTO where V.ID_ZONA = "+zona+" AND V.ASIENTO_NUM = "+asiento+" AND E.ID_EVENTO ="+idEvento+";";
					String queryReservacion="select R.ID_RESERVACION from RESERVACION AS R join EVENTO AS E ON R.ID_EVENTO = E.ID_EVENTO where R.ID_ZONA = "+zona+" AND R.ASIENTO_NUM = "+asiento+" AND E.ID_EVENTO ="+idEvento+" AND R.ESTADO = 1;";
					rs1=getStatusVenta.executeQuery(queryVenta);
					rs2=getStatusReservacion.executeQuery(queryReservacion);
					rs1.first();
	/*				int r1 = rs1.getInt(1);
					rs1.
					
					rs2.first();
					int r2 = rs2.getInt(1);*/
					
					if (!rs1.first() && !rs2.first()){
					%>
					<td><input type="submit" class=button-libre  name="asiento"  value="<%=asiento%>"></td>
					<%
					}else{
						%>
						<td>
						<div class="ocupado"><%=asiento%></div>
						</td>
						<%
					}
				}
			%>
			</tr>

		<%
		}
		}
		}
		}
		%>
		
		</table>
		</form>
		
		<form action="RegistroZona.jsp" method="post">
		<input type="hidden" id="buttonOpt" name="buttonOpt" value=<%=accion %>>
		<input type="hidden" id="evento" name="accion" value=<%=evento %>>
		<table>
			<tr>
					<td align="center" width="33%"><input type="submit"
					name="button" id="button" value="Cancelar"></td>
			</tr>
		</table>
		</form>
		
</body>
</html>