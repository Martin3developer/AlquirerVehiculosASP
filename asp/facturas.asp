<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
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
		
			<h1>Ver factura</h1>
			
			<%
			
				Set conexion = Server.createObject("ADODB.Connection")
				hoy=date()
				conexion.Open("vehiculos")
				
				if tipo=1 then
					ssql = "SELECT r.* ,v.precio FROM cliente c, reservas r, vehiculo v WHERE  c.codigo = r.cliente and r.vehiculo= v.matricula and c.nick='"&usuario&"' and r.inicio < cdate('"&hoy&"');" 
					response.write("<table ><thead><tr><th>vehiculo</th ><th >inicio</th ><th >fin</th ><th >precio</th ></tr></thead><tbody>")
					else
					ssql = "SELECT c.nombre, c.nick, r.* ,v.precio FROM cliente c, reservas r, vehiculo v WHERE  c.codigo = r.cliente and r.vehiculo= v.matricula and r.inicio < cdate('"&hoy&"') order by c.nombre;" 
					response.write("<table ><thead><tr><th>nombre</th><th>vehiculo</th ><th >inicio</th ><th >fin</th ><th >precio</th ></tr></thead><tbody>")
				end if
				set datos= conexion.execute(ssql)

				do while not datos.Eof
				dias=datediff("d",datos("inicio"),datos("fin"))
				precio=datos("precio")*dias
				if tipo=1 then
					response.write("<tr><td>"&datos("vehiculo")&"</td><td>"&datos("inicio")&"</td><td>"&datos("fin")&"</td><td>"&precio&"€</td></tr>")
				else
					response.write("<tr><td>"&datos("nick")&"("&datos("nombre")&")</td><td>"&datos("vehiculo")&"</td><td>"&datos("inicio")&"</td><td>"&datos("fin")&"</td><td>"&precio&"€</td></tr>")

				end if 
			
				datos.MoveNext
				loop
				response.write("</tbody></table>")

				conexion.Close	
		

			%>
	</body>
</html>
