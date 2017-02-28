<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
response.redirect("../index.asp")	
end if 


'--------------------------------------------------------Si pulsa modificar
ok=Request.form("modificar")
If ok="Modificar" Then

	matricula=Request.form("matricula")
	modelo=Request.form("modelo")
	marca=Request.form("marca")
	n_puertas=Request.form("n_puertas")
	categoria=Request.form("categoria")
	precio=Request.form("precio")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

ssql = "UPDATE vehiculo SET modelo='"&modelo&"', marca='"&marca&"', n_puertas="&n_puertas&", categoria="&categoria&", precio= "&precio&" WHERE matricula='"&matricula&"';"

		set datos= conexion.execute(ssql)

	conexion.Close	
	response.redirect("vehiculos.asp")
End If
%>

<html>
	<head>
		<meta charset="utf-8">
	 
		<title>Inicio</title>

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
		
			<h1>Modificar Vehículo</h1>
			<form id="formulario" action="#" method="post" role="form">
		<%
		Set conexion = Server.createObject("ADODB.Connection")

			conexion.Open("vehiculos")
			matricula=Request.queryString("mat")
			ssql = "Select * from vehiculo where matricula= '"&matricula&"' ;"
			set datos= conexion.execute(ssql)
			
			if not datos.Eof then
		
			response.write("<input type='text'  placeholder='Matricula' name='matricula' value='"&datos("matricula")&"' readonly><br>")

			response.write("<input type='text'  placeholder='Modelo' name='modelo' value='"&datos("modelo")&"'><br>")

			response.write("<input type='text'  placeholder='Marca' name='marca' value='"&datos("marca")&"'><br>")
				
			response.write("<input type='text'  placeholder='Número de Puertas' name='n_puertas' value='"&datos("n_puertas")&"'><br>")

			response.write("<input type='text'  placeholder='Categoría' name='categoria' value='"&datos("categoria")&"'><br>")

			response.write("<input type='text'  placeholder='Precio' name='precio' value='"&datos("precio")&"'><br>")
					
			response.write("<input name='modificar' type='submit' value='Modificar'></div>")

		
			end if

			conexion.Close	

		%>
					</form>

	</body>
</html>
