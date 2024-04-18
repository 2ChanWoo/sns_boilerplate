
/**
 * 마이크로 서비스일 경우 아래와 같이 늘어날 수 있다.
    InternalWebService("https://~"),
    DispatchManagementService("https://~"),
    IDMService("https://~"),
    MessageService("https://~"),
    geoSpetailService("https://~");
 * */
enum ApiEndpoint {
  FavQsService("https://favqs.com/api");

  final String baseUrl;
  const ApiEndpoint(this.baseUrl);
}