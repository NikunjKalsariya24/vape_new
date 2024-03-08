import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  // bool setToken(String value) {
  //   try {
  //     instance.setString("token", value);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // removeSalon() {
  //   try {
  //     instance.remove("token");
  //     instance.remove("userLat");
  //     instance.remove("userLong");
  //     instance.remove("salonLogIn");
  //     instance.remove("salonName");
  //     instance.remove("salonEmail");
  //     instance.remove("salonNumber");
  //     instance.remove("salonId");
  //     instance.remove("userPassword");
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // removeSalonRememberPassword() {
  //   try {
  //     instance.remove("token");
  //     instance.remove("userLat");
  //     instance.remove("userLong");
  //     instance.remove("salonLogIn");
  //     instance.remove("salonName");
  //     instance.remove("salonEmail");
  //     instance.remove("salonId");
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // String? getToken() {
  //   return instance.getString("token");
  // }
  //
  // String? getTokenBarber() {
  //   return instance.getString("tokenBarber");
  // }
  //
  // void logout() {
  //   instance.clear();
  // }
  //
  // double setLat(double lat) {
  //   try {
  //     instance.setDouble("userLat", lat);
  //     return lat;
  //   } catch (e) {
  //     return 0.00;
  //   }
  // }
  //
  // double setLong(double long) {
  //   try {
  //     instance.setDouble("userLong", long);
  //     return long;
  //   } catch (e) {
  //     return 0.00;
  //   }
  // }
  //
  // double getLat() {
  //   try {
  //     return instance.getDouble("userLat") ?? 0.00;
  //   } catch (e) {
  //     return 0.00;
  //   }
  // }
  //
  // double getLong(double long) {
  //   try {
  //     return instance.getDouble("userLong") ?? 0.00;
  //   } catch (e) {
  //     return 0.00;
  //   }
  // }
  //
  // String setPhone(String phoneNumber) {
  //   try {
  //     instance.setString("userPhone", phoneNumber);
  //     return phoneNumber;
  //   } catch (e) {
  //     return "";
  //   }
  // }
  //
  // String setPassword(String password) {
  //   try {
  //     instance.setString("userPassword", password);
  //     return password;
  //   } catch (e) {
  //     return "";
  //   }
  // }
  //
  //
  //
  // String? getSalonPassword() {
  //   try {
  //     return instance.getString("userPassword");
  //   } catch (e) {
  //     return "";
  //   }
  // }
  //
  // bool setRemember(isRemember) {
  //   try {
  //     instance.setBool("passwordRemember", isRemember);
  //     return isRemember;
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  //
  //
  // bool getRemember() {
  //   try {
  //     return instance.getBool("passwordRemember") ?? false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  bool setSkipLogIn(salonLogIn) {
    try {
      instance.setBool("skipLogIn", salonLogIn);
      return salonLogIn;
    } catch (e) {
      return false;
    }
  }

  bool getSkipLogIn() {
    try {
      return instance.getBool("skipLogIn") ?? false;
    } catch (e) {
      return false;
    }
  }

  bool setLogIn(login) {
    try {
      instance.setBool("logIn", login);
      return login;
    } catch (e) {
      return false;
    }
  }

  bool getLogIn() {
    try {
      return instance.getBool("logIn") ?? false;
    } catch (e) {
      return false;
    }
  }

  String setToken(String token) {
    try {
      instance.setString("logInToken", token);
      return token;
    } catch (e) {
      return "";
    }
  }

  String getToken() {
    try {
      return instance.getString("logInToken") ?? "";
    } catch (e) {
      return "";
    }
  }

  String setPermission(String permission) {
    try {
      instance.setString("logInPermission", permission);
      return permission;
    } catch (e) {
      return "";
    }
  }

  String getPermission() {
    try {
      return instance.getString("logInPermission") ?? "";
    } catch (e) {
      return "";
    }
  }

  String setRole(String role) {
    try {
      instance.setString("logInRole", role);
      return role;
    } catch (e) {
      return "";
    }
  }

  String getRole() {
    try {
      return instance.getString("logInRole") ?? "";
    } catch (e) {
      return "";
    }
  }

  logOutProfile() {
    try {
      instance.remove("skipLogIn");
      instance.remove("logIn");
      instance.remove("logInToken");
      instance.remove("logInPermission");
      instance.remove("logInRole");
    } catch (e) {
      return false;
    }
  }

  String setDeviceToken(String deviceToken) {
    try {
      instance.setString("deviceToken", deviceToken);
      return deviceToken;
    } catch (e) {
      return "";
    }
  }

  String? getDeviceToken() {
    try {
      return instance.getString("deviceToken");
    } catch (e) {
      return null;
    }
  }



  String nonVariationProduct(String nonVariationProduct) {
    try {
      instance.setString("nonVariationProduct", nonVariationProduct);
      return nonVariationProduct;
    } catch (e) {
      return "";
    }
  }


  String nonVariationProductGet() {
    try {
      return instance.getString("nonVariationProduct") ?? "";
    } catch (e) {
      return "";
    }
  }
  nonVariationRemove() {
    try {
      instance.remove("nonVariationProduct");

    } catch (e) {
      return false;
    }
  }
  String variationProduct(String variationProduct) {
    try {
      instance.setString("variationProduct", variationProduct);
      return variationProduct;
    } catch (e) {
      return "";
    }
  }


  String variationProductGet() {
    try {
      return instance.getString("variationProduct") ?? "";
    } catch (e) {
      return "";
    }
  }
  variationRemove() {
    try {
      instance.remove("variationProduct");

    } catch (e) {
      return false;
    }
  }



