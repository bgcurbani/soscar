<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="LocalizadorOficinas.Form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Google Maps</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyBV1qe9vPcm0CrnGsjawFulvtjwHZcOdiM" ></script>
        <script type ="text/javascript">
        function InicializaMapa() {
            var latlng = new google.maps.LatLng(-15.682543, -47.978874);
            var opcoes = {
                zoom: 8,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var mapa = new google.maps.Map(document.getElementById("mapa"), opcoes);
        }
        window.onload = InicializaMapa;
        </script>
        <h2>Usando Google Maps </h2>
        <div id ="mapa"  style="width: 600px; top: 68px; left: 272px; position: absolute; height: 400px" ></div>
    </div>
    </form>
</body>
</html>