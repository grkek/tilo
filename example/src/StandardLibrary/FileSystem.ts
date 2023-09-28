const readFile = (path: string) => {
  // @ts-expect-error
  if(fileExists(path)) return FileSystem__ReadFile(path);
  throw `File does not exist, ${path}`;
};

const writeFile = (path: string, content: string) => {
  // @ts-expect-error
  FileSystem__WriteFile(path, content);
};

const fileExists = (path: string) => {
  // @ts-expect-error
  return FileSystem__FileExists(path);
};

const directoryChildren = (path: string) => {
  // @ts-expect-error
  return FileSystem__DirectoryChildren(path);
}

export { readFile, writeFile, fileExists, directoryChildren };