//
// String setEmail(String salonEmail) {
//   try {
//     instance.setString("salonEmail", salonEmail);
//     return salonEmail;
//   } catch (e) {
//     return "";
//   }
// }
//
// String setNumber(String salonNumber) {
//   try {
//     instance.setString("salonNumber", salonNumber);
//     return salonNumber;
//   } catch (e) {
//     return "";
//   }
// }
//
// String setId(String salonId) {
//   try {
//     instance.setString("salonId", salonId);
//     return salonId;
//   } catch (e) {
//     return "";
//   }
// }
//
// String? getSalonId() {
//   return instance.getString("salonId");
// }
//
// String setBarberName(String barberName) {
//   try {
//     instance.setString("barberName", barberName);
//     return barberName;
//   } catch (e) {
//     return "";
//   }
// }
//
// String setBarberEmail(String barberEmail) {
//   try {
//     instance.setString("barberEmail", barberEmail);
//     return barberEmail;
//   } catch (e) {
//     return "";
//   }
// }
//
// String setBarberNumber(String barberNumber) {
//   try {
//     instance.setString("barberNumber", barberNumber);
//     return barberNumber;
//   } catch (e) {
//     return "";
//   }
// }
//
// String setBarberQrCode(String barberQrCode) {
//   try {
//     instance.setString("barberQrCode", barberQrCode);
//     return barberQrCode;
//   } catch (e) {
//     return "";
//   }
// }
//
// String setBarberId(String barberId) {
//   try {
//     instance.setString("barberId", barberId);
//     return barberId;
//   } catch (e) {
//     return "";
//   }
// }
//
// String? getsBarberId() {
//   return instance.getString("barberId");
// }
//
// String? getsBarberQrCode() {
//   return instance.getString("barberQrCode");
// }
//
// String? getSalonName() {
//   return instance.getString("salonName");
// }
//
// String? getSalonEmail() {
//   return instance.getString("salonEmail");
// }
//
// String? getSalonNumber() {
//   return instance.getString("salonNumber");
// }
//
// String? getBarberName() {
//   return instance.getString("barberName");
// }
//
// String? getBarberEmail() {
//   return instance.getString("barberEmail");
// }
//
// String? getBarberNumber() {
//   return instance.getString("barberNumber");
// }
//
// bool setBarberLogIn(barberLogIn) {
//   try {
//     instance.setBool("barberLogIn", barberLogIn);
//     return barberLogIn;
//   } catch (e) {
//     return false;
//   }
// }
//
// bool setTokenBarber(String value) {
//   try {
//     instance.setString("tokenBarber", value);
//     return true;
//   } catch (e) {
//     return false;
//   }
// }
//
// bool getBarberLogIn() {
//   try {
//     return instance.getBool("barberLogIn") ?? false;
//   } catch (e) {
//     return false;
//   }
// }
// bool setBarberRemember(isBarberRemember) {
//   try {
//     instance.setBool("barberPasswordRemember", isBarberRemember);
//     return isBarberRemember;
//   } catch (e) {
//     return false;
//   }
// }
//
// bool getBarberRemember() {
//   try {
//     return instance.getBool("barberPasswordRemember")??false;
//   } catch (e) {
//     return false;
//   }
// }
//
// String setBarberPassword(String barberPassword) {
//   try {
//     instance.setString("barberPassword", barberPassword);
//     return barberPassword;
//   } catch (e) {
//     return "";
//   }
// }
//
// String? getBarberPassword() {
//   try {
//     return instance.getString("barberPassword");
//   } catch (e) {
//     return "";
//   }
// }
//
// removeBarber(){
//   try {
//     instance.remove("tokenBarber");
//
//     instance.remove("barberLogIn");
//     instance.remove("barberName");
//     instance.remove("barberEmail");
//     instance.remove("barberNumber");
//
//     instance.remove("barberPassword");
//
//   } catch (e) {
//     return false;
//   }
//
// }
//
// removeBarberRememberPassword(){
//   try {
//     instance.remove("tokenBarber");
//
//     instance.remove("barberLogIn");
//     instance.remove("barberName");
//     instance.remove("barberEmail");
//
//   } catch (e) {
//     return false;
//   }
//
// }
//
// String setDeviceToken(String deviceToken) {
//
//   try {
//     instance.setString("deviceToken", deviceToken);
//     return deviceToken;
//   } catch (e) {
//     return "";
//   }
//
//
//
//
//
//
// }
//
// String?  getDeviceToken() {
//
//   try {
//     return instance.getString("deviceToken");
//   } catch (e) {
//     return null;
//   }
//
//
// }
//
// String?  setDeviceType(String deviceType) {
//
//   try {
//     instance.setString("deviceType", deviceType);
//     return deviceType;
//   } catch (e) {
//     return "";
//   }
//
//
// }
//
//
//
// String?  getDeviceType() {
//
//   try {
//     return instance.getString("deviceType");
//   } catch (e) {
//     return null;
//   }
//
//
// }
}
