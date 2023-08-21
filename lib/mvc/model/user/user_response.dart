import 'user.dart';

class UserResponse {
    User? data;
    String? message;
    int? success;

    UserResponse({this.data, this.message, this.success});

    factory UserResponse.fromJson(Map<String, dynamic> json) {
        return UserResponse(
            data: json['data'] != null ? User.fromJson(json['data']) : null,
            message: json['message']??"",
            success: json['success']??0,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['message'] = message;
        data['success'] = success;
        if (this.data != null) {
            data['data'] = this.data?.toJson();
        }
        return data;
    }
}