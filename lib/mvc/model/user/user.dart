class User {
    int? user_city_id;
    int? user_country_id;
    String? user_fcm_token;
    String? user_name;
    String? user_phone_no;
    int? user_registered;
    int? user_state_id;
    String? user_token;

    User({this.user_city_id, this.user_country_id, this.user_fcm_token, this.user_name, this.user_phone_no, this.user_registered, this.user_state_id, this.user_token});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            user_city_id: json['user_city_id']??0,
            user_country_id: json['user_country_id']??0,
            user_fcm_token: json['user_fcm_token']??"",
            user_name: json['user_name']??"",
            user_phone_no: json['user_phone_no']??"",
            user_registered: json['user_registered']??0,
            user_state_id: json['user_state_id']??0,
            user_token: json['user_token']??"",
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['user_city_id'] = this.user_city_id;
        data['user_country_id'] = this.user_country_id;
        data['user_fcm_token'] = this.user_fcm_token;
        data['user_name'] = this.user_name;
        data['user_phone_no'] = this.user_phone_no;
        data['user_registered'] = this.user_registered;
        data['user_state_id'] = this.user_state_id;
        data['user_token'] = this.user_token;
        return data;
    }
}