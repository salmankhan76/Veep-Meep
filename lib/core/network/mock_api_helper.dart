import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'mock_models.dart';
import 'network_config.dart';

class MockAPIHelper{
  Future<dynamic> post(String url, {@required body}) async {
    final dio = Dio();
    final adapter = DioAdapter(dio: dio);
    adapter.onPost(NetworkConfig.getNetworkUrl() + url, (request) {
      final response = _getResponse(url);
      return request.reply(200, json.decode(response),);
    }, data: body);

    dio.options.headers['content-Type'] = 'application/json';
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        error: true,
        requestBody: true,
        requestHeader: false,
        responseBody: true,
        responseHeader: false,
      ),
    );

    final response = await dio.post(NetworkConfig.getNetworkUrl() + url, data: body, options: Options());
    await Future.delayed(const Duration(seconds: 1));
    return response;
  }

  _getResponse(String url){
    if(url == 'author/upload/doc'){
      return MockModels.uploadAuthorDocResponse;
    } else if(url == 'veep'){
      return MockModels.veepResponse;
    } else if(url == 'verify/email'){
      return MockModels.emailVerificationResponse;
    } else if(url == 'otp/generate'){
      return MockModels.generateOtpResponse;
    }else if(url == 'otp/submit'){
      return MockModels.otpSubmitResponse;
    }else if(url == 'personal/submit'){
      return MockModels.personalDataSubmitResponse;
    }else if(url == 'about/submit'){
      return MockModels.aboutDataSubmitResponse;
    }else if(url == 'socials/submit'){
      return MockModels.socialsDataSubmitResponse;
    }else if(url == 'match'){
      return MockModels.matchResponse;
    }else if(url == 'favourite'){
      return MockModels.favouriteResponse;
    }else if(url == 'user/imageChange'){
      return MockModels.userImageChangeResponse;
    }else if(url == 'profileImage/submit'){
      return MockModels.addImageResponse;
    }else if(url == 'change/username'){
      return MockModels.changeUserNameResponse;
    }else if(url == 'change/useremail'){
      return MockModels.changeUserEmailResponse;
    }else if(url == 'location/data'){
      return MockModels.locationResponse;
    }else if(url == 'setting/unsubscribe'){
      return MockModels.emailSettingResponse;
    } else if (url == 'profile/edit/veep') {
      return MockModels.regularEditResponse;
    }else if (url == 'profile/edit/biz') {
      return MockModels.bizEditResponse;
    }
  }
}