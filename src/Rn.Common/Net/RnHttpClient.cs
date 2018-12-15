using System.Diagnostics;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

namespace Rn.Common.Net
{
  public class RnHttpClient : IHttpClient
  {
    private readonly ILogger<RnHttpClient> _logger;
    private readonly HttpClient _httpClient;

    public RnHttpClient(ILogger<RnHttpClient> logger)
    {
      _logger = logger;
      _httpClient = new HttpClient();
    }

    public async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request)
    {
      return await _httpClient.SendAsync(request);
    }

    public async Task<string> GetPageTextAsync(string requestUri)
    {
      var stopwatch = Stopwatch.StartNew();
      var result = await _httpClient.GetAsync(requestUri);
      result.EnsureSuccessStatusCode();

      var responseStr = await result.Content.ReadAsStringAsync();
      stopwatch.Stop();
      _logger.LogDebug($"Fetched '{requestUri}' in {stopwatch.ElapsedMilliseconds} ms");

      return responseStr;
    }
  }
}
