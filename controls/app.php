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
public static $content;

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
	self::$content="asfa";
}


public static function get() {
	// $s=""; $i=-1;
	// self::$path="http://www.4doktor.ru/?subid=0&sort=Title%20ASC&page=".intval(url::$first);
	// $t=file_get_contents(self::$path);
	// if ($t) {
	// 	if ($t!="") {
	// 		$t=self::getContent($t);
	// 		$s=self::parseContent($t);
	// 		self::$text=$s;
	// 	}
	// }
	// return true;
}

public static function content() {
	// if (url::$href) {
	// 	self::$content=file_get_contents(url::$href);
	// 	return true;
	// }
	if (url::$href) {
		if( $curl = curl_init() ) {


			$headers = array();
			$headers[] = 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
			$headers[] = 'Accept-Encoding: gzip, deflate';
			$headers[] = 'Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3';
			$headers[] = 'Cache-Control: no-cache';
			$headers[] = 'Connection: keep-alive';
			$headers[] = 'Cookie: __utma=20033147.1622148547.1366107282.1366347206.1366351987.8; __utmz=20033147.1366107282.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmc=20033147; __utmb=20033147.6.10.1366351987; _ym_visorc=b';
			$headers[] = 'Host: www.rlsnet.ru';
			$headers[] = 'Pragma: no-cache';
			$headers[] = 'Referer: http://www.rlsnet.ru/mnn_alf_letter_C0.htm';
			$headers[] = 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:20.0) Gecko/20100101 Firefox/20.0';
			
			curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
			curl_setopt($curl, CURLOPT_URL, url::$href);
			curl_setopt($curl, CURLOPT_REFERER, 'http://www.rlsnet.ru/mnn_alf_letter_C0.htm');
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
			curl_setopt($curl, CURLOPT_HEADER, 1);
			curl_setopt($curl, CURLOPT_GET, 1);
			curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
			curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:20.0) Gecko/20100101 Firefox/20.0");
			curl_setopt($curl, CURLOPT_NOBODY, 1);
			curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 30);
			curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);

			$out = curl_exec($curl);
			self::$content = $out;
			curl_close($curl);
		}
	}

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

	

} ?>
