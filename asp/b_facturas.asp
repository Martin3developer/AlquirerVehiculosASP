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
			<h1>Buscar Clientes con facturas</h1>
			
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
					response.write("Introduzca un nombre de cliente") 'Comprobamos que no deja el campo vacío'
				else
					Set conexion = Server.createObject("ADODB.Connection")

					conexion.Open("vehiculos")

					ssql = "SELECT * FROM cliente WHERE nombre like '%"&nombre&"%' ;" 
					
									
					set datos= conexion.execute(ssql)
					if not datos.Eof then

					response.write("<table ><thead><tr><th>Cliente</th><th>Facturas</th></tr></thead><tbody>")
						do while not datos.Eof 
							response.write("<tr><td>"&datos("nombre")&"("&datos("nick")&")</td><td><a href='b_facturas.asp?nick="&datos("nick")&"'>factura</a></td></tr>")
						datos.MoveNext
						loop
							conexion.Close	
						response.write("</tbody></table>")

					else
						response.write("no hay resultados")
					end if 
				end if
				
			
			end if

			%>
			<%
			nick=Request.queryString("nick")
			If nick<>"" Then
				Set conexion = Server.createObject("ADODB.Connection")
				hoy=date()
				conexion.Open("vehiculos")
				
				
				ssql = "SELECT c.nombre, r.* ,v.precio FROM cliente c, reservas r, vehiculo v WHERE  c.codigo = r.cliente and r.vehiculo= v.matricula and c.nick='"&nick&"' and r.inicio < cdate('"&hoy&"');" 
			
				
				set datos= conexion.execute(ssql)

				response.write("<table ><thead><tr><th colspan=4>Factura de "&datos("nombre")&"</th></tr></thead><tbody>")

				do while not datos.Eof
				dias=datediff("d",datos("inicio"),datos("fin"))
				precio=datos("precio")*dias
					response.write("<tr><td>"&datos("vehiculo")&"</td><td>"&datos("inicio")&"</td><td>"&datos("fin")&"</td><td>"&precio&"€</td></tr>")


				datos.MoveNext
				loop
				response.write("</tbody></table>")

				conexion.Close	
			end if

			%>
	</body>
</html>
