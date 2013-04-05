<?php class start extends sn {
	
public static $conf;
public static $options;

function __construct() {
	self::engine();
}

function engine() {
	if (self::getControls()) {
		echo project::engine();
	}
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
