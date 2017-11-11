<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcuraOficinas.aspx.cs" Inherits="LocalizadorOficinas.Caminhos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyBV1qe9vPcm0CrnGsjawFulvtjwHZcOdiM&libraries=places" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        //Variaveis globais
        var posAtual;
        var mapa;
        var infowindow;
        var markers = [];

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

        //TODO: adicionar aqui as avaliacoes dos usuarios para ser exibido
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

        markers.push(marker);
    }

    function Button1_onclick() {
        procurarOficinas();
    }

    window.onload = IniciarMapa;
    </script>

    <style>
        .mapa
        {
            min-width: 400px;
            width: auto;
            min-height: 400px;
            height: auto;
            margin: 50px auto 50px auto;
            background-color: black;
            padding: 10px 10px;
            overflow: hidden;
        }

        .controle
        {
            min-width: 200px;
            width: auto;
            min-height: 100px;
            height: auto;
            margin: 0px auto 0px auto;
            overflow: auto;
        }

        .listaOficinas
        {
            margin: 20px auto 5px auto;
            height: 390px;
            
        }

        .pesquisa
        {
            margin: 20px auto 5px auto;
        }
        
    </style>

    <table id ="controle" class="controle">
        <tr>
            <td>
                <table class="pesquisa">
                    <tr>
                        <td>Raio de Busca (em metros):</td>
                        <td>
                            <input id="raiobusca" type="range" style="width: 105px" min="1" max="1000" value="500" />
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
            <td valign ="top">
                <div id ="listaOficinas" class="listaOficinas"></div>
            </td>
        </tr>
    </table>
        <div id ="mapa" class="mapa"></div>
    </div>
    </form>
</body>
</html>
