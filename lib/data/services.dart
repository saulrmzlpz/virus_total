import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:virus_total_multi/models/analysis_exception.dart';
import 'package:virus_total_multi/models/analysis_response.dart';
import 'package:virus_total_multi/models/upload_response.dart';

class Services {
  static const String _apiKey = 'API KEY HERE';
  static Future<Map<String, dynamic>?> sendFile({required File file}) async {
    try {
      Uri parsedUrl = Uri.parse('https://www.virustotal.com/api/v3/files');

      final Map<String, String> headers = {
        HttpHeaders.acceptHeader: ContentType.json.mimeType,
        'x-apikey': _apiKey,
      };
      final request = http.MultipartRequest('POST', parsedUrl)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('file', file.path));
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);

      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        final bodyStr = const Utf8Decoder().convert(response.bodyBytes);
        final uploadResult = UploadResponse.fromRawJson(bodyStr);

        return {'ok': await getAnalysisDetail(analysisUrl: uploadResult.data.links.self)};
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        throw AnalysisException('Su suscripción ha terminado. Por favor, renueve su suscripción e inténtelo de nuevo');
      }
      if (response.statusCode == HttpStatus.badRequest) {
        throw AnalysisException('Ha ocurrido un error al enviar el archivo. Por favor, verifiquelo e inténtelo de nuevo');
      }
    } on AnalysisException catch (e) {
      return {'error': '$e'};
    } catch (_) {
      return {'error': 'Ha ocurrido un error inesperado. Inténtelo de nuevo más tarde'};
    }
    return null;
  }

  static Future<AnalysisResponse?> getAnalysisDetail({required String analysisUrl}) async {
    try {
      Uri parsedUrl = Uri.parse(analysisUrl);

      final Map<String, String> headers = {
        HttpHeaders.acceptHeader: ContentType.json.mimeType,
        'x-apikey': _apiKey,
      };
      final response = await http.get(parsedUrl, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        final body = const Utf8Decoder().convert(response.bodyBytes);
        return AnalysisResponse.fromRawJson(body);
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        throw AnalysisException('Su suscripción ha terminado. Por favor, renueve su suscripción e inténtelo de nuevo');
      }
      if (response.statusCode == HttpStatus.badRequest) {
        throw AnalysisException('No se logró obtener el informe del análisis. Inténtelo de nuevo más tarde');
      }
    } catch (_) {
      throw AnalysisException('Ha ocurrido un error inesperado. Inténtelo de nuevo más tarde');
    }
    return null;
  }
}
