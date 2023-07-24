package br.com.oitiliveness3d.oiti_liveness3d.utils

open class AltLiveness3dException(val code: String, message: String) : Exception(message) {}

class InvalidAppKey(code: String = "INVALID_APP_KEY", message: String = "INVALID_APP_KEY") :
    AltLiveness3dException(code, message) {}
