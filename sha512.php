<?php

// init hash HTML and then check for POST not being empty
$hashResultHtml = '';
if (!empty($_POST['password'])) {

    // generate a secure 10 char hash and use crypt() with 5000 rounds
    // to hash password.
    $secure = true;
    $dataBin = openssl_random_pseudo_bytes(10, $secure);

    $salt = bin2hex($dataBin);
    $hash = crypt($_POST['password'], '$6$rounds=5000$' . $salt . '$');

    // build up HTML response
    // thanks http://stackoverflow.com/a/30810322 !
    $hashResultHtml = "
        Resulting Hash: <br />
        <input type='text' class='js-copytextarea' value='$hash'/><br />
        <button class='js-textareacopybtn'>Copy Hash</button>
        <script>
            var copyTextareaBtn = document.querySelector('.js-textareacopybtn');
      
            copyTextareaBtn.addEventListener('click', function(event) {
                var copyTextarea = document.querySelector('.js-copytextarea');
                copyTextarea.select();
        
                try {
                    var successful = document.execCommand('copy');
                    var msg = successful ? 'successful' : 'unsuccessful';
                } catch (err) {
                }
            });
        </script>";
}
// check for PCH specific css and logo
if (is_file('pch_logo.plain.dark.svg')){
    $logoHtml = '<img src="pch_logo.plain.dark.svg" />';
} else {
    $logoHtml = '';
}
if (is_file('black.css')){
    $cssHtml = '<link rel="stylesheet" media="all" type="text/css" href="black.css" />';
} else {
    $cssHtml = '';
}
?>
<!DOCTYPE html>
<html>
    <head>
        <title>SHA512 HASHER</title>
    </head>
    <body>
        <?php echo $logoHtml ?>
        <h1>SHA512 HASHER</h1>
        <p>
            <form method="post" action="./<?php echo basename(__FILE__ ) ?>" >
                Password To Hash:<br />
                <input type="text" name="password" value="" /><br />
                <input type="submit" name="Generate Hash" value="Generate Hash" />
            </form>
        </p>
        <p>
            <?php echo $hashResultHtml ?>
        </p>
        <?php echo $cssHtml ?>
    </body>
</html>