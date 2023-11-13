MODULE epoxy;
IMPORT Out, Strings := ooc2Strings, List, StringList, strutils, pipes;

CONST
  maxStrLen = 1024; (* many things will get truncated to this number of chars*)

TYPE
  pstring* = StringList.pstring;
  strlist* = StringList.TStringList;
(*
PROCEDURE list*(VAR s : strlist);
VAR e : StringList.Node;
    i : INTEGER;
BEGIN
   NEW(e);
   i := 0;
   REPEAT
      e := s.Get(s, i);
      IF e # NIL THEN Out.String (e.obj(StringList.TString).str^); Out.Ln END;
      (*Out.String (e.string); Out.Ln;*)
      INC(i);
   UNTIL i = s.Count-1;
   (* the reason i use s.Count-1 here is because
   the original StringList.list function doesn't use it
   is that pipes.ReadLine returns an empty string at the end of the pipe
   because that's how unix pipes work it seems.
   update: i decided to fix the list i got from pipes in this module below.*)
END list;
*)

PROCEDURE list*(VAR s: strlist);
BEGIN
  StringList.list(s)
END list;

PROCEDURE getCmdOutputStr*(cmd: ARRAY OF CHAR): pstring;
VAR
  text: pipes.Text;
  pstr: pstring;
  str:  ARRAY maxStrLen OF CHAR;
  l:    LONGINT;
BEGIN
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
  text : pipes.Text;
  strs : strlist;
  str  : ARRAY maxStrLen OF CHAR;
BEGIN
  strs := StringList.Create();
  text := pipes.Popen(cmd, 'r');
  WHILE ~pipes.isEOF(text) DO
    pipes.ReadLine(text, str);
    strs.AppendString(strs, str);
  END;
  strs.Last.prev := NIL; (* fixing the output we got from pipes
                            which seems to contain always empty string
                            at the end *)
  RETURN strs
END getCmdOutputList;


END epoxy.
