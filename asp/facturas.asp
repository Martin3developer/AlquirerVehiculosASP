<!-- #include file ="cabecera.asp" -->
<% 
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
	response.redirect("../index.asp")	
end if 

'------------------------Añadir Cliente------------------------------'

If Request.form("nuevo")="Añadir" Then
comprobar=0
	nombre=Request.form("nombre")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "SELECT nick FROM cliente WHERE nick='"&nombre&"';"'Comprobamos que no coincida con otro nick ya registrado'

		set datos= conexion.execute(ssql)

		if not datos.Eof then
			comprobar=1
		end if 

	conexion.Close
	if comprobar<>1 then

	telefono=Request.form("telefono")
	user=Request.form("nick")
	pass=Request.form("pass")

	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "INSERT INTO cliente (nombre,telefono,nick,pass) VALUES ('"&nombre&"',"&telefono&",'"&user&"','"&pass&"');"

		set datos= conexion.execute(ssql)

	conexion.Close	

	end if 
	
End If
'-------------------------------------------------------------------------------------'
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
							<a class="navbar-brand text-size-24" href="facturas.asp">FACTURAS</a>
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
<!--______________Si nos piden que mostremos una factura______________________-->

					<%	if request.queryString("mostrar")<>"" or tipo=1 then 

								factnick=request.queryString("mostrar")

								if tipo=1 then
									factnick=usuario
								end if 

								Set conexion = Server.createObject("ADODB.Connection")

								conexion.Open("vehiculos")
			
								ssql = "Select codigo, nombre from cliente where nick='"&factnick&"'" 
								
								set datos= conexion.execute(ssql)
								if not datos.Eof then
									factcodigo=datos("codigo")
									factnombre=datos("nombre")
								end if
								conexion.Close	
								%>
								<h1><%response.write("Factura de "&factnombre&":")%></h1>
							</div>

							<div class="panel-body table-responsive table-full">
								<table class="table table-stripped table-hover table-bordered">
									<thead>
										<tr>
											
											<th class="text-center text-nowrap">Vehículo</th>
											<th class="text-center text-nowrap">Reserva</th>
											<th class="text-center text-nowrap">Nº de Días</th>
											<th class="text-center text-nowrap">Precio Vehículo</th>
											<th class="text-center text-nowrap">Total</th>
											
										</tr>
									</thead>
									<tbody>

									<% 

											Set conexion = Server.createObject("ADODB.Connection")

											conexion.Open("vehiculos")
						'--------------------------Si hay o no una búsqueda--------------------'
											hoy=date()
											ssql = "SELECT r.* ,v.precio FROM cliente c, reservas r, vehiculo v WHERE  c.codigo = r.cliente and r.vehiculo= v.matricula and c.nick='"&factnick&"' and r.inicio < cdate('"&hoy&"');" 
											
											set datos= conexion.execute(ssql)
											total=0
											do while not datos.Eof 
											dias=datediff("d",datos("inicio"),datos("fin"))
											precio=datos("precio")*dias
											
												response.write("<tr><td class='text-center text-nowrap'>"&datos("vehiculo")&"</td><td class='text-center text-nowrap'>"&datos("inicio")&"-"&datos("fin")&"</td><td class='text-center text-nowrap'>"&dias&"</td><td class='text-center text-nowrap'>"&datos("precio")&"</td><td>"&precio&" €</td></tr>")
											total=total+precio
											datos.MoveNext
											loop
											conexion.Close	
											response.write("<tr><td class='text-right text-nowrap' colspan='4'><b>TOTAL: </b></td><td><b>"&total&" €</b></td></tr>")

											%>
											
										
									</tbody>
								</table>
							</div>
							<div class="panel-footer">
								<span class="panel-footer-text text-grey text-size-12"><i class="fa fa-info-circle"></i> Factura editada a dia : <%=date()%> <a href='javascript:window.print(); void 0;' class='btn btn-default btn-xm'><i class='fa fa-print'></i></a></span>
							</div>

					<%else%>

			<!--___________________Si no nos piden que mostremos factura__________________-->

								<span class="panel-title pull-left text-black"><i class="fa fa-fw fa-users"></i> Busqueda de Clientes con factura</span>
								<!-- Busqueda de clientes -->
								<form action="#" class="pull-right hidden-xs" method="post">
									<div class="form-group">
										<div class="input-group input-group-sm">
											<input type="text" class="form-control" placeholder="Buscar por nombre" name="busqueda" value="">
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
											<th>Nombre y Apellidos</th>
											<th class="text-center text-nowrap">Factura</th>
											<th class="text-center text-nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
											
										</tr>
									</thead>
									<tbody>
										<tr>

<!-- _____________________________Mostrar los clientes_________________________________ -->
						<% 

											Set conexion = Server.createObject("ADODB.Connection")

											conexion.Open("vehiculos")
						'--------------------------Si hay o no una búsqueda--------------------'
											if Request.form("buscar")<>"" then 
												nombre=Request.form("busqueda")
												ssql = "SELECT distinct nombre, nick FROM cliente c, reservas r WHERE c.codigo=r.cliente and nombre like '%"&nombre&"%' and r.inicio < cdate('"&date()&"');" 
											else
												ssql = "SELECT distinct nombre, nick FROM cliente c, reservas r WHERE c.codigo=r.cliente and r.inicio < cdate('"&date()&"');" 
											end if 
											
											set datos= conexion.execute(ssql)
											do while not datos.Eof 
												response.write("<tr><td class='text-center text-nowrap'>"&datos("nombre")&"</td><td class='text-center text-nowrap'><a href='facturas.asp?mostrar="&datos("nick")&"' class='btn btn-default btn-xm'><i class='fa fa-file-text-o'></i></a></td><td></td></tr>")
											datos.MoveNext
											loop
											conexion.Close	

											%>
											
										</tr>
									</tbody>
								</table>
							</div>

							<%end if%>

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
