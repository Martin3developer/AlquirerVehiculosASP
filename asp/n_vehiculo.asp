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
comprobar=0
If ok="Enviar" Then

	matricula=Request.form("matricula")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "SELECT matricula FROM vehiculo WHERE matricula='"&matricula&"'"

		set datos= conexion.execute(ssql)
		if not datos.Eof then
			comprobar=1
		end if 

	conexion.Close	

		if comprobar<>1 then
			
			modelo=Request.form("modelo")
			marca=Request.form("marca")
			n_puertas=Request.form("n_puertas")
			categoria=Request.form("categoria")
			precio=Request.form("precio")

			Set conexion = Server.createObject("ADODB.Connection")

				conexion.Open("vehiculos")

		ssql = "INSERT INTO vehiculo VALUES ('"&matricula&"','"&modelo&"','"&marca&"',"&n_puertas&","&categoria&","&precio&");"
		

				set datos= conexion.execute(ssql)

			conexion.Close	
		End If

end if 
	
%>

<html>
	<head>
		<meta charset="utf-8">
	  
		<title>Inicio</title>

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
		
			<h1>Crear Nuevo Vehículo</h1>
			
					<form id="formulario" action="#" method="post">
		
				   			
								<input type="text"  placeholder="Matricula" name="matricula" maxlength="10" required>
						<br>

						
								<input type="text"  placeholder="Modelo" name="modelo" required>
						<br>

						
								<input type="text"  placeholder="Marca" name="marca" required>
						<br>
				
							
								<input type="number"  placeholder="Número de Puertas" name="n_puertas" min="1" max="8" required>
						<br>

						
								<input type="number"  placeholder="Categoría" name="categoria" min="1" required>
						<br>

							
								<input type="number"  placeholder="Precio" name="precio" min="1" required> €
						<br>
						<%
						if comprobar=1 then
							response.write("Matrícula incorrecta.<br>La matrícula ya está registrada. <br>")
						end if 
						%>
				          	<input name="enviar" type="submit" value="Enviar">

					</form>
				
		
	</body>
</html>
