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

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
		
			<h1>Reservas</h1>

<% 
Set conexion = Server.createObject("ADODB.Connection")

conexion.Open("vehiculos")
if tipo=0 then
ssql = "Select c.nombre as nombre, c.nick as nick, r.* from reservas r, cliente c where c.codigo = r.cliente;"
else
ssql = "Select c.nombre as nombre, c.nick as nick, r.* from reservas r, cliente c where c.codigo = r.cliente and c.nick='"&usuario&"';"
end if
set datos= conexion.execute(ssql)
response.write("<table><thead><tr><th>Cliente</th><th>Vehiculo</th><th>Inicio</th><th>Fin</th></tr></thead><tbody>")
do while not datos.Eof 
	response.write("<tr><td>"&datos("nick")&"("&datos("nombre")&")</td><td>"&datos("vehiculo")&"</td><td>"&datos("inicio")&"</td><td>"&datos("fin")&"</td></tr>")
datos.MoveNext
loop
response.write("</tbody></table>")

conexion.Close	

%>





	</body>
</html>
