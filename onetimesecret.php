<?php

/**
 * A simple one page script to share secrets.  This is VERY basic
 * copy of https://onetimesecret.com.  You should know they they're
 * open source and WAY more full featured: https://github.com/onetimesecret/onetimesecret
 *
 * To install:
 *  - update the $baseDir path if needed
 *  - test to make sure web server can read/write to that same path to create and remove files
 *  - make sure this script is called "index.php" (and not onetimesecret.php or anything else)
 *
 * see https://github.com/Packet-Clearing-House/gists/blob/master/onetimesecret.php
 *
 */

// update this if it's not your path you installed on
$baseDir = '/var/www/html/www/onetimesecret/';
$baseLink = "https://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]?f=";

// check for customized css and logo
if (is_file('logo.svg')){
    $logoHtml = '<img src="logo.svg" />';
} else {
    $logoHtml = '';
}
if (is_file('css.css')){
    $cssHtml = '<link rel="stylesheet" media="all" type="text/css" href="css.css" />';
} else {
    $cssHtml = '';
}

// init contents var with a form
$contents = 'Enter a secret you want to share: '.
    '<form method="post" action="./" ><input type="text" name="s" autocomplete="off" />' .
    '<input type="submit" name="Get URL" value="Get URL" /> </form>';

// check if we got a file (f) value and show it if possible
if (isset($_GET['f'])){
    $contents = "Nothing here.  If that's not what you expected, contact the person who sent you this link. You can <a href='./'>also share a secret</a>.";
    $file = preg_replace("/[^a-zA-Z0-9\s]/", "", $_GET['f']);
    $file =  $baseDir . $file;
    if(is_file($file) && is_readable($file) && is_writable($file) && is_writable($baseDir)){
        $tmpContents = htmlspecialchars(file_get_contents($file), ENT_QUOTES, 'UTF-8');
        $contents = "Copy this password - it will only be shown once!<br /> <input type='text' value='" . $tmpContents . "' size='50'>";
        unlink($file);
    }
}

// check if we got a secret (s) and write it of possible
$rand = random_str(40);
if (isset($_POST['s']) && is_writable($baseDir . $rand)){
    file_put_contents($baseDir . $rand, $_POST['s']);
    $contents = "View this URL to see your secret. You may do so only once!! <br /> <input type='text' value='" . $baseLink. $rand . "' size='50'>";
}

/**
 * Generate a random string
 * thanks https://stackoverflow.com/a/13212994
 */
function random_str($length)
{
    return substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
}
?>

<!DOCTYPE html>
<html>
<head>
    <?php echo $cssHtml ?>
    <title>One time secret</title>
</head>
<body>
<?php echo $logoHtml ?>
<h1>One time secret</h1>

<p>
    <?php echo $contents ?>
</p>

</body>
</html>
