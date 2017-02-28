<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
response.redirect("../index.asp")	
end if 
%>
<html>
	<head>
		<meta charset="utf-8">
	   
		<title>Inicio</title>

		<!-- Bootstrap core CSS -->
  

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
		
			<h1>Vehículos disponibles</h1>
<% 
Set conexion = Server.createObject("ADODB.Connection")

conexion.Open("vehiculos")

ssql = "Select * from vehiculo"
set datos= conexion.execute(ssql)
response.write("<table ><thead><tr><th>Matricula</th><th>Modelo</th><th>Marca</th><th>Nº Puertas</th><th>Categoria</th><th>Precio</th><th></th></tr></thead><tbody>")
do while not datos.Eof 
	response.write("<tr><td>"&datos("matricula")&"</td><td>"&datos("modelo")&"</td><td>"&datos("marca")&"</td><td>"&datos("n_puertas")&"</td><td>"&datos("categoria")&"</td><td>"&datos("precio")&" €</td><td>")
	if tipo=0 then
		response.write("<a href='m_vehiculo.asp?mat="&datos("matricula")&"'>Modificar</a></td></tr>")
		else
		response.write("</tr>")
	end if 

		
datos.MoveNext
loop
response.write("</tbody></table>")

conexion.Close	

%>

	</body>
</html>
