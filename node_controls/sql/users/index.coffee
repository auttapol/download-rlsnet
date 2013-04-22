
exports.getList = () ->
	"select USER_ID,USERNAME,USERPASW,USERSTATUS, usercode from SP$PR_GETUSERLIST(-1)"