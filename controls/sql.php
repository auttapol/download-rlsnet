<?php class sql extends sn {
	
public static $request;

function __construct() {

}

public static function ins($s="") {
	$tm=time();
	$s.="insert into `parse` (name,mnn,regnum,producer,packer,date,tm,page) values ('".app::$name."','".app::$mnn."','".app::$regnum."','".app::$producer."','".app::$packer."','".app::$date."',".$tm.",".url::$first.") ";
	self::$request=$s;
	return $s;
}


} ?>
