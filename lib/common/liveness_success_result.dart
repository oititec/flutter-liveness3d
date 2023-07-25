class LivenessSuccessResult {
  final bool valid;
  final String cause;
  final String codId;
  final String protocol;
  final String scanResultBlob;

  LivenessSuccessResult(
    this.valid,
    this.cause,
    this.codId,
    this.protocol,
    this.scanResultBlob,
  );
}
