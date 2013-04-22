
exports.start = () ->
	"select SESSION_ID, WORKSTATION_ID, SUCCESS, ws_name from SP$PR_NEWSESSION('+inttostr(user_id)+','''+session.wsname+''','''+session.ws_ip+''','''+GetMACAdress+''','+forcecreate+','''+session.prog+''','''+cfSec.PCID+''')"

exports.close = () ->
	"execute procedure SP$PR_CLOSESESSION('+sCLOSESESSION_ID+', '+inttostr(ENDFLAG)+', '+inttostr(session.id)+', '+sDOEVENT+')"
 