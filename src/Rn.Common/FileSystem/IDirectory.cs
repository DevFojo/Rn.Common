using System.IO;

namespace Rn.Common.FileSystem
{
  public interface IDirectory
  {
    bool Exists(string path);
    DirectoryInfo CreateDirectory(string path);
  }
}
