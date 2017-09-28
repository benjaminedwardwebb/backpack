with builtins;
let
  # These functions are private, helper functions. They are not exported.
  isMatched = groups: ! (isNull groups);
in
rec {
  attrsToList = attrs:
    let
      names = attrNames attrs;
      f = name: { "${name}" = (getAttr name attrs); };
      list = map f names;
    in
    list;

  concatenateFiles = files:
    concatStringsSep "\n" (map readFile files);

  # Given a directory, returns the list of all files in that directory or in a
  # nested directory at any level of depth.
  listFilesRecursively = path:
    let
      attrs = readDir path;

      list = attrsToList attrs;

      # For simplicity, we do not follow symlinks and ignore paths of unknown
      # type. Paths returned by builtins.readDir with these types are filtered
      # out before recursing over only the file and directory cases.
      children =
        let
          f = elem:
            let
              name = head (attrNames elem);
              value = getAttr name elem;
              bool =
                if value == "symlink" || value == "unknown"
                then false
                else true;
            in
            bool;
          filtered = filter f list;
        in
        filtered;

      recurseOnAttr = name: value:
        let
          child_path = /. + path + "/${name}";
        in
        if value == "regular"
        then [ child_path ]
        else listFilesRecursively child_path;

      recurseOnElem = elem:
        let
          name = head (attrNames elem);
          value = getAttr name elem;
          list = recurseOnAttr name value;
        in
        list;

      recurse = list: concatLists (map recurseOnElem list);

      paths = recurse children;
    in
    paths;

  # This is naive. It only works for extensions without any characters that
  # would be interpreted with special meaning in a regex expression, i.e., it
  # does not do any escaping.
  filenameHasExtension = extension: path:
    let
      string = toString path;
      filename = baseNameOf string;
      bool = isSuffixedWith ".${extension}" filename;
    in
    bool;

  filenamePrefixedWith = prefix: path:
    let
      string = toString path;
      filename = baseNameOf string;
      bool = isPrefixedWith "${prefix}" filename;
    in
    bool;

  isPrefixedWith = prefix: string:
    isMatched (match "${prefix}.*" string);

  isSuffixedWith = suffix: string:
    isMatched (match ".*${suffix}" string);
}
