import 'dart:io';

import 'package:mapbox_search/colors/color.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';

main() {
  final MAPBOX_KEY = '';

  group('static image', () {
    late var staticImage;

    setUp(() {
      staticImage = StaticImage(apiKey: MAPBOX_KEY);
    });

    test('polyline', () async {
      var polyline = staticImage.getStaticUrlWithPolyline(
        point1: Location(lat: 37.77343, lng: -122.46589),
        point2: Location(lat: 37.75965, lng: -122.42816),
        marker1: MapBoxMarker(
            markerColor: Color.rgb(0, 0, 0) as RgbColor,
            markerLetter: MakiIcons.aerialway.value,
            markerSize: MarkerSize.LARGE),
        marker2: MapBoxMarker(
            markerColor: Color.rgb(244, 67, 54) as RgbColor,
            markerLetter: 'q',
            markerSize: MarkerSize.SMALL),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Dark,
        render2x: true,
        center: Location(lat: 37.766541503617475, lng: -122.44702324243272),
        auto: true,
      );

      print(polyline);

      expect(polyline,
          "https://api.mapbox.com/styles/v1/mapbox/dark-v10/static/pin-l-aerialway+000000(-122.46589,37.77343),pin-s-q+f44336(-122.42816,37.75965),path-5+723436-0.5(%7DrpeFxbnjVsFwdAvr@cHgFor@jEmAlFmEMwM_FuItCkOi@wc@bg@wBSgM)/auto/600x300@2x?access_token=$MAPBOX_KEY");
      var uri = Uri.tryParse(polyline)!;
      expect(uri, isNotNull);

      var req = await HttpClient().getUrl(uri);
      var resp = await req.close();
      expect(resp.statusCode, 200);
    });
    test('with Marker', () async {
      var withMarker = staticImage.getStaticUrlWithMarker(
        center: Location(lat: 37.77343, lng: -122.46589),
        marker: MapBoxMarker(
            markerColor: Color.rgb(0, 0, 0) as RgbColor,
            markerLetter: 'p',
            markerSize: MarkerSize.LARGE),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Streets,
        render2x: true,
      );

      print(withMarker);

      expect(withMarker,
          "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l-p+000000(-122.46589,37.77343)/-122.46589,37.77343,16,0,20/600x300@2x?access_token=$MAPBOX_KEY");

      var uri = Uri.tryParse(withMarker)!;
      expect(uri, isNotNull);

      var req = await HttpClient().getUrl(uri);
      var resp = await req.close();
      expect(resp.statusCode, 200);
    });
    test('without Marker', () async {
      var withoutMarker = staticImage.getStaticUrlWithoutMarker(
        center: Location(lat: 37.75965, lng: -122.42816),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Outdoors,
        render2x: true,
      );

      print(withoutMarker);

      expect(withoutMarker,
          "https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/static/-122.42816,37.75965,16,0,20/600x300@2x?access_token=$MAPBOX_KEY");

      var uri = Uri.tryParse(withoutMarker)!;
      expect(uri, isNotNull);

      var req = await HttpClient().getUrl(uri);
      var resp = await req.close();
      expect(resp.statusCode, 200);
    });
  });
}
