class MockModels {
  ///Endpoint : author/upload/doc
  static const String uploadAuthorDocRequest = '''{
  "nic": "9623472364",
  "address": "Sample address",
  "extension_front":"jpg",
  "extension_back":"jpg"
}''';
  static const String uploadAuthorDocResponse = '''{
  "success": true,
  "message": "Documents uploaded successfully"
 }''';

  ///Endpoint : veep
  static const String veepRequest = '''{
  "user_id": 1
 }''';
  static const String veepResponse = '''{
 
  "success":true,
  "message":"Error",
  "output": [{
  "veep_id":1,
  "name":"Eliza Williams",
  "age":23,
  "distance":10,
  "veepStatus":0,
  "designation":"Art Manager",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
  "images":["https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg","https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg", "https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":1,
  "name":"John Williams",
  "age":25,
  "distance":20,
  "veepStatus":1,
  "designation":"Doctor",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Male",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
  "images":["https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg","https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg", "https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg"],
  "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":1,
  "name":"John Doe",
  "age":32,
  "distance":12,
  "veepStatus":2,
  "designation":"Director",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg","https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg", "https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":1,
  "name":"Eliza Nash",
  "age":23,
  "distance":40,
  "veepStatus":1,
  "designation":"Teacher",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg","https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg", "https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
}]

 }''';

  ///Endpoint : match
  static const String matchRequest = '''{
  "user_id": 1
}''';
  static const String matchResponse = '''{
 
 
  "success":true,
  "message":"Error",
  "output": [{
  "veep_id":1,
  "name":"Eliza Williams",
  "age":23,
  "distance":10,
  "designation":"Art Manager",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
  "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":1,
  "name":"John Williams",
  "age":25,
  "distance":20,
  "designation":"Doctor",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Male",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":1,
  "name":"John Doe",
  "age":32,
  "distance":12,
  "designation":"Director",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":1,
  "name":"Eliza Nash",
  "age":23,
  "distance":40,
  "designation":"Teacher",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
}]

 }''';

  ///Endpoint : verify/email
  static const String emailVerificationRequest = '''{
  "email_address": "admin@gmail.com",
  "conform_email_address":"admin@gmail.com"
 
}''';
  static const String emailVerificationResponse = '''{
  "success": true,
  "message": "Success",
  "output": {
  "user_id": 1,
  "token": "token"
}
 }''';

  ///Endpoint : otp/generate
  static const String generateOtpRequest = '''{
   "email_address": "admin@gmail.com",
  "otp":1234
 
}''';
  static const String generateOtpResponse = '''{
  "success": true,
  "message": "error"
 }''';

  ///Endpoint : otp/submit
  static const String otpSubmitRequest = '''{
  "email_address": "admin@gmail.com",
  "otp_code":1234
 
}''';
  static const String otpSubmitResponse = '''{
  "success": true,
  "message": "Success"
 }''';

  ///Endpoint : personal/submit
  static const String personalDataSubmitRequest = '''{
   "name":"name",
   "dob":"dob",
   "sexuality":"sexuality",
   "vegan_scale":"veganScale",
   "gender":"gender",
   "user_id":1
 
}''';
  static const String personalDataSubmitResponse = '''{
  "success": true,
  "message": "Success"
 }''';

  ///Endpoint : about/submit
  static const String aboutDataSubmitRequest = '''{
   "job":"job",
   "hobbies":"hobbies",
   "about":"about",
   "country":"country",
   "province":"province",
   "city":"city",
   "neighbourhood":"neighbourhood",
   "user_id":1
 
}''';
  static const String aboutDataSubmitResponse = '''{
  "success": true,
  "message": "Success"
 }''';

  ///Endpoint : socials/submit
  static const String socialsDataSubmitRequest = '''{
    "web":"web",
   "facebook":"fb",
   "instagram":"insta",
   "linkedin":"linkdin",
   "snapchat":"snapchat",
   "twitter":"twitter",
   "user_id":1
 
 
}''';
  static const String socialsDataSubmitResponse = '''{
  "success": true,
  "message": "Success"
 }''';

  ///Endpoint : change/username
  static const String changeUserNameRequest = '''{
   "user_id":1,
   "user_name":"admin"
   
 }''';
  static const String changeUserNameResponse = '''{
  "success": true,
  "message": "Success"
 }''';

  ///Endpoint : change/userEmail
  static const String changeUserEmailRequest = '''{
   "user_id":1,
   "user_email":"admin@gmail.com"
   
 }''';
  static const String changeUserEmailResponse = '''{
  "success": true,
  "message": "Success"
 }''';

