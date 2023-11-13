MODULE epoxy;
IMPORT Strings := ooc2Strings, Out, List, StringList, strutils, pipes;

TYPE
  pstring* = StringList.pstring;
  strlist* = StringList.TStringList;

PROCEDURE getCmdOutputStr*(cmd: ARRAY OF CHAR): pstring;
VAR
  text: pipes.Text;
  pstr: pstring;
  str:  ARRAY 1024 OF CHAR;
  l:    LONGINT;
BEGIN
  text := pipes.NewText();
  text := pipes.Popen(cmd, 'r');
  pipes.ReadLine(text, str);
  l := pipes.Pclose(text);
  l := Strings.Length(str);
  NEW(pstr, l+1);
  COPY (str, pstr^);
  RETURN pstr
END getCmdOutputStr;

PROCEDURE getCmdOutputList*(cmd: ARRAY OF CHAR): strlist;
VAR
  text: pipes.Text;

BEGIN

END getCmdOutputList;


END epoxy.
