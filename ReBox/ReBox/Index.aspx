<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ReBox.Index" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Homepage / ReBox</title>
    <meta charset="utf-8">
    <link rel="icon" href="resources/icon.ico" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/Site.css" rel="stylesheet">
    <style>
        html,
        body {
            background-repeat: repeat;
            background-image: url('resources/background2.png');
            box-shadow: inset 0 0 5rem rgba(0, 0, 0, .5);
            overflow: auto;
        }

        body {
            color: #fff;
            text-shadow: 0 .05rem .1rem rgba(0, 0, 0, .5);
        }

        .map-text {
            color: #000;
        }

        .map-div {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
            <header class="mb-auto">
                <nav class="navbar fixed-top navbar-dark navbar-expand-md">
                    <div class="container">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="index.html">
                                <img class="logo" src="resources/icon.png" alt="main icon">
                            </a>
                        </div>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarCollapse">
                            <div class="nav navbar-nav ml-auto">
                                <a class="nav-item nav-link active" href="/Index.aspx">HOME<span class="sr-only">(current)</span></a>
                                <a class="nav-item nav-link" href="/About.aspx">ABOUT</a>
                                <a class="nav-item nav-link" href="/Contact.aspx">CONTACT</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </header>
            <main role="main" class="cover text-center" runat="server">
                <h1>ReBox</h1>
                <p class="lead">Find the recycle bin closest to your location.</p>
                <div class="mb-3">
                    <input type="text" class="form-control" id="inputLocation" placeholder="Your Location">
                </div>
                <div class="mb-3">
                    <a class="btn btn-lg" id="findBox" style="color: #333" role="button">Find the Box</a>
                </div>

                <div class="mb-3" style="width: 100%; height: 500px">
                    <div id="embedMap" class="maps" runat="server" style="width: 100%; height: 100%" />

                </div>
            </main>
            <footer class="mastfoot mt-auto text-center">
                <div class="inner">
                    <p>Made by <a href="https://github.com/re-box">@re-box</a>.</p>
                </div>
            </footer>
        </div>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEPrOLNaCMXPAkj-imxYe1QgqMFJ6zZeg"></script>
        <script src="js/bigdatacloud_reverse_geocode.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/gh/bigdatacloudapi/js-reverse-geocode-client@latest/bigdatacloud_reverse_geocode.min.js" type="text/javascript"></script>
        <script type="text/javascript">  
            var reverseGeocoder = new BDCReverseGeocode();
            reverseGeocoder.localityLanguage = 'tr';
            const map = new google.maps.Map(document.getElementById("embedMap"), {
                zoom: 15,
                center: { lat: 39.779428, lng: 30.515562 },
            });
            geocodeLatLng(reverseGeocoder);

            function geocodeLatLng(reverseGeocoder) {
                reverseGeocoder.getClientLocation(function (result) {
                    var infoWindow = new google.maps.InfoWindow();
                    document.getElementById("inputLocation").value = result.locality + ", " + result.principalSubdivision + ", " + result.countryName;
                    infoWindow.setContent("<div class='map-div'><p class='map-text'>" + result.locality + ", " + result.principalSubdivision + ", " + result.countryName + "</p></div>");

                    reverseGeocoder.getClientCoordinates(function (result) {
                        const marker = new google.maps.Marker({
                            position: { lat: result.coords.latitude, lng: result.coords.longitude },
                            map: map,
                        });
                        google.maps.event.addListener(marker, "click", function (e) {
                            infoWindow.open(map, marker);
                        });
                        map.setCenter(marker.getPosition());
                        infoWindow.open(map, marker);

                    });
                });
            }

        </script>
    </form>
</body>
</html>
