<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcuraOficinas.aspx.cs" Inherits="LocalizadorOficinas.Caminhos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <style>
        html, body
        {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            position: relative;
            background-color: #E0F8F7;
        }

        .cabecalho
        {
            position: absolute;
            width: 100%;
            height: 45px;
            background-color: red;
        }

        #lblUsuario
        {
            float: right;
            font-size: 30px;
            color: white;
            margin: 3px 30px 0px 0px;
        }

        #login
        {
            margin: 5px 0px 0px 0px; 
            float: right;
        }

        .mapa
        {
            position: absolute;
            width: 70%;
            height: 95%;
            margin: 45px 0px 0px 30%;
            padding: 0;
        }

        .controle
        {
            position: absolute;
            width: 30%;
            height: 70%;
            margin: 45px 0px 0px auto;
        }

        #listaOficinas
        {
            position: absolute;
            margin: 10px 0px 0px auto;
            height: 100%;
            width: 98%;
            border-color: red;
			border: 1px solid black;
        }

        #tblAvaliacao
        {
            width: 98%;
            border-color: red;
			border: 1px solid black;
        }

		.tblListagem thead 
		{
			border-top: 1px solid black;
			border-bottom: 1px solid black;
		}

		.tblListagem thead tr:hover 
		{
		  background-color: transparent;
	      color: #2E2EFE;
		}
		
		.tblListagem th 
		{
		  font-weight: normal;
		  text-align: left;
		  border: 1px solid black;
		}
		
		.tblListagem td 
		{
		  padding: 0.1em 1em;
	      border: 1px solid black;
		  font-color: #2E2EFE;
		}

        .pesquisa
        {
            margin: 20px auto 5px auto;
        }

        .imgFavorito
        {
            width: 20px;
            height: 20px;
            margin: 0px 0px 0px 35%;
            cursor: pointer;
        }

        .imgAlteracao
        {
            width: 20px;
            height: 20px;
            cursor: pointer;
            float: left;
        }
       
        .imgExcluir
        {
            width: 20px;
            height: 20px;
            cursor: pointer;
            float: left;
        }

        .imgAvaliacao
        {
            width: 20px;
            height: 20px;
            margin: 0px 0px 0px 35%;
            cursor: pointer;
        }

        /* The Modal (background) */
        .modal 
        {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content 
        {
            background-color: #E0F8F7;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 40%;
        }

        /* The Close Button */
        .close 
        {
            color: red;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus 
        {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        #txtAvaliacao
        {
            width: 98%;
            height: 50px;
            float: left;
        }

        /*#txtNota
        {
            float: left;
        }

        #lblAvaliacao
        {
            float: left;
        }

        #btnAvaliacao
        {
            float: left;
        }*/
        
    </style>

</head>
<body>
    <form id="form1" runat="server">
        

    <div id="tela" class="tela">
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyBV1qe9vPcm0CrnGsjawFulvtjwHZcOdiM&libraries=places" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        //Variaveis globais
        var posAtual;
        var mapa;
        var infowindow;
        var markers = [];
        var places = [];
        var idOficinaAvaliacao;
        var alteracao = false;
        var idAvaliacaoAlteracao = 0;

    function IniciarMapa() {

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(success);
        } else {
            alert("Geo Localização não é suportada no seu navegadro atual!");
        }

        function success(position) {

            //Informacoes sobre a posicao atual do usuário
            var lat = position.coords.latitude;
            var long = position.coords.longitude;
            var cidade = position.coords.locality;
            posAtual = new google.maps.LatLng(lat, long);

            var opcoes =
            {
                //TODO: verificar possibilidade de ajustar zoom conforme configuracao de distnacia de busca
                zoom: 15,
                center: posAtual,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            mapa = new google.maps.Map(document.getElementById("mapa"), opcoes);

            var controle = document.getElementById('controle');
            controle.style.display = 'block';
        }
    }

    // Sets the map on all markers in the array.
    function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(map);
        }
    }

    // Remove os markers do mapa, sem deletar array.
    function clearMarkers() {
        setMapOnAll(null);
    }

    // Mostra os markers que estão no array.
    function showMarkers() {
        setMapOnAll(mapa);
    }

    // Deleta os markers do array
    function deleteMarkers() {
        clearMarkers();
        markers = [];
        places = [];
    }

    function procurarOficinas() {
        deleteMarkers();
        //Detalhes da pesquisa dos locais
        var request = {
            location: posAtual,
            radius: document.getElementById('raiobusca').value,
            types: ['car_repair'],
            language: 'pt-BR'
        };

        //Busca os locais de acordo com as configurações do usuário
        var service = new google.maps.places.PlacesService(mapa);
        infowindow = new google.maps.InfoWindow();

        service.nearbySearch(request, function (results, status) {
            if (status == google.maps.places.PlacesServiceStatus.OK) {
                for (var i = 0; i < results.length; i++) {
                    addMarker(results[i]);
                }

                showMarkers();
            }
            else if (status == google.maps.places.PlacesServiceStatus.ZERO_RESULTS){
                alert("Não foram encontradas oficinas dentro do raio de busca.")
            }
        });
    }
        
    function IsDefined(elemento) {
        return (typeof elemento !== 'undefined' && typeof elemento !== null);
    }

    function DeParaBool(booleano) {
        return booleano ? "Sim" : "N&atildeo";
    }

    // Adiciona marker no mapa e no array.
    function addMarker(place) {
        var marker = new google.maps.Marker({
            position: place.geometry.location,
            map: mapa
        });

        google.maps.event.addListener(marker, 'click', function () {
            const INDISPONIVEL = "Indispon&iacutevel";

            var str = "Nome: " + (IsDefined(place.name) ? place.name : INDISPONIVEL) +
                      "<br> Nota Geral: " + (IsDefined(place.rating) ? place.rating : INDISPONIVEL) +
                      //"<br> Place_id: " + (IsDefined(place.place_id) ? place.place_id : INDISPONIVEL) +
                      "<br> Endere&ccedilo: " + (IsDefined(place.vicinity) ? place.vicinity : INDISPONIVEL) +
                      //"<br> Location: " + (IsDefined(place.geometry.viewport) ? place.geometry.viewport : INDISPONIVEL) +
                      "<br> Est&aacute aberto: " + (IsDefined(place.opening_hours) && IsDefined(place.opening_hours.open_now) ? DeParaBool(place.opening_hours.open_now) : INDISPONIVEL);
            // TODO: opening_hours 

            infowindow.setContent(str);
            infowindow.open(mapa, this);
        });

        var listaOficinas = document.getElementById("listaOficinas");
        var row = listaOficinas.insertRow();
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);


        var id    = "imgFavorito" + (listaOficinas.rows.length - 1);
        var idAva = "imgAvaliacao" + (listaOficinas.rows.length - 1);

        cell1.innerHTML += (IsDefined(place.name) ? place.name : "INDISPONIVEL");
        cell3.innerHTML += "<img class='imgAvaliacao' id='" + idAva + "' src='avaliacao.png' onclick='return Avaliacao_onclick(this.id)'></img>";

        var sNomeCliente = document.getElementById("lblUsuario").textContent;
        var sIDOficina = place.place_id;

        PageMethods.VerificaFavorito(sIDOficina, sNomeCliente, onSucess, onError);

        function onSucess(result) {
            if (result == "S")
                cell2.innerHTML += "<img class='imgFavorito' id='" + id + "' src='favorito.png' onclick='return Favorito2_onclick(this.id)'></img>";
            else
                cell2.innerHTML += "<img class='imgFavorito' id='" + id + "' src='favorito2.png' onclick='return Favorito_onclick(this.id)'></img>";
        }

        function onError(result) {
            alert('Cannot process your request at the moment, please try later.');
        }

        places.push(place);
        markers.push(marker);
    }

    function Button1_onclick() {

        var sNomeCliente = document.getElementById("lblUsuario");
        if (sNomeCliente == null)
        {
            alert("Por favor, faça login antes de procurar oficinas.");
            return false;
        }

        var listaOficinas = document.getElementById("listaOficinas");
        listaOficinas.innerHTML = "";

        var header = listaOficinas.createTHead();
        var row = header.insertRow(0);  
        var cell = row.insertCell(0);
        cell.innerHTML = "<b>Nome</b>";
        cell = row.insertCell();
        cell.innerHTML = "<b>Favorito</b>";
        cell = row.insertCell();
        cell.innerHTML = "<b>Avaliação</b>";

        procurarOficinas();
    }

    function Avaliacao_onclick(clicked_avaliacao) {
        var listaOficinas = document.getElementById("listaOficinas");
        var indice = clicked_avaliacao.substring(12, clicked_avaliacao.length);

        idOficinaAvaliacao = places[indice - 1].place_id;

        var modal = document.getElementById('myModal');
        modal.style.display = "block";

        PageMethods.GetCodigoAvaliacoes(idOficinaAvaliacao, onSucess, onError);

        var tblAvaliacao = document.getElementById("tblAvaliacao");
        tblAvaliacao.innerHTML = "";

        var header = tblAvaliacao.createTHead();
        var row = header.insertRow(0);
        var cell = row.insertCell(0);
        cell.innerHTML = "<b>Usuário</b>";
        cell = row.insertCell();
        cell.innerHTML = "<b>Avaliação</b>";
        cell = row.insertCell();
        cell.innerHTML = "<b>Nota</b>";
        cell = row.insertCell();
        cell.innerHTML = "";
        cell = row.insertCell();
        cell.innerHTML = "";

        function onSucess(result) {

            while (result != "")
            {
                var iVirgula = result.indexOf(",");

                var iCodigo = result.substring(0, iVirgula);
                result = result.substr(iVirgula + 1);
                
                PageMethods.LeAvaliacao(iCodigo, onSucess, onError);

                function onSucess(result) {

                    var iPipe = result.indexOf("|");
                    var sUsuario = result.substring(0, iPipe);
                    result = result.substr(iPipe + 1);

                    iPipe = result.indexOf("|");
                    var sAvaliacao = result.substring(0, iPipe);
                    result = result.substr(iPipe + 1);

                    iPipe = result.indexOf("|");
                    var sNota = result.substring(0, iPipe);
                    result = result.substr(iPipe + 1);

                    var iCodigoAvaliacao = result;

                    var listaOficinas = document.getElementById("tblAvaliacao");
                    var row = listaOficinas.insertRow();
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);

                    cell1.innerHTML += sUsuario;
                    cell2.innerHTML += sAvaliacao;
                    cell3.innerHTML += sNota;
                    
                    var id = "imgAlteracao" + iCodigoAvaliacao;
                    var idExcluir = "imgExcluir" + iCodigoAvaliacao;

                    cell4.innerHTML += "<img class='imgAlteracao' id='" + id + "' src='alteracao.png' onclick='return Alteracao_onclick(this.id)'></img>";
                    cell5.innerHTML += "<img class='imgExcluir' id='" + idExcluir + "' src='excluir.png' onclick='return Excluir_onclick(this.id)'></img>";
                }

                function onError(result) {
                    alert('Cannot process your request at the moment, please try later.');
                }
            }

        }

        function onError(result) {
            alert('Cannot process your request at the moment, please try later.');
        }
    }

    function Alteracao_onclick(clicked_alterar)
    {
        var sNomeCliente = document.getElementById("lblUsuario").textContent;
        var indice = clicked_alterar.substring(12, clicked_alterar.length);

        var listaAvaliacoes = document.getElementById("tblAvaliacao");
        for (var i = 1; i < listaAvaliacoes.rows.length; i++)
        {
            var cell = listaAvaliacoes.rows[i].cells[3].innerHTML;

            if (cell.indexOf(clicked_alterar) > 0)
            {
                if (sNomeCliente != listaAvaliacoes.rows[i].cells[0].innerHTML)
                {
                    alert("Você não pode alterar avaliações de outros usuários.");
                    return false;
                }

                document.getElementById("txtAvaliacao").innerHTML = listaAvaliacoes.rows[i].cells[1].innerHTML;
                document.getElementById("txtNota").value = listaAvaliacoes.rows[i].cells[2].innerHTML;

                break;
            }
        }

        idAvaliacaoAlteracao = indice;
        alteracao = true;
    }

    function Excluir_onclick(clicked_excluir)
    {
        var sNomeCliente = document.getElementById("lblUsuario").textContent;
        var indice = clicked_excluir.substring(10, clicked_excluir.length);

        var listaAvaliacoes = document.getElementById("tblAvaliacao");
        for (var i = 1; i < listaAvaliacoes.rows.length; i++) {
            var cell = listaAvaliacoes.rows[i].cells[4].innerHTML;

            if (cell.indexOf(clicked_excluir) > 0) {
                if (sNomeCliente != listaAvaliacoes.rows[i].cells[0].innerHTML) {
                    alert("Você não pode excluir avaliações de outros usuários.");
                    return false;
                }
            }
        }

        PageMethods.DeletarAvaliacao(indice, onSucess, onError);

        function onSucess(result) {
            alert(result);

            var listaAvaliacoes = document.getElementById("tblAvaliacao");
            for (var i = 1; i < listaAvaliacoes.rows.length; i++)
            {
                var cell = listaAvaliacoes.rows[i].cells[4].innerHTML;

                if (cell.indexOf(clicked_excluir) > 0)
                {
                    if (sNomeCliente != listaAvaliacoes.rows[i].cells[0].innerHTML)
                    {
                        alert("Você não pode excluir avaliações de outros usuários.");
                        return false;
                    }

                    listaAvaliacoes.deleteRow(i);
                    break;
                }
            }
        }

        function onError(result) {
            alert('Cannot process your request at the moment, please try later.');
        }
    }

    function Favorito_onclick(clicked_favorito)
    {
        var listaOficinas = document.getElementById("listaOficinas");
        var indice = clicked_favorito.substring(11, clicked_favorito.length);

        var id = "imgFavorito" + (indice);

        listaOficinas.rows[indice].cells[1].innerHTML = "<img class='imgFavorito' id='" + id + "' src='favorito.png' onclick='return Favorito2_onclick(this.id)'></img>";

        var sNomeCliente = document.getElementById("lblUsuario").textContent;
        var sIDOficina = places[indice - 1].place_id;
        var sFavoritar = "sim";
        
        PageMethods.FavoritarOficina(sIDOficina, sNomeCliente, sFavoritar, onSucess, onError);

        function onSucess(result) {
            alert(result);
        }

        function onError(result) {
            alert('Cannot process your request at the moment, please try later.');
        }
    }

    function Favorito2_onclick(clicked_favorito) {
        var listaOficinas = document.getElementById("listaOficinas");
        var indice = clicked_favorito.substring(11, clicked_favorito.length);

        var id = "imgFavorito" + (indice);

        listaOficinas.rows[indice].cells[1].innerHTML = "<img class='imgFavorito' id='" + id + "' src='favorito2.png' onclick='return Favorito_onclick(this.id)'></img>";

        var sNomeCliente = document.getElementById("lblUsuario").textContent;
        var sIDOficina = places[indice - 1].place_id;
        var sFavoritar = "não";

        PageMethods.FavoritarOficina(sIDOficina, sNomeCliente, sFavoritar, onSucess, onError);

        function onSucess(result) {
            alert(result);
        }

        function onError(result) {
            alert('Cannot process your request at the moment, please try later.');
        }
    }

    function Avaliar_onclick() {
        var sNomeCliente = document.getElementById("lblUsuario").textContent;
        var sAvaliacao = document.getElementById("txtAvaliacao").value;
        var iNota = document.getElementById("txtNota").value;

        if (alteracao)
        {
            PageMethods.AtualizarAvaliacao(idAvaliacaoAlteracao, sAvaliacao, iNota, onSucess, onError);

            function onSucess(result) {
                alert(result);

                var alterado = "imgAlteracao" + idAvaliacaoAlteracao;

                var listaAvaliacoes = document.getElementById("tblAvaliacao");
                for (var i = 1; i < listaAvaliacoes.rows.length; i++)
                {
                    var cell = listaAvaliacoes.rows[i].cells[3].innerHTML;

                    if (cell.indexOf(alterado) > 0)
                    {
                        listaAvaliacoes.rows[i].cells[1].innerHTML = sAvaliacao;
                        listaAvaliacoes.rows[i].cells[2].innerHTML = iNota;

                        break;
                    }
                }

                alteracao = false;
                idAvaliacaoAlteracao = -1;

                document.getElementById("txtAvaliacao").value = "";
                document.getElementById("txtNota").value = "";
            }

            function onError(result) {
                alert('Cannot process your request at the moment, please try later.');
            }
        }
        else
        {
            PageMethods.CadastrarAvaliacao(idOficinaAvaliacao, sNomeCliente, sAvaliacao, iNota, onSucess, onError);

            function onSucess(result) {
                alert(result);

                var listaOficinas = document.getElementById("tblAvaliacao");
                var row = listaOficinas.insertRow();
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);

                cell1.innerHTML += sNomeCliente;
                cell2.innerHTML += sAvaliacao;
                cell3.innerHTML += iNota;

                var id = "imgAlteracao" + 0;
                var idExcluir = "imgExcluir" + 0;

                cell4.innerHTML += "<img class='imgAlteracao' id='" + id + "' src='alteracao.png' onclick='return Alteracao_onclick(this.id)'></img>";
                cell5.innerHTML += "<img class='imgExcluir' id='" + idExcluir + "' src='excluir.png' onclick='return Excluir_onclick(this.id)'></img>";

                document.getElementById("txtAvaliacao").value = "";
                document.getElementById("txtNota").value = "";
            }

            function onError(result) {
                alert('Cannot process your request at the moment, please try later.');
            }
        }
    }

    function updateTextInput(val) {
        document.getElementById('textRange').value = val;
    }

    function listarOficinas() {

        for (var i in tbClientes) {
            var cli = JSON.parse(tbClientes[i]);

        }
    }

    function validateLogin()
    {
        var txtLogin = document.getElementById("<%=txtLogin.ClientID%>");
        var txtSenha = document.getElementById("<%=txtPassword.ClientID%>");
        
        if (txtLogin.value == "") {
            alert("Por favor informar o usuário!");
            return false;
        }

        if (txtSenha.value == "") {
            alert("Por favor informar a senha!");
            return false;
        }

        return true;
    }

    window.onload = IniciarMapa;
    </script>

    <div id="cabecalho" class="cabecalho">
        <h1 style="margin: 5px auto auto auto; color:white; float: left;">S.O.S.CAR</h1>

        <asp:Label ID="lblUsuario" runat="server" Visible="false" Text="" />
        <table id="login">
            <tr>
                <td>
                    <asp:Label ID="lblLogin" runat="server" style="margin: 5px auto auto auto; color: white; float: left;" Text="Usuário:" />
                </td>
                <td>
                    <asp:TextBox ID="txtLogin" runat="server" style="margin 5px auto auto auto; float: left" maxlength="50"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="lblPassword" runat="server" style="margin: 5px auto auto auto; color: white; float: left;" Text="Senha:" />
                </td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" maxlength="50"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btnLogin" runat="server" OnClientClick="return validateLogin();" OnClick="BtnLogin_Click" text="Login" />
                </td>
                <td>
                    <asp:Button ID="btnCadastrar" runat="server" OnClientClick="return validateLogin();" OnClick="BtnCadastrar_Click" text="Cadastrar" />
                </td>
            </tr>
        
        </table>

    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>

    <table id ="controle" class="controle">
        <tr>
            <td>
                <table class="pesquisa">
                    <tr>
                        <td>Raio de Busca (em metros):</td>
                        <td>
                            <input id="raiobusca" type="range" style="width: 105px" min="1" max="1000" value="500" onchange="updateTextInput(this.value);"/>
                        </td>
                        <td>
                            <input type="text" id="textRange" value="500" size="3" readonly />
                        </td>
                    </tr>
                    <tr>
                        <td align ="right">
                            <input id="Button1" type="button" value="Procurar Oficinas" onclick="return Button1_onclick()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table id="listaOficinas" class="tblListagem">
                    <thead>
                        <tr>
                            <td><b>Nome</b></td>
                            <td><b>Favorito</b></td>
                            <td><b>Avaliação</b></td>
                        </tr>
                    </thead>
                </table>

            </td>
        </tr>
  
    </table>

    <div id="myModal" class="modal">

      <!-- Modal content -->
      <div class="modal-content">
        <span class="close">&times;</span>
        <h2 align="center">AVALIAÇÕES</h2>
         
        <table>
            <tr>
                <td><p class="lblAvaliacao">Avaliação:</p></td>
                <td><textarea id="txtAvaliacao" cols="40" rows="5" max="500"></textarea></td>
            </tr>
            <tr>
                <td><p class="lblAvaliacao">Nota:</p></td>
                <td><input type="number" id="txtNota"  min="0" max="10" /></td>
                <td><input type="button" id="btnAvaliacao" onclick="return Avaliar_onclick()" value="Avaliar" /></td>
            </tr>
        </table>

        <table class="tblListagem" id="tblAvaliacao">
            <thead>
                <tr>
                    <td><b>Usuário</b></td>
                    <td><b>Avaliação</b></td>
                    <td><b>Nota</b></td>
                    <td></td>
                    <td></td>
                </tr>
            </thead>
        </table>
      </div>

    </div>

    <div id="mapa" class="mapa" />
    

    </div>
    </form>

    <script language="javascript" type="text/javascript">
        // Get the modal
        var modal = document.getElementById('myModal');
    
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];
    
        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }
    
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

</body>
</html>
