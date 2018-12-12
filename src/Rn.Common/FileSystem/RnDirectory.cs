using System.IO;

namespace Rn.Common.FileSystem
{
  public class RnDirectory : IDirectory
  {
    public bool Exists(string path) => Directory.Exists(path);
    public DirectoryInfo CreateDirectory(string path) => Directory.CreateDirectory(path);
  }
}