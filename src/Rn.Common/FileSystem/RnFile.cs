using System.IO;

namespace Rn.Common.FileSystem
{
  public class RnFile : IFile
  {
    public string ReadAllText(string path) => File.ReadAllText(path);
    public bool Exists(string path) => File.Exists(path);
    public void Delete(string path) => File.Delete(path);
    public void WriteAllText(string path, string contents) => File.WriteAllText(path, contents);
  }
}
