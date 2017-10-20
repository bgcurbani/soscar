<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoogleMapsMarcador.aspx.cs" Inherits="LocalizadorOficinas.GoogleMapsMarcador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyBV1qe9vPcm0CrnGsjawFulvtjwHZcOdiM"></script>
        <script type ="text/javascript">
            var mapa;
            function IniciaMapa() {
                var latlng = new google.maps.LatLng(-15.682543, -47.978874);
                var Opcoes = {
                    zoom: 8,
                    center: latlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                mapa = new google.maps.Map(document.getElementById("mapa"), Opcoes);
                var marker = new google.maps.Marker
                (
                    {
                        position: new google.maps.LatLng(-15.682543, -47.978874),
                        map: mapa,
                        title: 'Clique aqui'
                    }
                );
                var infowindow = new google.maps.InfoWindow({
                    content: 'Localização:<br/>Nome Pais:<br/>Latit./Longit:'
                });
                google.maps.event.addListener(marker, 'click', function () {
                    infowindow.open(mapa, marker);
                });
            }
            window.onload = IniciaMapa;
        </script>
        <h2>Macoratti .net - Usando marcadores</h2>
        <div id ="mapa" style="height: 522px; width: 553px; top: 60px; left: 126px; position: absolute;"></div>
    </div>
    </form>
</body>
</html>
