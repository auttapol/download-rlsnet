<?php class app extends sn {

public static $search;
public static $src;
public static $dst;
public static $prev;
public static $next;
public static $skip;
public static $page;
public static $pages;
public static $limit;
public static $records;
public static $id;
public static $first;
public static $last;
public static $text;
public static $path;
public static $message;

public static $date;
public static $name;
public static $mnn;
public static $regnum;
public static $producer;
public static $packer;

function __construct() {
	self::$id=0;
	self::$first=0;
	self::$last=1;
	self::$text="";
}

public static function getContent($t="") {
	$t=preg_replace('/\r/m',"",$t);
	$t=preg_replace('/\n/m',"",$t);
	$t=preg_replace('/\t/m',"",$t);
	preg_match_all('/<table border="0" cellpadding="0" cellspacing="0" class="grid">(.*?)<\/table>/i',$t,$c,PREG_PATTERN_ORDER);
	$t=$c[0][0];

	$t=preg_replace('/<tr class="table_row">/mi',"<tr>",$t);
	$t=preg_replace('/<tr >/mi',"<tr>",$t);
	$t=preg_replace('/<td class="cell">/mi',"<td>",$t);

	$t=preg_replace('/>[\s]*</i',"><",$t);
	$t=preg_replace('/<\/tr>/i',"",$t);
	$t=preg_replace('/<\/tr>/i',"",$t);
	$t=preg_replace('/<\/td>/i',"",$t);
	$t=preg_replace('/table>/i',"",$t);
	$t=preg_replace('/~/i',"-",$t);
	return $t;
}

public static function get() {
	$s=""; $i=-1;
	self::$path="http://www.4doktor.ru/?subid=0&sort=Title%20ASC&page=".intval(url::$first);
	$t=file_get_contents(self::$path);
	if ($t) {
		if ($t!="") {
			$t=self::getContent($t);
			$s=self::parseContent($t);
			self::$text=$s;
		}
	}
	return true;
}

public static function parseContent($t,$s="") {
	foreach (explode("<tr>",$t) as $str) { $i++;
		if ($i>1) {
			$line=explode("<td>", $str);
			if (sizeof($line)>3) {
				if (self::parseLine($line)) {
					if (query(sql::ins())) {
						$s.=self::getLineLog($line,$i);
					}
				}				
			}
		}
	}
	return $s;
}

public static function parseLine($line) {
	self::$date=self::checkLine($line[1]);
	self::$name=self::checkLine($line[2]);
	self::$mnn=self::checkLine($line[3]);
	self::$regnum=self::checkLine($line[4]);
	self::$producer=self::checkLine($line[5]);
	self::$packer=self::checkLine($line[6]);
	if ((self::$name!="") && (self::$mnn!="")) {
		return true;
	}
	return false;
}

public static function getLineLog($line,$i=0) {
	$s="<small>"+strval(url::$first)."</small> <b>".self::$name."</b> <small>".self::$mnn."</small><br>";
	return $s;
}

public static function checkLine($s="") {
	$s=preg_replace('/<a(.*?)>/i',"",$s);
	$s=preg_replace('/<div(.*?)>/i',"",$s);
	$s=preg_replace('/<\/title>/i',"",$s);
	$s=preg_replace('/<style>(.*?)<\/style>/i',"",$s);
	$s=preg_replace('/<\/a>/i',"",$s);
	$s=preg_replace('/<\//i',"",$s);
	$s=trim($s);
	return $s;
}
	

} ?>
