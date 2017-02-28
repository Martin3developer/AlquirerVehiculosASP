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
		
			<h1>Buscar Vehiculos</h1>
			
					<form action="#" method="post" role="form">
				    
				   			
								<input type="text" placeholder="Marca / Modelo / Matricula" name="nombre">
							<br>

				          	<input  name="enviar" type="submit" value="Enviar">

					    
					</form>
				
		
			<%
			ok=Request.form("enviar")
			If ok="Enviar" Then
				nombre=Request.form("nombre")
				if nombre="" then
					response.write("Introduzca marca, modelo o matrícula.") 'Comprobamos que no deja el campo vacío'
				else
					Set conexion = Server.createObject("ADODB.Connection")

					conexion.Open("vehiculos")

					ssql = "SELECT * FROM vehiculo WHERE marca like '%"&nombre&"%' or modelo like '%"&nombre&"%'  or matricula like '%"&nombre&"%';" 
					
									
					set datos= conexion.execute(ssql)
					if not datos.Eof then
						response.write("<table ><thead><tr><th>Matricula</th><th>Modelo</th><th>Marca</th><th>Nº Puertas</th><th>Categoria</th><th>Precio</th><th></th></tr></thead><tbody>")
						do while not datos.Eof 
							response.write("<tr><td>"&datos("matricula")&"</td><td>"&datos("modelo")&"</td><td>"&datos("marca")&"</td><td>"&datos("n_puertas")&"</td><td>"&datos("categoria")&"</td><td>"&datos("precio")&" €</td><td><a href='m_vehiculo.asp?mat="&datos("matricula")&"'>Modificar</a></td></tr>")
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
		</div>
		</div>




		</div>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	    <script src="../js/jquery-3.1.1.min.js"> </script>
	    <script src="../js/bootstrap.min.js"></script>
	</body>
</html>
