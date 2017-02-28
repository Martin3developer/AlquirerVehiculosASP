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


ok=Request.form("enviar")
If ok="Enviar" Then

	cliente=Request.form("cliente")
	vehiculo=Request.form("vehiculo")
	inicio=Request.form("inicio")
	fin=Request.form("fin")

'---------------------------------------------------------------------------------------------------------------------'

	if inicio > fin then 'Si la fecha de fin es anterior a la de inicio'
		response.redirect("n_reserva.asp?err=1")
	end if 

'----------------------Control de dias de reserva-------------------------------------------------------------------------
''	dias=datediff("d",inicio,fin)

''	redim fecha_alquiler(dias)
''	redim fechas_alquilado(1,1)
''	contador=0

''	for i = 0 to ubound(fecha_alquiler) 
''		fecha_alquiler(i)=dateadd("d",i,inicio) 'fecha que el cliente quiere reservar'
''	next

''	Set conexion = Server.createObject("ADODB.Connection")

''		conexion.Open("vehiculos")

''	ssql = "select inicio, fin from reservas where vehiculo='"&vehiculo&"';"
''		set datos= conexion.execute(ssql)

''			do while not datos.Eof 
''			dias=datediff("d",datos("inicio"),datos("fin"))
''				redim fechas_alquilado(contador,dias) 'añadimos el espacio para las fechas'
''				for i = 0 to ubound(fechas_alquilado,2) 
''					fechas_alquilado(contador,2)=dateadd("d",i,inicio) 'añadimos todas las fechas a un array'
''				next
''			contador=contador+1
''			loop
''	conexion.Close	

''	for i = 0 to ubound(fecha_alquiler)' Recorremos todas las fechas comparandolas'
''		for j = 0 to ubound(fechas_alquilado)
''			for k = 0 to ubound(fechas_alquilado,2)
''				
''			if fecha_alquiler(i)=fechas_alquilado(j,k) then
''
''				response.redirect("n_reserva.asp?err=2") 'Si coincide con alguna fecha es que ya está reservado para esa fecha'
''
''			end if 
''
''			next	
''		next
''	next





'----------------------------------------------------------------------------------------------------------------------------'
	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

	ssql = "INSERT INTO reservas VALUES ("&cliente&",'"&vehiculo&"','"&inicio&"','"&fin&"');"

		set datos= conexion.execute(ssql)

	conexion.Close	
	response.redirect("n_reserva.asp")
End If
%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Inicio</title>

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
			<h1>Crear Nueva Reserva</h1>

		<form id="formulario" action="#" method="post" >

			<select name="cliente">
				<%
				Set conexion = Server.createObject("ADODB.Connection")

				conexion.Open("vehiculos")

				ssql = "Select codigo, nombre, nick from cliente;"

				set datos= conexion.execute(ssql)

				do while not datos.Eof 
				response.write("<option value='"&datos("codigo")&"'>"&datos("nombre")&"("&datos("nick")&")</option>")
				datos.MoveNext
				loop

				conexion.Close	
				%>
			  
			</select><br>
			<select name="vehiculo">
				<%
				Set conexion = Server.createObject("ADODB.Connection")

				conexion.Open("vehiculos")

				ssql = "Select matricula, marca, modelo from vehiculo;"

				set datos= conexion.execute(ssql)

				do while not datos.Eof 
				response.write("<option value='"&datos("matricula")&"'>"&datos("marca")&"("&datos("modelo")&")</option>")
				datos.MoveNext
				loop

				conexion.Close	
				%>
			  
			</select><br>
				<input type="date" name="inicio">
			<br>

				<input type="date" placeholder="dd/mm/aaaa" name="fin">
			<br>
			<% 
			if Request.queryString("err")=1 then
				response.write("Error al introducir las fechas<br>")
			end if
			if  Request.queryString("err")=2 then 
				response.write("El vehiculo no esta disponible en esa fecha<br>")
			end if
			 %>
          	<input  name="enviar" type="submit" value="Enviar">

	</form>

	</body>
</html>
