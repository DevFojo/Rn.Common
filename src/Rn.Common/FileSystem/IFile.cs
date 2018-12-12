namespace Rn.Common.FileSystem
{
  public interface IFile
  {
    string ReadAllText(string path);
    bool Exists(string path);
    void Delete(string path);
    void WriteAllText(string path, string contents);
  }
}
