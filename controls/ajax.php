<?php class ajax extends sn {
	
public static $response;

function __construct() {
	self::$response=array();
	if (self::getControls()) {
		if (self::getAction()) {
			echo self::getResponseString(json_encode(self::$response));
		}
	}	
}

function getResponseString($s="") {
	if ($s) {
		if (isset(url::$callback)) {
			return url::$callback."(".$s.");";
		} else {
			return $s;
		}
	}
	return false;
}

function getAction() {
	if (isset(url::$action)) {
		switch(url::$action) {
			case "get":
				self::$response=project::get(); return true;
			break;
		}
	}
	return false;
}

function getControls() {
	foreach (array("url","sql","project","app") as $key) {
		if (!file_exists(project."/controls/".$key.".php")) return false;
		require_once(project."/controls/".$key.".php");
		sn::cl($key);
	}
	return true;	
}

} ?>
