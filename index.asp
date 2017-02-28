<%

'-----------------------------En caso de que cierren sesión
if Request.querystring("cerrar")="1" then
	Session("user")=""
	Session.Abandon
	response.cookies("user").expires=Date()-1
	response.cookies("tipo").expires=Date()-1
	response.redirect("../index.asp")
end if 

'----------------------------En caso de que halla cookies
if Request.Cookies("user")<>"" then
	Session("user")=Request.Cookies("user")
	Session("tipo")=Request.Cookies("tipo")
	response.redirect("asp/vehiculos.asp")
end if 


'-----------------------------En caso de que introduzcan login
ok=Request.form("enviar")
If ok="Enviar" Then

	user=Request.form("user")
	pass=Request.form("pass")
	recordar=Request.form("recordar")
	val=0


	Set conexion = Server.createObject("ADODB.Connection")

		conexion.Open("vehiculos")

		ssql = "Select pass,nick from cliente"

		set datos= conexion.execute(ssql)

	do while not datos.Eof 

		if (user=datos("nick") and pass=datos("pass"))then
			Session("user")=datos("nick")
			
			Session("tipo")="1"
			Session.timeout = 60
			val=1
			if recordar="on" then
				response.cookies("user")=datos("nick")
				response.cookies("tipo")=Session("tipo")
			end if 
			response.redirect("asp/vehiculos.asp")
		end if
		if user="admin" and pass="admin"  then
			Session("user")="admin"
			Session("tipo")="0"
			val=1
			if recordar="on" then
				response.cookies("user")="admin"
				response.cookies("tipo")=Session("tipo")
			end if 

			response.cookies("user").expires=Date()+365
			response.cookies("tipo").expires=Date()+365
			response.redirect("asp/clientes.asp")
		end if 

		datos.MoveNext
	loop

	if val=0 then
		val=2
	end if 
	
	conexion.Close	
End If
%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Inicio</title>
		 <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
       

	</head>
	<body>
	<div class="login">
		<div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>Regístrate en Alkilómetro</h3>
                            		<p>Introduce tu Nick y tu Contraseña para comenzar.</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Nick</label>
			                        	<input type="text" name="user" placeholder="Nick..." class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Contraseña</label>
			                        	<input type="password" name="pass" placeholder="Password..." class="form-password form-control" id="form-password">
			                        </div>
			                        <%
										if val=2 then
												response.write("<p><b>Usuario y contraseña incorrectos</b></p>")
											end if 
									%>
									<input type="checkbox" name="recordar"> Recordar sesión<br>
			
          							<input  name="enviar" class="btn btn-block" type="submit" value="Enviar">
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
	</div>


        <!-- Javascript -->
        <script src="assets/js/jquery-1.11.1.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.backstretch.min.js"></script>
        <script src="assets/js/scripts.js"></script>

	</body>
</html>