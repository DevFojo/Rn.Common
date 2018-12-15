using System.Net.Http;
using System.Threading.Tasks;

namespace Rn.Common.Net
{
  public interface IHttpClient
  {
    Task<HttpResponseMessage> SendAsync(HttpRequestMessage request);
    Task<string> GetPageTextAsync(string requestUri);
  }
}
