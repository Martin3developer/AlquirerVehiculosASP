<!-- #include file ="cabecera.asp" -->
<%
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
response.redirect("../index.asp")	
end if 

If Request.form("nuevo")="Añadir" Then
	comprobarf=0
	comprobard=0
	cliente=Request.form("cliente")
	vehiculo=Request.form("vehiculo")
	if cliente="1" or vehiculo="1" then 'comprobamos que no dejen el campo por defecto'
		comprobard=1
	end if 
	inicio=Request.form("inicio")
	fin=Request.form("fin")
	hoy=date()

	if inicio > fin or inicio < hoy then 'Si la fecha de fin es anterior a la de inicio'
		comprobarf=1
	end if 

	Set conexion = Server.createObject("ADODB.Connection")'Comprobamos que no se repiten las claves primarias'
		conexion.Open("vehiculos")

ssql = "SELECT * FROM reservas WHERE cliente ="&cliente&" and vehiculo='"&vehiculo&"' and inicio = cdate('"&inicio&"');" 
	set datos= conexion.execute(ssql)

	if not datos.Eof then
			comprobard=2
			else
			comprobard=3
		end if 
	conexion.Close	

'----------------------Control de dias de reserva-------------------------------------
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
''			next	
''		next
''	next

'---------------------------------------------------------------------------------'
	if comprobard=3 and comprobarf=0 then
		Set conexion = Server.createObject("ADODB.Connection")

			conexion.Open("vehiculos")

		ssql = "INSERT INTO reservas VALUES ("&cliente&",'"&vehiculo&"','"&inicio&"','"&fin&"');"

		set datos= conexion.execute(ssql)
		conexion.Close	
	end if 
	
End If
%>

<% imprimirCabecera(tipo) %>

<div id="content">
			<div class="content-nav">
				<nav class="navbar navbar-default">
					<div class="container-fluid">
						<div class="navbar-header">

							<!-- Sidebar toggle button -->
							<button type="button" class="sidebar-toggle">
								<i class="fa fa-bars"></i>
							</button>
							<a class="navbar-brand text-size-24" href="#">RESERVAS</a>
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

							<%if tipo=0 then   'si es administrador le mostramos el buscador%>
							<div class="panel-heading">
								<span class="panel-title pull-left text-black"><i class="fa fa-fw fa-address-book-o"></i> Busqueda de Reservas</span>
								<!-- Busqueda -->
								<form action="#" class="pull-right hidden-xs" method="get">
									<div class="form-group">
										<div class="input-group input-group-sm">
											<input type="text" class="form-control" placeholder="Buscar por Nombre de cliente , Matricula o Fecha de inicio" name="busqueda" value="">
											<span class="input-group-btn">
												<input type="submit" class="btn btn-default btn-block" name="buscar" value="Buscar">
											</span>
										</div>
									</div>
								</form>
								<div class="clearfix"></div>
							</div>
							<%end if%>

							<div class="panel-body table-responsive table-full">
								<table class="table table-stripped table-hover table-bordered">
									<thead>
										<tr>
											<%if tipo=0 then%>
											<th class='text-center text-nowrap'>Cliente</th>
											<%end if%>
											<th class='text-center text-nowrap'>Vehículo</th>
											<th class="text-center text-nowrap">Fecha de Inicio</th>
											<th class="text-center text-nowrap">Fecha de Fin</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										
<!--__________________________ Añadir nueva Reserva _______________________________________-->
										<%if tipo=0 then%>
											<tr>
											<form action="#" method="post">
												<td><select name="cliente" class="form-control input-sm">
												<%
												Set conexion = Server.createObject("ADODB.Connection")

												conexion.Open("vehiculos")

												ssql = "Select codigo, nombre, nick from cliente;"

												set datos= conexion.execute(ssql)
												response.write("<option value='1'>-- Elige un cliente --</option>")
												do while not datos.Eof 
												response.write("<option value='"&datos("codigo")&"'>"&datos("nombre")&"("&datos("nick")&")</option>")
												datos.MoveNext
												loop

												conexion.Close	
												%>
												</select><br></td>
												<td><select name="vehiculo" class="form-control input-sm">
												<%
												Set conexion = Server.createObject("ADODB.Connection")

												conexion.Open("vehiculos")

												ssql = "Select matricula, marca, modelo from vehiculo;"

												set datos= conexion.execute(ssql)
												response.write("<option value='1'>-- Elige un Vehículo --</option>")
												do while not datos.Eof 
												response.write("<option value='"&datos("matricula")&"'>"&datos("marca")&"("&datos("modelo")&") - "&datos("matricula")&"</option>")
												datos.MoveNext
												loop

												conexion.Close	
												%>
												</select><br></td>

												<% if comprobarf=1 then%>
												<td><input type="date" name="inicio" class="form-control input-sm" placeholder="Error al introducir la fecha" style='border:1px solid red' required</td>
												</td>
												<%else%>
												<td><input type="date" name="inicio" class="form-control input-sm" required</td>
												</td>
												<%end if%>

												<td><input type="date" name="fin" class="form-control input-sm" required</td>
												</td>
												<td>
												   <input type="submit" class="btn btn-default btn-block" name="nuevo" value="Añadir">
												</td>
											</form>
										</tr>
										<%end if %>
<!-- _____________________________Mostrar las Reservas_________________________________ -->
											<% 
											Set conexion = Server.createObject("ADODB.Connection")

											conexion.Open("vehiculos")

											if tipo=0 then
'--------------------------Si hay una búsqueda--------------------'
												if Request.queryString("buscar")<>"" then 
													nombre=Request.queryString("busqueda")
													ssql = "Select c.nombre as nombre, c.nick as nick, r.* from reservas r, cliente c where c.codigo = r.cliente and (nombre like '%"&nombre&"%' or r.inicio like '%"&nombre&"%' or r.vehiculo like '%"&nombre&"%') ORDER BY r.inicio desc;"
												else
													ssql = "Select c.nombre as nombre, c.nick as nick, r.* from reservas r, cliente c where c.codigo = r.cliente ORDER BY r.inicio desc;"
												end if 
											else
											ssql = "Select c.nombre as nombre, c.nick as nick, r.* from reservas r, cliente c where c.codigo = r.cliente and c.nick='"&usuario&"';"
											end if
											set datos= conexion.execute(ssql)
											do while not datos.Eof 
											if tipo=0 then
												response.write("<tr><td class='text-center text-nowrap'>"&datos("nombre")&"("&datos("nick")&")</td>")
											end if
												response.write("<td class='text-center text-nowrap'>"&datos("vehiculo")&"</td><td class='text-center text-nowrap'>"&datos("inicio")&"</td><td class='text-center text-nowrap'>"&datos("fin")&"</td>")
			'-------------------Si la reserva es actual no se puede borrar-------------'
												if datos("inicio") <  date() then
													response.write("<td class='text-center text-nowrap'><a href='#' class='btn btn-default btn-block' disabled='disabled'><i class='fa fa-trash'></i></a></td></tr>")
												else
													response.write("<td class='text-center text-nowrap'><a href='#' class='btn btn-default btn-block'><i class='fa fa-trash'></i></a></td></tr>")
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
