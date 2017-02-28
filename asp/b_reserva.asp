
<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
	response.redirect("../index.asp")	
end if 
if tipo=1 then 'Si no tiene permisos'
	response.redirect("../index.asp")	
end if 


'Si pulsa borrar'
if Request.queryString("borrar")=1 then 
	cliente=Request.queryString("cliente")	
	vehiculo=Request.queryString("vehiculo")
	inicio=Request.queryString("inicio")

	Set conexion = Server.createObject("ADODB.Connection")

	conexion.Open("vehiculos")

	ssql = "DELETE FROM reservas WHERE cliente ="&cliente&" and vehiculo='"&vehiculo&"' and inicio = cdate('"&inicio&"');" 
	response.write(ssql)
					
	set datos= conexion.execute(ssql)
	conexion.Close	

end if 


%>


<html>
	<head>
		<meta charset="utf-8">
	
		<title>Inicio</title>

	</head>

	<body>
		<% imprimirCabecera(tipo) %>
	
			<h1>Buscar Reserva</h1>
			
					<form id="formulario" action="#" method="post" role="form">
				    
				   		
							<input type="text"  placeholder="Nombre de Cliente / Matricula / Fecha inicio" name="nombre">
							<br>
				          	<input  name="enviar" type="submit" value="Enviar">

					</form>
			
			<%
			ok=Request.form("enviar")
			If ok="Enviar" Then
			nombre=Request.form("nombre")
				if nombre="" then
					response.write("Introduzca nombre, matricula o fecha") 'Comprobamos que no deja el campo vacío'
				else

					Set conexion = Server.createObject("ADODB.Connection")

					conexion.Open("vehiculos")

					ssql = "SELECT r.*, c.nombre, c.nick,c.codigo FROM reservas r, cliente c  WHERE r.cliente=c.codigo and (c.nombre like '%"&nombre&"%' or r.vehiculo like '%"&nombre&"%'or r.inicio like '%"&nombre&"%') " 
									
					set datos= conexion.execute(ssql)
					if not datos.Eof then
						response.write("<table><thead><tr><th>Cliente</th><th>Vehiculo</th><th>Inicio</th><th>Fin</th><th></th></tr></thead><tbody>")
						hoy=date()
						
						do while not datos.Eof 
							if datos("inicio") >  hoy then
							response.write("<tr><td>"&datos("nombre")&"("&datos("nick")&")</td><td>"&datos("vehiculo")&"</td><td>"&datos("inicio")&"</td><td>"&datos("fin")&"</td><td><a href='b_reserva.asp?borrar=1&cliente="&datos("cliente")&"&vehiculo="&datos("vehiculo")&"&inicio="&datos("inicio")&"'>borrar</a></td></tr>")
							else
							response.write("<tr><td>"&datos("nombre")&"("&datos("nick")&")</td><td>"&datos("vehiculo")&"</td><td>"&datos("inicio")&"</td><td>"&datos("fin")&"</td><td>borrar</td></tr>")	
							end if 
						datos.MoveNext		
								loop
						response.write("</tbody></table>")

						conexion.Close
						else
						response.write("No hay resultados")	
					end if
				end if
			end if

			%>
	
	</body>
</html>
