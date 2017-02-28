<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
response.redirect("../index.asp")	
end if 
if tipo=1 then 'Si no tiene persmisos'
	response.redirect("../index.asp")	
end if 
%>
<html>
	<head>
		<meta charset="utf-8">

		<title>Clientes</title>

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
	
		<h1>Clientes</h1>
		<% 
		Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "Select * from cliente"
		set datos= conexion.execute(ssql)
		response.write("<table><thead><tr><th>Nombre</th><th>Telefono</th><th>Usuario</th><th>Contraseña</th></tr></thead><tbody>")
		do while not datos.Eof 
			response.write("<tr><td>"&datos("nombre")&"</td><td>"&datos("telefono")&"</td><td>"&datos("nick")&"</td><td>"&datos("pass")&"</td></tr>")
		datos.MoveNext
		loop
		response.write("</tbody></table>")

		conexion.Close	

		%>

	</body>
</html>
