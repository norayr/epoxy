MODULE testEpoxy;
IMPORT epoxy, Out;


VAR
  pstr: epoxy.pstring;
  strs: epoxy.strlist;
BEGIN
  pstr := epoxy.getCmdOutputStr("date -I");
  Out.String(pstr^); Out.Ln;

  strs := epoxy.getCmdOutputList("ls -al");
  epoxy.list(strs);

END testEpoxy.
