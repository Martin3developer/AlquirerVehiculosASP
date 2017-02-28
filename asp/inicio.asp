
<!-- #include file ="cabecera.asp" -->
<% 
usuario=Session("user")
tipo=Session("tipo")
if usuario="" then
response.redirect("../index.asp")	
end if 

imprimirCabecera(tipo)

%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Inicio</title>

		<!-- Bootstrap core CSS -->
 
	</head>

	<body>
		<div>
			<h1>Bienvenido <% = usuario %></h1>
			<h3>Aquí tienes una lista con los coches disponibles para su alquiler</h3>

			

	</body>
</html>