  ///Endpoint : location/data
  static const String locationRequest = '''{
  "user_id": 1,
 }''';
  static const String locationResponse = '''{
  "success":true,
  "message": "Error",
  "output": [
    {
    "user_id":2,
    "state":"Los Angeles",
    "town":"Victoria"
    },
     {
    "user_id":2,
    "state":"Melbourne",
    "town":"Victoria"
    },
     {
    "user_id":2,
    "state":"London",
    "town":"GB"
    }
    ]
}''';

  ///Endpoint : setting/unsubscribe
  static const String emailSettingRequest = '''{
  "user_id":1,
  "email_setting_id":1,
  "status":true
 
}''';
  static const String emailSettingResponse = '''{
  "success": true,
  "message": "Success"
 }''';


  ///Endpoint : favourite
  static const String favouriteRequest = '''{
  "user_id": 1,
}''';
  static const String favouriteResponse = '''{
  "success": true,
  "message": "Error",
  "output": {
    "liked": [{
  "veep_id":1,
  "name":"Eliza Williams",
  "age":23,
  "distance":10,
  "isPicked":false,
  "designation":"Art Manager",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
  "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":2,
  "name":"John Williams",
  "age":25,
  "distance":20,
  "isPicked":true,
  "designation":"Doctor",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Male",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":3,
  "name":"John Doe",
  "age":32,
  "distance":12,
  "isPicked":false,
  "designation":"Director",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2023-01-13 10:40:21",
 "expire_time":"2022-10-22 10:20:21"
},
{
  "veep_id":1,
  "name":"Eliza Nash",
  "age":23,
  "distance":40,
  "isPicked":true,
  "designation":"Teacher",
  "bio": "i'm a photographer, yoga enthusiast, love to relax but very adventurous and lover of superhero movies.",
  "gender":"Female",
  "fb":"@Eliza-williams",
  "instagram":"@Eliza-williams",
  "linkedin":"@Eliza-williams",
  "snapchat":"@Eliza-williams",
  "twitter":"@Eliza-williams",
  "hobbies": "Computer Programming, Archery, Drawing, Chess",
 "images":["https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg","https://static.wixstatic.com/media/5f5390_3e39835060a442db8d4c73efc2081c1d~mv2.jpg/v1/crop/x_489,y_0,w_1222,h_1467/fill/w_516,h_620,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Jeremy.jpg"],
 "last_activated":"2022-10-22 10:20:21",
 "expire_time":"2022-10-22 10:20:21"
}]
   
  }

 }''';

  ///Endpoint : user/imageChange (form data)
  static const String userImageChangeRequest = '''{
  "user_id": 1,
  'file_extension': "jpg",
  "updated_by":1,
  "profile": (file)
}''';
  static const String userImageChangeResponse = '''{
  "success": true,
  "message": "Profile Image Updated successfully"
 }''';

  ///Endpoint : profileImage/submit (form data)
  static const String addImageRequest = '''{
  "user_id": 1,
  'file_extension': "jpg",
  "profile": (file)
}''';
  static const String addImageResponse = '''{
  "success": true,
  "message": "Profile Image Added successfully"
 }''';

  ///Endpoint : offering/edit (form data)
  static const String bizEditRequest = '''{
  "user_id": 1,
  "service_name": "Software Engineer",
  "service_description": "I am a software engineer with 5 years of experience in building web applications.",
  "slogan": "Male",
  "service_type": "Intermediate",
  "fb": "https://www.facebook.com/myprofile",
  "instagram": "https://www.instagram.com/myprofile",
  "linkedin": "https://www.linkedin.com/in/myprofile",
  "snapchat": "https://www.linkedin.com/in/myprofile",
  "twitter": "https://twitter.com/myprofile",
  "web": "https://www.myprofile.com",
  "city": "New York",
  "province": "NY",
  "country": "USA",
  'file_extension': "pdf",
  "offering_file": (file)
}''';
  static const String bizEditResponse = '''{
  "success": true,
  "message": "Success"
 }''';

  ///Endpoint : profile/edit/veep
  static const String regularEditRequest = '''{
  "user_id": 123,
  "age": 30,
  "designation": "Software Engineer",
  "bio": "I am a software engineer with 5 years of experience in building web applications.",
  "gender": "Male",
  "vegan_scale": "Intermediate",
  "fb": "https://www.facebook.com/myprofile",
  "instagram": "https://www.instagram.com/myprofile",
  "linkedin": "https://www.linkedin.com/in/myprofile",
  "snapchat": "https://www.linkedin.com/in/myprofile",
  "twitter": "https://twitter.com/myprofile",
  "web": "https://www.myprofile.com",
  "hobbies": "Playing guitar, reading books, hiking",
  "city": "New York",
  "province": "NY",
  "country": "USA"
}''';
  static const String regularEditResponse = '''{
 "success": true,
  "message": "Success"
 }''';
}
