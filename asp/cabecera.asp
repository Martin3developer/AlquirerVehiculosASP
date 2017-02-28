<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%

    dim pagename

     pagename = Request.ServerVariables("SCRIPT_NAME") 

      if inStr(pagename, "/") > 0 then 
        pagename = Right(pagename, Len(pagename) - instrRev(pagename, "/")) 
      end if 

     curPageName = pagename
	function imprimirCabecera(tipo)
%>
 <html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <title>Inicio</title>
        <link rel="stylesheet" href="../assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/plugins/fontawesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="../assets/css/theme.css">
        <link rel="stylesheet" href="../assets/css/theme-helper.css">
    </head>
<%

	if tipo="0" then %>

    <body>
		<div class="container-fluid" id="wrapper">
        <div id="sidebar">
            <div id="sidebar-wrapper">
                <div class="sidebar-title"><h2>Alkilometro</h2><span>Aquiler de vehículos</span></div>
                <ul class="sidebar-nav">
                    <!--Boton de abrir y cerrar el menu lateral-->

                    <li class="sidebar-close ">
                        <a href="#"><i class="fa fa-fw fa-close"></i></a>
                    </li>
                    <%if curPageName="clientes.asp" then
                        response.write("<li class='seccion active' >")
                        else
                        response.write("<li class='seccion' >")
                    end if %>
                     
                        <a href="clientes.asp"><i class="fa fa-fw fa-user"></i>
                        <span class="nav-label">Clientes</span></a>
                    </li>
                    <%if curPageName="vehiculos.asp" then
                        response.write("<li class='seccion active' >")
                        else
                        response.write("<li class='seccion' >")
                    end if %>
                    
                        <a href="vehiculos.asp">
                        <i class="fa fa-fw fa-car"></i>
                        <span class="nav-label">Vehículos</span></a>
                    </li>
                    <%if curPageName="reservas.asp" then
                        response.write("<li class='seccion active' >")
                        else
                        response.write("<li class='seccion' >")
                    end if %>
                    
                        <a href="reservas.asp"><i class="fa fa-fw fa-address-book-o"></i><span class="nav-label">Reservas</span></a>
                    </li>
                    <%if curPageName="facturas.asp" then
                        response.write("<li class='seccion active' >")
                        else
                        response.write("<li class='seccion' >")
                    end if %>
                  
                        <a href="facturas.asp"><i class="fa fa-fw fa-file-text-o"></i>
                        <span class="nav-label">Facturas</span></a>
                    </li>
                </ul>
                <div class="sidebar-footer">
                    <a href='../index.asp?cerrar=1'><button class="btn btn-default btn-block"><i class="fa fa-fw fa-power-off"></i><span class="nav-label">Cerrar Sesión</span></button><a>
                </div>
            </div>
        </div>

    <%
	
    else	
    %>

    <body>

        <div class="container-fluid" id="wrapper">
        <div id="sidebar">
            <div id="sidebar-wrapper">
                <div class="sidebar-title"><h2>Alkilometro</h2><span>Aquiler de vehículos</span></div>
                <ul class="sidebar-nav">
                    <li class="sidebar-close">
                        <a href="#"><i class="fa fa-fw fa-close"></i></a>
                    </li>
                     <%if curPageName="vehiculos.asp" then
                        response.write("<li class='seccion active' >")
                        else
                        response.write("<li class='seccion' >")
                    end if %>
                        <a href="vehiculos.asp"><i class="fa fa-fw fa-car"></i><span class="nav-label">Vehículos</span></a>
                    </li>

                     <%if curPageName="reservas.asp" then
                        response.write("<li class='seccion active' >")
                        else
                        response.write("<li class='seccion' >")
                    end if %>
                    
                        <a href="reservas.asp"><i class="fa fa-fw fa-address-book-o"></i><span class="nav-label">Mis Reservas</span></a>
                    </li>

                     <%if curPageName="facturas.asp" then
                        response.write("<li class='seccion active' >")
                        else
                        response.write("<li class='seccion' >")
                    end if %>
                    <a href="facturas.asp"><i class="fa fa-fw fa-file-text-o"></i><span class="nav-label">Mi Factura</span></a>
                    </li>
                </ul>
                <div class="sidebar-footer">
                    <a href='../index.asp?cerrar=1'><button class="btn btn-default btn-block"><i class="fa fa-fw fa-power-off"></i><span class="nav-label">Cerrar Sesión</span></button></a>
                </div>
            </div>
        </div>

<%
	end if 


	end function

%>
