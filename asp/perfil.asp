<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
response.redirect("../index.asp")	
end if 
if tipo=0 then 'Si no tiene persmisos'
	response.redirect("../index.asp")	
end if 

ok=Request.form("enviar")
If ok="Enviar" Then

	nombre=Request.form("nombre")
	telefono=Request.form("telefono")
	user=Request.form("nick")
	pass=Request.form("pass")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")
				response.write(ssql)

	ssql = "UPDATE cliente SET nombre='"&nombre&"', telefono="&telefono&", pass='"&pass&"' WHERE nick='"&usuario&"';"
	response.write(ssql)

		set datos= conexion.execute(ssql)

	conexion.Close	
End If
%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Inicio</title>

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
		<div class="container contenedor">
			<h1>Crear Nuevo Cliente</h1>


		<%	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "Select * from cliente where nick ='"&usuario&"'"


		set datos= conexion.execute(ssql)

		%>

		<form action="#" method="post" >

   		<%
		response.write("<input type='text'  placeholder='Nombre de Usuario'  name='nombre' value="&datos("nombre")&"><br>")
			
		response.write("<input type='text'  placeholder='Telefono'  name='telefono' value="&datos("telefono")&"><br>")

		response.write("<input type='text'  placeholder='Usuario'  name='nick' value="&datos("nick")&"><br>")

		response.write("<input type='text'  placeholder='Contraseña'  name='pass' value="&datos("pass")&"><br>")
			
		%>
          	<input  name="enviar" type="submit" value="Enviar">

		</form>

	<%
	conexion.Close	
		%>

	</body>
</html>
