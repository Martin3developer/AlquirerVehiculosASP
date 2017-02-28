<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
response.redirect("../index.asp")	
end if 
'-----------------------------Añadir---------------------------------------'
If Request.form("nuevo")="Añadir" Then
	comprobar=0
	matricula=Request.form("matricula")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "SELECT matricula FROM vehiculo WHERE matricula='"&matricula&"'"

		set datos= conexion.execute(ssql)
		if not datos.Eof then
			comprobar=2
			else
			comprobar=1
		end if 

	conexion.Close	

		if comprobar=1 then
			
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
'-------------------------Modificar----------------------'
If Request.form("modificar")="Ok" Then

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
if Request.form("modificar")="X" then
	response.redirect("vehiculos.asp")
end if 
%>
<% imprimirCabecera(tipo)

'________________________Maquetación de la información_________________________________________' %>


<div id="content">
			<div class="content-nav">
				<nav class="navbar navbar-default">
					<div class="container-fluid">
						<div class="navbar-header">
							<!-- Sidebar toggle button -->
							<button type="button" class="sidebar-toggle">
								<i class="fa fa-bars"></i>
							</button>
							<a class="navbar-brand text-size-24" href="#">VEHÍCULOS</a>
						</div>
							<div id="menu">
								<span class="navbar-brand text-size-24 navbar-right">Bienvenido <%=usuario%></span>
							</div>
					</div>
				</nav>
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-xs-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<span class="panel-title pull-left text-black"><i class="fa fa-fw fa-car"></i> Busqueda de Vehículos</span>
								<!-- Busqueda de Vehículos -->
								<form action="#" class="pull-right hidden-xs" method="post">
									<div class="form-group">
										<div class="input-group input-group-sm">
											<input type="text" class="form-control" placeholder="Buscar por marca, modelo o matrícula" name="busqueda" value="">
											<span class="input-group-btn">
												<input type="submit" class="btn btn-default btn-block" name="buscar" value="Buscar">
											</span>
										</div>
									</div>
								</form>
								<div class="clearfix"></div>
							</div>
							<div class="panel-body table-responsive table-full">
								<table class="table table-stripped table-hover table-bordered">
									<thead>
										<tr>
											<th class="text-center text-nowrap">Matrícula</th>
											<th class="text-center text-nowrap">Modelo</th>
											<th class="text-center text-nowrap">Marca</th>
											<th class="text-center text-nowrap">Nº de Puertas</th>
											<th class="text-center text-nowrap">Categoría</th>
											<th class="text-center text-nowrap">Precio</th>
											<%if tipo=0 then
													response.write("<th></th>")
											end if%> 
											
										</tr>
									</thead>
									<tbody>
										
	<!-- _________________________________Añadir nuevo Vehículo____________________________- -->

											<%if tipo=0 then
													response.write("<tr><form action='#' method='post'>")
													if comprobar=2 then
														response.write("<td><input type='text' class='form-control input-sm' placeholder='Matrícula no disponible'name='matricula' style='border:1px solid red' maxlength='10' required></td>")
														else
														response.write("<td><input type='text' class='form-control input-sm' placeholder='Matricula' name='matricula' maxlength='10' required></td>")
													end if 
													
													response.write("<td><input type='text' class='form-control input-sm' placeholder='Modelo' name='modelo' required></td><td><input type='text' class='form-control input-sm' placeholder='Marca' name='marca' required></td><td><input type='text' class='form-control input-sm' placeholder='Número de Puertas' name='n_puertas' min='1' max='8' required></td><td><input type='text' class='form-control input-sm' placeholder='Categoría' name='categoria' min='1' required></td><td><input type='text' class='form-control input-sm' placeholder='Precio' name='precio' min='1' required></td><td><input type='submit' class='btn btn-default btn-block' name='nuevo' value='Añadir'></td></form></tr>")
													else
													response.write("</tr>")
												end if%>

											
<!-- _______________________________________Mostrar los vehículos_____________________________- -->
											<% 
											Set conexion = Server.createObject("ADODB.Connection")

											conexion.Open("vehiculos")
											if Request.form("buscar")<>"" then 'Si hay o no una búsqueda'
												nombre=Request.form("busqueda")
												ssql = "SELECT * FROM vehiculo WHERE marca like '%"&nombre&"%' or modelo like '%"&nombre&"%'  or matricula like '%"&nombre&"%';" 
											else
												ssql = "Select * from vehiculo"
											end if 
											
											set datos= conexion.execute(ssql)
											do while not datos.Eof 

'_________________________Modificar Vehículo____________________________________________'
											if request.queryString("mat")=datos("matricula") then
												
												response.write("<tr><form action='#' method='post'><td><input type='text' class='form-control input-sm' placeholder='Matricula' value='"&datos("matricula")&"' name='matricula' maxlength='10' required></td><td><input type='text' class='form-control input-sm' placeholder='Modelo' value='"&datos("modelo")&"'name='modelo' required></td><td><input type='text' class='form-control input-sm' placeholder='Marca' name='marca' value='"&datos("marca")&"' required></td><td><input type='text' class='form-control input-sm' placeholder='Número de Puertas' name='n_puertas' value='"&datos("n_puertas")&"' min='1' max='8' required></td><td><input type='text' class='form-control input-sm' placeholder='Categoría' name='categoria' value='"&datos("categoria")&"' min='1' required></td><td><input type='text' class='form-control input-sm' placeholder='Precio' name='precio'value='"&datos("precio")&"' min='1' required></td><td class='text-center text-nowrap'><input type='submit' class='btn btn-default btn-xs' name='modificar' value='Ok'>&nbsp;&nbsp;<input type='submit' class='btn btn-default btn-xs' name='modificar' value='X'></td></form></tr>")
											
												'Si no pulsa modificar se muestra sin más'
											else
												response.write("<tr><td class='text-center text-nowrap'>"&datos("matricula")&"</td><td class='text-center text-nowrap'>"&datos("modelo")&"</td><td class='text-center text-nowrap'>"&datos("marca")&"</td><td class='text-center text-nowrap'>"&datos("n_puertas")&"</td><td class='text-center text-nowrap'>"&datos("categoria")&"</td><td class='text-center text-nowrap'>"&datos("Precio")&"</td>")
												if tipo=0 then
													response.write("<td class='text-center text-nowrap'><a href='vehiculos.asp?mat="&datos("matricula")&"' class='btn btn-default btn-block'><i class='fa fa-cog'></i></a></td></tr>")
													else
													response.write("</tr>")
												end if 
											end if 		
											datos.MoveNext
											loop
											conexion.Close	

											%>
											
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

		<script src="../assets/plugins/jquery/jquery-3.1.1.min.js"></script>
	<script src="../assets/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script src="../assets/js/theme.js"></script>
	</body>
</html>
