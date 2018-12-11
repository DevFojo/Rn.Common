using NUnit.Framework;

namespace Rn.CommonTests
{
  [TestFixture]
  public class HelloWorldTests
  {
    [Test]
    public void HelloWorld_GivenCalled_ShouldSayHelloWorld()
    {
      Assert.AreEqual("Hello World", HelloWorld());
    }

    // Hello World
    private static string HelloWorld()
    {
      return "Hello World";
    }
  }
}
