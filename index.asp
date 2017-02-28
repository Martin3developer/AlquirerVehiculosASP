<%

'-----------------------------En caso de que cierren sesión
if Request.querystring("cerrar")="1" then
	Session("user")=""
	Session.Abandon
	response.cookies("user").expires=Date()-1
	response.cookies("tipo").expires=Date()-1
	response.redirect("../index.asp")
end if 

'----------------------------En caso de que halla cookies
if Request.Cookies("user")<>"" then
	Session("user")=Request.Cookies("user")
	Session("tipo")=Request.Cookies("tipo")
	response.redirect("asp/inicio.asp")
end if 


'-----------------------------En caso de que introduzcan login
ok=Request.form("enviar")
If ok="Enviar" Then

	user=Request.form("user")
	pass=Request.form("pass")
	recordar=Request.form("recordar")
	val=0


	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "Select pass,nick from cliente"

		set datos= conexion.execute(ssql)

	do while not datos.Eof 

		if (user=datos("nick") and pass=datos("pass"))then
			Session("user")=datos("nick")
			
			Session("tipo")="1"
			Session.timeout = 60
			val=1
			if recordar="on" then
				response.cookies("user")=datos("nick")
				response.cookies("tipo")=Session("tipo")
			end if 
			response.redirect("asp/inicio.asp")
		end if
		if user="admin" and pass="admin"  then
			Session("user")="admin"
			Session("tipo")="0"
			val=1
			if recordar="on" then
				response.cookies("user")="admin"
				response.cookies("tipo")=Session("tipo")
			end if 

			response.cookies("user").expires=Date()+365
			response.cookies("tipo").expires=Date()+365
			response.redirect("asp/inicio.asp")
		end if 

		datos.MoveNext
	loop

	if val=0 then
		val=2
	end if 
	
	conexion.Close	
End If
%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Inicio</title>
	</head>
	<body >
			
	<form id="formulario" action="#" method="post" role="form">
   
        <legend>Login</legend>
      		<input type="text" class="form-control" id="uLogin" placeholder="Usuario" name="user"><br>
			<input type="password" placeholder="Contraseña" name="pass"><br>

			<%
				if val=2 then
						response.write("<p><b>Usuario y contraseña incorrectos</b></p>")
					end if 
			%>

				<input type="checkbox" name="recordar"> Recordar sesión<br>
			
          	<input  name="enviar" type="submit" value="Enviar">
	</form>

	</body>
</html>