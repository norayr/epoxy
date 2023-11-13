MODULE testEpoxy;
IMPORT epoxy, Out;


VAR
  pstr: epoxy.pstring;
BEGIN
  pstr := epoxy.getCmdOutputStr("date -I");
  Out.String(pstr^); Out.Ln;

END testEpoxy.
