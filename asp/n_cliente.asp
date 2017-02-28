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
comprobar=0
ok=Request.form("enviar")
If ok="Enviar" Then

	nombre=Request.form("nombre")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "SELECT nick FROM cliente WHERE nick='"&nombre&"';"'Comprobamos que no coincida con otro nick ya registrado'

		set datos= conexion.execute(ssql)

		if not datos.Eof then
			comprobar=1
		end if 

	conexion.Close
	if comprobar<>1 then

	telefono=Request.form("telefono")
	user=Request.form("nick")
	pass=Request.form("pass")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "INSERT INTO cliente (nombre,telefono,nick,pass) VALUES ('"&nombre&"',"&telefono&",'"&user&"','"&pass&"');"

		set datos= conexion.execute(ssql)

	conexion.Close	
	end if 
	
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

		<form id="formulario" action="#" method="post" >

   		
				<input type="text" placeholder="Nombre de Usuario" name="nombre" maxlength="10" required>
			<br>

			
				<input type="number" placeholder="Telefono" name="telefono" min="100000000" max="999999999" required>
			<br>

			
				<input type="text" placeholder="Usuario" name="nick" maxlength="10" required>
			<br>

			
				<input type="text" placeholder="Contraseña" name="pass" maxlength="10" required>
			<br>
			<%
				If comprobar=1 then
					response.write("El Usuario ya existe.<br>")
				end if
			%>
	
          	<input  name="enviar" type="submit" value="Enviar">

	    </div>
	</form>

	</body>
</html>
