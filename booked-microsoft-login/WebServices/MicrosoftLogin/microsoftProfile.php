<?php
require_once("microsoftConfig.php");
$code = filter_input(INPUT_GET,'code');
header("Location: ".ROOT."Web/external-auth.php?type=office&code=".$code);
exit;