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
	
		<title>Inicio</title>

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
		<div class="container contenedor">
			<h1>Buscar Clientes</h1>
			
					<form id="formulario" action="#" method="post" role="form">
				    
				   		
							<input type="text"  placeholder="Nombre de Usuario" name="nombre">
							<br>
				          	<input  name="enviar" type="submit" value="Enviar">

					</form>
			
			<%
			ok=Request.form("enviar")
			If ok="Enviar" Then
				nombre=Request.form("nombre")
				if nombre="" then
					response.write("Introduzca un nombre.") 'Comprobamos que no deja el campo vacío'
				else
					Set conexion = Server.createObject("ADODB.Connection")

					conexion.Open("vehiculos")

					ssql = "SELECT * FROM cliente WHERE nombre like '%"&nombre&"%' and nick<>'admin' ;" 
					
									
					set datos= conexion.execute(ssql)
					if not datos.Eof then
					response.write("<table ><thead><tr><th>Nombre</th><th>Telefono</th><th>Usuario</th><th>Contraseña</th></tr></thead><tbody>")
					do while not datos.Eof 
						response.write("<tr><td>"&datos("nombre")&"</td><td>"&datos("telefono")&"</td><td>"&datos("nick")&"</td><td>"&datos("pass")&"</td></tr>")
					datos.MoveNext
					loop
					response.write("</tbody></table>")

					conexion.Close	
					else
						response.write("No hay resultados con esta búsqueda")
						
					end if 
 				end if
				
			end if

			%>

	</body>
</html>
