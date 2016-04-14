<?php

// functiona used to do nonces to fight CSRF at PCH
// NONCE_KEY is a constant defined in config

/**
 * standard way to write nonce to cookie valid for 5 minutes. we write
 * the key of the cookie as "NONCE_KEY + $nonce" so we donate invalidate
 * multiple instances of the same form in the same browser. should be checked
 * with isFromNonce()
 * @param $nonce
 */
public function writeNonceCookie($nonce) {
    $this->writeCookie($nonce, time() + 300, BASEDOMAIN, NONCE_KEY . $nonce);
}

/**
 * look in the passed POST and COOKIE arrays for the NONCE_KEY and make sure they match.
 * value checked is in cookie array is $_COOKIE[NONCE_KEY + $nonce] where we derive the
 * $nonce from $POST[NONCE_KEY]. a little cyclical, but allows for N instances of the
 * same form in the same browser without inadvertent invalidation. should be written
 * with writeNonceCookie()
 * @param $_POST
 * @param $_COOKIE
 * @return bool
 */
public function isFormNonce($cookie, $post){
    $result = false;
    if (isset($post[NONCE_KEY]) && isset($cookie[NONCE_KEY . $post[NONCE_KEY]] ) &&
        $post[NONCE_KEY] == $cookie[NONCE_KEY . $post[NONCE_KEY]]){
        $result = true;
    }
    return $result;
}

/**
 * Standardize how we write cookies.
 * @param $value string to save in cookie
 * @param $expire epoch expire time
 * @param $domain string for domain, default to "pch.net"
 * @param $cookieName defaults to enviroment cookie (eg "PCHSession-www-stage")
 * @param bool $secure boolean defaults to true
 * @param bool $http_only boolean defaults to true
 * @return bool
 */
public function writeCookie($value, $expire, $domain = BASEDOMAIN, $cookieName = COOKIE_NAME,
    $secure = true, $http_only = true){
        return setcookie($cookieName, $value, $expire, "/", $domain, $secure, $http_only);
}

/**
 * Generate a random ID to be used in a session cookie or a URL parameter
 * in password reset
 * @return string 50 chars of openssl_random_pseudo_bytes()
 */
public function getRandomId(){
    $dataBin = openssl_random_pseudo_bytes(50);
    return bin2hex($dataBin);
}


?>