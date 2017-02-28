<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	function imprimirCabecera(tipo)

	if tipo="0" then %>
		
	   <ul>
            <li >Clientes
                <ul class='dropdown-menu'>
                    <li><a href='n_cliente.asp'>Nuevo Cliente</a></li>
                    <li><a href='clientes.asp'>Ver Clientes</a></li>
                    <li><a href='b_clientes.asp'>Buscar Clientes</a></li>
                </ul>
            </li>

            <li>Vehículos
                <ul class='dropdown-menu'>
                    <li><a href='n_vehiculo.asp'>Nuevo Vehículo</a></li>
                    <li><a href='b_vehiculo.asp'>Buscar Vehículos</a></li>
                    <li><a href='vehiculos.asp'>Ver Vehículos</a></li> 
                </ul>
            </li>

            <li>Reservas
                <ul class='dropdown-menu'>
                    <li><a href='n_reserva.asp'>Nueva Reserva</a></li>
                    <li><a href='b_reserva.asp'>Buscar Reserva</a></li>          
                    <li><a href='reservas.asp'>Ver Reservas</a></li>
                </ul>
            </li>

            <li>Facturas
                <ul class='dropdown-menu'>
                    <li><a href='b_facturas.asp'>Ver Factura cliente</a></li>
                    <li><a href='facturas.asp'>Ver Facturas</a></li>
                </ul>
            </li>
            <li><a href='../index.asp?cerrar=1'>Cerrar Sesión</a></li>
    </ul>


    <%
	
    else	
    %>
        
       <ul>
            <li >Clientes
                <ul class='dropdown-menu'>
                    <li><a href='perfil.asp'>Ver Perfil</a></li>
                </ul>
            </li>

            <li>Vehículos
                <ul class='dropdown-menu'>
                    <li><a href='vehiculos.asp'>Ver Vehículos</a></li> 
                </ul>
            </li>

            <li>Reservas
                <ul class='dropdown-menu'>
                    <li><a href='reservas.asp'>Ver Reservas</a></li>
                </ul>
            </li>

            <li>Facturas
                <ul class='dropdown-menu'>
                    <li><a href='facturas.asp'>Ver Factura</a></li>
                </ul>
            </li>
            <li><a href='../index.asp?cerrar=1'>Cerrar Sesión</a></li>
    </ul><%
	end if 


	end function

%>
