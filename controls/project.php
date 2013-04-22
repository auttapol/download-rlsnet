<?php class project extends sn {

function __construct() {
	session_start();
}

public static function engine() {
	load("index.html");
	echo html();
}	

public static function get($j=array()) {
	app::get();
	$j['text']=app::$text;
	$j['callback']="afterGet";
	$j['response']=true;
	return $j;
}

public static function content($j=array()) {
	app::content();
	$j['content']=app::$content;
	$j['href']=url::$href;
	$j['callback']="afterContent";
	$j['response']=true;
	return $j;
}

} ?>
