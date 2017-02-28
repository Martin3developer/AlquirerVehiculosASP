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
			else
			comprobar=2
		end if 

	conexion.Close
	if comprobar=1 then

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
							<a class="navbar-brand text-size-24" href="#">CLIENTES</a>
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
								<span class="panel-title pull-left text-black"><i class="fa fa-fw fa-users"></i> Busqueda de Clientes</span>
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
											<th>Teléfono</th>
											<th class="text-center text-nowrap">Nombre Usuario</th>
											<th class="text-center text-nowrap">Contraseña</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<tr>
<!--__________________________ Añadir nuevo Cliente _______________________________________-->
											<form action="#" method="post">
												<td><input type="text" class="form-control input-sm" name="nombre" maxlength="10" required placeholder="Nombre y Apellidos"></td>
												<td><input type="number" class="form-control input-sm" name="telefono" min="100000000" max="999999999" required placeholder="Teléfono"></td>
											<% if comprobar=2 then
												response.write("<td><input type='text' class='form-control input-sm' name='nick' maxlength='10' required placeholder='Nombre de usuario no disponible' style='border:1px solid red'></td>")
												else
												response.write("<td><input type='text' class='form-control input-sm' name='nick' maxlength='10' required placeholder='Nick'></td>")
											end if %>
											
												<td><input type="text" class="form-control input-sm" name="pass" maxlength="10" required placeholder="Contraseña"></td>
												<td>
												   <input type="submit" class="btn btn-default btn-block" name="nuevo" value="Añadir">
												</td>

												
											</form>
										</tr>
<!-- _____________________________Mostrar los clientes_________________________________ -->
											<% 
											Set conexion = Server.createObject("ADODB.Connection")

											conexion.Open("vehiculos")
						'--------------------------Si hay o no una búsqueda--------------------'
											if Request.form("buscar")<>"" then 
												nombre=Request.form("busqueda")
												ssql = "SELECT * FROM cliente WHERE nombre like '%"&nombre&"%' ;" 
											else
												ssql = "Select * from cliente"
											end if 
											
											set datos= conexion.execute(ssql)
											do while not datos.Eof 
												response.write("<tr><td class='text-center text-nowrap'>"&datos("nombre")&"</td><td class='text-center text-nowrap'>"&datos("telefono")&"</td><td class='text-center text-nowrap'>"&datos("nick")&"</td><td class='text-center text-nowrap'>"&datos("pass")&"</td><td class='text-center text-nowrap'><a href='reservas.asp?busqueda="&datos("nombre")&"&buscar=Buscar#' class='btn btn-default btn-xm'><i class='fa fa-address-book-o'></i></a><a href='facturas.asp?mostrar="&datos("nick")&"' class='btn btn-default btn-xm'><i class='fa fa-file-text-o'></i></a></td></tr>")
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
