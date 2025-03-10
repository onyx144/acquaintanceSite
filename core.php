<?php
use Google\Cloud\Storage\StorageClient;
function SessionStart(){
    global $app;
    if (session_status() != PHP_SESSION_NONE) {
        return;
    }
    ini_set('session.hash_bits_per_character', 5);
    ini_set('session.serialize_handler', 'php_serialize');
    ini_set('session.use_only_cookies', 1);
    $cookieParams = session_get_cookie_params();
    session_set_cookie_params(
        $cookieParams['lifetime'],
        $cookieParams['path'],
        $cookieParams['domain'],
        false,
        true
    );
    //session_name(strtolower($app));
    session_start();
}
SessionStart();
$config = new stdClass();
function LoadConfig() {
    global $db,$config,$site_url;
    $result = $db->get('options',null,array('option_name','option_value'));
    if (!empty($result)) {
        foreach ($result as $key => $val) {
            $config->{$val->option_name} = $val->option_value;
        }
        if( $config->default_language == 'arabic' ){
            $config->is_rtl = true;
        }else{
            $config->is_rtl = false;
        }

        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";

        $config->uri = $site_url;
    }
    return $config;
}
$config = LoadConfig();
if ($config->developer_mode == 1) {
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
}
$config->reserved_usernames_array = array();
if (!empty($config->reserved_usernames)) {
    $config->reserved_usernames_array = explode(',', $config->reserved_usernames);
}
$config->withdrawal_payment_method = json_decode($config->withdrawal_payment_method,true);
$config->currency_array        = json_decode($config->currency_array,true);
$config->currency_symbol_array        = json_decode($config->currency_symbol_array,true);
if (!empty($config->exchange)) {
    $config->exchange = json_decode($config->exchange,true);
}
$config->cashfree_currency_array = array('INR','USD','BDT','GBP','AED','AUD','BHD','CAD','CHF','DKK','EUR','HKD','JPY','KES','KWD','LKR','MUR','MYR','NOK','NPR','NZD','OMR','QAR','SAR','SEK','SGD','THB','ZAR');
$config->iyzipay_currency_array = array('USD','EUR','GBP','IRR','TL');
$s3_site_url_2         = 'https://test.s3.amazonaws.com';
if (!empty($config->bucket_name_2)) {
    $s3_site_url_2 = "https://{bucket}.s3.amazonaws.com";
    $s3_site_url_2 = str_replace('{bucket}', $config->bucket_name_2, $s3_site_url_2);
}
$config->s3_site_url_2 = $s3_site_url_2;
$theme_url = $config->uri . '/themes/' . $config->theme .'/';
function reset_langs(){
    unset($_SESSION['lang']);
    unset($_SESSION['gender']);
    unset($_SESSION['language']);
    unset($_SESSION['height']);
    unset($_SESSION['hair_color']);
    unset($_SESSION['relationship']);
    unset($_SESSION['work_status']);
    unset($_SESSION['education']);
    unset($_SESSION['ethnicity']);
    unset($_SESSION['body']);
    unset($_SESSION['character']);
    unset($_SESSION['children']);
    unset($_SESSION['friends']);
    unset($_SESSION['pets']);
    unset($_SESSION['live_with']);
    unset($_SESSION['car']);
    unset($_SESSION['religion']);
    unset($_SESSION['smoke']);
    unset($_SESSION['drink']);
    unset($_SESSION['travel']);
    unset($_SESSION['notification']);
}
$lang  = new stdClass();
function GetActiveLang(){
//    global $config;
//    $lang = $config->default_language;
////    if( isset( $_SESSION['activeLang'] ) && !isset( $_COOKIE['activeLang'] ) ){
////        $lang = $_SESSION['activeLang'];
////    }
//    if( isset( $_COOKIE['activeLang'] ) ){
//        $lang = $_COOKIE['activeLang'];
//    }
//    return $lang;

    global $config, $db,$q;
    $lang = $config->default_language;

    if( isset($_GET['language']) && $_GET['language'] !== '' ){
        //$lang = Secure($_GET['language']);
        setcookie("activeLang", Secure($_GET['language']), time() + (10 * 365 * 24 * 60 * 60), '/');
        return Secure($_GET['language']);
    }

    if ( isset( $_COOKIE['JWT'] ) && !isset($_GET['language']) ) {
        $uid = $db->where('session_id', $_COOKIE['JWT'])->getOne('sessions');
        $dafult_user_lang = $db->where('id', $uid['user_id'])->getOne('users');

        if(isset($_COOKIE['activeLang']) && !empty($dafult_user_lang)){
            if( $dafult_user_lang['language'] !== $_COOKIE['activeLang'] ){
                return $_COOKIE['activeLang'];
            }
        }

        if(!empty($dafult_user_lang) && $dafult_user_lang['language'] !== $lang ){
            setcookie("activeLang", $dafult_user_lang['language'], time() + (10 * 365 * 24 * 60 * 60), '/');
            return $dafult_user_lang['language'];
        }
    }else{

    }
    if(isset($_COOKIE['activeLang'])){
        return $_COOKIE['activeLang'];
    }

    return $lang;
}
function LoadLanguage() {
    global $db,$config,$lang;
//    if( isset( $_GET['language'] ) && $_GET['language'] !== '' ){
//        //Dataset::reset();
//        //$_SESSION['activeLang'] = Secure($_GET['language']);
//        setcookie("activeLang", Secure($_GET['language']), time() + (10 * 365 * 24 * 60 * 60), '/');
//    }
    $dafault_lang = GetActiveLang();//$config->default_language;
//    if( !isset( $_SESSION['activeLang'] ) ){
//        $_SESSION['activeLang'] = $config->default_language;
//    }
//    if( isset( $_COOKIE['activeLang'] ) ){
//        $dafault_lang = $_COOKIE['activeLang'];
//    }else {
//        if (isset($_SESSION['activeLang'])) {
//            $dafault_lang = $_SESSION['activeLang'];
//        }
//    }

    $result = $db->arrayBuilder()->get('langs',null,array('lang_key','english',$dafault_lang));
    if (!empty($result)) {
        foreach ($result as $key => $val) {
            if(!empty($val['lang_key'])) {
                if (is_null($val[$dafault_lang]) || $val[$dafault_lang] == '' || empty($val[$dafault_lang])) {
                    $lang->{$val['lang_key']} = $val['english'];
                } else {
                    $lang->{$val['lang_key']} = $val[$dafault_lang];
                }
            }
        }
    }
    return $lang;
}
function ToArray($obj) {
    if (is_object($obj))
        $obj = (array) $obj;
    if (is_array($obj)) {
        $new = array();
        foreach ($obj as $key => $val) {
            $new[$key] = ToArray($val);
        }
    } else {
        $new = $obj;
    }
    return $new;
}
$lang = LoadLanguage();
$dev = true;
function __($key) {
    global $lang , $db,$dev;
    //$lang_array = ToArray($lang);
    $string = trim($key);
    if(empty($string)) return false;
    $stringFromArray = strtolower(preg_replace('/[^a-zA-Z0-9-_\.]/','_', $string));

    if(property_exists($lang,$stringFromArray)){
        return $lang->{$stringFromArray};
    }

//    if (in_array($stringFromArray, array_keys($lang_array))) {
//        if(property_exists($lang,$stringFromArray)){
//            return $lang->{$stringFromArray};
//        }else{
//            return $stringFromArray;
//        }
//    }
    if((GetActiveLang() == 'english')) {
        if($dev === true) {
            $insert = $db->insert('langs', ['lang_key' => $stringFromArray, 'english' => secure($string)]);
        }else{
            return '';
        }
        $lang->{$stringFromArray} = $string;
        return $string;
    }else{
        return $string;
    }
}
function _lang($string){
    global $lang;
    if(empty($string)) return $string;
    $stringFromArray = strtolower(preg_replace('/[^a-zA-Z0-9-_\.]/','_', $string));
    if(property_exists($lang,$stringFromArray)){
        return $lang->{$stringFromArray};
    }else{
        return $string;
    }

}
function GetInterested(){
    global $db;
    $data = array();
    $interested = $db->get('users',null,array('interest'));
    foreach ($interested as $key => $value ){
        if( !empty($value['interest'])) {
            foreach (explode(',',$value['interest']) as $k => $v){
                if( $v !== '') {
                    $data[trim($v)] = null;
                }
            }
        }
    }
    return $data;
}
function ProUsers(){
    global $db;
    $pro_users  = new stdClass();

    $u = auth();
    $limit = 18;
    $logged_user_id = 0;
    if (!empty($u) && !empty($u->id)) {
        if($u->is_pro === "1" || $u->admin === "1" ){
            $limit = 18;
        }

        if($u->is_pro === "0" && $u->admin === "1" ){
            $limit = 17;
        }
        $logged_user_id = $u->id;
    }

    $gender_query = '';
    $genders = GetGenders($u);
    if( strpos( $genders, ',' ) === false ) {
        $gender_query = '`gender` = "'. $genders .'"';
    }else{
        $gender_query = '`gender` IN ('. $genders .')';
    }

    $sql = 'SELECT * FROM `users` WHERE '. $gender_query . ' AND `verified` = "1" AND (`is_pro` = "1" OR `is_boosted` = "1") AND `id` NOT IN (SELECT `like_userid` FROM `likes` WHERE `is_dislike` = "1" AND `user_id` = '.$logged_user_id.') AND `id` NOT IN (SELECT `block_userid` FROM `blocks` WHERE `user_id` = '.$logged_user_id.') AND `id` NOT IN (SELECT `user_id` FROM `blocks` WHERE `block_userid` = '.$logged_user_id.') AND `id` != '.$logged_user_id.' ORDER BY rand(),`boosted_time`,`is_pro`,`pro_time` DESC LIMIT '. $limit;
    $pro_users = $db->rawQuery($sql);

    return ToObject($pro_users);
}
function isAjax() {
    return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';
}
function BlokedUsers($userid = null){
    global $db;
    $blocked = array();
    if( $userid > 0 ){
        $uid = $userid;
    }else{
        $u = auth();
        if (!empty($u) && !empty($u->id)) {
            $uid = $u->id;
        }
        else{
            return $blocked;
        }

    }
    $blocked_users = $db->arrayBuilder()
        ->where( 'b.user_id', $uid )
        ->where( 'verified', '1' )
        ->join( 'users u', 'u.id=b.`block_userid`', 'LEFT')
        ->get( 'blocks b', null, array('u.id', 'u.username'));
    foreach ($blocked_users as $key => $value) {
        $blocked[$value['id']] = $value['username'];
    }

    $blocked_users2 = $db->arrayBuilder()
        ->where( 'b.block_userid', $uid )
        ->where( 'verified', '1' )
        ->join( 'users u', 'u.id=b.`user_id`', 'LEFT')
        ->get( 'blocks b', null, array('u.id', 'u.username'));
    foreach ($blocked_users2 as $key => $value) {
        $blocked[$value['id']] = $value['username'];
    }
    return $blocked;
}
function LikedUsers($userid = null){
    global $db;
    $liked = array();
    if( $userid > 0 ){
        $uid = $userid;
    }else{
        $uid = auth()->id;
    }
    $liked_users = $db->arrayBuilder()
                        ->where( 'l.user_id', $uid )
                        ->where( 'l.is_like', '1' )
                        ->where( 'verified', '1' )
                        ->join( 'users u', 'u.id = l.like_userid', 'LEFT')
                        ->get( 'likes l', null, array('u.id', 'u.username'));
    foreach ($liked_users as $key => $value) {
        $liked[$value['id']] = $value['username'];
    }
    return $liked;
}
function DisLikedUsers($userid = null){
    global $db;
    $liked = array();
    if( $userid > 0 ){
        $uid = $userid;
    }else{
        $uid = auth()->id;
    }
    $liked_users = $db->arrayBuilder()
        ->where( 'l.user_id', $uid )
        ->where( 'l.is_dislike', '1' )
        ->where( 'verified', '1' )
        ->join( 'users u', 'u.id = l.like_userid', 'LEFT')
        ->get( 'likes l', null, array('u.id', 'u.username'));
    foreach ($liked_users as $key => $value) {
        $liked[$value['id']] = $value['username'];
    }
    return $liked;
}
function isUserInBlockList($user,$user_id = null){
    //global $_blocked_users;
    if( $user_id !== null ){
        $blockusers = BlokedUsers($user_id);
    }else{
        $blockusers = BlokedUsers();
    }
    $userid = $user;
    $username = $user;
    $is_blocked = false;
    if (isset($blockusers[$userid])) {
        $is_blocked = true;
    }
    if (in_array($username, $blockusers)) {
        $is_blocked = true;
    }
    return $is_blocked;
}
function isUserInLikeList($user){
    //global $_liked_users;
    $likedusers = LikedUsers();
    $userid = $user;
    $username = $user;
    $is_liked = false;
    if (isset($likedusers[$userid])) {
        $is_liked = true;
    }
    if (in_array($username, $likedusers)) {
        $is_liked = true;
    }
    return $is_liked;
}
function isUserInDisLikeList($user){
    //global $_disliked_users;
    $dislikedusers = DisLikedUsers();
    $userid = $user;
    $username = $user;
    $is_disliked = false;
    if (isset($dislikedusers[$userid])) {
        $is_disliked = true;
    }
    if (in_array($username, $dislikedusers)) {
        $is_disliked = true;
    }
    return $is_disliked;
}
$loggedin_user  = new stdClass();
function auth(){
    global $loggedin_user, $db;
    if (!empty($loggedin_user) && !empty($loggedin_user->id)) {
        return $loggedin_user;
    }
    $token = '';
    if( isset( $_SESSION['user_id'] ) && !empty( $_SESSION['user_id'] ) ){
        $token = $_SESSION['user_id'];
    }else if( isset( $_COOCKIE['JWT'] ) && !empty( $_COOCKIE['JWT'] ) ){
        $token = $_COOCKIE['JWT'];
    }else if( isset( $_POST['access_token'] ) && !empty( $_POST['access_token'] ) ){
        $token = $_POST['access_token'];
    }

    if(IS_LOGGED === true) {

        //if (!isset($_SESSION['userEdited'])) {
            if (isset($loggedin_user->id)) {
                //var_dump($loggedin_user);
                return $loggedin_user;
            }else {
                //}

                $_user = LoadEndPointResource('users');
                if ($_user) {
                    $uid = GetUserFromSessionID($token);
                    $loggedin_user = userData($uid);//$_user->get_user_profile($uid, array(), true);
                    if (isset($_SESSION['userEdited'])) {
                        unset($_SESSION['userEdited']);
                    }
                    return $loggedin_user;
                }
            }
    }else if(IS_LOGGED === false && isEndPointRequest()){
        if( isset ( $_POST['access_token'] ) && !empty( $_POST['access_token'] )){
            $user_id = GetUserFromSessionID(Secure($_POST['access_token']));
            $loggedin_user = userData($user_id);
            return $loggedin_user;
        }else{
            return $loggedin_user;
        }
    }else{
        return $loggedin_user;
    }
}
function userData($username, $cols = array(),$only_token = false){
    global $config;
    if( $username == '' ){
        return false;
    }

    $user = userProfile($username, $cols ,$only_token);
//
//    $_user = LoadEndPointResource('users');
//    if( $_user ) {
//        $user = $_user->get_user_profile($username,$cols,false);
//    }
    return $user;
}
function GetAd($type, $admin = true) {
    global $conn;
    $type      = Secure($type);
    $query_one = "SELECT `code` FROM `site_ads` WHERE `placement` = '{$type}'";
    if ($admin === false) {
        $query_one .= " AND `active` = '1'";
    }
    $sql          = mysqli_query($conn, $query_one);
    $fetched_data = mysqli_fetch_assoc($sql);

    if (empty($fetched_data)) {
        return '';
    }else{
        return htmlspecialchars_decode($fetched_data['code']);
    }
}
function GetUserByID($id) {
    global $conn;
    $id      = Secure($id);
    $query_one = "SELECT * FROM `users` WHERE `id` = {$id}";
    $sql          = mysqli_query($conn, $query_one);
    $fetched_data = mysqli_fetch_assoc($sql);

    if (empty($fetched_data)) {
        return array();
    }else{
        return $fetched_data;
    }
}
function verifiedUser($user){
    global $db,$config;
    if(!isset($user->admin) || !isset($user->active) ||!isset($user->phone_verified) ) return false;
    if( $user->admin == 1 ){
        return true;
    }
    $usermedia_files = $db->where('user_id',$user->id)->getValue('mediafiles','count(id)');
    if($config->emailValidation == "1" && intval($usermedia_files) >= 5){
        return true;
    }
    if( $user->phone_verified == 1 && $user->active == 1 && intval($usermedia_files) >= 6 ){
        return true;
    }else{
        if( $user->active == 1 && intval($usermedia_files) >= 6 ){
            return true;
        }else{
            return false;
        }
    }
    //to verify user profile without uploading 5 image, admin approve user account manually
    if($config->image_verification == "1") {
        if( $user->approved_at > 0 && $user->snapshot !== '' ){
            return true;
        }
    }
}
function FullName($user){
    if( !isset($user->first_name) || !isset($user->last_name) || !isset($user->username)) return '';
    $full_name = trim($user->first_name . ' ' . $user->last_name);
    return (empty($full_name)) ? trim($user->username) : $full_name;
}
function DatasetGetSelect($database_value, $dataset_array, $null_value) {
    $result = '';
    $result .= '<option value="" disabled selected>' . $null_value . '</option>';
    $data = Dataset::load($dataset_array);
    if (isset($data) && !empty($data)) {
        foreach ($data as $key => $val) {
            $result .= '<option value="' . $key . '" ' . (($database_value == $key) ? 'selected' : '') . '>' . $val . '</option>';
        }
        return $result;
    } else {
        return $result;
    }
}
function GetMedia($media, $allow_empty = true) {
    global $config;
    $s3_site_url = 'https://test.s3.amazonaws.com';
    if (!empty($config->bucket_name) && $config->amazone_s3 == 1) {
        $s3_site_url = 'https://'.$config->bucket_name.'.s3.amazonaws.com';
        $media = str_replace("\\", "/", $media);
        //$media = str_replace("/", "%5C", $media);
    }
    $config->s3_site_url = $s3_site_url;

    if ($allow_empty) {
        if (empty($media)) {
            return '';
        }
    }
    if ($config->amazone_s3 == 1) {
        if (empty($config->amazone_s3_key) || empty($config->amazone_s3_s_key) || empty($config->region) || empty($config->bucket_name)) {
            return $config->uri . '/' . $media;
        }
        return $config->s3_site_url . '/' . $media;
    }
    elseif (!empty($config->spaces_key) && $config->spaces == 1) {
        return 'https://' . $config->space_name . '.' . $config->space_region . '.digitaloceanspaces.com/' . $media;
    }
    elseif (!empty($config->wasabi_access_key) && $config->wasabi_storage == 1) {
        $config->wasabi_site_url        = "https://s3.".$config->wasabi_bucket_region.".wasabisys.com";
        if (!empty($config->wasabi_bucket_name)) {
            $config->wasabi_site_url = "https://s3.".$config->wasabi_bucket_region.".wasabisys.com/".$config->wasabi_bucket_name;
            return $config->wasabi_site_url . '/' . $media;
        }
    }
    elseif (!empty($config->ftp_host) && $config->ftp_upload == 1) {
        return "http://" . $config->ftp_endpoint . '/' . $media;
    }
    elseif (!empty($config->cloud_bucket_name) && $config->cloud_upload == 1) {
        return 'https://storage.googleapis.com/' . $config->cloud_bucket_name . '/' . $media;
    }
    elseif ($config->backblaze_storage == 1) {
        if (!empty($config->backblaze_endpoint) && filter_var($config->backblaze_endpoint, FILTER_VALIDATE_URL)) {
            return $config->backblaze_endpoint . "/" . $media;
        }
        return 'https://'.$config->backblaze_bucket_name.'.s3.'.$config->backblaze_bucket_region.'.backblazeb2.com/' . $media;
    }
    //if($_SERVER['DOCUMENT_ROOT'] == 'D:/xampp/htdocs/quickdate'){
    //    return 'https://quickdatescript.com'. '/' . $media;
    //}
    return $config->uri . '/' . $media;
}
function get_verification_photo($id){
    global $db;
    if (empty($id)) {
        return '';
    }
    $img = $db->where('user_id',Secure($id))->getValue('verification_requests','photo');
    return $img;
}
function get_verification_passport($id){
    global $db;
    if (empty($id)) {
        return '';
    }
    $img = $db->where('user_id',Secure($id))->getValue('verification_requests','passport');
    return $img;
}
function timestampdiff($qw,$saw)
{
    $datetime1 = new DateTime("@$qw");
    $datetime2 = new DateTime("@$saw");
    $interval = $datetime1->diff($datetime2);
    return $interval->format('%H');
}
function Secure($string, $br = true, $strip = 0) {
    global $conn;
    if(is_array($string) || is_object($string)) return;
    $string = trim($string);
    $string = mysqli_real_escape_string($conn, $string);
    $string = htmlspecialchars($string, ENT_QUOTES);
    if ($br == true) {
        $string = str_replace('\r\n', ' <br>', $string);
        $string = str_replace('\n\r', ' <br>', $string);
        $string = str_replace('\r', ' <br>', $string);
        $string = str_replace('\n', ' <br>', $string);
    } else {
        $string = str_replace('\r\n', '', $string);
        $string = str_replace('\n\r', '', $string);
        $string = str_replace('\r', '', $string);
        $string = str_replace('\n', '', $string);
    }
    if ($strip == 1) {
        $string = stripslashes($string);
    }
    $string = str_replace('&amp;#', '&#', $string);
    return $string;
}
function url_slug($str, $options = array()) {
    $str      = mb_convert_encoding((string) $str, 'UTF-8', mb_list_encodings());
    $defaults = array(
        'delimiter' => '_',
        'limit' => null,
        'lowercase' => true,
        'replacements' => array(),
        'transliterate' => false
    );
    $options  = array_merge($defaults, $options);
    $char_map = array(
        'À' => 'A',
        'Á' => 'A',
        'Â' => 'A',
        'Ã' => 'A',
        'Ä' => 'A',
        'Å' => 'A',
        'Æ' => 'AE',
        'Ç' => 'C',
        'È' => 'E',
        'É' => 'E',
        'Ê' => 'E',
        'Ë' => 'E',
        'Ì' => 'I',
        'Í' => 'I',
        'Î' => 'I',
        'Ï' => 'I',
        'Ð' => 'D',
        'Ñ' => 'N',
        'Ò' => 'O',
        'Ó' => 'O',
        'Ô' => 'O',
        'Õ' => 'O',
        'Ö' => 'O',
        'Ő' => 'O',
        'Ø' => 'O',
        'Ù' => 'U',
        'Ú' => 'U',
        'Û' => 'U',
        'Ü' => 'U',
        'Ű' => 'U',
        'Ý' => 'Y',
        'Þ' => 'TH',
        'ß' => 'ss',
        'à' => 'a',
        'á' => 'a',
        'â' => 'a',
        'ã' => 'a',
        'ä' => 'a',
        'å' => 'a',
        'æ' => 'ae',
        'ç' => 'c',
        'è' => 'e',
        'é' => 'e',
        'ê' => 'e',
        'ë' => 'e',
        'ì' => 'i',
        'í' => 'i',
        'î' => 'i',
        'ï' => 'i',
        'ð' => 'd',
        'ñ' => 'n',
        'ò' => 'o',
        'ó' => 'o',
        'ô' => 'o',
        'õ' => 'o',
        'ö' => 'o',
        'ő' => 'o',
        'ø' => 'o',
        'ù' => 'u',
        'ú' => 'u',
        'û' => 'u',
        'ü' => 'u',
        'ű' => 'u',
        'ý' => 'y',
        'þ' => 'th',
        'ÿ' => 'y',
        '©' => '(c)',
        'Α' => 'A',
        'Β' => 'B',
        'Γ' => 'G',
        'Δ' => 'D',
        'Ε' => 'E',
        'Ζ' => 'Z',
        'Η' => 'H',
        'Θ' => '8',
        'Ι' => 'I',
        'Κ' => 'K',
        'Λ' => 'L',
        'Μ' => 'M',
        'Ν' => 'N',
        'Ξ' => '3',
        'Ο' => 'O',
        'Π' => 'P',
        'Ρ' => 'R',
        'Σ' => 'S',
        'Τ' => 'T',
        'Υ' => 'Y',
        'Φ' => 'F',
        'Χ' => 'X',
        'Ψ' => 'PS',
        'Ω' => 'W',
        'Ά' => 'A',
        'Έ' => 'E',
        'Ί' => 'I',
        'Ό' => 'O',
        'Ύ' => 'Y',
        'Ή' => 'H',
        'Ώ' => 'W',
        'Ϊ' => 'I',
        'Ϋ' => 'Y',
        'α' => 'a',
        'β' => 'b',
        'γ' => 'g',
        'δ' => 'd',
        'ε' => 'e',
        'ζ' => 'z',
        'η' => 'h',
        'θ' => '8',
        'ι' => 'i',
        'κ' => 'k',
        'λ' => 'l',
        'μ' => 'm',
        'ν' => 'n',
        'ξ' => '3',
        'ο' => 'o',
        'π' => 'p',
        'ρ' => 'r',
        'σ' => 's',
        'τ' => 't',
        'υ' => 'y',
        'φ' => 'f',
        'χ' => 'x',
        'ψ' => 'ps',
        'ω' => 'w',
        'ά' => 'a',
        'έ' => 'e',
        'ί' => 'i',
        'ό' => 'o',
        'ύ' => 'y',
        'ή' => 'h',
        'ώ' => 'w',
        'ς' => 's',
        'ϊ' => 'i',
        'ΰ' => 'y',
        'ϋ' => 'y',
        'ΐ' => 'i',
        'Ş' => 'S',
        'İ' => 'I',
        'Ç' => 'C',
        'Ü' => 'U',
        'Ö' => 'O',
        'Ğ' => 'G',
        'ş' => 's',
        'ı' => 'i',
        'ç' => 'c',
        'ü' => 'u',
        'ö' => 'o',
        'ğ' => 'g',
        'А' => 'A',
        'Б' => 'B',
        'В' => 'V',
        'Г' => 'G',
        'Д' => 'D',
        'Е' => 'E',
        'Ё' => 'Yo',
        'Ж' => 'Zh',
        'З' => 'Z',
        'И' => 'I',
        'Й' => 'J',
        'К' => 'K',
        'Л' => 'L',
        'М' => 'M',
        'Н' => 'N',
        'О' => 'O',
        'П' => 'P',
        'Р' => 'R',
        'С' => 'S',
        'Т' => 'T',
        'У' => 'U',
        'Ф' => 'F',
        'Х' => 'H',
        'Ц' => 'C',
        'Ч' => 'Ch',
        'Ш' => 'Sh',
        'Щ' => 'Sh',
        'Ъ' => '',
        'Ы' => 'Y',
        'Ь' => '',
        'Э' => 'E',
        'Ю' => 'Yu',
        'Я' => 'Ya',
        'а' => 'a',
        'б' => 'b',
        'в' => 'v',
        'г' => 'g',
        'д' => 'd',
        'е' => 'e',
        'ё' => 'yo',
        'ж' => 'zh',
        'з' => 'z',
        'и' => 'i',
        'й' => 'j',
        'к' => 'k',
        'л' => 'l',
        'м' => 'm',
        'н' => 'n',
        'о' => 'o',
        'п' => 'p',
        'р' => 'r',
        'с' => 's',
        'т' => 't',
        'у' => 'u',
        'ф' => 'f',
        'х' => 'h',
        'ц' => 'c',
        'ч' => 'ch',
        'ш' => 'sh',
        'щ' => 'sh',
        'ъ' => '',
        'ы' => 'y',
        'ь' => '',
        'э' => 'e',
        'ю' => 'yu',
        'я' => 'ya',
        'Є' => 'Ye',
        'І' => 'I',
        'Ї' => 'Yi',
        'Ґ' => 'G',
        'є' => 'ye',
        'і' => 'i',
        'ї' => 'yi',
        'ґ' => 'g',
        'Č' => 'C',
        'Ď' => 'D',
        'Ě' => 'E',
        'Ň' => 'N',
        'Ř' => 'R',
        'Š' => 'S',
        'Ť' => 'T',
        'Ů' => 'U',
        'Ž' => 'Z',
        'č' => 'c',
        'ď' => 'd',
        'ě' => 'e',
        'ň' => 'n',
        'ř' => 'r',
        'š' => 's',
        'ť' => 't',
        'ů' => 'u',
        'ž' => 'z',
        'Ą' => 'A',
        'Ć' => 'C',
        'Ę' => 'e',
        'Ł' => 'L',
        'Ń' => 'N',
        'Ó' => 'o',
        'Ś' => 'S',
        'Ź' => 'Z',
        'Ż' => 'Z',
        'ą' => 'a',
        'ć' => 'c',
        'ę' => 'e',
        'ł' => 'l',
        'ń' => 'n',
        'ó' => 'o',
        'ś' => 's',
        'ź' => 'z',
        'ż' => 'z',
        'Ā' => 'A',
        'Č' => 'C',
        'Ē' => 'E',
        'Ģ' => 'G',
        'Ī' => 'i',
        'Ķ' => 'k',
        'Ļ' => 'L',
        'Ņ' => 'N',
        'Š' => 'S',
        'Ū' => 'u',
        'Ž' => 'Z',
        'ā' => 'a',
        'č' => 'c',
        'ē' => 'e',
        'ģ' => 'g',
        'ī' => 'i',
        'ķ' => 'k',
        'ļ' => 'l',
        'ņ' => 'n',
        'š' => 's',
        'ū' => 'u',
        'ž' => 'z'
    );
    $str      = preg_replace(array_keys($options['replacements']), $options['replacements'], $str);
    if ($options['transliterate']) {
        $str = str_replace(array_keys($char_map), $char_map, $str);
    }
    $str = preg_replace('/[^\p{L}\p{Nd}]+/u', $options['delimiter'], $str);
    $str = preg_replace('/(' . preg_quote($options['delimiter'], '/') . '){2,}/', '$1', $str);
    $str = mb_substr($str, 0, ($options['limit'] ? $options['limit'] : mb_strlen($str, 'UTF-8')), 'UTF-8');
    $str = trim($str, $options['delimiter']);
    return $options['lowercase'] ? mb_strtolower($str, 'UTF-8') : $str;
}
function _print_r($a) {
    echo '<pre>' . print_r($a, 1) . '</pre>';
}
function execTime($id = '0', $round = 4, $reset = FALSE) {
    global $console_log;
    static $data = array();
    if (!isset($data[$id]) or $reset) {
        $data[$id] = microtime(true);
        return 0;
    } else {
        if (LOGTIME == true) {
            if (!isEndPointRequest()) {
                $console_log['log'][] = str_pad($id, 60, ".", STR_PAD_RIGHT) . " : \t" . number_format((microtime(true) - $data[$id]), $round) . " Sec";
            }
        } else {
            number_format((microtime(true) - $data[$id]), $round);
        }
    }
}
function write_console() {
    global $console_log;
    echo '<script>';
    if (isset($console_log['log']) && !empty($console_log['log'])) {
        echo 'console.group(\'Application Load time log\');';
        foreach ($console_log['log'] as $key => $value) {
            echo 'console.info(\'' . $value . '\');';
        }
        echo 'console.groupEnd();';
    }
    if (isset($console_log['error']) && !empty($console_log['error'])) {
        echo 'console.groupCollapsed(\'Application Error log. [ ' . count($console_log['error']) . ' ] Issue found.\');';
        foreach ($console_log['error'] as $key => $value) {
            echo 'console.warn("' . escapeJavaScriptText($value) . '");';
        }
        echo 'console.groupEnd();';
    }
    if (isset($console_log['database']) && !empty($console_log['database'])) {
        echo 'console.groupCollapsed(\'Application Database log. [ ' . count($console_log['database']) . ' ] Query found\');';
        $tim = 0;
        foreach ($console_log['database'] as $key => $value) {
            if( isset( $value['time'] ) ) {
                $tim += $value['time'];
            }
            echo 'console.log(JSON.parse("' . escapeJavaScriptText(json_encode($value)) . '"));';
        }
        echo 'console.warn("Total execution time = ' . escapeJavaScriptText($tim) . ' ms.");';
        echo 'console.groupEnd();';
    }
    if (isset($console_log['debug']) && !empty($console_log['debug'])) {
        echo 'console.group(\'Application debug log. [ ' . count($console_log['debug']) . ' ].\');';
        foreach ($console_log['debug'] as $key => $value) {
            echo 'console.group(\'' . $key . '\');';
            echo 'console.log(JSON.parse("' . escapeJavaScriptText(json_encode($value)) . '"));';
            echo 'console.groupEnd();';
        }
        echo 'console.groupEnd();';
    }

    echo 'console.groupCollapsed(\'Application SESSION\');';
    echo 'console.log(JSON.parse("' . escapeJavaScriptText(json_encode($_SESSION)) . '"));';
    echo 'console.groupEnd();';
    echo '</script>';
}
function isEndPointRequest() {
    if (strstr($_SERVER['SCRIPT_NAME'], 'endpoint/index.php') !== 'endpoint/index.php') {
        return false;
    } else {
        return true;
    }
}
function json($array, $code = 0, $exit = true) {
    global $_statusCodes;
    if ($array === null && $code === 0) {
        $code = 204;
    }
    if ($array !== null && $code === 0) {
        $code = 200;
    }
    if (!isEndPointRequest()) {
        $exit = false;
    }else{
        if( !isset( $array['data'] ) ) $array['data'] = array();
        if( !isset( $array['errors'] ) ) $array['errors'] = array('error_id'=>'','error_text'=>'');
        if( !isset( $array['message'] ) ) $array['message'] = '';
    }
    if ($exit) {
        header('HTTP/1.1 ' . $code . '  ' . $_statusCodes[$code]);
        if ($array !== null) {
            header('Content-Type: application/json');
            echo json_encode($array, JSON_UNESCAPED_UNICODE);
        }
        exit();
    } else {
        return $array;
    }
}
function escapeJavaScriptText($string) {
    return str_replace("\n", '\n', str_replace('"', '\"', addcslashes(str_replace("\r", '', (string) $string), "\0..\37'\\")));
}
function route($segment) {
    if ($segment == 0) {
        return null;
    }
    $segment = $segment - 1;
    $path    = array();
    if (ISSET($_GET['path']) && !empty($_GET['path'])) {
        $path = explode('/', $_GET['path']);
        if (!empty($path)) {
            if (empty($path[0])) {
                unset($path[0]);
                $path_ = $path;
                $path = array();
                foreach ($path_ as $key => $new_path) {
                    $path[] = $new_path;
                }
            }
            if (!empty($path[$segment])) {
                return $path[$segment];
            }
        }
    }
}
function render($file,$_data = array()){
    global $config,$_BASEPATH,$_DS,$q;
    $site_url = $config->uri;
    $theme_url = $config->uri . '/themes/' . $config->theme .'/';
    $theme_path = $_BASEPATH . 'themes' . $_DS . $config->theme . $_DS;
    $base_file = $theme_path . 'base.php';
    $file_path = $theme_path . $file . '.php';
    $profile = auth();
    $data = $_data;
    if( file_exists( $file_path ) ){
        require($base_file);
    }else{
        require($theme_path .'404.php');
    }
}
function Time_Elapsed_String($ptime) {
    $etime = time() - $ptime;
    if ($etime < 45) {
        return __('Just now');
    }
    if ($etime >= 45 && $etime < 90) {
        return __('about a minute ago');
    }
    $day = 24 * 60 * 60;
    if ($etime > $day * 30 && $etime < $day * 45) {
        return __('about a month ago');
    }
    $a        = array(
        365 * 24 * 60 * 60 => "year",
        30 * 24 * 60 * 60 => "month",
        24 * 60 * 60 => "day",
        60 * 60 => "hour",
        60 => "minute",
        1 => "second"
    );
    $a_plural = array(
        'year' => __("years"),
        'month' => __("months"),
        'day' => __("days"),
        'hour' => __("hours"),
        'minute' => __("minutes"),
        'second' => __("seconds")
    );
    foreach ($a as $secs => $str) {
        $d = $etime / $secs;
        if ($d >= 1) {
            $r        = round($d);
            return $r . ' ' . ($r > 1 ? $a_plural[$str] : $str) . ' ' . __("ago");
        }
    }
}
function GetIpAddress() {
    if (!empty($_SERVER['HTTP_CLIENT_IP']) && ValidateIpAddress($_SERVER['HTTP_CLIENT_IP'])) {
        return $_SERVER['HTTP_CLIENT_IP'];
    }
    if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        if (strpos($_SERVER['HTTP_X_FORWARDED_FOR'], ',') !== false) {
            $iplist = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            foreach ($iplist as $ip) {
                if (ValidateIpAddress($ip))
                    return $ip;
            }
        } else {
            if (ValidateIpAddress($_SERVER['HTTP_X_FORWARDED_FOR']))
                return $_SERVER['HTTP_X_FORWARDED_FOR'];
        }
    }
    if (!empty($_SERVER['HTTP_X_FORWARDED']) && ValidateIpAddress($_SERVER['HTTP_X_FORWARDED']))
        return $_SERVER['HTTP_X_FORWARDED'];
    if (!empty($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']) && ValidateIpAddress($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']))
        return $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'];
    if (!empty($_SERVER['HTTP_FORWARDED_FOR']) && ValidateIpAddress($_SERVER['HTTP_FORWARDED_FOR']))
        return $_SERVER['HTTP_FORWARDED_FOR'];
    if (!empty($_SERVER['HTTP_FORWARDED']) && ValidateIpAddress($_SERVER['HTTP_FORWARDED']))
        return $_SERVER['HTTP_FORWARDED'];
    return $_SERVER['REMOTE_ADDR'];
}
function ValidateIpAddress($ip) {
    if (strtolower($ip) === 'unknown')
        return false;
    $ip = ip2long($ip);
    if ($ip !== false && $ip !== -1) {
        $ip = sprintf('%u', $ip);
        if ($ip >= 0 && $ip <= 50331647)
            return false;
        if ($ip >= 167772160 && $ip <= 184549375)
            return false;
        if ($ip >= 2130706432 && $ip <= 2147483647)
            return false;
        if ($ip >= 2851995648 && $ip <= 2852061183)
            return false;
        if ($ip >= 2886729728 && $ip <= 2887778303)
            return false;
        if ($ip >= 3221225984 && $ip <= 3221226239)
            return false;
        if ($ip >= 3232235520 && $ip <= 3232301055)
            return false;
        if ($ip >= 4294967040)
            return false;
    }
    return true;
}
function GetBrowser() {
    $ub    = '';
    $u_agent  = $_SERVER['HTTP_USER_AGENT'];
    $bname    = 'Unknown';
    $platform = 'Unknown';
    $version  = '';
    if (preg_match('/linux/i', $u_agent)) {
        $platform = 'linux';
    } elseif (preg_match('/macintosh|mac os x/i', $u_agent)) {
        $platform = 'mac';
    } elseif (preg_match('/windows|win32/i', $u_agent)) {
        $platform = 'windows';
    }
    if (preg_match('/MSIE/i', $u_agent) && !preg_match('/Opera/i', $u_agent)) {
        $bname = 'Internet Explorer';
        $ub    = 'MSIE';
    } elseif (preg_match('/Firefox/i', $u_agent)) {
        $bname = 'Mozilla Firefox';
        $ub    = 'Firefox';
    } elseif (preg_match('/Chrome/i', $u_agent)) {
        $bname = 'Google Chrome';
        $ub    = 'Chrome';
    } elseif (preg_match('/Safari/i', $u_agent)) {
        $bname = 'Apple Safari';
        $ub    = 'Safari';
    } elseif (preg_match('/Opera/i', $u_agent)) {
        $bname = 'Opera';
        $ub    = 'Opera';
    } elseif (preg_match('/Netscape/i', $u_agent)) {
        $bname = 'Netscape';
        $ub    = 'Netscape';
    }
    $known   = array(
        'Version',
        $ub,
        'other'
    );
    $pattern = '#(?<browser>' . join('|', $known) . ')[/ ]+(?<version>[0-9.|a-zA-Z.]*)#';
    if (!preg_match_all($pattern, $u_agent, $matches)) {
    }
    $i = count($matches['browser']);
    if ($i != 1) {
        if (strripos($u_agent, 'Version') < strripos($u_agent, $ub)) {
            $version = $matches['version'][0];
        } else {
            $version = $matches['version'][1];
        }
    } else {
        $version = $matches['version'][0];
    }
    if ($version == null || $version == "") {
        $version = '?';
    }
    return array(
        'userAgent' => $u_agent,
        'name' => $bname,
        'version' => $version,
        'platform' => $platform,
        'pattern' => $pattern
    );
}
function GetDeviceType() {
    $deviceName = '';
    $userAgent    = $_SERVER['HTTP_USER_AGENT'];
    $devicesTypes = array(
        'computer' => array(
            'msie 10',
            'msie 9',
            'msie 8',
            'windows.*firefox',
            'windows.*chrome',
            'x11.*chrome',
            'x11.*firefox',
            'macintosh.*chrome',
            'macintosh.*firefox',
            'opera'
        ),
        'tablet' => array(
            'tablet',
            'android',
            'ipad',
            'tablet.*firefox'
        ),
        'mobile' => array(
            'mobile ',
            'android.*mobile',
            'iphone',
            'ipod',
            'opera mobi',
            'opera mini'
        ),
        'bot' => array(
            'googlebot',
            'mediapartners-google',
            'adsbot-google',
            'duckduckbot',
            'msnbot',
            'bingbot',
            'ask',
            'facebook',
            'yahoo',
            'addthis'
        )
    );
    foreach ($devicesTypes as $deviceType => $devices) {
        foreach ($devices as $device) {
            if (preg_match('/' . $device . '/i', $userAgent)) {
                $deviceName = $deviceType;
            }
        }
    }
    return ucfirst($deviceName);
}
function GetDeviceToken() {
    $finger_print               = array();
    $browser                    = GetBrowser();
    $finger_print['ip']         = GetIpAddress();
    $finger_print['browser']    = $browser['name'] . " " . $browser['version'];
    $finger_print['os']         = $browser['platform'];
    $finger_print['deviceType'] = GetDeviceType();
    $device                     = serialize($finger_print);
    return $device;
}
function LoadEndPointResource( $_resourceName, $IsLoadFromLoadEndPointResource = false ) {
    global $_ENDPOINT_PATH,$_DS;
    $_resourceName = strtolower($_resourceName);
    $_resourceFile = $_ENDPOINT_PATH . 'models' . $_DS . $_resourceName . '.php';
    if (file_exists($_resourceFile)) {
        if(!class_exists($_resourceFile)) {
            require_once($_resourceFile);
            $resource = new $_resourceName($IsLoadFromLoadEndPointResource);
            return $resource;
        }
    }else{
        return false;
    }
}
function userProfile($username, $cols = array(),$only_token = false){
    global $db,$config;
    $profile_completion_fields       = array(
        'email',
        'first_name',
        'last_name',
        'avater',
        'facebook',
        'google',
        'twitter',
        'linkedin',
        'instagram',
        'phone_number',
        'birthday',
        'interest',
        'location',
        'relationship',
        'work_status',
        'education',
        'ethnicity',
        'body',
        'character',
        'children',
        'friends',
        'pets',
        'live_with',
        'car',
        'religion',
        'smoke',
        'drink',
        'travel',
        'music',
        'dish',
        'song',
        'hobby',
        'city',
        'sport',
        'book',
        'movie',
        'colour',
        'tv'
    );
    $profile_completion_fields_count = count($profile_completion_fields);
    $profile_completion_field        = 0;
    $profile_completion_value        = 0;
    $profile_completion_missing      = array();
    $profile                         = new stdClass();
    $columns = array('*');
    if(!empty($cols)){
        $columns = $cols;
    }
    if( $only_token == true ){
        $db->where('id', $username);
    }
    elseif (is_numeric($username)) {
        $db->where('id', $username);
    }
    else{
        $db->Where('username', $username);
        $db->orWhere('email', $username);
    }
    $user = $db->objectBuilder()->getOne('users',$columns);
    if ($db->count > 0) {
        $icon = '';
        if (!empty($user) && !empty($user->is_pro) && $user->is_pro == 1) {
            if ($user->pro_type == 1) {
                $icon = '<span tooltip="'.__( 'premium_member' ).'" flow="down" class="pro_svg"><svg xmlns="http://www.w3.org/2000/svg" height="24px" width="24px" viewBox="0 0 576 512"><!--! Font Awesome Pro 6.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. --><path d="M381.2 150.3L524.9 171.5C536.8 173.2 546.8 181.6 550.6 193.1C554.4 204.7 551.3 217.3 542.7 225.9L438.5 328.1L463.1 474.7C465.1 486.7 460.2 498.9 450.2 506C440.3 513.1 427.2 514 416.5 508.3L288.1 439.8L159.8 508.3C149 514 135.9 513.1 126 506C116.1 498.9 111.1 486.7 113.2 474.7L137.8 328.1L33.58 225.9C24.97 217.3 21.91 204.7 25.69 193.1C29.46 181.6 39.43 173.2 51.42 171.5L195 150.3L259.4 17.97C264.7 6.954 275.9-.0391 288.1-.0391C300.4-.0391 311.6 6.954 316.9 17.97L381.2 150.3z"/></svg></span>';
            }
            elseif ($user->pro_type == 2) {
                $icon = '<span tooltip="'.__( 'premium_member' ).'" flow="down" class="pro_svg"><svg xmlns="http://www.w3.org/2000/svg" height="24px" width="24px" viewBox="0 0 448 512"><!--! Font Awesome Pro 6.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. --><path d="M323.5 51.25C302.8 70.5 284 90.75 267.4 111.1C240.1 73.62 206.2 35.5 168 0C69.75 91.12 0 210 0 281.6C0 408.9 100.2 512 224 512s224-103.1 224-230.4C448 228.4 396 118.5 323.5 51.25zM304.1 391.9C282.4 407 255.8 416 226.9 416c-72.13 0-130.9-47.73-130.9-125.2c0-38.63 24.24-72.64 72.74-130.8c7 8 98.88 125.4 98.88 125.4l58.63-66.88c4.125 6.75 7.867 13.52 11.24 19.9C364.9 290.6 353.4 357.4 304.1 391.9z"/></svg></span>';
            }
            elseif ($user->pro_type == 3) {
                $icon = '<span tooltip="'.__( 'premium_member' ).'" flow="down" class="pro_svg"><svg xmlns="http://www.w3.org/2000/svg" height="24px" width="24px" viewBox="0 0 384 512"><!--! Font Awesome Pro 6.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. --><path d="M240.5 224H352C365.3 224 377.3 232.3 381.1 244.7C386.6 257.2 383.1 271.3 373.1 280.1L117.1 504.1C105.8 513.9 89.27 514.7 77.19 505.9C65.1 497.1 60.7 481.1 66.59 467.4L143.5 288H31.1C18.67 288 6.733 279.7 2.044 267.3C-2.645 254.8 .8944 240.7 10.93 231.9L266.9 7.918C278.2-1.92 294.7-2.669 306.8 6.114C318.9 14.9 323.3 30.87 317.4 44.61L240.5 224z"/></svg></span>';
            }
            elseif ($user->pro_type == 4) {
                $icon = '<span tooltip="'.__( 'premium_member' ).'" flow="down" class="pro_svg"><svg xmlns="http://www.w3.org/2000/svg" height="24px" width="24px" viewBox="0 0 512 512"><!--! Font Awesome Pro 6.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. --><path d="M156.6 384.9L125.7 353.1C117.2 345.5 114.2 333.1 117.1 321.8C120.1 312.9 124.1 301.3 129.8 288H24C15.38 288 7.414 283.4 3.146 275.9C-1.123 268.4-1.042 259.2 3.357 251.8L55.83 163.3C68.79 141.4 92.33 127.1 117.8 127.1H200C202.4 124 204.8 120.3 207.2 116.7C289.1-4.07 411.1-8.142 483.9 5.275C495.6 7.414 504.6 16.43 506.7 28.06C520.1 100.9 516.1 222.9 395.3 304.8C391.8 307.2 387.1 309.6 384 311.1V394.2C384 419.7 370.6 443.2 348.7 456.2L260.2 508.6C252.8 513 243.6 513.1 236.1 508.9C228.6 504.6 224 496.6 224 488V380.8C209.9 385.6 197.6 389.7 188.3 392.7C177.1 396.3 164.9 393.2 156.6 384.9V384.9zM384 167.1C406.1 167.1 424 150.1 424 127.1C424 105.9 406.1 87.1 384 87.1C361.9 87.1 344 105.9 344 127.1C344 150.1 361.9 167.1 384 167.1z"/></svg></span>';
            }

        }
        foreach ($user as $key => $value) {
            $profile->$key = trim($value);
            if (in_array($key, $profile_completion_fields)) {
                if (!empty($value)) {
                    $profile_completion_field++;
                } else {
                    $profile_completion_missing[] = $key;
                }
            }
            $data = Dataset::load($key);
            if (isset($data) && !empty($data)) {
                if (isset($data[$value])) {
                    $profile->{$key . '_txt'} = $data[$value];
                } else {
                    $profile->{$key . '_txt'} = '';
                }
            }
            $profile_completion_value = ((100 * $profile_completion_field) / $profile_completion_fields_count);
            $profile->profile_completion = (int)$profile_completion_value;
            $profile->profile_completion_missing = $profile_completion_missing;
        }
        if (empty($user->email)) {
            return $user;
        }
        
        $profile->verified_final = verifiedUser($user);
        $profile->fullname = FullName($user);
        if ($user->country !== '') {
            $countries = Dataset::load('countries');
            if (isset($countries[$user->country])) {
                $profile->country_txt = $countries[$user->country]['name'];
                if ($user->phone_number !== '') {
                    $profile->full_phone_number = '+' . $countries[$user->country]['isd'] . $user->phone_number;
                }
            }
        } else {
            $profile->country_txt = '-';
        }

        if ($user->phone_verified == 1) {
            $profile->full_phone_number = '+' . $user->phone_number;
        }
        if (!empty($user->web_token)) {
            $profile->web_token = strtolower($user->web_token);
        }
        $profile->password = '**********************';
        if ($user->birthday !== '0000-00-00') {
            $profile->age = floor((time() - strtotime($user->birthday)) / 31556926);
        } else {
            $profile->age = 0;
        }
        if (!empty($user->web_device)) {
            $profile->web_device = unserialize($user->web_device);
        }
        if (isEndPointRequest()) {
            $profile->avater = GetMedia($user->avater, false);
        }else{
            $profile->avater = new stdClass();
            $profile->avater->full = GetMedia(str_replace('_avater.', '_full.', $user->avater), false);
            $profile->avater->avater = GetMedia($user->avater, false);
        }

        

        $full_name = ucfirst(trim($user->first_name . ' ' . $user->last_name));
        $profile->full_name = ($full_name == '') ? ucfirst(trim($user->username)) : $full_name;

        $profile->lastseen_txt = get_time_ago($user->lastseen);
        $profile->lastseen_date = date('c', $user->lastseen);
        $profile->mediafiles = array();
        $mediafiles = $db->where('user_id', trim($user->id))->orderBy('id', 'desc')->get('mediafiles', null, array('id','file','is_private','private_file','is_video','video_file','is_confirmed','is_approved'));
        if ($mediafiles) {
            $mediafilesid = 0;
            foreach ($mediafiles as $mediafile) {
                $mf = array(
                    'id' => $mediafile['id'],
                    'full' => GetMedia($mediafile['file'], false),
                    'avater' => GetMedia(str_replace('_full.', '_avater.', $mediafile['file']), false),
                    'is_private' => $mediafile['is_private'],
                    'private_file_full' => GetMedia( $mediafile['private_file'], false),
                    'private_file_avater' => GetMedia(str_replace('_full.', '_avatar.', $mediafile['private_file']), false),
                    'is_video' => $mediafile['is_video'],
                    'video_file' => GetMedia($mediafile['video_file']),
                    'is_confirmed' => $mediafile['is_confirmed'],
                    'is_approved' => $mediafile['is_approved']
                );
                $profile->mediafiles[] = $mf;
            }
        }

        
        
        $profile->pro_icon = $icon;
        if(isEndPointRequest()){
            unset($profile->web_device);
        }else{
            if(!empty($user->id) && !is_avatar_approved($user->id, $user->avater)) {
                $profile->avater->full = GetMedia($config->userDefaultAvatar, false);
                $profile->avater->avater = GetMedia($config->userDefaultAvatar, false);
            }
        }
        return $profile;
    }else{
        if(!empty($user) && !empty($user->id) && !empty($user->avater) && !is_avatar_approved($user->id, $user->avater)) {
            $profile->avater->full = GetMedia($config->userDefaultAvatar, false);
            $profile->avater->avater = GetMedia($config->userDefaultAvatar, false);
        }
        return $profile;
    }
}
use Aws\S3\S3Client;
function UploadToS3($filename, $options = array()) {
    $path = realpath(dirname(__FILE__)) . DIRECTORY_SEPARATOR;
    $safefilename = str_replace($path, '',$filename );
    $safefilename = str_replace('\\', '/', $safefilename);
    global $config;
    $s3_site_url = 'https://test.s3.amazonaws.com';
    if (!empty($config->bucket_name)) {
        $s3_site_url = 'https://'.$config->bucket_name.'.s3.amazonaws.com';
    }
    $config->s3_site_url = $s3_site_url;

    if ($config->amazone_s3 == 0 && $config->spaces == 0 && $config->wasabi_storage == 0 && $config->ftp_upload == 0 && $config->cloud_upload == 0 && $config->backblaze_storage == 0) {
        return false;
    }
    if ($config->amazone_s3 == 1) {
        if (empty($config->amazone_s3_key) || empty($config->amazone_s3_s_key) || empty($config->region) || empty($config->bucket_name)) {
            return false;
        }
        require_once("libs/s3/vendor/autoload.php");
        $s3 = new S3Client(array(
            'version' => 'latest',
            'region' => $config->region,
            'credentials' => array(
                'key' => $config->amazone_s3_key,
                'secret' => $config->amazone_s3_s_key
            )
        ));
        $s3->putObject(array(
            'Bucket' => $config->bucket_name,
            'Key' => $safefilename,
            'Body' => fopen($filename, 'r+'),
            'ACL' => 'public-read',
            'CacheControl' => 'max-age=3153600'
        ));
        if (empty($options['delete'])) {
            if ($s3->doesObjectExist($config->bucket_name, $filename)) {
                if (empty($options['amazon'])) {
                    @unlink($filename);
                }
                return true;
            }
        } else {
            return true;
        }
    }
    elseif ($config->backblaze_storage == 1) {
        $info = BackblazeConnect(array('apiUrl' => 'https://api.backblazeb2.com',
                                       'uri' => '/b2api/v2/b2_authorize_account',
                                ));
        if (!empty($info)) {
            $result = json_decode($info,true);
            if (!empty($result['authorizationToken']) && !empty($result['apiUrl']) && !empty($result['accountId'])) {
                $info = BackblazeConnect(array('apiUrl' => $result['apiUrl'],
                                               'uri' => '/b2api/v2/b2_get_upload_url',
                                               'authorizationToken' => $result['authorizationToken'],
                                        ));
                if (!empty($info)) {
                    $info = json_decode($info,true);
                    if (!empty($info) && !empty($info['uploadUrl'])) {
                        $info = BackblazeConnect(array('apiUrl' => $info['uploadUrl'],
                                                       'uri' => '',
                                                       'file' => $filename,
                                                       'authorizationToken' => $info['authorizationToken'],
                                                        ));

                        if (!empty($info)) {
                            $info = json_decode($info,true);
                            if (!empty($info) && !empty($info['accountId'])) {
                                if (empty($options['amazon'])) {
                                    @unlink($filename);
                                }
                                return true;
                            }
                        }
                    }
                }
            }
        }
        return false;
    }
    elseif ($config->spaces == 1) {

        require_once 'libs/s3/vendor/autoload.php';

        $s3 = new S3Client(array(
                'version' => 'latest',
                'endpoint' => 'https://' . $config->space_region . '.digitaloceanspaces.com',
                'region' => $config->space_region,
                'credentials' => array(
                    'key' => $config->spaces_key,
                    'secret' => $config->spaces_secret
                )
            ));
        $r = $s3->putObject(array(
            'Bucket' => $config->space_name,
            'Key' => $filename,
            'Body' => fopen($filename, 'r+'),
            'ACL' => 'public-read',
            'CacheControl' => 'max-age=3153600'
        ));
        if (empty($options['delete'])) {
            if ($s3->doesObjectExist($config->space_name, $filename)) {
                if (empty($options['amazon'])) {
                    @unlink($filename);
                }
                return true;
            }
        } else {
            return true;
        }
        return false;
    }
    elseif ($config->wasabi_storage == 1) {
        if (empty($config->wasabi_bucket_name) || empty($config->wasabi_access_key) || empty($config->wasabi_secret_key) || empty($config->wasabi_bucket_region)) {
            return false;
        }
        require_once("libs/s3/vendor/autoload.php");
        $s3 = new S3Client(array(
                'version' => 'latest',
                'endpoint' => 'https://s3.'.$config->wasabi_bucket_region.'.wasabisys.com',
                'region' => $config->wasabi_bucket_region,
                'credentials' => array(
                    'key' => $config->wasabi_access_key,
                    'secret' => $config->wasabi_secret_key
                )
            ));
        $s3->putObject(array(
            'Bucket' => $config->wasabi_bucket_name,
            'Key' => $safefilename,
            'Body' => fopen($filename, 'r+'),
            'ACL' => 'public-read',
            'CacheControl' => 'max-age=3153600'
        ));
        if (empty($options['delete'])) {
            if ($s3->doesObjectExist($config->wasabi_bucket_name, $filename)) {
                if (empty($options['wasabi'])) {
                    //@unlink($filename);
                }
                return true;
            }
        } else {
            return true;
        }
    }
    elseif ($config->ftp_upload == 1) {
        include_once('libs/ftp/vendor/autoload.php');
        $ftp = new \FtpClient\FtpClient();
        $ftp->connect($config->ftp_host, false, $config->ftp_port);
        $login = $ftp->login($config->ftp_username, $config->ftp_password);
        if ($login) {
            if (!empty($config->ftp_path)) {
                if ($config->ftp_path != "./") {
                    $ftp->chdir($config->ftp_path);
                }
            }
            $file_path      = substr($filename, 0, strrpos($filename, '/'));
            $file_path_info = explode('/', $file_path);
            $path           = '';
            if (!$ftp->isDir($file_path)) {
                foreach ($file_path_info as $key => $value) {
                    if (!empty($path)) {
                        $path .= '/' . $value . '/';
                    } else {
                        $path .= $value . '/';
                    }
                    if (!$ftp->isDir($path)) {
                        $mkdir = $ftp->mkdir($path);
                    }
                }
            }
            $ftp->chdir($file_path);
            $ftp->pasv(true);
            if ($ftp->putFromPath($filename)) {
                if (empty($options['delete'])) {
                    if (empty($options['amazon'])) {
                        @unlink($filename);
                    }
                }
                $ftp->close();
                return true;
            }
            $ftp->close();
        }
    }
    elseif ($config->cloud_upload == 1) {
        require_once 'libs/cloud/vendor/autoload.php';
        try {
            $storage       = new StorageClient(array(
                'keyFilePath' => $config->cloud_file_path
            ));
            // set which bucket to work in
            $bucket        = $storage->bucket($config->cloud_bucket_name);
            $fileContent   = file_get_contents($filename);
            // upload/replace file
            $storageObject = $bucket->upload($fileContent, array(
                'name' => str_replace('\\', '/', $filename)
            ));
            if (!empty($storageObject)) {
                if (empty($options['delete'])) {
                    if (empty($options['amazon'])) {
                        @unlink($filename);
                    }
                }
                return true;
            }
        }
        catch (Exception $e) {
            // maybe invalid private key ?
            // print $e;
            // exit();
            return false;
        }
    }

}
function DeleteFromToS3($filename, $options = array()) {
    global $config,$_BASEPATH;
    $filename = str_replace('\\', '/', $filename);
    if( file_exists($_BASEPATH.$filename) ) {
        if( @unlink($_BASEPATH.$filename) !== true ){
            //return false;
        }else{
            //return true;
        }
    }

    if($config->amazone_s3 == 0 && $config->spaces == 0 && $config->wasabi_storage == 0 && $config->ftp_upload == 0 && $config->cloud_upload == 0 && $config->backblaze_storage == 0) {
        return false;
    }
    if($config->amazone_s3 == 1) {
        if (empty($config->amazone_s3_key) || empty($config->amazone_s3_s_key) || empty($config->region) || empty($config->bucket_name)) {
            return false;
        }
        require_once("libs/s3/vendor/autoload.php");
        $s3 = new S3Client(array(
            'version' => 'latest',
            'region' => $config->region,
            'credentials' => array(
                'key' => $config->amazone_s3_key,
                'secret' => $config->amazone_s3_s_key
            )
        ));
        $d = $s3->deleteObject(array(
            'Bucket' => $config->bucket_name,
            'Key' => $filename
        ));
        if (!$s3->doesObjectExist($config->bucket_name, $filename)) {
            return true;
        }
    }
    elseif ($config->backblaze_storage == 1) {
        $info = BackblazeConnect(array('apiUrl' => 'https://api.backblazeb2.com',
                                       'uri' => '/b2api/v2/b2_authorize_account',
                                ));
        if (!empty($info)) {
            $result = json_decode($info,true);
            if (!empty($result['authorizationToken']) && !empty($result['apiUrl']) && !empty($result['accountId'])) {
                $info = BackblazeConnect(array('apiUrl' => $result['apiUrl'],
                                               'uri' => '/b2api/v2/b2_list_file_names',
                                               'authorizationToken' => $result['authorizationToken'],
                                        ));
                if (!empty($info)) {
                    $info = json_decode($info,true);
                    if (!empty($info) && !empty($info['files'])) {
                        foreach ($info['files'] as $key => $value) {
                            if ($value['fileName'] == $filename) {
                                $info = BackblazeConnect(array('apiUrl' => $result['apiUrl'],
                                                               'uri' => '/b2api/v2/b2_delete_file_version',
                                                               'authorizationToken' => $result['authorizationToken'],
                                                               'fileId' => $value['fileId'],
                                                               'fileName' => $value['fileName'],
                                                        ));
                                return true;
                            }
                        }
                    }
                }
            }
        }
    }
    elseif ($config->spaces == 1) {
        require_once 'libs/s3/vendor/autoload.php';

        $s3 = new S3Client(array(
                'version' => 'latest',
                'endpoint' => 'https://' . $config->space_region . '.digitaloceanspaces.com',
                'region' => $config->space_region,
                'credentials' => array(
                    'key' => $config->spaces_key,
                    'secret' => $config->spaces_secret
                )
            ));
        $s3->deleteObject(array(
            'Bucket' => $config->space_name,
            'Key' => $filename
        ));
        if (!$s3->doesObjectExist($config->space_name, $filename)) {
            return true;
        }
        return false;
    }
    elseif ($config->wasabi_storage == 1) {
        require_once("libs/s3/vendor/autoload.php");
        if (empty($config->wasabi_bucket_name) || empty($config->wasabi_access_key) || empty($config->wasabi_secret_key) || empty($config->wasabi_bucket_region)) {
            return false;
        }
        $s3 = new S3Client(array(
                'version' => 'latest',
                'endpoint' => 'https://s3.'.$config->wasabi_bucket_region.'.wasabisys.com',
                'region' => $config->wasabi_bucket_region,
                'credentials' => array(
                    'key' => $config->wasabi_access_key,
                    'secret' => $config->wasabi_secret_key
                )
            ));
        $s3->deleteObject(array(
            'Bucket' => $config->wasabi_bucket_name,
            'Key' => $filename
        ));
        if (!$s3->doesObjectExist($config->wasabi_bucket_name, $filename)) {
            return true;
        }
    }
    elseif ($config->ftp_upload == 1) {
        include_once('libs/ftp/vendor/autoload.php');
        $ftp = new \FtpClient\FtpClient();
        $ftp->connect($config->ftp_host, false, $config->ftp_port);
        $login = $ftp->login($config->ftp_username, $config->ftp_password);
        if ($login) {
            if (!empty($config->ftp_path)) {
                if ($config->ftp_path != "./") {
                    $ftp->chdir($config->ftp_path);
                }
            }
            $file_path      = substr($filename, 0, strrpos($filename, '/'));
            $file_name      = substr($filename, strrpos($filename, '/') + 1);
            $file_path_info = explode('/', $file_path);
            $path           = '';
            if (!$ftp->isDir($file_path)) {
                return false;
            }
            $ftp->chdir($file_path);
            $ftp->pasv(true);
            if ($ftp->remove($file_name)) {
                return true;
            }
        }
    }
    elseif ($config->cloud_upload == 1) {
        require_once 'libs/cloud/vendor/autoload.php';
        try {
            $storage = new StorageClient(array(
                'keyFilePath' => $config->cloud_file_path
            ));
            // set which bucket to work in
            $bucket  = $storage->bucket($config->cloud_bucket_name);
            $object  = $bucket->object(str_replace('\\', '/', $filename));
            $delete  = $object->delete();
            if ($delete) {
                return true;
            }
        }
        catch (Exception $e) {
            // maybe invalid private key ?
            // print $e;
            // exit();
            return false;
        }
    }
}
function DeleteFromLiveToS3($filename, $options = array()) {
    global $config,$_BASEPATH;
    if( file_exists($_BASEPATH.$filename) ) {
        if( @unlink($_BASEPATH.$filename) !== true ){
            return false;
        }else{
            return true;
        }
    }

    if($config->amazone_s3_2 == 0) {
        return false;
    }
    if($config->amazone_s3_2 == 1) {
        if (empty($config->amazone_s3_key_2) || empty($config->amazone_s3_s_key_2) || empty($config->region_2) || empty($config->bucket_name_2)) {
            return false;
        }
        $s3 = new S3Client(array(
            'version' => 'latest',
            'region' => $config->region_2,
            'credentials' => array(
                'key' => $config->amazone_s3_key_2,
                'secret' => $config->amazone_s3_s_key_2
            )
        ));
        $s3->deleteObject(array(
            'Bucket' => $config->bucket_name_2,
            'Key' => $filename
        ));
        if (!$s3->doesObjectExist($config->bucket_name_2, $filename)) {
            return true;
        }
    }
}
function CompressImage($source_url, $destination_url, $quality, $blur = false) {
    global $config;
    $imgsize = list($w, $h) = @getimagesize($source_url);
    $finfof  = $imgsize['mime'];
    $image_c = 'imagejpeg';
    if ($finfof == 'image/jpeg') {
        header("content-type: image/jpeg");
        $image   = @imagecreatefromjpeg($source_url);
        $image_c = 'imagejpeg';
    } else if ($finfof == 'image/gif') {
        $image   = @imagecreatefromgif($source_url);
        $image_c = 'imagegif';
    } else if ($finfof == 'image/png') {
        header("content-type: image/png");
        $image   = @imagecreatefrompng($source_url);
        $image_c = 'imagepng';
    } else if ($finfof == 'image/webp' && function_exists('imagecreatefromwebp')) {
        header("content-type: image/webp");
        $image   = @imagecreatefromwebp($source_url);
        $image_c = 'imagewebp';
    } else {
        header("content-type: image/jpeg");
        $image = @imagecreatefromjpeg($source_url);
    }
    if (function_exists('exif_read_data')) {
        $exif = @exif_read_data($source_url);
        if (!empty($exif['Orientation'])) {
            switch ($exif['Orientation']) {
                case 3:
                    $image = @imagerotate($image, 180, 0);
                    break;
                case 6:
                    $image = @imagerotate($image, -90, 0);
                    break;
                case 8:
                    $image = @imagerotate($image, 90, 0);
                    break;
            }
        }
    }

    if( $blur == true ) {
        $size = array('sm'=>array('w'=>intval($w/4), 'h'=>intval($h/4)),
                   'md'=>array('w'=>intval($w/2), 'h'=>intval($h/2))
                  );                       

        /* Scale by 25% and apply Gaussian blur */
        $sm = imagecreatetruecolor($size['sm']['w'],$size['sm']['h']);
        imagecopyresampled($sm, $image, 0, 0, 0, 0, $size['sm']['w'], $size['sm']['h'], $w, $h);

        for ($x=1; $x <=40; $x++){
            imagefilter($sm, IMG_FILTER_GAUSSIAN_BLUR, 999);
        } 

        imagefilter($sm, IMG_FILTER_SMOOTH,99);
        imagefilter($sm, IMG_FILTER_BRIGHTNESS, 10);       
        
        $md = imagecreatetruecolor($size['md']['w'], $size['md']['h']);
        imagecopyresampled($md, $sm, 0, 0, 0, 0, $size['md']['w'], $size['md']['h'], $size['sm']['w'], $size['sm']['h']);
        imagedestroy($sm);

        for ($x=1; $x <=25; $x++){
            imagefilter($md, IMG_FILTER_GAUSSIAN_BLUR, 999);
        } 

        imagefilter($md, IMG_FILTER_SMOOTH,99);
        imagefilter($md, IMG_FILTER_BRIGHTNESS, 10);        

        /* Scale result back to original size */
        imagecopyresampled($image, $md, 0, 0, 0, 0, $w, $h, $size['md']['w'], $size['md']['h']);
        imagedestroy($md);  

        @imagejpeg($image, $destination_url);
    }
    @$image_c($image, $destination_url);
    return $destination_url;
}
function Resize_Crop_Image($max_width, $max_height, $source_file, $dst_dir, $quality = 80) {
    $imgsize = _getimagesize($source_file);
    $width   = $imgsize[0];
    $height  = $imgsize[1];
    $mime    = $imgsize['mime'];
    $image   = 'imagejpeg';
    switch ($mime) {
        case 'image/gif':
            $image_create = 'imagecreatefromgif';
            break;
        case 'image/png':
            $image_create = 'imagecreatefrompng';
            break;
        case 'image/jpeg':
            $image_create = 'imagecreatefromjpeg';
            break;
        case 'image/webp':
            $image_create = 'imagecreatefromwebp';
            break;
        default:
            return false;
            break;
    }
    $dst_img = @imagecreatetruecolor($max_width, $max_height);
    $src_img = @$image_create($source_file);
    if (function_exists('exif_read_data')) {
        $exif          = @exif_read_data($source_file);
        $another_image = false;
        if (!empty($exif['Orientation'])) {
            switch ($exif['Orientation']) {
                case 3:
                    $src_img = @imagerotate($src_img, 180, 0);
                    @imagejpeg($src_img, $dst_dir, $quality);
                    $another_image = true;
                    break;
                case 6:
                    $src_img = @imagerotate($src_img, -90, 0);
                    @imagejpeg($src_img, $dst_dir, $quality);
                    $another_image = true;
                    break;
                case 8:
                    $src_img = @imagerotate($src_img, 90, 0);
                    @imagejpeg($src_img, $dst_dir, $quality);
                    $another_image = true;
                    break;
            }
        }
        if ($another_image == true) {
            $imgsize = getimagesize($dst_dir);
            if ($width > 0 && $height > 0) {
                $width  = $imgsize[0];
                $height = $imgsize[1];
            }
        }
    }
    @$width_new = $height * $max_width / $max_height;
    @$height_new = $width * $max_height / $max_width;
    if ($width_new > $width) {
        $h_point = (($height - $height_new) / 2);
        @imagecopyresampled($dst_img, $src_img, 0, 0, 0, $h_point, $max_width, $max_height, $width, $height_new);
    } else {
        $w_point = (($width - $width_new) / 2);
        @imagecopyresampled($dst_img, $src_img, 0, 0, $w_point, 0, $max_width, $max_height, $width_new, $height);
    }
    @imagejpeg($dst_img, $dst_dir, $quality);
    if ($dst_img)
        @imagedestroy($dst_img);
    if ($src_img)
        @imagedestroy($src_img);
    return true;
}
function fetchDataFromURL($url = '') {
    if (empty($url)) {
        return false;
    }
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POST, false);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7');
    curl_setopt($ch, CURLOPT_HEADER, false);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    return curl_exec($ch);
}
function isUserBlocked($userid){
    global $db;
    $blocked = false;
    if( isset( $_SESSION['JWT'] ) ){
        $user = $db->objectBuilder()
            ->where('user_id', auth()->id )
            ->where('block_userid', $userid )
            ->getValue('blocks','count(*)');
        if( $user > 0 ){
            $blocked = true;
        }
        return $blocked;
    }else{
        return false;
    }
}
function isUserReported($userid){
    global $db;
    $reported = false;
    if( isset( $_SESSION['JWT'] ) ){
        $user = $db->objectBuilder()
            ->where('user_id', auth()->id )
            ->where('report_userid', $userid )
            ->getValue('reports','count(*)');
        if( $user > 0 ){
            $reported = true;
        }
        return $reported;
    }else{
        return false;
    }
}
function isUserLiked($userid){
    global $db;
    $liked = false;
    if( isset( $_SESSION['JWT'] ) ){
        $user = $db->objectBuilder()
            ->where('user_id', auth()->id )
            ->where('like_userid', $userid )
            ->where('is_like', '1' )
            ->getValue('likes','count(*)');
        if( $user > 0 ){
            $liked = true;
        }
        return $liked;
    }else{
        return false;
    }
}
function isUserDisliked($userid){
    global $db;
    $disliked = false;
    if( isset( $_SESSION['JWT'] ) ){
        $user = $db->objectBuilder()
            ->where('user_id', auth()->id )
            ->where('like_userid', $userid )
            ->where('is_dislike', '1' )
            ->getValue('likes','count(*)');
        if( $user > 0 ){
            $disliked = true;
        }
        return $disliked;
    }else{
        return false;
    }
}
function GenerateKey($minlength = 20, $maxlength = 20, $uselower = true, $useupper = true, $usenumbers = true, $usespecial = false) {
    $charset = '';
    if ($uselower) {
        $charset .= 'abcdefghijklmnopqrstuvwxyz';
    }
    if ($useupper) {
        $charset .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    }
    if ($usenumbers) {
        $charset .= '123456789';
    }
    if ($usespecial) {
        $charset .= '~@#$%^*()_+-={}|][';
    }
    if ($minlength > $maxlength) {
        $length = mt_rand($maxlength, $minlength);
    } else {
        $length = mt_rand($minlength, $maxlength);
    }
    $key = '';
    for ($i = 0; $i < $length; $i++) {
        $key .= $charset[(mt_rand(0, strlen($charset) - 1))];
    }
    return $key;
}
function GetUserFromSessionID($session_id, $platform = 'web') {
    global $conn, $db;
    if (empty($session_id)) {
        return false;
    }
    $session_id = Secure($session_id);
    $query      = mysqli_query($conn, "SELECT * FROM `sessions` WHERE `session_id` = '{$session_id}' LIMIT 1");
    $fetched_data = mysqli_fetch_assoc($query);
    if (empty($fetched_data['platform_details']) && $fetched_data['platform'] == 'web') {
        $ua = serialize(GetBrowser());
        if (isset($fetched_data['platform_details'])) {
            $update_session = $db->where('id', $fetched_data['id'])->update('sessions', array('platform_details' => $ua));
        }
    }
    return $fetched_data['user_id'];
}
function CreateLoginSession($user_id = 0, $platform = 'web') {
    global $conn, $db;
    if (empty($user_id)) {
        return false;
    }
    $user_id   = Secure($user_id);
    $hash      = sha1(rand(111111111, 999999999)) . md5(microtime()) . rand(11111111, 99999999) . md5(rand(5555, 9999));
    $query_two = mysqli_query($conn, "DELETE FROM `sessions` WHERE `session_id` = '{$hash}'");
    if ($query_two) {
        $ua = serialize(getBrowser());
        $query_three = mysqli_query($conn, "INSERT INTO `sessions` (`user_id`, `session_id`, `platform`, `platform_details`, `time`) VALUES('{$user_id}', '{$hash}', '{$platform}', '$ua'," . time() . ")");
        if ($query_three) {
            return $hash;
        }
    }
}
function IsLogged() {
    if (isset($_SESSION['user_id']) && !empty($_SESSION['user_id'])) {
        $id = GetUserFromSessionID($_SESSION['user_id']);
        if (is_numeric($id) && !empty($id)) {
            return true;
        }
    } else if (!empty($_COOKIE['JWT']) && !empty($_COOKIE['JWT'])) {
        $id = GetUserFromSessionID($_COOKIE['JWT']);
        if (is_numeric($id) && !empty($id)) {
            return true;
        }
    } else {
        return false;
    }
}
DEFINE('IS_LOGGED', IsLogged());
function IsGotCredit()
{
    global $config,$db;
    if (IS_LOGGED == false) {
        return false;
    }
    $user_id = auth()->id;
    if($config->credit_earn_system == 0) return false;
    $max_days = (int)$config->credit_earn_max_days;
    $day_amount = (int)$config->credit_earn_day_amount;

    $today_start = strtotime(date('M')." ".date('d').", ".date('Y')." 12:00am");
    $today_end = strtotime(date('M')." ".date('d').", ".date('Y')." 11:59pm");
    $count = $db->where('user_id', $user_id)->where('created_at',$today_start,'>=')->where('created_at',$today_end,'<=')->objectbuilder()->get('daily_credits');
    if (!empty($count)) {
        foreach ($count as $key => $value) {
            if ($value->added == 1) {
                return false;
            }
        }
        if ($config->credit_earn_max_days <= count($count)) {
            $db->where('user_id', $user_id)->update('daily_credits',['added' => 1]);
            $db->where('id', $user_id)->update('users',array(
                "balance" => $db->inc($day_amount)
            ));
            return true;
        }
        
    }
    return false;
}

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;
function SendEmail($to, $subject, $message, $db = false) {
    error_reporting(1);
    ini_set('display_startup_errors', true);
    ini_set('display_errors', true);

    global $config,$conn,$_LIBS;
    require_once($_LIBS . "PHPMailer/vendor/autoload.php");
    $mail = new PHPMailer;
    if (empty($to)) {
        return false;
    }
    if (empty($subject)) {
        return false;
    }
    if (empty($message)) {
        return false;
    }
    $message = str_replace(array("\r\n", "\r", "\n"), "", $message);
    $message_body    = mysqli_real_escape_string($conn, $message);
    if ($db === true) {
        $u = auth();
        $user_id   = Secure($u->id);
        $query_one = mysqli_query($conn, "INSERT INTO `emails` (`email_to`, `user_id`, `subject`, `message`) VALUES ('{$to}', '{$user_id}', '{$subject}', '{$message_body}')");
        if ($query_one) {
            return true;
        }
        return true;
        exit();
    }
    if ($config->smtp_or_mail == 'mail') {
        $mail->IsMail();
    } else if ($config->smtp_or_mail == 'smtp') {
        $mail->isSMTP();
        $mail->Host          = $config->smtp_host;
        $mail->SMTPAuth      = true;
        $mail->SMTPKeepAlive = true;
        $mail->Username      = $config->smtp_username;
        $mail->Password      = openssl_decrypt($config->smtp_password, "AES-128-ECB", 'mysecretkey1234');
        $mail->SMTPSecure    = $config->smtp_encryption;
        $mail->Port          = $config->smtp_port;
        $mail->SMTPOptions   = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true
            )
        );
    }
    $mail->setFrom($config->siteEmail, $config->site_name);
    $mail->CharSet = 'utf-8';
    $mail->IsHTML(true);
    $mail->addAddress($to);
    $mail->Subject = $subject;
    $mail->MsgHTML($message_body);
    $sent = $mail->send();
    $mail->ClearAddresses();
    return $sent;
}
use Twilio\Rest\Client;
use Twilio\Exceptions\RestException;
function SendSMS($to, $message) {
    global $config,$_LIBS;

    if (empty($to)) {
        return false;
    }
    if (empty($message)) {
        return false;
    }
    if ($config->twilio_provider == 1) {

        $account_sid = $config->sms_twilio_username;
        $auth_token  = $config->sms_twilio_password;

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, "https://api.twilio.com/2010-04-01/Accounts/".$account_sid."/Messages");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "Body=".$message."&From=".$config->sms_t_phone_number."&To=".$to);
        curl_setopt($ch, CURLOPT_USERPWD, $account_sid . ':' . $auth_token);

        $headers = array();
        $headers[] = 'Content-Type: application/x-www-form-urlencoded';
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);
        }
        curl_close($ch);
        if (!empty($result)) {
            $result = simplexml_load_string($result);
            if (!empty($result->Message) && !empty($result->Message->Status)) {
                return true;
            }
        }
        return false;
    }
    elseif ($config->bulksms_provider == 1) {
        require_once($_LIBS . "int-send_sms.php");
        $post_body = seven_bit_sms($config->bulksms_username, $config->bulksms_password, $message, $to );
        $result = send_bulk_message( $post_body, $url );
        if( $result['success'] ) {
            return true;
        }
        else {
            return false;
        }
    }
    elseif ($config->messagebird_provider == 1) {
        require_once($_LIBS . "messagebird/vendor/autoload.php");
        try {
            $messageBird = new \MessageBird\Client($config->messagebird_key);
            $messageB = new MessageBird\Objects\Message;
            $messageB->originator = $config->messagebird_phone;
            $messageB->recipients = array($to);
            $messageB->body = $message;
            $response = $messageBird->messages->create($messageB);
            return true;
        }
        catch (RestException $e) {
            return false;
        }
    }
    elseif ($config->infobip_provider == 1) {
        $username = $config->infobip_username;
        $password  = $config->infobip_password;
        $to          = Secure($to);
        if (empty($to) || empty($config->infobip_username) || empty($config->infobip_password) ) {
            return false;
        }

        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://ejmd4q.api.infobip.com/sms/2/text/advanced',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS =>'{"messages":[{"destinations":[{"to":"'.$to.'"}],"from":"InfoSMS","text":"'.$message.'"}]}',
            CURLOPT_HTTPHEADER => array(
                'Authorization: Basic '.base64_encode($username.':'.$password),
                'Content-Type: application/json',
                'Accept: application/json'
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        $responseBody = json_decode($response);
        if (!empty($responseBody) && !empty($responseBody->messages) && !empty($responseBody->messages[0])) {
            return true;
        }
        return false;
    }
    elseif ($config->msg91_provider == 1) {
        if (empty($config->msg91_authKey)) {
            return false;
        }
        //Your authentication key
        $authKey = $config->msg91_authKey;
        //Multiple mobiles numbers separated by comma
        $mobileNumber = $to;
        //Sender ID,While using route4 sender id should be 6 characters long.
        $senderId = rand(111111,999999);
        //Define route
        $route = "4";
        //Prepare you post parameters
        $postData = array(
            'authkey' => $authKey,
            'mobiles' => $mobileNumber,
            'message' => $message,
            'sender' => $senderId,
            'route' => $route
        );
        if (!empty($config->msg91_dlt_id)) {
            $postData["DLT_TE_ID"] = $config->msg91_dlt_id;
        }
        //API URL
        $url="http://api.msg91.com/api/sendhttp.php";
        // init the resource
        $ch = curl_init();
        curl_setopt_array($ch, array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => $postData
            //,CURLOPT_FOLLOWLOCATION => true
        ));
        //Ignore SSL certificate verification
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        //get response
        $output = curl_exec($ch);
        //Print error if any
        if(curl_errno($ch))
        {
            return false;
        }
        curl_close($ch);
        return true;

    }
    return false;
}
function ToObject($array) {
    $object = new stdClass();
    foreach ($array as $key => $value) {
        if (is_array($value)) {
            $value = ToObject($value);
        }
        if (isset($value)) {
            $object->$key = $value;
        }
    }
    return $object;
}
use PayPal\Api\Payer;
use PayPal\Api\Item;
use PayPal\Api\ItemList;
use PayPal\Api\Details;
use PayPal\Api\Amount;
use PayPal\Api\Transaction;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;
function PayUsingPayPal($product, $price, $mode = 'credits', $ReturnUrl = '', $CancelUrl = '') {
    global $config,$q;
    require_once("libs/paypal.php");
    if (empty($product)) {
        return false;
    }
    if (empty($price) || !is_numeric($price)) {
        return false;
    }
    $product  = Secure($product);
    $price = $sum    = Secure($price);
    if (!empty($config->currency_array) && in_array($config->paypal_currency, $config->currency_array) && $config->paypal_currency != $config->currency && !empty($config->exchange) && !empty($config->exchange[$config->paypal_currency])) {
        $sum= (int)(($sum * $config->exchange[$config->paypal_currency]));
    }
    if ($ReturnUrl == '') {
        $ReturnUrl = $config->uri . '/aj/paypal/payment_success?userid=' . auth()->id . '&mode=' . $mode . '&price=' . $price . '&product=' . urlencode($product);
    }
    if ($CancelUrl == '') {
        $CancelUrl = $config->uri . '/aj/paypal/payment_cenceled?userid=' . auth()->id . '&mode=' . $mode . '&price=' . $price . '&product=' . urlencode($product);
    }






    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url . '/v2/checkout/orders');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, '{
      "intent": "CAPTURE",
      "purchase_units": [
            {
                "items": [
                    {
                        "name": "Wallet Replenishment",
                        "description":  "Pay For ' . $config->site_name.'",
                        "quantity": "1",
                        "unit_amount": {
                            "currency_code": "'.$config->paypal_currency.'",
                            "value": "'.$sum.'"
                        }
                    }
                ],
                "amount": {
                    "currency_code": "'.$config->paypal_currency.'",
                    "value": "'.$sum.'",
                    "breakdown": {
                        "item_total": {
                            "currency_code": "'.$config->paypal_currency.'",
                            "value": "'.$sum.'"
                        }
                    }
                }
            }
        ],
        "application_context":{
            "shipping_preference":"NO_SHIPPING",
            "return_url": "'.$ReturnUrl.'",
            "cancel_url": "'.$CancelUrl.'"
        }
    }');

    $headers = array();
    $headers[] = 'Content-Type: application/json';
    $headers[] = 'Authorization: Bearer '.$q['paypal_access_token'];
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    $result = curl_exec($ch);
    if (curl_errno($ch)) {
        echo 'Error:' . curl_error($ch);
    }
    curl_close($ch);
    $result = json_decode($result);
    if (!empty($result) && !empty($result->links) && !empty($result->links[1]) && !empty($result->links[1]->href)) {
        $data = array(
            'type' => 'SUCCESS',
            'url' => $result->links[1]->href
        );
        return $data;
    }
    elseif(!empty($result->message)){
        $data = array(
            'type' => 'ERROR',
            'details' => $result->message
        );
        return $data;
    }











    // require_once("lib/PayPal/vendor/autoload.php");
    // $paypal = new \PayPal\Rest\ApiContext(new \PayPal\Auth\OAuthTokenCredential($config->paypal_id, $config->paypal_secret));
    // $paypal->setConfig(array(
    //     'mode' => $config->paypal_mode
    // ));
    
    // $payer    = new Payer();
    // $payer->setPaymentMethod('paypal');
    // $item = new Item();
    // $item->setName($product)->setQuantity(1)->setPrice($sum)->setCurrency($currency);
    // $itemList = new ItemList();
    // $itemList->setItems(array(
    //     $item
    // ));
    // $details = new Details();
    // $details->setSubtotal($sum);
    // $amount = new Amount();
    // $amount->setCurrency($currency)->setTotal($sum)->setDetails($details);
    // $transaction = new Transaction();
    // $transaction->setAmount($amount)->setItemList($itemList)->setDescription('Pay For ' . $config->site_name)->setInvoiceNumber(uniqid());
    // $redirectUrls = new RedirectUrls();
    // if ($ReturnUrl == '') {
    //     $ReturnUrl = $config->uri . '/aj/paypal/payment_success?userid=' . auth()->id . '&mode=' . $mode . '&price=' . $price . '&product=' . urlencode($product);
    // }
    // if ($CancelUrl == '') {
    //     $CancelUrl = $config->uri . '/aj/paypal/payment_cenceled?userid=' . auth()->id . '&mode=' . $mode . '&price=' . $price . '&product=' . urlencode($product);
    // }
    // $redirectUrls->setReturnUrl($ReturnUrl)->setCancelUrl($CancelUrl);
    // $payment = new Payment();
    // $payment->setIntent('sale')->setPayer($payer)->setRedirectUrls($redirectUrls)->setTransactions(array(
    //     $transaction
    // ));
    // try {
    //     $payment->create($paypal);
    // }
    // catch (Exception $e) {
    //     $data = array(
    //         'type' => 'ERROR',
    //         'details' => json_decode($e->getData())
    //     );
    //     if (empty($data['details'])) {
    //         $data['details'] = json_decode($e->getCode());
    //     }
    //     return $data;
    // }
    // $data = array(
    //     'type' => 'SUCCESS',
    //     'url' => $payment->getApprovalLink()
    // );
    // return $data;
}
function PayPalCheckPayment($token) {
    global $config,$q;

    require_once("libs/paypal.php");

    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url . '/v2/checkout/orders/'.$token.'/capture');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);

    $headers = array();
    $headers[] = 'Content-Type: application/json';
    $headers[] = 'Authorization: Bearer '.$q['paypal_access_token'];
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    $result = curl_exec($ch);
    if (curl_errno($ch)) {
        header("Location: $site_url/payment-error?reason=invalid-payment");
        exit();
    }
    curl_close($ch);
    if (!empty($result)) {
        $result = json_decode($result);
        if (!empty($result->status) && $result->status == 'COMPLETED') {
            return true;
        }
    }
    return array(
        'type' => 'ERROR',
        'details' => 'Payment Declined'
    );









    // require_once("lib/PayPal/vendor/autoload.php");
    // $paypal = new \PayPal\Rest\ApiContext(new \PayPal\Auth\OAuthTokenCredential($config->paypal_id, $config->paypal_secret));
    // $paypal->setConfig(array(
    //     'mode' => $config->paypal_mode
    // ));
    // $payment = Payment::get($paymentId, $paypal);
    // $execute = new PaymentExecution();
    // $execute->setPayerId($PayerID);
    // try {
    //     $result = $payment->execute($execute, $paypal);
    // }
    // catch (Exception $e) {
    //     return json_decode($e->getData(), true);
    // }
    // return true;
}
function SeoUri($link) {
    global $config;
    return $config->uri . '/' . $link;
}
function PayUsingStripe($product, $price, $ReturnUrl = '', $CancelUrl = '') {
    global $config, $paypal;
    if (empty($product)) {
        return false;
    }
    if (empty($price) || !is_numeric($price)) {
        return false;
    }
    $data     = array();
    $product  = Secure($product);
    $price    = Secure($price);
    $currency = strtolower($config->currency);
    $token    = '';
    try {
        $customer = \Stripe\Customer::create(array(
            'source' => $token
        ));
        $charge   = \Stripe\Charge::create(array(
            'customer' => $customer->id,
            'amount' => $price,
            'currency' => $currency
        ));
        if ($charge) {
            $data = array(
                'status' => 200,
                'error' => 'Payment successfully'
            );
        }
    }
    catch (Exception $e) {
        $data = array(
            'status' => 400,
            'error' => $e->getMessage()
        );
        return $data;
    }
}
function getMessageContainer($message){
    $class = "";
    $avater = "";
    $sent = "";
    if( $message->type == 'received' ){
        $class = "r";
        $avater = '     <div class="m_avatar"><img src="'. GetMedia($message->from_avater) .'" alt="'. $message->to_name .'" title="'. $message->to_name .'"></div>' . "\n";
    }else if( $message->type == 'sent' ){
        $class = "s";
        if( $message->seen > 0  ){
            $sent .= '      <div class="seen" title="'. $message->seen.'" data-seen="'.$message->seen.'">' . "\n";
            $sent .= '          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="#03A9F4" d="M0.41,13.41L6,19L7.41,17.58L1.83,12M22.24,5.58L11.66,16.17L7.5,12L6.07,13.41L11.66,19L23.66,7M18,7L16.59,5.58L10.24,11.93L11.66,13.34L18,7Z" /></svg>' . "\n";
            $sent .= '      </div>' . "\n";
        }
    }
    $response = '<div class="messages messages--'.$message->type.'" data-msgid="'.$message->id.'" data-lastid="MSGID">' . "\n";
    $response .= '  <div class="msg_'.$class.'_combo">' . "\n";
    $response .= $avater;
    $response .= '      <div class="m_msg_part">' . "\n";
    $response .= 'CONTENT';
    $response .= '      </div>' . "\n";
    $response .= $sent;
    $response .= '  </div>' . "\n";
    $response .= '</div>' . "\n";
    return $response;
}
function renderTextMessage(&$message,$msg){
    if( (int)$msg['from'] === (int)auth()->id ){
        $message .= '<div class="message" data-messageid="'.$msg['id'].'">' . makeClickableLinks(trim(nl2br( $msg['_message'] )),'#ffffff') . '</div>';
    }else{
        $message .= '<div class="message" data-messageid="'.$msg['id'].'">' . makeClickableLinks(trim(nl2br( $msg['_message'] ))) . '</div>';
    }
}
function makeClickableLinks($s,$color='') {
    return stripslashes( preg_replace('@(https?://([-\w\.]+[-\w])+(:\d+)?(/([\w/_\.#-]*(\?\S+)?[^\.\s])?)?)@', '<a href="$1" style="color: '.$color.'" target="_blank">$1</a>', $s) );
}
function renderMediaMessage(&$message,$msg){
    $css = "gifimg";
    $mediafile = $msg['_message'];
    if(strpos($mediafile,'giphy') === false){
        $mediafile = GetMedia($msg['_message']);
        $css = "image";
    }
    $message .= '<div class="message '.$css.'" data-messageid="'.$msg['id'].'"><a class="fancybox" href="'. $mediafile .'" rel="gallery'.$msg['id'].'" tabIndex="-1" data-fancybox="gallery'.$msg['id'].'"><img src="' . $mediafile . '" style="background: #dddddd;" data-src="' . $mediafile . '"></a></div>';
}
function renderStickerMessage(&$message,$msg){
    $message .= '<div class="message sticker" data-messageid="'.$msg['id'].'"><a class="fancybox" href="'. GetMedia($msg['_message']) .'" rel="gallery'.$msg['id'].'" tabIndex="-1" data-fancybox="gallery'.$msg['id'].'"><img src="' . GetMedia($msg['_message']) . '"></a></div>';
}
function chat_messages_sortFunction( $a, $b ) {
    return strtotime($a["created_at"]) - strtotime($b["created_at"]);
}
function logout($redirect = true){
    global $db,$config;
    $token = '';
    if( isset($_SESSION['user_id']) && $_SESSION['user_id'] !== '' ) {
        $db->where('web_token', $_SESSION['user_id'])->update('users', array('web_token' => null, 'web_token_created_at' => '0', 'web_device' => null));
        $db->where('session_id', $_SESSION['user_id'])->delete('sessions');
    }
    setcookie('JWT', '', 1, '/');
    setcookie('verify_email', '', 1, '/');
    setcookie('verify_phone', '', 1, '/');
    setcookie('quickdating', '', 1, '/');
    setcookie('src', '', 1, '/');
    setcookie('mode', '', 1, '/');
    if( isset($_SESSION['JWT'] ) ){
        unset($_SESSION['JWT']);
        unset($_SESSION['user_id']);
    }
    session_write_close();
    @session_destroy();
    if($redirect) {
        header('Location: ' . $config->uri);
        exit();
    }
}
function generate_chat_messages_convirsation($user_id,$to,$offset = 0,$show_unreadline = true,$lastmsg = 0,$prev=false){
    global $db,$console_log;

    $operator = '>';
    if( $prev == true ){
        $operator = '<';
    }
    $limit = array($offset,40);

    $db->where("m.id  " . $operator .  ' ' . (int)$lastmsg);
    $db->where("( (`to` = ? and `from` = ?) OR (`to` = ? and `from` = ?) )", Array($user_id,$to,$to,$user_id));
    $db->join("stickers s", "m.sticker=s.id", "LEFT");
    $db->join("users u", "m.`from`=u.id", "LEFT");
    $db->join("users u1", "m.`to`=u1.id", "LEFT");
    $db->orderBy('m.created_at','DESC');

    $chat_messages = $db->arrayBuilder()->get('messages m',$limit,array('m.id','u.username as from_name','u.avater as from_avater','u1.username as to_name','u1.avater as to_avater','m.`from`','m.`to`','m.text','m.media','m.from_delete','m.to_delete','s.file as sticker','m.created_at','m.seen'));
    if( !empty( $chat_messages ) ) {
        $messagesList = '';
        $MessageContainer = '';
        $chat = '';
        $is_from_delete = false;
        usort($chat_messages, "chat_messages_sortFunction");
        $_msg = LoadEndPointResource('messages');
        $last_message = count($chat_messages) - 1;
        $is_unread_show = false;
        $is_unread_showen = false;
        $unread_count = 0;
        $unread_txt = '<div class="unread_msg_line"> {{unread_count}} ' . __('Unread Messages') . '&nbsp;&nbsp;</div>';
        if ($chat_messages) {

            foreach ($chat_messages as $key => $value) {
                if (!empty($value['text'])) {
                    $chat_messages[$key]['_function'] = 'renderTextMessage';
                    $chat_messages[$key]['_message'] = $value['text'];
                }
                if (!empty($value['media'])) {
                    $chat_messages[$key]['_function'] = 'renderMediaMessage';
                    $chat_messages[$key]['_message'] = $value['media'];
                }
                if (!empty($value['sticker'])) {
                    $chat_messages[$key]['_function'] = 'renderStickerMessage';
                    $chat_messages[$key]['_message'] = $value['sticker'];
                }
                if ($value['to'] !== $user_id) {
                    $chat_messages[$key]['type'] = 'sent';
                    $chat_messages[$key]['class'] = 's';
                } else {
                    $chat_messages[$key]['type'] = 'received';
                    $chat_messages[$key]['class'] = 'r';
                }
                if (isset($chat_messages[$key + 1])) {
                    if ($chat_messages[$key + 1]['to'] !== $value['to']) {
                        $chat_messages[$key]['container'] = getMessageContainer(ToObject($chat_messages[$key]));
                        $MessageContainer = getMessageContainer(ToObject($chat_messages[$key]));
                    }
                    if ($chat_messages[$key]['seen'] === 0) {
                        $is_unread_show = true;
                        if ($_msg) {

                            if ($user_id == $value['to']) {

                                if ($_msg->setMessageSeen($value['id'], $value['from'])) {
                                    $unread_count++;
                                }
                            }
                        }
                    }
                } else {
                    $chat_messages[$last_message]['container'] = getMessageContainer(ToObject($chat_messages[$key]));
                    $MessageContainer = getMessageContainer(ToObject($chat_messages[$key]));
                    if ($chat_messages[$key]['seen'] === 0) {
                        $is_unread_show = true;
                        if ($_msg) {
                            if ($user_id == $value['to']) {
                                if ($_msg->setMessageSeen($value['id'], $value['from'])) {
                                    $unread_count++;
                                }
                            }
                        }
                    }
                    $unread_txt = str_replace('{{unread_count}}', $unread_count, $unread_txt);
                }
                if (isset($chat_messages[$key]['_function'])) {
                    if ($chat_messages[$key]['from'] == $user_id && $chat_messages[$key]['from_delete'] == 1) {

                    } else if ($chat_messages[$key]['to'] == $user_id && $chat_messages[$key]['to_delete'] == 1) {

                    } else {
                        $chat .= call_user_func_array($chat_messages[$key]['_function'], array(&$chat, $chat_messages[$key]));
                    }
                }
                if ($is_unread_show == true && $is_unread_showen === false) {
                    $is_unread_showen = true;
                }
                if (isset($chat_messages[$key]['container'])) {
                    $messagesList .= str_replace(array('CONTENT', 'MSGID'), array($chat, $chat_messages[$key]['id']), $MessageContainer);
                    $chat = '';
                }
            }
        } else {
            $db->where('`to`', $user_id)->where('`from`', $to)->where('seen', 0)->update('messages', array('seen' => time()));
        }


        if ($show_unreadline) {
            $messagesList = str_replace('{{unread_text}}', $unread_txt, $messagesList);
        } else {
            $messagesList = str_replace('{{unread_text}}', '', $messagesList);
        }
        return $messagesList;
    }else{
        return '';
    }
}
function userEmailNotification($recipient_id){
    $u = LoadEndPointResource( 'users' )->get_user_profile($recipient_id);
    $data = array(
        'email_on_profile_view'             => $u->email_on_profile_view,
        'email_on_new_message'              => $u->email_on_new_message,
        'email_on_profile_like'             => $u->email_on_profile_like,
        'email_on_purchase_notifications'   => $u->email_on_purchase_notifications,
        'email_on_special_offers'           => $u->email_on_special_offers,
        'email_on_announcements'            => $u->email_on_announcements,
        'email_on_get_gift'                 => $u->email_on_get_gift,
        'email_on_got_new_match'            => $u->email_on_got_new_match,
        'email_on_chat_request'             => $u->email_on_chat_request
    );
    if (!in_array(1, $data)) {
        return false;
    } else {
        return $data;
    }
}
function sendNotificationEmail($notification){
    global $db,$config;
    $send_mail = false;
    $userEmailNotification = $db->where('id', $notification['recipient_id'])->getOne('users',array('id','username','first_name','last_name','email','email_on_profile_view','email_on_profile_like','email_on_get_gift','email_on_got_new_match','email_on_new_message','email_on_purchase_notifications','email_on_chat_request'));

    $u = auth();

    if($config->emailNotification == 1 && $userEmailNotification !== false) {
        if (($notification['type'] == 'visit') && $userEmailNotification['email_on_profile_view'] == 1) {
            $send_mail = true;
        }
        if (($notification['type'] == 'like') && $userEmailNotification['email_on_profile_like'] == 1) {
            $send_mail = true;
        }
        if (($notification['type'] == 'send_gift') && $userEmailNotification['email_on_get_gift'] == 1) {
            $send_mail = true;
        }
        if (($notification['type'] == 'got_new_match') && $userEmailNotification['email_on_got_new_match'] == 1) {
            $send_mail = true;
        }
        if (($notification['type'] == 'message') && $userEmailNotification['email_on_new_message'] == 1) {
            $send_mail = true;
        }
        if (($notification['type'] == 'approve_receipt' || $notification['type'] == 'disapprove_receipt') && $userEmailNotification['email_on_purchase_notifications'] == 1) {
            $send_mail = true;
        }
        if (($notification['type'] == 'accept_chat_request' || $notification['type'] == 'decline_chat_request') && $userEmailNotification['email_on_chat_request'] == 1) {
            $send_mail = true;
        }
    }
    if ($send_mail == true) {
        $body = Emails::parse('notification-email', array(
            'full_name' => $u->full_name,
            'username' => $u->username,
            'avater' => $u->avater->avater,
            'contents' => $notification['contents'],
            'url' => $notification['url']
        ));
        SendEmail($userEmailNotification['email'], 'New notification', $body,true);
    }
    return true;
}
function CanSendEmails() {
    global $config;
    if (IS_LOGGED == false) {
        return false;
    }
    // if ($config->smtp_or_mail == 'mail') {
    //     return false;
    // }
    $can_send_time = time() - 180;
    $u = auth();
    if ($u->last_email_sent > $can_send_time) {
        return false;
    }
    return true;
}
function SendMessageFromDB() {
    global $config,$conn,$_LIBS;
    require_once($_LIBS . "PHPMailer/vendor/autoload.php");
    $mail = new PHPMailer;
    if (IS_LOGGED == false) {
        return false;
    }
    $data = array();
    if (CanSendEmails() === false) {
        return false;
    }
    $u = auth();
    $user_id   = Secure($u->id);
    $query_one = " SELECT * FROM `emails` WHERE `user_id` = {$user_id} ORDER BY `id` DESC";
    $sql       = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($sql) < 1) {
        return false;
    }

    if ($config->smtp_or_mail == 'mail') {
        $mail->IsMail();
    } else if ($config->smtp_or_mail == 'smtp') {
        $mail->isSMTP();
        $mail->Host          = $config->smtp_host;
        $mail->SMTPAuth      = true;
        $mail->SMTPKeepAlive = true;
        $mail->Username      = $config->smtp_username;
        $mail->Password      = openssl_decrypt($config->smtp_password, "AES-128-ECB", 'mysecretkey1234');
        $mail->SMTPSecure    = $config->smtp_encryption;
        $mail->Port          = $config->smtp_port;
        $mail->SMTPOptions   = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true
            )
        );
    } else {
        return false;
    }
    $mail->setFrom($config->siteEmail, $config->site_name);
    $send          = false;
    $mail->CharSet = 'utf-8';

    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $mail->addAddress($fetched_data['email_to']);
        $mail->Subject = $fetched_data['subject'];
        $mail->MsgHTML($fetched_data['message']);
        $mail->IsHTML(true);
        $send = $mail->send();
        if($send){
            $query_one_  = "DELETE FROM `emails` WHERE `user_id` = {$user_id} AND `id`= " . $fetched_data['id'];
            $sql_        = mysqli_query($conn, $query_one_);
        }
        $mail->ClearAddresses();
    }

    $query_one__ = "UPDATE `users` SET `last_email_sent` = " . time() . " WHERE `id` = {$user_id}";
    $sql__       = mysqli_query($conn, $query_one__);
    return $send;
}
function sendOneSignalPush($data = array()){
    global $db,$config;
    if( $config->push == 0 ){
        return false;
    }
    if( !isset( $data['img'] ) ){
        $data['img'] = $config->uri . '/themes/' . $config->theme .'/assets/img/icon.png';
    }

    $notify['userdata'] = $db->where('id', $data['data']['notifier_id'])->getOne('users',array('id','username','first_name','last_name','avater'));

    if( !isset( $notify['userdata']['username'] ) ){
        $data['title'] = $config->site_name;
    }else{
        $data['title'] = $notify['userdata']['username'] . ' . ' . $config->site_name;
    }
    if( !isset( $data['url'] ) ){
        $data['url'] = $config->uri;
    }
    $fields = array(
        'app_id' => $config->push_id,
        'headings' => array("en" => $data['title']),
        'isAnyWeb' => true,
        'chrome_web_icon' => $data['img'],
        'firefox_icon' => $data['img'],
        'chrome_web_image' => $data['img'],
        //'url' => $data['url'],
    );
    //if( isset( $data['data'] ) ){
    $notify = array();
    $notify['type'] = $data['data']['type'];
    $notify['userdata'] = $db->where('id', $data['data']['notifier_id'])->getOne('users',array('id','username','first_name','last_name','avater'));
    $notify['userdata']['avater'] = GetMedia($notify['userdata']['avater']);
    $fields['data'] = $notify;
    //}
    if( !isset( $data['player_ids'] )){
        $fields['included_segments'] = array('All');
    }else{
        $fields['include_player_ids'] = $data['player_ids'];
    }
    $notification_text = Dataset::load('notification');
    if (isset($notification_text[$data['data']['type']])) {
        $txt = $notification_text[$data['data']['type']];
        $fields['contents'] = array("en" => $txt);
    }else{
        $fields['contents'] = array("en" => '');
    }
    $ch = curl_init();
    $onesignal_post_url = "https://onesignal.com/api/v1/notifications";
    curl_setopt($ch, CURLOPT_URL, $onesignal_post_url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json',
        'Authorization: Basic ' . $config->push_key
    ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HEADER, false);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $response = curl_exec($ch);
    $curl_http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    if ($curl_http_code === 200) {
        if( isset( $data['id'] ) && !empty( $data['id'] ) ){
            $db->where('id', (int)$data['id'])->update('notifications',array('push_sent'=>time()));
        }
        return true;
    }else{
        return false;
    }
}
function audit($type,$data){
    global $db;
    return false;

    $txt = '';
    if( is_array($data) ) {
        $txt = "Key                             : Value\n";
        $txt .= "--------------------------------------------------------------\n";
        foreach ($data as $key => $value) {
            $txt .= "|" . str_pad($key, 30, ".", STR_PAD_RIGHT) . "\t: " . ( is_array($value) ? json_encode($value) : $value ) . "\n";
        }
    }else{
        $txt = $data;
    }
    $item = array();
    $item['type'] = $type;
    $item['message'] = $txt;
    $item['user_id'] = auth()->id;
    $item['created_at'] = time();
    $db->insert('audits',$item);
}
function get_time_ago($time_stamp)
{
    //_lang
//    $strings = [
//        'suffixAgo' => _lang("ago"),
//        'suffixFromNow' => _lang("from now"),
//        'inPast'=> _lang("any moment now"),
//        'seconds'=> _lang("Just now"),
//        'minute' => _lang("about a minute ago"),
//        'minutes' => _lang("%d minutes ago"),
//        'hour'=> _lang("about an hour ago"),
//        'hours'=> _lang("%d hours ago"),
//        'day'=> _lang("a day ago"),
//        'days'=> _lang("%d days ago"),
//        'month'=> _lang("about a month ago"),
//        'months'=> _lang("%d months ago"),
//        'year'=> _lang("about a year ago"),
//        'years'=> _lang("%d years ago"),
//    ];

    $strings = [
        'suffixAgo' => __("ago"),
        'suffixFromNow' => __("from now"),
        'inPast'=> __("any moment now"),
        'seconds'=> __("Just now"),
        'minute' => __("about a minute ago"),
        'minutes' => __("%d minutes ago"),
        'hour'=> __("about an hour ago"),
        'hours'=> __("%d hours ago"),
        'day'=> __("a day ago"),
        'days'=> __("%d days ago"),
        'month'=> __("about a month ago"),
        'months'=> __("%d months ago"),
        'year'=> __("about a year ago"),
        'years'=> __("%d years ago"),
    ];

//    $strings = [
//        'suffixAgo' => "ago",
//        'suffixFromNow' => "from now",
//        'inPast'=> "any moment now",
//        'seconds'=> "Just now",
//        'minute' => "about a minute ago",
//        'minutes' => "%d minutes ago",
//        'hour'=> "about an hour ago",
//        'hours'=> "%d hours ago",
//        'day'=> "a day ago",
//        'days'=> "%d days ago",
//        'month'=> "about a month ago",
//        'months'=> "%d months ago",
//        'year'=> "about a year ago",
//        'years'=> "%d years ago",
//    ];

    $time_difference = time() - $time_stamp;
    $seconds =  $time_difference ;
    $minutes = $seconds / 60;
    $hours = $minutes / 60;
    $days = $hours / 24;
    $years = $days / 365;

    if( $seconds < 45 ){
        return str_replace('%d',floor($seconds), $strings['seconds']);
    }
    if( $seconds < 90 ){
        return str_replace('%d',1, $strings['minute']);
    }
    if( $minutes < 45 ){
        return str_replace('%d',floor($minutes), $strings['minutes']);
    }
    if( $minutes < 90 ){
        return str_replace('%d',1, $strings['hour']);
    }
    if( $hours < 24 ){
        return str_replace('%d',floor($hours), $strings['hours']);
    }
    if( $hours < 42 ){
        return str_replace('%d',1, $strings['day']);
    }
    if( $days < 30 ){
        return str_replace('%d',floor($days), $strings['days']);
    }
    if( $days < 45 ){
        return str_replace('%d',1, $strings['month']);
    }
    if( $days < 365 ){
        return str_replace('%d',floor($days / 30), $strings['months']);
    }
    if( $years < 1.5 ){
        return str_replace('%d',1, $strings['year']);
    }else{
        return str_replace('%d',floor($years), $strings['years']);
    }
}
function get_time_ago_string($time_stamp, $divisor, $time_unit)
{
    $time_difference = strtotime("now") - $time_stamp;
    $time_units      = round(floor($time_difference / $divisor));
    settype($time_units, 'string');
    if( $time_difference < 45 ){
        return __('Just now');
    }else if( $time_difference < 90 ){
        return __('about a minute ago');
    }else if( $time_difference < 45*60 ){
        return str_replace('%d',$time_units, __('%d minutes ago'));
    }else if( $time_difference < 90*60 ){
        return __('about an hour ago');
    }else if( $time_difference < 24*60*60 ){
        return str_replace('%d',$time_units, __('%d hours ago'));
    }else if( $time_difference < 42*60*60 ){
        return __('a day ago');
    }else if( $time_difference < 30*24*60*60 ){
        return str_replace('%d',$time_units,__('%d days ago'));
    }else if( $time_difference < 45*24*60*60 ){
        return __('about a month ago');
    }else if( $time_difference < 365*24*60*60 ){
        return str_replace('%d',$time_units,__('%d months ago'));
    }else if( $time_difference < 1.5*365*24*60*60 ){
        return __('about a year ago');
    }else{
        return str_replace('%d',$time_units,__('%d years ago'));
    }
}
function minifyhtml($input) {
    if($input === "") return $input;
    $input = preg_replace_callback('#<([^\/\s<>!]+)(?:\s+([^<>]*?)\s*|\s*)(\/?)>#s', function($matches) {
        return '<' . $matches[1] . preg_replace('#([^\s=]+)(\=([\'"]?)(.*?)\3)?(\s+|$)#s', ' $1$2', $matches[2]) . $matches[3] . '>';
    }, str_replace("\r", "", $input));
    if(strpos($input, ' style=') !== false) {
        $input = preg_replace_callback('#<([^<]+?)\s+style=([\'"])(.*?)\2(?=[\/\s>])#s', function($matches) {
            return '<' . $matches[1] . ' style=' . $matches[2] . minify_css($matches[3]) . $matches[2];
        }, $input);
    }
    if(strpos($input, '</style>') !== false) {
        $input = preg_replace_callback('#<style(.*?)>(.*?)</style>#is', function($matches) {
            return '<style' . $matches[1] .'>'. minify_css($matches[2]) . '</style>';
        }, $input);
    }
    return preg_replace(
        array(
            '#<(img|input)(>| .*?>)#s',
            '#(<!--.*?-->)|(>)(?:\n*|\s{2,})(<)|^\s*|\s*$#s',
            '#(<!--.*?-->)|(?<!\>)\s+(<\/.*?>)|(<[^\/]*?>)\s+(?!\<)#s',
            '#(<!--.*?-->)|(<[^\/]*?>)\s+(<[^\/]*?>)|(<\/.*?>)\s+(<\/.*?>)#s',
            '#(<!--.*?-->)|(<\/.*?>)\s+(\s)(?!\<)|(?<!\>)\s+(\s)(<[^\/]*?\/?>)|(<[^\/]*?\/?>)\s+(\s)(?!\<)#s',
            '#(<!--.*?-->)|(<[^\/]*?>)\s+(<\/.*?>)#s',
            '#<(img|input)(>| .*?>)<\/\1>#s',
            '#(&nbsp;)&nbsp;(?![<\s])#',
            '#(?<=\>)(&nbsp;)(?=\<)#',
            '#\s*<!--(?!\[if\s).*?-->\s*|(?<!\>)\n+(?=\<[^!])#s'
        ),
        array(
            '<$1$2</$1>',
            '$1$2$3',
            '$1$2$3',
            '$1$2$3$4$5',
            '$1$2$3$4$5$6$7',
            '$1$2$3',
            '<$1$2',
            '$1 ',
            '$1',
            ""
        ),
        $input);
}
function minify_css($input) {
    if(trim($input) === "") return $input;
    return preg_replace(
        array(
            '#("(?:[^"\\\]++|\\\.)*+"|\'(?:[^\'\\\\]++|\\\.)*+\')|\/\*(?!\!)(?>.*?\*\/)|^\s*|\s*$#s',
            '#("(?:[^"\\\]++|\\\.)*+"|\'(?:[^\'\\\\]++|\\\.)*+\'|\/\*(?>.*?\*\/))|\s*+;\s*+(})\s*+|\s*+([*$~^|]?+=|[{};,>~+]|\s*+-(?![0-9\.])|!important\b)\s*+|([[(:])\s++|\s++([])])|\s++(:)\s*+(?!(?>[^{}"\']++|"(?:[^"\\\]++|\\\.)*+"|\'(?:[^\'\\\\]++|\\\.)*+\')*+{)|^\s++|\s++\z|(\s)\s+#si',
            '#(?<=[\s:])(0)(cm|em|ex|in|mm|pc|pt|px|vh|vw|%)#si',
            '#:(0\s+0|0\s+0\s+0\s+0)(?=[;\}]|\!important)#i',
            '#(background-position):0(?=[;\}])#si',
            '#(?<=[\s:,\-])0+\.(\d+)#s',
            '#(\/\*(?>.*?\*\/))|(?<!content\:)([\'"])([a-z_][a-z0-9\-_]*?)\2(?=[\s\{\}\];,])#si',
            '#(\/\*(?>.*?\*\/))|(\burl\()([\'"])([^\s]+?)\3(\))#si',
            '#(?<=[\s:,\-]\#)([a-f0-6]+)\1([a-f0-6]+)\2([a-f0-6]+)\3#i',
            '#(?<=[\{;])(border|outline):none(?=[;\}\!])#',
            '#(\/\*(?>.*?\*\/))|(^|[\{\}])(?:[^\s\{\}]+)\{\}#s'
        ),
        array(
            '$1',
            '$1$2$3$4$5$6$7',
            '$1',
            ':0',
            '$1:0 0',
            '.$1',
            '$1$3',
            '$1$2$4$5',
            '$1$2$3',
            '$1:0',
            '$1$2'
        ),
        $input);
}
function minify_js($input) {
    if(trim($input) === "") return $input;
    return preg_replace(
        array(
            '#\s*("(?:[^"\\\]++|\\\.)*+"|\'(?:[^\'\\\\]++|\\\.)*+\')\s*|\s*\/\*(?!\!|@cc_on)(?>[\s\S]*?\*\/)\s*|\s*(?<![\:\=])\/\/.*(?=[\n\r]|$)|^\s*|\s*$#',
            '#("(?:[^"\\\]++|\\\.)*+"|\'(?:[^\'\\\\]++|\\\.)*+\'|\/\*(?>.*?\*\/)|\/(?!\/)[^\n\r]*?\/(?=[\s.,;]|[gimuy]|$))|\s*([!%&*\(\)\-=+\[\]\{\}|;:,.<>?\/])\s*#s',
            '#;+\}#',
            '#([\{,])([\'])(\d+|[a-z_][a-z0-9_]*)\2(?=\:)#i',
            '#([a-z0-9_\)\]])\[([\'"])([a-z_][a-z0-9_]*)\2\]#i'
        ),
        array(
            '$1',
            '$1$2',
            '}',
            '$1$3',
            '$1.$3'
        ),
        $input);
}
function DeleteSpamWarning() {
    global $conn,$db;
    $day_duration   = 86400;
    $query_one = "SELECT `id`, `spam_warning` FROM `users` WHERE `spam_warning` > 0 ORDER BY `id` ASC";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        if ($fetched_data['spam_warning'] < (time() - $day_duration)) {
            $db->where('id',$fetched_data['id'])->update('users',array('spam_warning'=>'0'));
        }
    }
    return true;
}
function DeleteExpiredProMemebership() {
    global $conn,$db;
    $week_duration   = 604800;
    $month_duration    = 2629743;
    $year_duration = 31556926;
    $life_duration    = 0;

    $data      = array();
    $query_one = "SELECT `id`, `is_pro`, `pro_type`, `pro_time` FROM `users` WHERE `is_pro` = '1' ORDER BY `id` ASC";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $update_data = false;
        switch ($fetched_data['pro_type']) {
            case '1':
                if ($fetched_data['pro_time'] < (time() - $week_duration)) {
                    $update_data = true;
                }
                break;
            case '2':
                if ($fetched_data['pro_time'] < (time() - $month_duration)) {
                    $update_data = true;
                }
                break;
            case '3':
                if ($fetched_data['pro_time'] < (time() - $year_duration)) {
                    $update_data = true;
                }
                break;
            case '4':
                if ($life_duration > 0) {
                    if ($fetched_data['pro_time'] < (time() - $life_duration)) {
                        $update_data = true;
                    }
                }
                break;
        }
        if ($update_data == true) {
            $db->where('id',$fetched_data['id'])->update('users',array('pro_time'=>'0','pro_type'=>'0','is_pro'=>'0'));
        }
    }
    return true;
}
function DeleteExpiredBoosts() {
    global $config,$db;
    $boost_duration   = time() - ( $config->boost_expire_time * 60 );
    $boosted = $db->objectBuilder()->where('is_boosted','1')->get('users',null,array('id','boosted_time'));
    foreach ($boosted as $key => $value){
        if( isset( $value->boosted_time ) ){
            if($value->boosted_time <= $boost_duration){
                $db->where('id',$value->id)->update('users',array('is_boosted'=>'0','boosted_time'=>'0'));
            }
        }
    }
    return true;
}
function DeleteExpiredXvisits() {
    global $config,$db;
    $_duration   = time() - ( $config->xvisits_expire_time * 60 );
    $boosted = $db->objectBuilder()->where('user_buy_xvisits','1')->get('users',null,array('id','xvisits_created_at'));
    foreach ($boosted as $key => $value){
        if( isset( $value->xvisits_created_at ) ){
            if($value->xvisits_created_at <= $_duration){
                $db->where('id',$value->id)->update('users',array('user_buy_xvisits'=>'0','xvisits_created_at'=>'0'));
            }
        }
    }
    return true;
}
function DeleteExpiredXmatches() {
    global $config,$db;
    $_duration   = time() - ( $config->xmatche_expire_time * 60 );
    $boosted = $db->objectBuilder()->where('user_buy_xmatches','1')->get('users',null,array('id','xmatches_created_at'));
    foreach ($boosted as $key => $value){
        if( isset( $value->xmatches_created_at ) ){
            if($value->xmatches_created_at <= $_duration){
                $db->where('id',$value->id)->update('users',array('user_buy_xmatches'=>'0','xmatches_created_at'=>'0'));
            }
        }
    }
    return true;
}
function DeleteExpiredHotUsers() {
    global $config,$db;
    $week_duration   = 604800;
    $month_duration  = 2629743;
    $year_duration   = 31556926;
    $_duration   = time() - $week_duration;
    $db->objectBuilder()->where('created_at',$_duration,'<=')->delete('hot');
    return true;
}
function DeleteUnusedVideo() {
    global $config, $db,$_BASEPATH;
    $videos = $db->where('is_video', '1')->where('is_confirmed', '0')->where('created_at', 'NOW() - INTERVAL 12 HOUR','>=')->orderBy('created_at','DESC')->get('mediafiles');
    foreach ($videos as $key => $value){
        $date1 = strtotime($value['created_at']);
        $date2 = time();
        $interval = floor(($date2 - $date1) / 60);
        //if($interval > 30) {
            if ($value['private_file'] <> '') {
                $private_file = $_BASEPATH . str_replace('/', DIRECTORY_SEPARATOR, $value['private_file']);
                if (file_exists($private_file)) {
                    @unlink($private_file);
                }
            }
            if ($value['file'] <> '') {
                $file = $_BASEPATH . str_replace('/', DIRECTORY_SEPARATOR, $value['file']);
                if (file_exists($file)) {
                    @unlink($file);
                }
            }
            if ($value['video_file'] <> '') {
                $video_file = $_BASEPATH . str_replace('/', DIRECTORY_SEPARATOR, $value['video_file']);
                if (file_exists($video_file)) {
                    @unlink($video_file);
                }
            }
            $db->where('id', $value['id'])->delete('mediafiles');
        //}
    }
}
function DeleteExpiredXlikes() {
    global $config,$db;
    $_duration   = time() - ( $config->xlike_expire_time * 60 );
    $boosted = $db->objectBuilder()->where('user_buy_xlikes','1')->get('users',null,array('id','xlikes_created_at'));
    foreach ($boosted as $key => $value){
        if( isset( $value->xlikes_created_at ) ){
            if($value->xlikes_created_at <= $_duration){
                $db->where('id',$value->id)->update('users',array('user_buy_xlikes'=>'0','xlikes_created_at'=>'0'));
            }
        }
    }
    return true;
}
function ShareFile($data = array(), $type = 0, $crop = true,$fldr=false) {
    global $config, $s3,$_UPLOAD;
    $allowed = '';
    $path = '';
    if( $fldr !== false && $fldr == 'blogs' ){
        $path = '../';
    }
    if (!file_exists($_UPLOAD.'/files/' . date('Y'))) {
        @mkdir($_UPLOAD.'/files/' . date('Y'), 0777, true);
    }
    if (!file_exists($_UPLOAD.'/files/' . date('Y') . '/' . date('m'))) {
        @mkdir($_UPLOAD.'/files/' . date('Y') . '/' . date('m'), 0777, true);
    }
    if (!file_exists($path.'upload/photos/' . date('Y'))) {
        @mkdir($path.'upload/photos/' . date('Y'), 0777, true);
    }
    if (!file_exists($path.'upload/photos/' . date('Y') . '/' . date('m'))) {
        @mkdir($path.'upload/photos/' . date('Y') . '/' . date('m'), 0777, true);
    }
    if (!file_exists($path.'upload/videos/' . date('Y'))) {
        @mkdir($path.'upload/videos/' . date('Y'), 0777, true);
    }
    if (!file_exists($path.'upload/videos/' . date('Y') . '/' . date('m'))) {
        @mkdir($path.'upload/videos/' . date('Y') . '/' . date('m'), 0777, true);
    }
    if (!file_exists($path.'upload/sounds/' . date('Y'))) {
        @mkdir($path.'upload/sounds/' . date('Y'), 0777, true);
    }
    if (!file_exists($path.'upload/sounds/' . date('Y') . '/' . date('m'))) {
        @mkdir($path.'upload/sounds/' . date('Y') . '/' . date('m'), 0777, true);
    }
    if (!file_exists($path.'upload/gifts/' . date('Y'))) {
        @mkdir($path.'upload/gifts/' . date('Y'), 0777, true);
    }
    if (!file_exists($path.'upload/gifts/' . date('Y') . '/' . date('m'))) {
        @mkdir($path.'upload/gifts/' . date('Y') . '/' . date('m'), 0777, true);
    }
    if (isset($data['file']) && !empty($data['file'])) {
        $data['file'] = $data['file'];
    }
    if (isset($data['name']) && !empty($data['name'])) {
        $data['name'] = Secure($data['name']);
    }
    if (empty($data)) {
        return false;
    }
    $allowed = 'jpg,png,jpeg,gif,mp4,m4v,webm,flv,mov,mpeg,mp3,wav';
    if (isset($data['types'])) {
        $allowed = $data['types'];
    }
    $new_string        = pathinfo($data['name'], PATHINFO_FILENAME) . '.' . strtolower(pathinfo($data['name'], PATHINFO_EXTENSION));
    $extension_allowed = explode(',', $allowed);
    $file_extension    = pathinfo($new_string, PATHINFO_EXTENSION);
    if (!in_array($file_extension, $extension_allowed)) {
        return false;
    }
    if ($data['size'] > $config->maxUpload) {
        return false;
    }
    if ($file_extension == 'jpg' || $file_extension == 'jpeg' || $file_extension == 'png' || $file_extension == 'gif') {
        $folder   = 'photos';
        $fileType = 'image';
    } else if ($file_extension == 'mp4' || $file_extension == 'mov' || $file_extension == 'webm' || $file_extension == 'flv') {
        $folder   = 'videos';
        $fileType = 'video';
    } else if ($file_extension == 'mp3' || $file_extension == 'wav') {
        $folder   = 'sounds';
        $fileType = 'soundFile';
    } else {
        $folder   = 'files';
        $fileType = 'file';
    }
    if( $fldr !== false && $fldr == 'blogs' ){
        $folder = 'photos';
    }
    if (empty($folder) || empty($fileType)) {
        return false;
    }
    $mime_types = explode(',', str_replace(' ', '', $config->mime_types . ',application/octet-stream'));
    if (IS_LOGGED && auth()->admin) {
        $mime_types = explode(',', str_replace(' ', '', $config->mime_types . ',application/json,application/octet-stream'));
    }
    if (!in_array($data['type'], $mime_types)) {
        return false;
    }
    $fn = GenerateKey() . '_' . date('d') . '_' . md5(time()) . "_{$fileType}.{$file_extension}";
    $dir         = $_UPLOAD . "{$folder}" . DIRECTORY_SEPARATOR . date('Y') . DIRECTORY_SEPARATOR . date('m');
    $filename    = $dir . DIRECTORY_SEPARATOR . $fn;

    if( $fldr == 'gifts' || $fldr == 'stickers' ){
        $filename    = 'upload/' . "{$fldr}" . DIRECTORY_SEPARATOR . $fn;
    }

    $second_file = pathinfo($filename, PATHINFO_EXTENSION);
    if (move_uploaded_file($data['file'], $filename)) {
        if ($second_file == 'jpg' || $second_file == 'jpeg' || $second_file == 'png' || $second_file == 'gif') {
            $check_file = _getimagesize($filename);
            if (!$check_file) {
                unlink($filename);
            }
            if( $crop == true ){
                if ($type == 1) {
                    @CompressImage($filename, $filename, 50);
                    $explode2  = @end(explode('.', $filename));
                    $explode3  = @explode('.', $filename);
                    $last_file = $explode3[0] . '_small.' . $explode2;

                    if (Resize_Crop_Image(400, 400, $filename, $last_file, 60)) {
                        if (empty($data['local_upload'])) {
                            if (($config->amazone_s3 == 1 || $config->spaces == 1 || $config->wasabi_storage == 1 || $config->ftp_upload == 1 || $config->cloud_upload == 1 || $config->backblaze_storage == 1) && !empty($last_file)) {
                                $upload_s3 = UploadToS3($last_file);
                            }
                        }
                    }
                } else {
                    if (!isset($data['compress']) && $second_file != 'gif') {
                        @CompressImage($filename, $filename, 10);
                    }
                }
            }
        }
        if (!empty($data['crop'])) {
            $crop_image = Resize_Crop_Image($data['crop']['width'], $data['crop']['height'], $filename, $filename, 60);
        }
        if (empty($data['local_upload'])) {
            if (($config->amazone_s3 == 1 || $config->spaces == 1 || $config->wasabi_storage == 1 || $config->ftp_upload == 1 || $config->cloud_upload == 1 || $config->backblaze_storage == 1) && !empty($filename)) {
                $upload_s3 = UploadToS3($filename);
            }
        }
        $last_data             = array();
        if( $fldr == 'gifts' || $fldr == 'stickers' ) {
            $last_data['filename'] = 'upload/'.$fldr.'/'.$fn;
        }else{
            if( $fldr !== false && $fldr == 'blogs' ){
                $last_data['filename'] = 'upload/photos/'. date('Y') . '/' . date('m') . '/' . $fn;
            }else{
                $last_data['filename'] = $filename;
            }
        }
        $last_data['name']     = $data['name'];
        return $last_data;
    }
}
function GetStories(){
    global $conn;
    $data = array();
    $sql  = mysqli_query($conn, 'SELECT * FROM `success_stories` WHERE `status` = "1" ORDER BY `story_date` DESC, `id` DESC LIMIT 4;');
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $fetched_data['user1Data'] = userData($fetched_data['user_id']);
        $fetched_data['user2Data'] = userData($fetched_data['story_user_id']);
        $data[] = $fetched_data;
    }
    return $data;
}
function GetSiteUsers(){
    global $conn, $config;
    $data = array();
    $showed_user = 20;
    if(!empty($config->showed_user)){
        $showed_user = $config->showed_user;
    }
    $sql  = mysqli_query($conn, 'SELECT * FROM `users` WHERE `active` = "1" ORDER BY `id` DESC LIMIT '.$showed_user.' ;');
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data[] = userData($fetched_data['id']);;
    }
    return $data;
}
function GetNonProMaxUserChatsPerDay($userid){
    global $conn;
    $data      = array();
    $query_one = "SELECT COUNT(DISTINCT(messages.`to`)) as ChatCount FROM messages WHERE messages.`from` = ".$userid." AND DATE(messages.created_at) = CURDATE() ORDER BY messages.`to`";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['ChatCount'] = $fetched_data['ChatCount'];
    }
    return $data['ChatCount'];
}
function isNonProBuyChatCredits($userid,$chat_userid){
    global $conn;
    $data      = array();
    $row_cnt = 0;
    $query_one = "SELECT id FROM user_chat_buy WHERE `user_id` = ".$userid." AND `chat_user_id` = ".$chat_userid." AND DATE(`created_at`) = CURDATE() LIMIT 1";
    if ($result = mysqli_query($conn, $query_one)){
        $row_cnt = mysqli_num_rows($result);
        mysqli_free_result($result);
    }
    if( $row_cnt == 0 ){
        return false;
    }else{
        return true;
    }
}
function isHadChatBefore($userid,$chat_userid)
{
    global $conn;
    $query_one = "SELECT * FROM `messages` WHERE `from` = ".$userid." AND DATE(`created_at`) = CURDATE()";
    $sql = mysqli_query($conn, $query_one);
    $users = array();
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $users[] = $fetched_data['to'];
    }
    if (in_array($chat_userid,$users)) {
        return true;
    }
    return false;
}
function isNonProCanChatWith($userid,$chat_userid){
    global $conn;
    $_result = false;
    $row_cnt = 0;
    $query_one = "SELECT id FROM `messages` WHERE `from` = ".$userid." AND DATE(`created_at`) = CURDATE() LIMIT 1";
    if ($result = mysqli_query($conn, $query_one)){
        $row_cnt = mysqli_num_rows($result);
        mysqli_free_result($result);
    }
    if( $row_cnt > 0 ){
        $_result = false;
    }
    //If one user used credit to initiate chat the other should be able to reply without having to buy credit.
//    $_result2 = isNonProBuyChatCredits($chat_userid,$userid);
//    if( $_result2 === false ){
//        $_result = false;
//    }else{
//        $_result = true;
//    }
//    $_result = isNonProBuyChatCredits($userid,$chat_userid);

    return $_result;
}
function isChatBefore($userid,$chat_userid){
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    if (empty($userid)) {
        return false;
    }
    $userid    = Secure($userid);
    $chat_userid    = Secure($chat_userid);
    $sql = 'SELECT count(id) FROM `conversations` WHERE `sender_id` = '.$userid.' AND `receiver_id` = '.$chat_userid.' AND `status` = 1';
    $query = mysqli_query($conn, $sql);
    if (mysqli_num_rows($query) > 0) {
        if((int)Sql_Result($query, 0) > 0){
            return true;
        }else{
            return false;
        }
    } else {
        return false;
    }


}
function NonProCanChat($userid,$chat_userid){
    global $conn;
    $data  = array();
    $query = 'SELECT
                    `id`,
                    (SELECT `created_at` FROM `conversations` WHERE `sender_id` = `users`.`id` ORDER BY `created_at` DESC LIMIT 1) as last_chat,
                    DATEDIFF(DATE_FORMAT(FROM_UNIXTIME((SELECT `created_at` FROM `conversations` WHERE `sender_id` = `users`.`id` ORDER BY `created_at` DESC LIMIT 1)), \'%Y-%m-%d %H:%i:%s\'),CURDATE()) * -1 as `days`
                FROM
                    `users`
                WHERE
                    `id` IN (SELECT receiver_id FROM `conversations` WHERE sender_id = '.$userid.')
                AND
                    (`id` NOT IN (SELECT `id` FROM `user_chat_buy` WHERE `user_id` = '.$userid.')';
    $sql = mysqli_query($conn, $query);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data[$fetched_data['id']]['last_chat'] = $fetched_data['last_chat'];
        $data[$fetched_data['id']]['days'] = $fetched_data['days'];
    }
    if( isset($data[$chat_userid]) ){
        if( $data[$chat_userid]['days'] > 1 ){
            return false;
        }else{
            return true;
        }
    }else{
        return false;
    }
}
function GetLastChat($userid){
    global $conn;
    $data  = 0;
    $query = 'SELECT `created_at` FROM `conversations` WHERE `sender_id` = '.$userid.' AND `receiver_id` NOT IN (SELECT `chat_user_id` FROM `user_chat_buy` WHERE `user_id` = '.$userid.') ORDER BY `created_at` DESC LIMIT 1';
    $sql = mysqli_query($conn, $query);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data = $fetched_data['created_at'];
    }
    if( $data > 1 ){
        return $data;
    }else{
        return 0;
    }
}
function GetTotalLikes(){
    global $conn;
    $data      = array();
    $query_one = "SELECT COUNT(`id`) as LikeCount FROM `likes` WHERE `created_at` >= (DATE_SUB(CURDATE(), INTERVAL 5 MINUTE));";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['LikeCount'] = $fetched_data['LikeCount'];
    }
    return $data['LikeCount'];
}
function GetTotalVisits(){
    global $conn;
    $data      = array();
    $query_one = "SELECT COUNT(`id`) as VisitCount FROM `views` WHERE `created_at` >= (DATE_SUB(CURDATE(), INTERVAL 5 MINUTE));";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['VisitCount'] = $fetched_data['VisitCount'];
    }
    return $data['VisitCount'];
}
function GetTotalMatches(){
    global $conn;
    $data      = array();
    $query_one = "SELECT COUNT(`id`) as MatcheCount FROM `notifications` WHERE `type` = 'got_new_match' AND `created_at` >= UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 5 MINUTE));";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['MatcheCount'] = $fetched_data['MatcheCount'];
    }
    return $data['MatcheCount'];
}
function GetUserTotalLikes($userid){
    global $conn;
    $data      = array();
    $query_one = "SELECT COUNT(`id`) as LikeCount FROM `likes` WHERE `like_userid` = ".$userid." AND `created_at` >= (DATE_SUB(CURDATE(), INTERVAL 5 MINUTE));";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['LikeCount'] = $fetched_data['LikeCount'];
    }
    return $data['LikeCount'];
}
function GetUserTotalVisits($userid){
    global $conn;
    $data      = array();
    $query_one = "SELECT COUNT(`id`) as VisitCount FROM `views` WHERE `view_userid` = ".$userid." AND `created_at` < NOW() AND UNIX_TIMESTAMP(`created_at`) < UNIX_TIMESTAMP(DATE_ADD(NOW(), INTERVAL -50 MINUTE));";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['VisitCount'] = $fetched_data['VisitCount'];
    }
    return $data['VisitCount'];
}
function GetUserTotalSwipes($userid){
    global $conn;
    $data      = array();
    $data['SwipeCount'] = 0;
    $query_one = "SELECT COUNT(`id`) as SwipeCount FROM `likes` WHERE `user_id` = ".$userid." AND `created_at` < NOW() AND UNIX_TIMESTAMP(`created_at`) > UNIX_TIMESTAMP(DATE_ADD(NOW(), INTERVAL -1 DAY));";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['SwipeCount'] = $fetched_data['SwipeCount'];
    }
    return $data['SwipeCount'];
}
function GetUserTotalMatches($userid){
    global $conn;
    $data      = array();
    $query_one = "SELECT COUNT(`id`) as MatcheCount FROM `notifications` WHERE `recipient_id` = ".$userid." AND `type` = 'got_new_match' AND `created_at` < NOW() AND `created_at` > UNIX_TIMESTAMP(DATE_ADD(NOW(), INTERVAL -50 MINUTE));";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $data['MatcheCount'] = $fetched_data['MatcheCount'];
    }
    return $data['MatcheCount'];
}
function GetUserPopularity($user_id,$percent = false,$color= false){
    $color_txt = '';
    $GetTotalLikes = GetTotalLikes();
    $GetTotalVisits = GetTotalVisits();
    $GetTotalMatches = GetTotalMatches();
    $siteTotal = $GetTotalLikes + $GetTotalVisits + $GetTotalMatches;

    $GetUserTotalLikes = GetUserTotalLikes($user_id);
    $GetUserTotalVisits = GetUserTotalVisits($user_id);
    $GetUserTotalMatches = GetUserTotalMatches($user_id);
    $userTotal = $GetUserTotalLikes + $GetUserTotalVisits + $GetUserTotalMatches;

    $percentage = 0;
    $percentageText = '';
    if( $siteTotal > 0 && $userTotal > 0 ) {
        $percentage = (int)(($userTotal * 100) / $siteTotal);
    }

    if( $percentage > 100 ){
        $percentage = 100;
    }

    if( $percentage >= 0 && $percentage <= 25 ){
        $percentageText = __('Very low');
        $color_txt = '';
    }else if( $percentage > 25 && $percentage <= 50 ){
        $percentageText = __('Low');
        $color_txt = '#9C27B0';
    }else if( $percentage > 50 && $percentage <= 75 ){
        $percentageText = __('High');
        $color_txt = '#2196F3';
    }else if( $percentage > 75 && $percentage <= 100 ){
        $percentageText = __('Very high');
        $color_txt = '#8BC34A';
    }
    if($color === true){
        return $color_txt;
    }
    if($percent === false) {
        return $percentageText;
    }else{
        return $percentage;
    }
}
function CreateNotification($token = '',$notifier_id=0,$recipient_id=0,$type='',$text = '',$url=''){
    if (empty($notifier_id) || empty($recipient_id) || empty($type) || empty($url) ) return false;
    if (isEndPointRequest()) {
        $Notification = LoadEndPointResource('Notifications',true);
    }else{
        $Notification = LoadEndPointResource('Notifications');
    }
    if($Notification){
        $notification = $Notification->createNotification($token,(int)$notifier_id, (int)$recipient_id, $type, $text, $url);
        if( $notification['code'] == 200 ) {
            return true;
        }else {
            return false;
        }
    }else{
        return false;
    }
}
function getAge($date) {
    if(empty($date) || $date === '0000-00-00') return 0;
    return intval(date('Y', time() - strtotime($date))) - 1970;
}
function udetails_age($user) {
    $age = getAge($user->birthday);
    return ($age > 0) ? $age : '&nbsp;';
}

function udetails($user){
    global $config,$db;
    $return = '';
    $age = getAge($user->birthday);
    $country = '';
    if (empty($user->country)) {

        $countries = Dataset::load('countries');
        if (!empty($countries) && !empty(array_keys($countries))) {
            $user->country = array_keys($countries)[0];
            $db->where('id',$user->id)->update('users',['country' => $user->country]);
        }
        
    }
    if(isset(Dataset::load('countries')[$user->country])){
        $country = Dataset::load('countries')[$user->country]['name'];
    }
    if($age > 0){
        $return = $age ;
    }
    if($country !== ''){
        if($return !== ''){
            $return .= ',';
        }
        $return .= '&nbsp;'.$country;
    }
    if($return == ''){
        $return = '&nbsp;';
    }
    return $return;
}
function GetGendersKeys(){
    global $db;
    $_genders = $db->where('ref','gender')->get('langs',null,array('lang_key'));
    $_data = array();
    foreach ($_genders as $key => $value) {
        $_data[$value['lang_key']] = $value['lang_key'];
    }
    $genders = implode(",",$_data);
    return $genders;
}
function GetGenders($u){
    global $config,$db;
    $_genders = $db->where('ref','gender')->get('langs',null,array('lang_key'));
    $_data = array();
    foreach ($_genders as $key => $value) {
        $_data[$value['lang_key']] = $value['lang_key'];
    }
    if($config->opposite_gender == "1"){
        if( in_array($u->gender, $_data) ){
            unset($_data[$u->gender]);
        }
    }
    $genders = implode(",",$_data);
    return $genders;
}
function GetFindMatcheQuery($user_id, $limit, $offset, $sort = 'DESC'){
    global $config,$db;

    if( $limit == 0 ){
        $limit = 20;
    }
    $is_xhr = false;
    if (!empty($_POST['page']) && count($_POST) == 1) {
        $is_xhr = false;
    }

    $user = auth();

    $genders = Dataset::load('gender');
    $countries = Dataset::load('countries');
    $languages = Dataset::load('language');
    $ethnicities = Dataset::load('ethnicity');
    $religions = Dataset::load('religion');
    $religions = Dataset::load('religion');
    $relationships = Dataset::load('relationship');
    $smokes = Dataset::load('smoke');
    $drinks = Dataset::load('drink');
    $educations = Dataset::load('education');
    $pets = Dataset::load('pets');
    $body = Dataset::load('body');

    $json = array();

    if( isset($_POST['_gender']) && !empty($_POST['_gender']) && !empty($genders)){
        $new_gender = explode(',', $_POST['_gender']);
        $adding_gender = array();
        foreach ($new_gender as $key => $value) {
            if (in_array($value, array_keys($genders))) {
                $adding_gender[] = Secure($value);
            }
        }
        $json['gender'] = $adding_gender;
    }
    elseif($is_xhr){
        $json['gender'] = '';
    }

    if( isset($_POST['_my_country']) && !empty($_POST['_my_country']) && $_POST['_my_country'] != 'undefined' && !empty($countries)){
        if (in_array($_POST['_my_country'], array_keys($countries))) {
            $json['country'] = Secure($_POST['_my_country']);
            $json['rand_country'] = Secure($_POST['_my_country']);
            //$json['location_enabled'] = 0;
        }
        else if($_POST['_my_country'] == 'all'){
            $json['country'] = 'all';
            $json['rand_country'] = 'all';
        }
    }
    elseif($is_xhr){
        $json['country'] = '';
    }

    if(  isset($_POST['_age_from']) && !empty($_POST['_age_from']) && isset($_POST['_age_to']) && !empty($_POST['_age_to'])){
        $json['age_from'] = Secure($_POST['_age_from']);
        $json['age_to'] = Secure($_POST['_age_to']);
    }
    elseif($is_xhr){
        $json['age_from'] = '';
        $json['age_to'] = '';
    }

    if (!empty($_POST['_lat']) && !empty($_POST['_lng']) && !empty($_POST['_located'])) {
        $json['lat'] = Secure($_POST['_lat']);
        $json['lng'] = Secure($_POST['_lng']);
        $json['located'] = Secure($_POST['_located']);
        $json['rand_lat'] = Secure($_POST['_lat']);
        $json['rand_lng'] = Secure($_POST['_lng']);
        $json['rand_located'] = Secure($_POST['_located']);
        //$json['location_enabled'] = 1;
    }
    elseif($is_xhr){
        $json['lat'] = '';
        $json['lng'] = '';
        $json['located'] = '';
    }

    if (!empty($_POST['city']) && $config->filter_by_cities == 1 && !empty($config->geo_username)) {
        $json['city'] = Secure($_POST['city']);
    }
    elseif($is_xhr){
        $json['city'] = '';
    }

    if( isset($_POST['_height_from']) && !empty($_POST['_height_from']) && isset($_POST['_height_to']) && !empty($_POST['_height_to']) ){
        $json['height_from'] = Secure($_POST['_height_from']);
        $json['height_to'] = Secure($_POST['_height_to']);
    }
    elseif($is_xhr){
        $json['height_from'] = '';
        $json['height_to'] = '';
    }

    if( isset($_POST['_body']) && !empty($_POST['_body']) ){
        $_body = explode(',', $_POST['_body']);
        $adding_body = array();
        foreach ($_body as $key => $value) {
            if (in_array($value, array_keys($body))) {
                $adding_body[] = Secure($value);
            }
        }
        $json['body'] = $adding_body;
    }
    elseif($is_xhr){
        $json['body'] = '';
    }

    if( isset($_POST['_language']) && !empty($_POST['_language']) && !empty($languages)){
        $new_language = explode(',', $_POST['_language']);
        $adding_language = array();
        foreach ($new_language as $key => $value) {
            if (in_array($value, array_keys($languages))) {
                $adding_language[] = Secure($value);
            }
        }
        $json['language'] = $adding_language;
    }
    elseif($is_xhr){
        $json['language'] = '';
    }

    if(isset($_POST['_ethnicity']) && !empty($_POST['_ethnicity'])){
        $_ethnicity = explode(',', $_POST['_ethnicity']);
        $adding_ethnicity = array();
        foreach ($_ethnicity as $key => $value) {
            if (in_array($value, array_keys($ethnicities))) {
                $adding_ethnicity[] = Secure($value);
            }
        }
        $json['ethnicity'] = $adding_ethnicity;
    }
    elseif($is_xhr){
        $json['ethnicity'] = '';
    }

    if( isset($_POST['_religion']) && !empty($_POST['_religion']) ){
        $_religion = explode(',', $_POST['_religion']);
        $adding_religion = array();
        foreach ($_religion as $key => $value) {
            if (in_array($value, array_keys($religions))) {
                $adding_religion[] = Secure($value);
            }
        }
        $json['religion'] = $adding_religion;
    }
    elseif($is_xhr){
        $json['religion'] = '';
    }

    if( isset($_POST['_relationship']) && !empty($_POST['_relationship']) ){
        $_relationship = explode(',', $_POST['_relationship']);
        $adding_relationship = array();
        foreach ($_relationship as $key => $value) {
            if (in_array($value, array_keys($relationships))) {
                $adding_relationship[] = Secure($value);
            }
        }
        $json['relationship'] = $adding_relationship;
    }
    elseif($is_xhr){
        $json['relationship'] = '';
    }

    if( isset($_POST['_smoke']) && !empty($_POST['_smoke']) ){
        $_smoke = explode(',', $_POST['_smoke']);
        $adding_smoke = array();
        foreach ($_smoke as $key => $value) {
            if (in_array($value, array_keys($smokes))) {
                $adding_smoke[] = Secure($value);
            }
        }
        $json['smoke'] = $adding_smoke;
    }
    elseif($is_xhr){
        $json['smoke'] = '';
    }

    if(isset($_POST['_drink']) && !empty($_POST['_drink'])){
        $_drink = explode(',', $_POST['_drink']);
        $adding_drink = array();
        foreach ($_drink as $key => $value) {
            if (in_array($value, array_keys($drinks))) {
                $adding_drink[] = Secure($value);
            }
        }
        $json['drink'] = $adding_drink;
    }
    elseif($is_xhr){
        $json['drink'] = '';
    }

    if( isset($_POST['_interest']) && !empty($_POST['_interest']) ){
        $json['interest'] = Secure($_POST['_interest']);
    }
    elseif($is_xhr){
        $json['interest'] = '';
    }

    if( isset($_POST['_education']) && !empty($_POST['_education']) ){
        $_education = explode(',', $_POST['_education']);
        $adding_education = array();
        foreach ($_education as $key => $value) {
            if (in_array($value, array_keys($educations))) {
                $adding_education[] = Secure($value);
            }
        }
        $json['education'] = $adding_education;
    }
    elseif($is_xhr){
        $json['education'] = '';
    }

    if( isset($_POST['_pets']) && !empty($_POST['_pets']) ){
        $_pets = explode(',', $_POST['_pets']);
        $adding_pets = array();
        foreach ($_pets as $key => $value) {
            if (in_array($value, array_keys($pets))) {
                $adding_pets[] = Secure($value);
            }
        }
        $json['pets'] = $adding_pets;
    }
    elseif($is_xhr){
        $json['pets'] = '';
    }

    if(isset($_POST['custom_profile_data'])){
        $custom_fields = array();
        $count = 100;
        for($i = 0 ; $i <= $count ; $i++ ){
            if(isset($_POST['fid_' . $i]) && !empty($_POST['fid_' . $i])){
                $custom_fields['fid_' . $i] = Secure($_POST['fid_' . $i]);
            }
        }
        $json['custom_fields'] = $custom_fields;
    }
    elseif($is_xhr){
        $json['custom_fields'] = '';
    }

    if (empty($json)) {
        if (!empty($user->find_match_data)) {
            $json = json_decode($user->find_match_data,true);
        }
        else{
            $json = array(
                //'location_enabled' => 1,
                'lat' => $user->lat,
                'lng' => $user->lng,
                'located' => 125
            );
        }
    }
    if ($user->is_pro == 0 && empty($json['located'])) {
        $json['lat'] = $user->lat;
        $json['lng'] = $user->lng;
        $json['located'] = 125;
        $json['country'] = '';
        $json['city'] = '';
    }

    if (!empty($_POST['_lat']) && !empty($_POST['_lng']) && !empty($_POST['_located'])) {
        $json['country'] = '';
        $json['city'] = '';
        //$json['location_enabled'] = 1;
    }
    elseif (!empty($_POST['_my_country'])) {
        $json['lat'] = '';
        $json['lng'] = '';
        $json['located'] = '';
        //$json['location_enabled'] = 0;
    }
    if (!empty($user->find_match_data)) {
        $info = json_decode($user->find_match_data,true);
        if (empty($json['rand_country']) && !empty($info['rand_country'])) {
            $json['rand_country'] = $info['rand_country'];
        }
        if ((empty($json['rand_lat']) || empty($json['rand_lng']) || empty($json['rand_located'])) && (!empty($info['rand_lat']) && !empty($info['rand_lng']) && !empty($info['rand_located']))) {
            $json['rand_lat'] = $info['rand_lat'];
            $json['rand_lng'] = $info['rand_lng'];
            $json['rand_located'] = $info['rand_located'];
        }
    }
    

    if (!empty($json)) {
        $db->where('id',$user->id)->update('users',['find_match_data' => json_encode($json)]);
    }




    $where = "";
    if(!empty($json['gender'])){
        $gender = implode(',', $json['gender']);
        $where .= ' AND `gender` IN (' . $gender . ') ';
    }

    if(!empty($json['country'])){
        if ($json['country'] != 'all') {
            $where .= ' AND `country` = "' . $json['country'] . '" ';
        }
    }

    if(!empty($json['age_from']) && !empty($json['age_to'])){
        $where .= ' AND (DATEDIFF(CURDATE(), `birthday`)/365 >= "'. $json['age_from'] .'" AND DATEDIFF(CURDATE(), `birthday`)/365 <= "'. $json['age_to'] . '") ';
    }

    if (!empty($json['lat']) && !empty($json['lng']) && !empty($json['located'])) {
        $located = $json['located'];
        $lat = $json['lat'];
        $lng = $json['lng'];

        $distance = ' AND ROUND( ( 6371 * acos(cos(radians(' . $lat . ')) * cos(radians(`lat`)) * cos(radians(`lng`) - radians(' . $lng . ')) + sin(radians(' . $lat . ')) * sin(radians(`lat`)))) ,1) ';
        $where .= $distance . ' <= ' . $located ;
    }

    if (!empty($json['city']) && $config->filter_by_cities == 1 && !empty($config->geo_username)) {
        $city = $json['city'];
        $where .= " AND `city` LIKE '%$city%' ";
    }

    if(!empty($json['height_from']) && !empty($json['height_to'])) {
        $where .= ' AND `height` BETWEEN "'. $json['height_from'] .'" AND "'. $json['height_to'] .'"';
    }

    if(!empty($json['body'])){
        $body = implode(',', $json['body']);
        $where .= ' AND `body` IN ('. $body .')';
    }

    if(!empty($json['language'])){
        $_lang = implode(',',$json['language']);
        $str = "'".str_replace(',', "','", $_lang)."'";
        $where .= ' AND `language` IN ('. $str .')';
    }

    if(!empty($json['ethnicity'])){
        $ethnicity = implode(',', $json['ethnicity']);
        $where .= ' AND `ethnicity` IN ('. $ethnicity .')';
    }

    if(!empty($json['religion'])){
        $religion = implode(',', $json['religion']);
        $where .= ' AND `religion` IN ('. $religion .')';
    }

    if(!empty($json['relationship'])){
        $relationship = implode(',', $json['relationship']);
        $where .= ' AND `relationship` IN ('. $relationship .')';
    }

    if(!empty($json['smoke'])){
        $smoke = implode(',', $json['smoke']);
        $where .= ' AND `smoke` IN ('. $smoke .')';
    }

    if(!empty($json['drink'])){
        $drink = implode(',', $json['drink']);
        $where .= ' AND `drink` IN ('. $drink .')';
    }

    if(!empty($json['interest'])){
        $where .= ' AND `interest` like "%'. $json['interest'] .'%"';
    }

    if(!empty($json['education'])){
        $education = implode(',', $json['education']);
        $where .= ' AND `education` IN ('. $education .')';
    }

    if(!empty($json['pets'])){
        $pets = implode(',', $json['pets']);
        $where .= ' AND `pets` IN ('. $pets .')';
    }

    $where .= " AND `id` NOT IN (SELECT `like_userid` FROM `likes` WHERE `user_id` = '".$user_id."') AND `id` != '".$user->id."' AND `active` = '1' AND `verified` = '1' ";


    $custom_sql = [];
    if(!empty($json['custom_fields'])){
        foreach ($json['custom_fields'] as $key => $value) {
            $custom_sql[] = ' id IN (SELECT `user_id` FROM `userfields` WHERE `'. $key .'` = "'.$value . '") ';
        }
    }

    $custom_sql_text = '';
    if(!empty($custom_sql)){
        $custom_sql_text .= ' AND ( ';
        $custom_sql_text .= implode(' OR ', $custom_sql);
        $custom_sql_text .= ' ) ';
        $where .= $custom_sql_text;
    }

    if ($sort == 'RAND()') {
        $orderBy = ' ORDER BY RAND() ';
    }
    else{
        $orderBy = ' ORDER BY';
        $orderBy .= '`xlikes_created_at` DESC';
        $orderBy .= ',`xvisits_created_at` DESC';
        $orderBy .= ',`xmatches_created_at` DESC';
        $orderBy .= ',`is_pro` DESC,`hot_count` DESC,`gender` DESC';
    }

    

    $query = 'SELECT * FROM `users` WHERE `id` > 0 ' .$where . $orderBy . ' LIMIT '.$limit.' OFFSET '.$offset.';';
    //print_r($query);
    return $query;

    
    

    
    // $where = '';

    // $genders_keys = GetGendersKeys();
    // $genders = $genders_keys;
    // if( isset($_POST['_gender']) && !empty($_POST['_gender'])){
    //     $_SESSION[ '_gender' ] = $_POST['_gender'];
    //     $genders = Secure($_POST['_gender']);
    // }
    // if( $config->opposite_gender == "1"  && $search == false) {
    //     if( isset($_POST['_gender']) && $genders_keys == $_POST['_gender'] ) {
    //         $genders = GetGenders($u);
    //     }else{
    //         if (!empty($_POST['_gender'])) {
    //             $genders = $_POST['_gender'];
    //         }
    //     }
    // }
    // if( $genders !== null ) {
    //     if (strpos($genders, ',') === false) {
    //         $gender_query = ' AND `gender` = "' . $genders . '" ';
    //         $where .= $gender_query;
    //     } else {
    //         $gender_query = ' AND `gender` IN (' . $genders . ') ';
    //         $where .= $gender_query;
    //     }
    // }else{
    //     if( $config->opposite_gender == "1"  && $search == false) {
    //         $genders = GetGenders($u);
    //         if (strpos($genders, ',') === false) {
    //             $gender_query = ' AND `gender` = "' . $genders . '" ';
    //             $where .= $gender_query;
    //         } else {
    //             $gender_query = ' AND `gender` IN (' . $genders . ') ';
    //             $where .= $gender_query;
    //         }
    //     }
    // }

    // $dist_query = '';
    // $mycountry = $u->show_me_to;
    // if(empty($u->show_me_to)){
    //     $mycountry = $u->country;
    // }

    // if ($mycountry == $u->country) {
    //     if( isset( $_REQUEST['access_token'] ) ) {

    //     }else{
    //     //var_dump('activate distance filter');
    //     $located = 50;
    //     $lat = 0;
    //     $lng = 0;
    //     if( isset( $_SESSION['_lat'] ) ) $lat = Secure($_SESSION['_lat']);
    //     if( isset( $_POST['_lat'] ) ) $lat = Secure($_POST['_lat']);

    //     if( isset( $_SESSION['_lng'] ) ) $lng = Secure($_SESSION['_lng']);
    //     if( isset( $_POST['_lng'] ) ) $lng = Secure($_POST['_lng']);

    //     if( isset( $_SESSION['_located'] ) ) $located = Secure($_SESSION['_located']);
    //     if( isset( $_POST['_located'] ) ) $located = Secure($_POST['_located']);
    //     //var_dump('distance : ' . $located);
    //     //var_dump('lat : ' . $lat . ', lng :' . $lng);

    //     $distance = ' AND ROUND( ( 6371 * acos(cos(radians(' . $lat . ')) * cos(radians(`lat`)) * cos(radians(`lng`) - radians(' . $lng . ')) + sin(radians(' . $lat . ')) * sin(radians(`lat`)))) ,1) ';
    //     $dist_query = $distance . ' <= ' . $located . ' AND `country` = "' . $mycountry . '"';
    //     }
    // } else {
    //     //var_dump('activate country filter');
    //     if( !empty($mycountry) ) {
    //         $dist_query = ' AND `country` = "' . $mycountry . '"';
    //     }
    // }

    // $age_query = '';
    // // check age from post or from session
    // if( isset($_POST['_age_from']) && !empty($_POST['_age_from']) && isset($_POST['_age_to']) && !empty($_POST['_age_to']) ){
    //     $age_query = ' (DATEDIFF(CURDATE(), `birthday`)/365 >= "'. Secure($_POST['_age_from']) .'" AND DATEDIFF(CURDATE(), `birthday`)/365 <= "'. Secure($_POST['_age_to']) . '") ';
    //     $where_and[] = $age_query;
    // }else{
    //     if( isset( $_REQUEST['access_token'] ) ) {

    //     }else{
    //         if(isset( $_SESSION['_age_from'] ) && isset( $_SESSION['_age_to'] )) {
    //             $age_query = ' (DATEDIFF(CURDATE(), `birthday`)/365 >= "'. Secure($_SESSION['_age_from']) .'" AND DATEDIFF(CURDATE(), `birthday`)/365 <= "'. Secure($_SESSION['_age_to']) . '") ';
    //             $where_and[] = $age_query;
    //         }else{
    //             $age_query = ' (DATEDIFF(CURDATE(), `birthday`)/365 >= "18" AND DATEDIFF(CURDATE(), `birthday`)/365 <= "55") ';
    //             $where_and[] = $age_query;
    //         }
    //     }
    // }



    // $where_and2 = array();
    // //******************* Looks Filters ************************//
    // if( isset($_POST['_height_from']) && !empty($_POST['_height_from']) && isset($_POST['_height_to']) && !empty($_POST['_height_to']) ){
    //     $where_and2[] = '`height` BETWEEN "'. Secure($_POST['_height_from']) .'" AND "'. Secure($_POST['_height_to']) .'"';
    // }
    // if( isset($_POST['_body']) && !empty($_POST['_body']) ){
    //     if( strpos( Secure( $_POST['_body'] ), ',' ) === false ) {
    //         $where_and2[] = '`body` = "'. Secure($_POST['_body']) . '"';
    //     }else{
    //         $where_and2[] = '`body` IN (0,'. Secure($_POST['_body']) .')';
    //     }
    // }
    // //******************* Background Filter ********************//
    // if( isset($_POST['_language']) && !empty($_POST['_language']) ){
    //     if( strpos( Secure( $_POST['_language'] ), ',' ) === false ) {
    //         $where_and2[] = '`language` = "'. Secure($_POST['_language']) .'"';
    //     }else{
    //         $langss = @explode(',', Secure($_POST['_language']));
    //         $where_and2[] = '`language` IN ("'. @implode('","', $langss) .'")';
    //     }
    // }
    // if( isset($_POST['_ethnicity']) && !empty($_POST['_ethnicity']) ){
    //     if( strpos( Secure( $_POST['_ethnicity'] ), ',' ) === false ) {
    //         $where_and2[] = '`ethnicity` = "'. Secure($_POST['_ethnicity']) . '"';
    //     }else{
    //         $where_and2[] = '`ethnicity` IN (0,'. Secure($_POST['_ethnicity']) .')';
    //     }
    // }
    // if( isset($_POST['_religion']) && !empty($_POST['_religion']) ){
    //     if( strpos( Secure( $_POST['_religion'] ), ',' ) === false ) {
    //         $where_and2[] = '`religion` = "'. Secure($_POST['_religion']) . '"';
    //     }else{
    //         $where_and2[] = '`religion` IN (0,'. Secure($_POST['_religion']) .')';
    //     }
    // }
    // //******************* LifeStyle filter *********************//
    // if( isset($_POST['_relationship']) && !empty($_POST['_relationship']) ){
    //     if( strpos( Secure( $_POST['_relationship'] ), ',' ) === false ) {
    //         $where_and2[] = '`relationship` = "'. Secure($_POST['_relationship']) .'"';
    //     }else{
    //         $where_and2[] = '`relationship` IN (0,'. Secure($_POST['_relationship']) .')';
    //     }
    // }
    // if( isset($_POST['_smoke']) && !empty($_POST['_smoke']) ){
    //     if( strpos( Secure( $_POST['_smoke'] ), ',' ) === false ) {
    //         $where_and2[] = '`smoke` = "'. Secure($_POST['_smoke']) . '"';
    //     }else{
    //         $where_and2[] = '`smoke` IN (0,'. Secure($_POST['_smoke']) .')';
    //     }
    // }
    // if( isset($_POST['_drink']) && !empty($_POST['_drink']) ){
    //     if( strpos( Secure( $_POST['_drink'] ), ',' ) === false ) {
    //         $where_and2[] = '`drink` = "'. Secure($_POST['_drink']) . '"';
    //     }else{
    //         $where_and2[] = '`drink` IN (0,'. Secure($_POST['_drink']) .')';
    //     }
    // }
    // //******************* More Filter **************************//
    // if( isset($_POST['_interest']) && !empty($_POST['_interest']) ){
    //     $where_and2[] = '`interest` like "%'. Secure($_POST['_interest']) .'%"';
    // }
    // if( isset($_POST['_education']) && !empty($_POST['_education']) ){
    //     if( strpos( Secure( $_POST['_education'] ), ',' ) === false ) {
    //         $where_and2[] = '`education` = "'. Secure($_POST['_education']) . '"';
    //     }else{
    //         $where_and2[] = '`education` IN (0,'. Secure($_POST['_education']) .')';
    //     }
    // }
    // if( isset($_POST['_pets']) && !empty($_POST['_pets']) ){
    //     if( strpos( Secure( $_POST['_pets'] ), ',' ) === false ) {
    //         $where_and2[] = '`pets` = "'. Secure($_POST['_pets']) .'"';
    //     }else{
    //         $where_and2[] = '`pets` IN (0,'. Secure($_POST['_pets']) .')';
    //     }
    // }

    // $custom_sql = [];
    // if(isset($_POST['custom_profile_data'])){
    //     $count = 100;
    //     for($i = 0 ; $i <= $count ; $i++ ){
    //         if(isset($_POST['fid_' . $i])){
    //             if(!empty($_POST['fid_' . $i])){
    //                 $custom_sql[] = ' id IN (SELECT `user_id` FROM `userfields` WHERE `fid_' . $i .'` = "'.Secure($_POST['fid_' . $i]) . '") ';
    //             }
    //         }
    //     }
    // }

    // $custom_sql_text = '';
    // if(!empty($custom_sql)){
    //     $custom_sql_text .= ' AND ( ';
    //     $custom_sql_text .= implode(' OR ', $custom_sql);
    //     $custom_sql_text .= ' ) ';
    // }

    // if( isset( $_REQUEST['access_token'] ) ) {
    //     $uid = GetUserFromSessionID(Secure($_REQUEST['access_token']));
    //     $u->id = $uid;
    // }

    // $notin = '';
    // if( isset( $u->id ) ) {
    //     // to exclude blocked users
    //     $notin = ' AND `id` NOT IN (SELECT `block_userid` FROM `blocks` WHERE `user_id` = ' . $u->id . ') ';
    //     // to exclude liked and disliked users users
    //     if (!isEndPointRequest()) {
    //         $notin .= ' AND `id` NOT IN (SELECT `like_userid` FROM `likes` WHERE `user_id` = ' . $u->id . ') ';
    //         $notin .= ' AND `id` NOT IN (SELECT `user_id` FROM `likes` WHERE `like_userid` = ' . $u->id . ') ';
    //     }
    //     $notin .= ' AND `id` <> "' . $u->id . '" ';
    //     //$notin .= ' AND '.$age_query;
    //     //if( $dist_query !== '' ) {
    //     //    $notin .= ' AND ' . $dist_query;
    //     //}
    // }

    // if( !empty($where_and) ){
    //     if (is_array($where_and) || is_object($where_and)) {
    //         $where = $where . ' AND (' . implode(' AND ' , $where_and) . ')';
    //     }

    // }
    // if( !empty($where_and2) ){
    //     if (is_array($where_and2) || is_object($where_and2)) {
    //         $where = $where . ' AND (' . implode(' AND ',$where_and2) . ')';
    //     }
    // }
    // if( route(1) == "find-matches" ){
    //     //$where = '';
    //     if( $config->opposite_gender == "1" && $search == false ) {
    //         $genders = GetGenders($u);
    //         if (strpos($genders, ',') === false) {
    //             $gender_query = ' AND `gender` = "' . $genders . '" ';
    //             $where .= $gender_query;
    //         } else {
    //             $gender_query = ' AND `gender` IN (' . $genders . ') ';
    //             $where .= $gender_query;
    //         }
    //     }
    // }

    // if( !empty($u->show_me_to) ){
    //     $where .= ' AND `country` = "'. $u->show_me_to . '" ';
    // }
    // if (!empty($_POST['city']) && $config->filter_by_cities == 1 && !empty($config->geo_username)) {
    //     $city = Secure($_POST['city']);
    //     $where .= " AND `city` LIKE '%$city%' ";
    // }

    // if( isset( $_SESSION['homepage'] ) && $_SESSION['homepage'] == true ) {
    //     //$notin = '';
    //     //$where = '';
    //     $custom_sql_text = '';
    //     $dist_query = '';
    // }

    // $orderBy = ' ORDER BY';
    // $orderBy .= '`xlikes_created_at` DESC';
    // $orderBy .= ',`xvisits_created_at` DESC';
    // $orderBy .= ',`xmatches_created_at` DESC';
    // $orderBy .= ',`is_pro` DESC,`hot_count` DESC,`gender` DESC';
    // $query = 'SELECT *, ROUND( ( 6371 * acos(cos(radians(' . $u->lat . ')) * cos(radians(`lat`)) * cos(radians(`lng`) - radians(' . $u->lng . ')) + sin(radians(' . $u->lat . ')) * sin(radians(`lat`)))) ,1) as dist FROM `users` WHERE `id` > 0 ' . $notin . $where . $custom_sql_text . $dist_query . $orderBy . ' LIMIT '.$limit.' OFFSET '.$offset.';';
    //     echo $query;
    // return $query;
}
function can_change_gender($gender){
    global $db;
    $can = $db->where('lang_key', $gender)->getValue('langs','options');
    if((int)$can === 1){
        return true;
    }else{
        return false;
    }
}
function _GetFindMatcheQuery($user_id, $limit, $offset, $country = true){
    global $config,$db;
    $where_or = array();
    $where_and = array();
    $u = auth();
    // main query
    $query = 'SELECT DISTINCT *, ROUND( ( 6371 * acos(cos(radians(' . $u->lat . ')) * cos(radians(`lat`)) * cos(radians(`lng`) - radians(' . $u->lng . ')) + sin(radians(' . $u->lat . ')) * sin(radians(`lat`)))) ,1) as dist FROM `users`';
    // Filters
    $where = ' WHERE ( ';

    $dist_query = '';
    // must be verified
    $where_and[] = '`active` = "1"';
    //$where_and[] = '`privacy_show_profile_match_profiles` = "1"';
    //********** public search params *****************//
    // check gender from post or from session
    $genders = null;
    $gender_query = '';

    /*

    if( $config->opposite_gender == "1" ) {
        if ($genders == null) {
            $genders = GetGenders($u);
        }
    }

    if( isset($_SESSION['_gender']) && $_SESSION['_gender'] !== ''){
        $genders = Secure( $_SESSION['_gender'] );
    }
    if( isset($_POST['_gender']) && $_POST['_gender'] !== ''){
        $_SESSION[ '_gender' ] = $_POST['_gender'];
        $genders = Secure( $_POST['_gender'] );
    }



    if( is_array($genders) ){
        $genders = @implode( ',' , $genders );
    }else{
        $genders = @explode( ',' , $genders );

        if($config->opposite_gender == "1"){
            foreach($genders as $key => $value ){
                if($value == $u->gender){
                    unset($genders[$key]);
                }
            }
        }
        $genders = @implode( ',' , $genders );
    }

    var_dump($genders);

    if( strpos( $genders, ',' ) === false ) {
        $gender_query = '`gender` = "'. $genders .'"';
        $where_and[] = $gender_query;
    }else{
        $gender_query = '`gender` IN ('. $genders .')';
        $where_and[] = $gender_query;
    }
    */
    if( $config->opposite_gender == "1" ) {
        $_SESSION['_gender'] = GetGenders($u);
    }else{
        unset($_SESSION['_gender']);
        $_SESSION['_gender'] = GetGendersKeys();
    }
    if( isset($_SESSION['_gender']) && $_SESSION['_gender'] !== ''){
        $genders = Secure( $_SESSION['_gender'] );
    }
    if( isset($_POST['_gender']) && !empty($_POST['_gender'])){
        $_SESSION[ '_gender' ] = Secure( $_POST['_gender'] );
        $genders = $_SESSION[ '_gender' ];
    }

    if( $config->opposite_gender == "1" ) {
        if ($genders == null) {
            $genders = GetGenders($u);
        }
    }

    if( strpos( $genders, ',' ) === false ) {
        $gender_query = '`gender` = "'. $genders .'"';
        $where_and[] = $gender_query;
    }else{
        $gender_query = '`gender` IN ('. $genders .')';
        $where_and[] = $gender_query;
    }

    //var_dump($gender_query);
    $age_query = '';
    // check age from post or from session
    if( isset($_POST['_age_from']) && !empty($_POST['_age_from']) && isset($_POST['_age_to']) && !empty($_POST['_age_to']) ){
        $age_query = 'DATEDIFF(CURDATE(), `birthday`)/365 >= "'. Secure($_POST['_age_from']) .'" AND DATEDIFF(CURDATE(), `birthday`)/365 <= "'. Secure($_POST['_age_to']) . '"';
        $where_and[] = $age_query;
    }else{
        if(isset( $_SESSION['_age_from'] ) && isset( $_SESSION['_age_to'] )) {
            $age_query = 'DATEDIFF(CURDATE(), `birthday`)/365 >= "'. Secure($_SESSION['_age_from']) .'" AND DATEDIFF(CURDATE(), `birthday`)/365 <= "'. Secure($_SESSION['_age_to']) . '"';
            $where_and[] = $age_query;
        }else{
            $age_query = 'DATEDIFF(CURDATE(), `birthday`)/365 >= "20" AND DATEDIFF(CURDATE(), `birthday`)/365 <= "55"';
            $where_and[] = $age_query;
        }
    }
    if( $u->show_me_to == '' ) {
        if (
            ( isset($_POST['_lat']) && !empty($_POST['_lat']) && isset($_POST['_lng']) && !empty($_POST['_lng']) )
            ||
            ( isset($_SESSION['_lat']) && !empty($_SESSION['_lat']) && isset($_SESSION['_lng']) && !empty($_SESSION['_lng']) )
        ) {
            $lat = 0;
            $lng = 0;
            $located = 125;
            if( isset( $_SESSION['_lat'] ) ) $lat = Secure($_SESSION['_lat']);
            if( isset( $_POST['_lat'] ) ) $lat = Secure($_POST['_lat']);

            if( isset( $_SESSION['_lng'] ) ) $lng = Secure($_SESSION['_lng']);
            if( isset( $_POST['_lng'] ) ) $lng = Secure($_POST['_lng']);

            if( isset( $_SESSION['_located'] ) ) $located = Secure($_SESSION['_located']);
            if( isset( $_POST['_located'] ) ) $located = Secure($_POST['_located']);

            $distance = 'ROUND( ( 6371 * acos(cos(radians(' . $lat . ')) * cos(radians(`lat`)) * cos(radians(`lng`) - radians(' . $lng . ')) + sin(radians(' . $lat . ')) * sin(radians(`lat`)))) ,1) ';
            $dist_query = $distance . ' <= ' . $located;
            $where_and[] = $dist_query;
        }
    }else{
        if( $country == true ) {
            $where_and[] = '`country` = "' . $u->show_me_to . '"';
        }
    }

    if (
        ( isset($_POST['_lat']) && !empty($_POST['_lat']) && isset($_POST['_lng']) && !empty($_POST['_lng']) )
        ||
        ( isset($_SESSION['_lat']) && !empty($_SESSION['_lat']) && isset($_SESSION['_lng']) && !empty($_SESSION['_lng']) )
    ) {
        $lat = 0;
        $lng = 0;
        $located = 7;
        if( isset( $_SESSION['_lat'] ) ) $lat = Secure($_SESSION['_lat']);
        if( isset( $_POST['_lat'] ) ) $lat = Secure($_POST['_lat']);

        if( isset( $_SESSION['_lng'] ) ) $lng = Secure($_SESSION['_lng']);
        if( isset( $_POST['_lng'] ) ) $lng = Secure($_POST['_lng']);

        if( isset( $_SESSION['_located'] ) ) $located = Secure($_SESSION['_located']);
        if( isset( $_POST['_located'] ) ) $located = Secure($_POST['_located']);

        $distance = 'ROUND( ( 6371 * acos(cos(radians(' . $lat . ')) * cos(radians(`lat`)) * cos(radians(`lng`) - radians(' . $lng . ')) + sin(radians(' . $lat . ')) * sin(radians(`lat`)))) ,1) ';
        $dist_query = $distance . ' <= ' . $located;
    }
    //******************* Looks Filters ************************//
    if( isset($_POST['_height_from']) && !empty($_POST['_height_from']) && isset($_POST['_height_to']) && !empty($_POST['_height_to']) ){
        $where_or[] = '`height` BETWEEN "'. Secure($_POST['_height_from']) .'" AND "'. Secure($_POST['_height_to']) .'"';
    }
    if( isset($_POST['_body']) && !empty($_POST['_body']) ){
        if( strpos( Secure( $_POST['_body'] ), ',' ) === false ) {
            $where_or[] = '`body` = "'. Secure($_POST['_body']) . '"';
        }else{
            $where_or[] = '`body` IN ('. Secure($_POST['_body']) .')';
        }
    }
    //******************* Background Filter ********************//
    if( isset($_POST['_language']) && !empty($_POST['_language']) ){
        $where_or[] = '`language` = "'. Secure($_POST['_language']) .'"';
    }
    if( isset($_POST['_ethnicity']) && !empty($_POST['_ethnicity']) ){
        if( strpos( Secure( $_POST['_ethnicity'] ), ',' ) === false ) {
            $where_or[] = '`ethnicity` = "'. Secure($_POST['_ethnicity']) . '"';
        }else{
            $where_or[] = '`ethnicity` IN ('. Secure($_POST['_ethnicity']) .')';
        }
    }
    if( isset($_POST['_religion']) && !empty($_POST['_religion']) ){
        if( strpos( Secure( $_POST['_religion'] ), ',' ) === false ) {
            $where_or[] = '`religion` = "'. Secure($_POST['_religion']) . '"';
        }else{
            $where_or[] = '`religion` IN ('. Secure($_POST['_religion']) .')';
        }
    }
    //******************* LifeStyle filter *********************//
    if( isset($_POST['_relationship']) && !empty($_POST['_relationship']) ){
        if( strpos( Secure( $_POST['_relationship'] ), ',' ) === false ) {
            $where_or[] = '`relationship` = "'. Secure($_POST['_relationship']) .'"';
        }else{
            $where_or[] = '`relationship` IN ('. Secure($_POST['_relationship']) .')';
        }
    }
    if( isset($_POST['_smoke']) && !empty($_POST['_smoke']) ){
        if( strpos( Secure( $_POST['_smoke'] ), ',' ) === false ) {
            $where_or[] = '`smoke` = "'. Secure($_POST['_smoke']) . '"';
        }else{
            $where_or[] = '`smoke` IN ('. Secure($_POST['_smoke']) .')';
        }
    }
    if( isset($_POST['_drink']) && !empty($_POST['_drink']) ){
        if( strpos( Secure( $_POST['_drink'] ), ',' ) === false ) {
            $where_or[] = '`drink` = "'. Secure($_POST['_drink']) . '"';
        }else{
            $where_or[] = '`drink` IN ('. Secure($_POST['_drink']) .')';
        }
    }
    //******************* More Filter **************************//
    if( isset($_POST['_interest']) && !empty($_POST['_interest']) ){
        $where_or[] = '`interest` like "%'. Secure($_POST['_interest']) .'%"';
    }
    if( isset($_POST['_education']) && !empty($_POST['_education']) ){
        if( strpos( Secure( $_POST['_education'] ), ',' ) === false ) {
            $where_or[] = '`education` = "'. Secure($_POST['_education']) . '"';
        }else{
            $where_or[] = '`education` IN ('. Secure($_POST['_education']) .')';
        }
    }
    if( isset($_POST['_pets']) && !empty($_POST['_pets']) ){
        if( strpos( Secure( $_POST['_pets'] ), ',' ) === false ) {
            $where_or[] = '`pets` = "'. Secure($_POST['_pets']) .'"';
        }else{
            $where_or[] = '`pets` IN ('. Secure($_POST['_pets']) .')';
        }
    }
    if( !empty($where_or) ){
        $where = $where . '('. implode($where_or, ' AND ') . ') ';
    }
    if( !empty($where_and) ){
        if( !empty($where_or) ) {
            $where = $where . ' AND (' . implode($where_and, ' AND ') . ')';
        }else{
            $where = $where . ' (' . implode($where_and, ' AND ') . ')';
        }
    }

    if( isset( $_REQUEST['access_token'] ) ) {
        $uid = GetUserFromSessionID(Secure($_REQUEST['access_token']));
        $u->id = $uid;
    }

    $notin = '';
    if( isset( $u->id ) ) {
        // to exclude blocked users
        $notin = ' AND `id` NOT IN (SELECT `block_userid` FROM `blocks` WHERE `user_id` = ' . $u->id . ') ';
        // to exclude liked and disliked users users
        $notin .= ' AND `id` NOT IN (SELECT `like_userid` FROM `likes` WHERE `user_id` = ' . $u->id . ') ';
        $notin .= ' AND `id` NOT IN (SELECT `user_id` FROM `likes` WHERE `like_userid` = ' . $u->id . ') ';
        $notin .= ' AND `id` <> "' . $u->id . '" ';
        $notin .= ' AND '.$age_query;
        if( $dist_query !== '' ) {
            $notin .= ' AND ' . $dist_query;
        }
    }

    $custom_sql = [];
    if(isset($_POST['custom_profile_data'])){
        $count = 100;
        for($i = 0 ; $i <= $count ; $i++ ){
            if(isset($_POST['fid_' . $i])){
                if(!empty($_POST['fid_' . $i])){
                    $custom_sql[] = ' id IN (SELECT `user_id` FROM `userfields` WHERE `fid_' . $i .'` = "'.Secure($_POST['fid_' . $i]) . '") ';
                }
            }
        }
    }

    $custom_sql_text = '';
    if(!empty($custom_sql)){
        $custom_sql_text .= ' AND ( ';
        $custom_sql_text .= implode(' OR ', $custom_sql);
        $custom_sql_text .= ' ) ';
    }


    if( $u->show_me_to !== '' ){
        $custom_sql_text .= ' OR (`country` = "'.$u->show_me_to.'"' . $notin . ') ';
    }

    //if( $config->opposite_gender == "1" ){
        $custom_sql_text .= ' AND (' . $gender_query . ' ' . $notin . ')';
    //}else{

    //}



    if( $limit == 0 ){
        $limit = 20;
    }

    $orderBy = ' ORDER BY ';
    $orderBy .= '`xlikes_created_at` DESC';
    $orderBy .= ',`xvisits_created_at` DESC';
    $orderBy .= ',`xmatches_created_at` DESC';
    $orderBy .= ',`is_pro` DESC,`hot_count` DESC';
    $query = $query . ' ' . $where . $notin . ') ' . $custom_sql_text . $orderBy . ' LIMIT '.$limit.' OFFSET '.$offset.';';
    return $query;
}
function allow_gender($genders, $gender){
    if(in_array($gender, $genders)) {
        return true;
    }else{
        return false;
    }
}
function GetAnnouncement($id) {
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    $data    = array();
    if (empty($id) || !is_numeric($id) || $id < 1) {
        return false;
    }
    $query = mysqli_query($conn, "SELECT * FROM `announcement` WHERE `id` = {$id} ORDER BY `id` DESC");
    if (mysqli_num_rows($query) == 1) {
        $fetched_data         = mysqli_fetch_assoc($query);
        return $fetched_data;
    }
}
function GetHomeAnnouncements() {
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    $user_id      = Secure(auth()->id);
    $query        = mysqli_query($conn, "SELECT `id` FROM `announcement` WHERE `active` = '1' AND `id` NOT IN (SELECT `announcement_id` FROM `announcement_views` WHERE `user_id` = {$user_id}) ORDER BY RAND() LIMIT 1");
    $fetched_data = mysqli_fetch_assoc($query);
    $data         = GetAnnouncement($fetched_data['id']);
    return $data;
}
function IsThereAnnouncement() {
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    $user_id = Secure(auth()->id);
    $query   = mysqli_query($conn, "SELECT COUNT(`id`) as count FROM `announcement` WHERE `active` = '1' AND `id` NOT IN (SELECT `announcement_id` FROM `announcement_views` WHERE `user_id` = {$user_id})");
    $sql     = mysqli_fetch_assoc($query);
    return ($sql['count'] > 0) ? true : false;
}
function IsActiveAnnouncement($id) {
    global $conn;
    $id    = Secure($id);
    $query = mysqli_query($conn, "SELECT COUNT(`id`) FROM `announcement` WHERE `id` = '{$id}' AND `active` = '1'");
    return (Sql_Result($query, 0) == 1) ? true : false;
}
function IsViewedAnnouncement($id) {
    global $conn, $wo;
    if (IS_LOGGED == false) {
        return false;
    }
    $id      = Secure($id);
    $user_id = Secure(auth()->id);
    $query   = mysqli_query($conn, "SELECT COUNT(`id`) FROM `announcement_views` WHERE `announcement_id` = '{$id}' AND `user_id` = '{$user_id}'");
    return (Sql_Result($query, 0) > 0) ? true : false;
}
function Sql_Result($res, $row = 0, $col = 0) {
    $numrows = mysqli_num_rows($res);
    if ($numrows && $row <= ($numrows - 1) && $row >= 0) {
        mysqli_data_seek($res, $row);
        $resrow = (is_numeric($col)) ? mysqli_fetch_row($res) : mysqli_fetch_assoc($res);
        if (isset($resrow[$col])) {
            return $resrow[$col];
        }
    }
    return false;
}
function GetNotificationIdFromChatRequest($route){
    global $db;
    $notification = $db->where('type','message')->where('url',$route)->orderBy('created_at','DESC')->get('notifications',1,array('*'));
    if(isset($notification[0]) && !empty($notification[0])) {
        return $notification[0];
    }else{
        return false;
    }
}
function CreateNewAudioCall($re_data,$api = false) {
    global  $conn;
    if( $api == false ) {
        if (IS_LOGGED == false) {
            return false;
        }
    }
    if (empty($re_data)) {
        return false;
    }
    $user_data  = userData($re_data['from_id']);
    $user_data2 = userData($re_data['to_id']);
    if (empty($user_data) || empty($user_data2)) {
        return false;
    }
    $logged_user_id    = Secure(auth()->id);
    $query1            = mysqli_query($conn, "DELETE FROM `audiocalls` WHERE `from_id` = {$logged_user_id} OR `to_id` = {$logged_user_id}");
    $re_data['active'] = 0;
    $re_data['called'] = $re_data['from_id'];
    $re_data['time']   = Secure(time());
    $fields            = '`' . implode('`, `', array_keys($re_data)) . '`';
    $data              = '\'' . implode('\', \'', $re_data) . '\'';
    $query             = mysqli_query($conn, "INSERT INTO `audiocalls` ({$fields}) VALUES ({$data})");
    if ($query) {
        return mysqli_insert_id($conn);
    } else {
        return false;
    }
}
function CreateNewVideoCall($re_data,$api = false) {
    global $conn;
    if( $api == false ) {
        if (IS_LOGGED == false) {
            return false;
        }
    }
    if (empty($re_data)) {
        return false;
    }
    $user_data  = userData($re_data['from_id']);
    $user_data2 = userData($re_data['to_id']);
    if (empty($user_data) || empty($user_data2)) {
        return false;
    }
    $logged_user_id    = Secure(auth()->id);
    $query1            = mysqli_query($conn, "DELETE FROM `videocalles` WHERE `from_id` = {$logged_user_id} OR `to_id` = {$logged_user_id}");
    $re_data['active'] = 0;
    $re_data['called'] = $re_data['from_id'];
    $re_data['time']   = Secure(time());
    $fields            = '`' . implode('`, `', array_keys($re_data)) . '`';
    $data              = '\'' . implode('\', \'', $re_data) . '\'';
    $query             = mysqli_query($conn, "INSERT INTO `videocalles` ({$fields}) VALUES ({$data})");
    if ($query) {
        return mysqli_insert_id($conn);
    } else {
        return false;
    }
}
function CheckCallAnswer($id = 0,$api = false) {
    global $conn,$config;
    if( $api == false ) {
        if (IS_LOGGED == false) {
            return false;
        }
    }
    if (empty($id)) {
        return false;
    }
    $data1 = array();
    $id    = Secure($id);
    $query = mysqli_query($conn, "SELECT * FROM `videocalles`  WHERE `id` = '{$id}' AND `active` = '1' AND `declined` = '0'");
    if (mysqli_num_rows($query) > 0) {
        $sql          = mysqli_fetch_assoc($query);
        $sql['url'] = $config->uri . '/video-call/' . $id;
        $sql['id'] =  $id;
        return $sql;
    } else {
        return false;
    }
}
function CheckCallAnswerDeclined($id = 0,$api = false) {
    global $conn,$config;
    if( $api == false ) {
        if (IS_LOGGED == false) {
            return false;
        }
    }
    if (empty($id)) {
        return false;
    }
    $id    = Secure($id);
    $query = mysqli_query($conn, "SELECT COUNT(`id`) FROM `videocalles` WHERE `id` = '{$id}' AND `declined` = '1'");
    return (Sql_Result($query, 0) == 1) ? true : false;
}
function CheckFroInCalls($type = 'video'){
    global $conn, $config;
    if (IS_LOGGED == false) {
        return false;
    }
    $user_id = Secure(auth()->id);
    $data1 = array();
    $time = time() - 40;
    $table = '`videocalles`';
    if ($type == 'audio') {
        $table = '`audiocalls`';
    }
    $query = mysqli_query($conn, "SELECT * FROM {$table}  WHERE `to_id` = '{$user_id}' AND `time` > '$time' AND `active` = '0' AND `declined` = 0");
    if (mysqli_num_rows($query) > 0) {
        $sql = mysqli_fetch_assoc($query);
        if (isUserBlocked($sql['from_id'])) {
            return false;
        }
        $sql['url'] = $config->uri . '/video-call/' . $sql['id'];
        $sql['id'] =  $sql['id'];
        return $sql;
    } else {
        return false;
    }
}
function GetAllDataFromCallID($id = 0) {
    global $conn,$config;
    $user_id = auth()->id;
    if (IS_LOGGED == false) {
        return false;
    }
    if (empty($id)) {
        return false;
    }
    $data1 = array();
    $id    = Secure($id);
    $query = mysqli_query($conn, "SELECT * FROM `videocalles` WHERE `id` = '{$id}'");
    if (mysqli_num_rows($query) > 0) {
        $sql        = mysqli_fetch_assoc($query);
        $sql['url'] = $config->uri . '/video-call/' . $sql['id'];
        return $sql;
    } else {
        return false;
    }
}
function CheckAudioCallAnswer($id = 0,$api = false) {
    global $conn,$config;
    if( $api == false ) {
        if (IS_LOGGED == false) {
            return false;
        }
    }
    if (empty($id)) {
        return false;
    }
    $data1 = array();
    $id    = Secure($id);
    $query = mysqli_query($conn, "SELECT * FROM `audiocalls`  WHERE `id` = '{$id}' AND `active` = '1' AND `declined` = '0'");
    if (mysqli_num_rows($query) > 0) {
        if( $api == false ) {
            return true;
        }else{
            $sql = mysqli_fetch_assoc($query);
            $sql['url'] = $config->uri . '/audio-call/' . $sql['id'];
            $sql['id'] =  $sql['id'];
            return $sql;
        }
    } else {
        return false;
    }
}
function CheckAudioCallAnswerDeclined($id = 0,$api = false) {
    global $conn;
    if( $api == false ) {
        if (IS_LOGGED == false) {
            return false;
        }
    }
    if (empty($id)) {
        return false;
    }
    $id    = Secure($id);
    $query = mysqli_query($conn, "SELECT COUNT(`id`) FROM `audiocalls` WHERE `id` = '{$id}' AND `declined` = '1'");
    return (Sql_Result($query, 0) == 1) ? true : false;
}
function IsConversationDeclined($notifier_id = 0, $recipient_id = 0){
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    if (empty($notifier_id)) {
        return false;
    }
    if (empty($recipient_id)) {
        return false;
    }
    $notifier_id    = Secure($notifier_id);
    $recipient_id   = Secure($recipient_id);
    $query = mysqli_query($conn, "SELECT `status`,`created_at` FROM `conversations` WHERE ( (`sender_id` = {$notifier_id} AND `receiver_id` = {$recipient_id}) OR (`sender_id` = {$recipient_id} AND `receiver_id` = {$notifier_id}) ) AND `status` = 2");
    if (mysqli_num_rows($query) > 0) {
        $arr = ['status' => (int)Sql_Result($query, 0), 'created_at' => Sql_Result($query, 1)];
        return $arr;
    }else{
        return false;
    }
}
function CheckIfConversionAccepted($notifier_id = 0, $recipient_id = 0){
    global $conn,$config;
    if($config->message_request_system == 'off'){
        return true;
    }
    if (IS_LOGGED == false) {
        return false;
    }
    if (empty($notifier_id)) {
        return false;
    }
    if (empty($recipient_id)) {
        return false;
    }
    $notifier_id    = Secure($notifier_id);
    $recipient_id   = Secure($recipient_id);



//    $query = mysqli_query($conn, "SELECT `id` FROM `notifications` WHERE `type` = 'message' AND `notifier_id` = {$notifier_id} AND `recipient_id` = {$recipient_id}");
//    if (mysqli_num_rows($query) > 0) {
//        return true;
//    } else {
//        return false;
//    }



    if($notifier_id !== auth()->id){
        $query = mysqli_query($conn, "SELECT `status`,`created_at` FROM `conversations` WHERE `sender_id` = {$notifier_id} AND `receiver_id` = {$recipient_id}");
    }else{
        $query = mysqli_query($conn, "SELECT `status`,`created_at` FROM `conversations` WHERE `sender_id` = {$recipient_id} AND `receiver_id` = {$notifier_id}");

    }

    if (mysqli_num_rows($query) > 0) {
        $arr = ['status' => (int)Sql_Result($query, 0), 'created_at' => Sql_Result($query, 1)];
        return $arr;
//        if((int)Sql_Result($query, 0) == 1){
//            //return true;
//            $arr = ['status' => (int)Sql_Result($query, 0), 'created_at' => Sql_Result($query, 1)];
//            return $arr;
//        }else if((int)Sql_Result($query, 0) == 2){
//            //return true;
//            $arr = ['status' => (int)Sql_Result($query, 0), 'created_at' => Sql_Result($query, 1)];
//            return $arr;
//        }else{
//            $arr = ['status' => (int)Sql_Result($query, 0), 'created_at' => Sql_Result($query, 1)];
//            return $arr;
//            //return false;
//        }
    } else {
        return false;
    }

}
function CheckIfUserDeclinedBefore($userid =0, $toid = 0){
    global $conn;
    if (IS_LOGGED == false) {
        return [];
    }
    if (empty($userid)) {
        return [];
    }
    if (empty($toid)) {
        return 0;
    }
    $userid    = Secure($userid);
    $toid      = Secure($toid);
    $query = mysqli_query($conn, "SELECT `status`,`created_at` FROM `conversations` WHERE `sender_id` = {$userid} AND `receiver_id` = {$toid}");
    if (mysqli_num_rows($query) > 0) {
        $row = $query->fetch_object();
        @mysqli_free_result($query);
        if(isset($row)){
            return $row;
        }else{
            return [];
        }
    } else {
        return [];
    }
}
function GetChatRequestCount($user_id,$api=false){
    global $conn;
    if( $api === false ){
        if (IS_LOGGED == false) {
            return 0;
        }
    }
    if (empty($user_id)) {
        return 0;
    }
    $userid    = Secure($user_id);
    $query = mysqli_query($conn, "SELECT count('id') FROM `conversations` WHERE `status` = 0 AND `receiver_id` = {$userid}");
    if (mysqli_num_rows($query) > 0) {
        if((int)Sql_Result($query, 0) > 0){
            return (int)Sql_Result($query, 0);
        }else{
            return 0;
        }
    } else {
        return 0;
    }
}
function GetChatRequestList($user_id,$api=false){
    global $conn;
    if( $api === false ){
        if (IS_LOGGED == false) {
            return 0;
        }
    }
    if (empty($user_id)) {
        return 0;
    }
    $data = array();
    $userid    = Secure($user_id);
    $query = mysqli_query($conn, "SELECT * FROM `conversations` WHERE `status` = 0 AND `receiver_id` = {$userid}");
    while ($fetched_data = mysqli_fetch_assoc($query)) {
        $fetched_data['senderData'] = userData($fetched_data['sender_id']);
        $data[] = $fetched_data;
    }
    return $data;
}
function IsUserSpammer($user_id){
    global $conn,$db;
    if (IS_LOGGED == false) {
        return 0;
    }
    if (empty($user_id)) {
        return 0;
    }
    $userid    = Secure($user_id);
    $query = mysqli_query($conn, "SELECT count('id') FROM `conversations` WHERE `created_at` >= DATE_SUB(CURDATE(), INTERVAL 6 MINUTE) AND `sender_id` = {$userid}");
    if (mysqli_num_rows($query) > 0) {
        if((int)Sql_Result($query, 0) > 5){
            return true;
        }else{
            return false;
        }
    } else {
        return false;
    }
}
function LangsNamesFromDB($lang = 'english') {
    global $conn, $wo;
    $data  = array();
    $query = mysqli_query($conn, "SHOW COLUMNS FROM `langs`");
    while ($fetched_data = mysqli_fetch_assoc($query)) {
        $data[$fetched_data['Field']] = __($fetched_data['Field']);
    }
    unset($data['id']);
    unset($data['ref']);
    unset($data['lang_key']);
    unset($data['options']);
    return $data;
}
function DeleteChatFiles($from,$to){
    global $db,$_UPLOAD;
    if (IS_LOGGED == false) {
        return 0;
    }
    if (empty($from)) {
        return false;
    }
    if (empty($to)) {
        return false;
    }
    $deleted = false;
    $deleted_message = $db->where('from_delete', '1')
        ->where('to_delete', '1')
        ->where('( `to` = ' . $to . ' AND `from` = ' . $from . ' ) OR ( `to` = ' . $from . ' AND `from` = ' . $to . ' )')
        ->get('messages',null,array('*'));
    if(!empty($deleted_message)){
        foreach ($deleted_message as $key => $value){
            $file = $value['media'];
            if( file_exists($file) ) {
                if( @is_writable($file) ) {
                    if( @unlink($file) ) {
                        $deleted = true;
                    }else{
                        $deleted = false;
                    }
                }
            }
        }
        return $deleted;
    }else{
        return false;
    }
}
function GetCustomPages() {
    global $conn;
    $data          = array();
    $query_one     = "SELECT * FROM `custom_pages` ORDER BY `id` DESC";
    $sql_query_one = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql_query_one)) {
        $data[] = GetCustomPage($fetched_data['page_name']);
    }
    return $data;
}
function GetCustomPage($page_name) {
    global $conn;
    if (empty($page_name)) {
        return false;
    }
    $data          = array();
    $page_name     = Secure($page_name);
    $query_one     = "SELECT * FROM `custom_pages` WHERE `page_name` = '{$page_name}'";
    $sql_query_one = mysqli_query($conn, $query_one);
    $fetched_data  = mysqli_fetch_assoc($sql_query_one);
    return $fetched_data;
}
function RegisterNewField($registration_data) {
    global $conn,$db;
    if (empty($registration_data)) {
        return false;
    }
    $fields = '`' . implode('`, `', array_keys($registration_data)) . '`';
    $data   = '\'' . implode('\', \'', $registration_data) . '\'';
    $query  = mysqli_query($conn, "INSERT INTO `profilefields` ({$fields}) VALUES ({$data})");
    if ($query) {

        $sql_id  = mysqli_insert_id($conn);
        $column  = 'fid_' . $sql_id;
        $length  = $registration_data['length'];
        $query_2 = mysqli_query($conn, "ALTER TABLE `userfields` ADD COLUMN `{$column}` varchar({$length}) NOT NULL DEFAULT ''");
        $insert = $db->insert('langs', ['lang_key' => $registration_data["name"], GetActiveLang() => secure($registration_data["description"])]);

        return true;
    }
    return false;
}
function GetProfileFields($type = 'all') {
    global $conn;
    $data       = array();
    $where      = '';
    $placements = array(
        'profile',
        'general',
        'social'
    );
    if ($type != 'all' && in_array($type, $placements)) {
        $where = "WHERE `placement` = '{$type}' AND `placement` <> 'none' AND `active` = '1'";
    } else if ($type == 'none') {
        $where = "WHERE `profile_page` = '1' AND `active` = '1'";
    } else if ($type != 'admin') {
        $where = "WHERE `active` = '1'";
    }
    $type      = Secure($type);
    $query_one = "SELECT * FROM `profilefields` {$where} ORDER BY `id` ASC";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $fetched_data['fid'] = 'fid_' . $fetched_data['id'];
        $fetched_data['name'] = preg_replace_callback("/{{LANG (.*?)}}/", function($m) {
            return __($m[1]);
        }, $fetched_data['name']);
        $fetched_data['description'] = preg_replace_callback("/{{LANG (.*?)}}/", function($m) {
            return __($m[1]);
        }, $fetched_data['description']);
        $fetched_data['type'] = preg_replace_callback("/{{LANG (.*?)}}/", function($m) {
            return __($m[1]);
        }, $fetched_data['type']);
        $data[]               = $fetched_data;
    }
    return $data;
}
function GetUserCustomFields() {
    global $conn;
    $data       = array();
    $where = "WHERE `active` = '1' AND `profile_page` = 1";

    $query_one = "SELECT * FROM `profilefields` {$where} ORDER BY `id` ASC";
    $sql       = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $fetched_data['fid'] = 'fid_' . $fetched_data['id'];
        $fetched_data['name'] = preg_replace_callback("/{{LANG (.*?)}}/", function($m) {
            return __($m[1]);
        }, $fetched_data['name']);
        $fetched_data['description'] = preg_replace_callback("/{{LANG (.*?)}}/", function($m) {
            return __($m[1]);
        }, $fetched_data['description']);
        $fetched_data['type'] = preg_replace_callback("/{{LANG (.*?)}}/", function($m) {
            return __($m[1]);
        }, $fetched_data['type']);
        $data[]               = $fetched_data;
    }
    return $data;
}
function UserFieldsData($user_id) {
    global $conn;
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 0) {
        return false;
    }
    $data         = array();
    $user_id      = Secure($user_id);
    $query_one    = "SELECT * FROM `userfields` WHERE `user_id` = {$user_id}";
    $sql          = mysqli_query($conn, $query_one);
    $fetched_data = mysqli_fetch_assoc($sql);
    if (empty($fetched_data)) {
        return array();
    }
    return $fetched_data;
}
function UpdateUserCustomData($user_id, $update_data, $loggedin = true) {
    global $conn;
    if ($loggedin == true) {
        if (IS_LOGGED == false) {
            return false;
        }
    }
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 0) {
        return false;
    }
    if (empty($update_data)) {
        return false;
    }
    $user_id = Secure($user_id);
    $u = auth();
    if ($loggedin == true) {
        if ($u->admin === "0") {
            if ($u->id != $user_id) {
                return false;
            }
        }
    }
    $update = array();
    foreach ($update_data as $field => $data) {
        foreach ($data as $key => $value) {
            $update[] = '`' . $key . '` = \'' . Secure($value, 0) . '\'';
        }
    }
    $impload     = implode(', ', $update);
    $query_one   = "UPDATE `userfields` SET {$impload} WHERE `user_id` = {$user_id}";
    $query_1     = mysqli_query($conn, "SELECT COUNT(`id`) as count FROM `userfields` WHERE `user_id` = {$user_id}");
    $query_1_sql = mysqli_fetch_assoc($query_1);
    $query       = false;
    if ($query_1_sql['count'] == 1) {
        $query = mysqli_query($conn, $query_one);
    } else {
        $query_2 = mysqli_query($conn, "INSERT INTO `userfields` (`user_id`) VALUES ({$user_id})");
        if ($query_2) {
            $query = mysqli_query($conn, $query_one);
        }
    }
    if ($query) {
        return true;
    }
    return false;
}
function GetFieldData($id = 0) {
    global $conn;
    if (empty($id) || !is_numeric($id) || $id < 0) {
        return false;
    }
    $data         = array();
    $id           = Secure($id);
    $query_one    = "SELECT * FROM `profilefields` WHERE `id` = {$id}";
    $sql          = mysqli_query($conn, $query_one);
    $fetched_data = mysqli_fetch_assoc($sql);
    if (empty($fetched_data)) {
        return array();
    }
    return $fetched_data;
}
function UpdateField($id, $update_data) {
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    if (empty($id) || !is_numeric($id) || $id < 0) {
        return false;
    }
    if (empty($update_data)) {
        return false;
    }
    $id = Secure($id);
//    $u = auth();
//    if ($u->admin === "0") {
//        return false;
//    }
    $update = array();
    foreach ($update_data as $field => $data) {
        $update[] = '`' . $field . '` = \'' . Secure($data, 0) . '\'';
        if ($field == 'length') {
            $mysqli = mysqli_query($conn, "ALTER TABLE `userfields` CHANGE `fid_{$id}` `fid_{$id}` VARCHAR(" . Secure($data) . ") CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '';");
        }
    }
    $impload   = implode(', ', $update);
    $query_one = "UPDATE `profilefields` SET {$impload} WHERE `id` = {$id} ";
    $query     = mysqli_query($conn, $query_one);
    if ($query) {
        return true;
    }
    return false;
}
function DeleteField($id) {
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
//    $u = auth();
//    if ($u->admin === "0") {
//        return false;
//    }
    $id    = Secure($id);
    $query = mysqli_query($conn, "DELETE FROM `profilefields` WHERE `id` = {$id}");
    if ($query) {
        $query2 = mysqli_query($conn, "ALTER TABLE `userfields` DROP `fid_{$id}`;");
        if ($query2) {
            return true;
        }
    }
    return false;
}
function br2nl($st) {
    $breaks   = array(
        "\r\n",
        "\r",
        "\n"
    );
    $st       = str_replace($breaks, "", $st);
    $st_no_lb = preg_replace("/\r|\n/", "", $st);
    return preg_replace('/<br(\s+)?\/?>/i', "\r", $st_no_lb);
}
function isGenderFree($gender_code){
    global $conn,$config;
    if($config->free_features === "1"){
        return true;
    }
    if (empty($gender_code) || !is_numeric($gender_code) || $gender_code < 0) {
        return false;
    }
    $id    = Secure($gender_code);
    $query = mysqli_query($conn, "SELECT `options` FROM `langs` WHERE `lang_key` = '{$id}' AND `ref` = 'gender'");
    return (Sql_Result($query, 0) == '1') ? true : false;
}
function TwoFactor($username = '') {
    global $config, $db;

    if (empty($username)) {
        return true;
    }
    if ($config->two_factor == 0) {
        return true;
    }
    $getuser = userData($username);
    if ($getuser->two_factor == 0 || $getuser->two_factor_verified == 0) {
        return true;
    }
    $code = rand(111111, 999999);
    $hash_code = md5($code);
    $update_code =  $db->where('id', $username)->update('users', array('email_code' => $hash_code));
    $message = "Your confirmation code is: $code";
    if (!empty($getuser->phone_number) && ($config->two_factor_type == 'both' || $config->two_factor_type == 'phone')) {
        $send_message = SendSMS($getuser->phone_number, $message);
    }
    if ($config->two_factor_type == 'both' || $config->two_factor_type == 'email') {
        $send = SendEmail($getuser->email,'Please verify that it\'s you',$message,false);
    }
    return false;
}
function UserIdFromUsername($username) {
    global $conn;
    if (empty($username)) {
        return false;
    }
    $username = Secure($username);
    $query    = mysqli_query($conn, "SELECT `id` FROM `users` WHERE `username` = '{$username}'");
    return Wo_Sql_Result($query, 0, 'id');
}
function get_ip_address() {
    if (!empty($_SERVER['HTTP_CLIENT_IP']) && validate_ip($_SERVER['HTTP_CLIENT_IP'])) {
        return $_SERVER['HTTP_CLIENT_IP'];
    }
    if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        if (strpos($_SERVER['HTTP_X_FORWARDED_FOR'], ',') !== false) {
            $iplist = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            foreach ($iplist as $ip) {
                if (validate_ip($ip))
                    return $ip;
            }
        } else {
            if (validate_ip($_SERVER['HTTP_X_FORWARDED_FOR']))
                return $_SERVER['HTTP_X_FORWARDED_FOR'];
        }
    }
    if (!empty($_SERVER['HTTP_X_FORWARDED']) && validate_ip($_SERVER['HTTP_X_FORWARDED']))
        return $_SERVER['HTTP_X_FORWARDED'];
    if (!empty($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']) && validate_ip($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']))
        return $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'];
    if (!empty($_SERVER['HTTP_FORWARDED_FOR']) && validate_ip($_SERVER['HTTP_FORWARDED_FOR']))
        return $_SERVER['HTTP_FORWARDED_FOR'];
    if (!empty($_SERVER['HTTP_FORWARDED']) && validate_ip($_SERVER['HTTP_FORWARDED']))
        return $_SERVER['HTTP_FORWARDED'];
    return $_SERVER['REMOTE_ADDR'];
}
function validate_ip($ip) {
    if (strtolower($ip) === 'unknown')
        return false;
    $ip = ip2long($ip);
    if ($ip !== false && $ip !== -1) {
        $ip = sprintf('%u', $ip);
        if ($ip >= 0 && $ip <= 50331647)
            return false;
        if ($ip >= 167772160 && $ip <= 184549375)
            return false;
        if ($ip >= 2130706432 && $ip <= 2147483647)
            return false;
        if ($ip >= 2851995648 && $ip <= 2852061183)
            return false;
        if ($ip >= 2886729728 && $ip <= 2887778303)
            return false;
        if ($ip >= 3221225984 && $ip <= 3221226239)
            return false;
        if ($ip >= 3232235520 && $ip <= 3232301055)
            return false;
        if ($ip >= 4294967040)
            return false;
    }
    return true;
}
function ip_in_range($ip, $range) {
    if (strpos($range, '/') == false) {
        $range .= '/32';
    }
    // $range is in IP/CIDR format eg 127.0.0.1/24
    list($range, $netmask) = explode('/', $range, 2);
    $range_decimal    = ip2long($range);
    $ip_decimal       = ip2long($ip);
    $wildcard_decimal = pow(2, (32 - $netmask)) - 1;
    $netmask_decimal  = ~$wildcard_decimal;
    return (($ip_decimal & $netmask_decimal) == ($range_decimal & $netmask_decimal));
}
function Wo_Sql_Result($res, $row = 0, $col = 0) {
    if (!empty($res)) {
        $numrows = mysqli_num_rows($res);
        if ($numrows && $row <= ($numrows - 1) && $row >= 0) {
            mysqli_data_seek($res, $row);
            $resrow = (is_numeric($col)) ? mysqli_fetch_row($res) : mysqli_fetch_assoc($res);
            if (isset($resrow[$col])) {
                return $resrow[$col];
            }
        }
    }

    return false;
}
function Wo_UserData($user_id){
    global $wo, $conn, $cache;
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 0) {
        return false;
    }
    $data           = array();
    $user_id        = Secure($user_id);
    $query_one      = "SELECT * FROM `users` WHERE `id` = {$user_id}";
    $sql          = mysqli_query($conn, $query_one);
    $fetched_data = mysqli_fetch_assoc($sql);
    if (empty($fetched_data)) {
        return array();
    }
    return $fetched_data;
}
function Wo_RequestNewPayment($user_id = 0, $amount = 0) {
    global $conn,$db;
    if (empty($user_id)) {
        return false;
    }
    if (empty($amount)) {
        return false;
    }
    $user_id = Secure($user_id);
    $amount  = Secure($amount);
    if (Wo_IsUserPaymentRequested($user_id) === true) {
        return false;
    }
    $user_data   = Wo_UserData($user_id);
    $full_amount = Secure($user_data['aff_balance']);
    $time        = time();
    $query_text  = "INSERT INTO `affiliates_requests` (`user_id`, `amount`, `full_amount`, `time`) VALUES ('$user_id', '$amount', '$full_amount', '$time')";
    $query       = mysqli_query($conn, $query_text);
    if ($query) {

        $notif_data = array(
            'recipient_id' => 0,
            'type' => 'with',
            'admin' => 1,
            'created_at' => time()
        );

        $db->insert('notifications', $notif_data);
        return true;
    }
    return false;
}
function Wo_IsUserPaymentRequested($user_id = 0) {
    global $conn;
    if (empty($user_id)) {
        return false;
    }
    $user_id = Secure($user_id);
    $query   = mysqli_query($conn, "SELECT COUNT(`id`) FROM `affiliates_requests` WHERE `user_id` = '{$user_id}' AND status = '0'");
    return (Wo_Sql_Result($query, 0) == 1) ? true : false;
}
function Wo_GetPaymentsHistory($user_id = 0) {
    global $conn;
    if (empty($user_id)) {
        return false;
    }
    $user_id       = Secure($user_id);
    $data          = array();
    $query_one     = "SELECT `id` FROM `affiliates_requests` WHERE `user_id` = '{$user_id}' ORDER BY `id` DESC";
    $sql_query_one = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql_query_one)) {
        $data[] = Wo_GetPaymentHistory($fetched_data['id']);
    }
    return $data;
}
function Wo_GetAllPaymentsHistory($type = 0) {
    global $conn;
    $type  = Secure($type);
    $data  = array();
    $where = "";
    if ($type != 'all') {
        $where = "WHERE `status` = '{$type}'";
    }
    $query_one     = "SELECT * FROM `affiliates_requests` {$where} ORDER BY `id` DESC";
    $sql_query_one = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql_query_one)) {
        $data[] = Wo_GetPaymentHistory($fetched_data['id']);
    }
    return $data;
}
function Wo_UserActive($username) {
    global $conn;
    if (empty($username)) {
        return false;
    }
    $username = Secure($username);
    $query    = mysqli_query($conn, "SELECT COUNT(`user_id`) FROM `users`  WHERE (`username` = '{$username}' OR `email` = '{$username}' OR `phone_number` = '{$username}') AND `active` = '1'");
    return (Wo_Sql_Result($query, 0) == 1) ? true : false;
}
function Wo_CountPaymentHistory($id) {
    global $conn;
    $data          = array();
    $id            = Secure($id);
    $query_one     = "SELECT COUNT(`id`) as count FROM `affiliates_requests` WHERE `status` = '{$id}'";
    $sql_query_one = mysqli_query($conn, $query_one);
    $fetched_data  = mysqli_fetch_assoc($sql_query_one);
    return $fetched_data['count'];
}
function Wo_GetPaymentHistory($id) {
    global $conn, $wo;
    if (empty($id)) {
        return false;
    }
    $data                         = array();
    $id                           = Secure($id);
    $query_one                    = "SELECT * FROM `affiliates_requests` WHERE `id` = '{$id}'";
    $sql_query_one                = mysqli_query($conn, $query_one);
    $fetched_data                 = mysqli_fetch_assoc($sql_query_one);
    $fetched_data['user']         = userData($fetched_data['user_id']);
    $fetched_data['total_refs']   = Wo_CountRefs($fetched_data['user_id']);
    $fetched_data['time_text']    = Time_Elapsed_String($fetched_data['time']);
    //$fetched_data['callback_url'] = $wo['config']['site_url'] . '/' . 'requests.php?f=admincp&paid_user_id=' . $fetched_data['id'] . '&paid_ref_id=' . $fetched_data['id'];
    return $fetched_data;
}
function Wo_CountRefs($user_id = 0) {
    global $conn;
    $data          = array();
    $user_id       = Secure($user_id);
    $query_one     = "SELECT COUNT(`id`) as count FROM `users` WHERE `referrer` = '{$user_id}'";
    $sql_query_one = mysqli_query($conn, $query_one);
    $fetched_data  = mysqli_fetch_assoc($sql_query_one);
    return $fetched_data['count'];
}
function Wo_GetReferrers($user_id = 0) {
    global $conn, $wo;
    if (IS_LOGGED == false) {
        return false;
    }
    if (empty($user_id)) {
        $u = auth();
        $user_id = Secure($u->id);
    } else {
        $user_id = Secure($user_id);
    }
    $data          = array();
    $query_one     = "SELECT * FROM `users` WHERE `referrer` = '{$user_id}' ORDER BY `id` DESC";
    $sql_query_one = mysqli_query($conn, $query_one);
    while ($fetched_data = mysqli_fetch_assoc($sql_query_one)) {
        $data[] = Wo_UserData($fetched_data['id']);
    }
    return $data;
}
function Wo_UpdateBalance($user_id = 0, $balance = 0, $type = '+') {
    global $wo, $conn;
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 0) {
        return false;
    }
    if (empty($balance)) {
        return false;
    }
    $user_id   = Secure($user_id);
    $balance   = Secure($balance);
    $user_data = Wo_UserData($user_id);
    if ($type == '+') {
        $balance = ((float)$user_data['aff_balance'] + (float)$balance);
    } else {
        $balance = ((float)$user_data['aff_balance'] - (float)$balance);
    }
    $query_one = "UPDATE `users` SET `aff_balance` = '{$balance}' WHERE `id` = {$user_id} ";
    $query     = mysqli_query($conn, $query_one);
    if ($query) {
        return true;
    }
    return false;
}
function Wo_GetBanned($type = '') {
    global $conn;
    $data  = array();
    $query = mysqli_query($conn, "SELECT * FROM `banned_ip` ORDER BY id DESC");
    if ($type == 'user') {
        while ($fetched_data = mysqli_fetch_assoc($query)) {
            $data[] = $fetched_data['ip_address'];
        }
    } else {
        while ($fetched_data = mysqli_fetch_assoc($query)) {
            $data[] = $fetched_data;
        }
    }
    return $data;
}
function Wo_IsBanned($value = '') {
    global $conn;
    $value           = Secure($value);
    $query_one    = mysqli_query($conn, "SELECT COUNT(`id`) as count FROM `banned_ip` WHERE `ip_address` = '{$value}'");
    $fetched_data = mysqli_fetch_assoc($query_one);
    if ($fetched_data['count'] > 0) {
        return true;
    }
    return false;
}
function Wo_BanNewIp($ip) {
    global $conn;
    $ip           = Secure($ip);
    $query_one    = mysqli_query($conn, "SELECT COUNT(`id`) as count FROM `banned_ip` WHERE `ip_address` = '{$ip}'");
    $fetched_data = mysqli_fetch_assoc($query_one);
    if ($fetched_data['count'] > 0) {
        return false;
    }
    $time      = time();
    $query_two = mysqli_query($conn, "INSERT INTO `banned_ip` (`ip_address`,`time`) VALUES ('{$ip}','{$time}')");
    if ($query_two) {
        return true;
    }
}
function Wo_IsIpBanned($id) {
    global $conn;
    $id           = Secure($id);
    $query_one    = mysqli_query($conn, "SELECT COUNT(`id`) as count FROM `banned_ip` WHERE `id` = '{$id}'");
    $fetched_data = mysqli_fetch_assoc($query_one);
    if ($fetched_data['count'] > 0) {
        return true;
    } else {
        return false;
    }
}
function Wo_DeleteBanned($id) {
    global $conn;
    $id = Secure($id);
    if (Wo_IsIpBanned($id) === false) {
        return false;
    }
    $query_two = mysqli_query($conn, "DELETE FROM `banned_ip` WHERE `id` = {$id}");
    if ($query_two) {
        return true;
    }
}
function Wo_IsBlocked($user_id) {
    global $wo, $conn;
//    if (IS_LOGGED == false) {
//        return false;
//    }
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 0) {
        return false;
    }
    $u = auth();
    $logged_user_id = Secure($u->id);
    $user_id        = Secure($user_id);
    $query          = mysqli_query($conn, "SELECT COUNT(`id`) FROM `blocks` WHERE (`user_id` = {$logged_user_id} AND `blocked` = {$user_id}) OR (`user_id` = {$user_id} AND `block_userid` = {$logged_user_id})");
    return (Wo_Sql_Result($query, 0) == 1) ? true : false;
}
//done
function Wo_IsFollowing($following_id, $user_id = 0) {
    global $conn, $wo;
//    if (IS_LOGGED == false) {
//        return false;
//    }
    if (empty($following_id) || !is_numeric($following_id) || $following_id < 0) {
        return false;
    }
    if ((empty($user_id) || !is_numeric($user_id) || $user_id < 0)) {
        $u = auth();
        $user_id = Secure($u->id);
    }
    $following_id = Secure($following_id);
    $user_id      = Secure($user_id);
    $query        = mysqli_query($conn, " SELECT COUNT(`id`) FROM `followers` WHERE `following_id` = {$following_id} AND `follower_id` = {$user_id} AND `active` = '1' ");
    return (Wo_Sql_Result($query, 0) == 1) ? true : false;
}
function Wo_RegisterFollow($following_id = 0, $followers_id = 0) {
    global $config, $conn, $db;
//    if (IS_LOGGED == false) {
//        return false;
//    }
    if (!isset($following_id) or empty($following_id) or !is_numeric($following_id) or $following_id < 1) {
        return false;
    }
    if (!is_array($followers_id)) {
        $followers_id = array($followers_id);
    }
    foreach ($followers_id as $follower_id) {
        if (!isset($follower_id) or empty($follower_id) or !is_numeric($follower_id) or $follower_id < 1) {
            continue;
        }
        if (Wo_IsBlocked($following_id)) {
            continue;
        }
        $following_id = Secure($following_id);
        $follower_id  = Secure($follower_id);
        $active       = 1;
        if (Wo_IsFollowing($following_id, $follower_id) === true) {
            continue;
        }
        $follower_data  = Wo_UserData($follower_id);
        $following_data = Wo_UserData($following_id);
        if (empty($follower_data['id']) || empty($following_data['id'])) {
            continue;
        }
        if ($following_data['confirm_followers'] == "1") {
            $active = 0;
        }
        $query = mysqli_query($conn, " INSERT INTO `followers` (`following_id`,`follower_id`,`active`,`created_at`) VALUES ({$following_id},{$follower_id},'{$active}','".time()."')");
        if ($query) {
            if (isEndPointRequest()) {
                $Notif = LoadEndPointResource('Notifications',true);
            }else{
                $Notif = LoadEndPointResource('Notifications');
            }
            if ($Notif) {
                if ($active === 1) {
                    $Notif->createNotification($following_data['web_device_id'], $follower_id, $following_id, 'friend_request_accepted', '', '/@' . $follower_data['username']);
                    $Notif->createNotification($following_data['web_device_id'], $following_id, $follower_id, 'friend_request_accepted', '', '/@' . $following_data['username']);
                }else{
                    $Notif->createNotification($following_data['web_device_id'], $follower_id, $following_id, 'friend_request', '', '/@' . $follower_data['username']);
                }
            }
        }
    }
    return true;
}
function Wo_CountFollowRequests($data = array()) {
    global $wo, $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    $get     = array();
    $user_id = Secure($wo['user']['user_id']);
    if (empty($data['account_id']) || $data['account_id'] == 0) {
        $data['account_id'] = $user_id;
        $account            = $wo['user'];
    }
    if (!is_numeric($data['account_id']) || $data['account_id'] < 1) {
        return false;
    }
    if ($data['account_id'] != $user_id) {
        $data['account_id'] = Secure($data['account_id']);
        $account            = Wo_UserData($data['account_id']);
    }
    $query_one = " SELECT COUNT(`id`) AS `FollowRequests` FROM `followers` WHERE `active` = '0' AND `following_id` =  " . $account['user_id'] . " AND `follower_id` IN (SELECT `user_id` FROM `users` WHERE `active` = '1')";
    if (isset($data['unread']) && $data['unread'] == true) {
        $query_one .= " AND `seen` = 0";
    }
    $query_one .= " ORDER BY `id` DESC";
    $sql_query_one = mysqli_query($conn, $query_one);
    $sql_fetch_one = mysqli_fetch_assoc($sql_query_one);
    return $sql_fetch_one['FollowRequests'];
}
function Wo_IsFollowRequested1($following_id = 0, $follower_id = 0) {
    global $conn;
    if (!isset($following_id) or empty($following_id) or !is_numeric($following_id) or $following_id < 1) {
        return false;
    }
    if (!is_numeric($follower_id) or $follower_id < 1) {
        return false;
    }
    $following_id = Secure($following_id);
    $follower_id  = Secure($follower_id);
    $query        = "SELECT `id` FROM `followers` WHERE `follower_id` = {$follower_id} AND `following_id` = {$following_id} AND `active` = '0'";
    $sql_query    = mysqli_query($conn, $query);
    if (mysqli_num_rows($sql_query) > 0) {
        return true;
    }else{
        return false;
    }
}
function Wo_IsFollowRequested($following_id = 0, $follower_id = 0) {
    global $conn;
    if (!isset($following_id) or empty($following_id) or !is_numeric($following_id) or $following_id < 1) {
        return false;
    }
    if (!is_numeric($follower_id) or $follower_id < 1) {
        return false;
    }
    $following_id = Secure($following_id);
    $follower_id  = Secure($follower_id);
    $query        = "SELECT `id` FROM `followers` WHERE `follower_id` = {$following_id} AND `following_id` = {$follower_id} AND `active` = '0'";
    $sql_query    = mysqli_query($conn, $query);
    if (mysqli_num_rows($sql_query) > 0) {
        return true;
    }else{
        return false;
    }
//     global $conn;
// //    if (IS_LOGGED == false) {
// //        return false;
// //    }
//     if (!isset($following_id) or empty($following_id) or !is_numeric($following_id) or $following_id < 1) {
//         return false;
//     }
//     if ((!isset($follower_id) or empty($follower_id) or !is_numeric($follower_id) or $follower_id < 1)) {
//         $u = auth();
//         $follower_id = Secure($u->id);
//     }
//     if (!is_numeric($follower_id) or $follower_id < 1) {
//         return false;
//     }
//     $following_id = Secure($following_id);
//     $follower_id  = Secure($follower_id);
//     $query        = "SELECT `id` FROM `followers` WHERE `follower_id` = {$follower_id} AND `following_id` = {$following_id} AND `active` = '0'";
//     $sql_query    = mysqli_query($conn, $query);
//     if (mysqli_num_rows($sql_query) > 0) {
//         return true;
//     }else{
//         return false;
//     }
}
//done
function Wo_DeleteFollow($following_id = 0, $follower_id = 0) {
    global $config, $conn;
//    if (IS_LOGGED == false) {
//        return false;
//    }
    if (!isset($following_id) or empty($following_id) or !is_numeric($following_id) or $following_id < 1) {
        return false;
    }
    if (!isset($follower_id) or empty($follower_id) or !is_numeric($follower_id) or $follower_id < 1) {
        return false;
    }
    $following_id = Secure($following_id);
    $follower_id  = Secure($follower_id);
    if (Wo_IsFollowing($following_id, $follower_id) === false && Wo_IsFollowRequested($following_id, $follower_id) === false) {
        return false;
    } else {
        $query = mysqli_query($conn, " DELETE FROM `followers` WHERE `following_id` = {$following_id} AND `follower_id` = {$follower_id}");
        if ($config->connectivitySystem == "1") {
            $query_two     = "DELETE FROM `followers` WHERE `follower_id` = {$following_id} AND `following_id` = {$follower_id}";
            $sql_query_two = mysqli_query($conn, $query_two);

            $query_two1     = "DELETE FROM `notifications` WHERE ( `notifier_id` = {$following_id} AND `recipient_id` = {$follower_id} AND `type` = 'friend_request_accepted' ) OR ( `notifier_id` = {$follower_id} AND `recipient_id` = {$following_id} AND `type` = 'friend_request_accepted' )";
            $sql_query_two1 = mysqli_query($conn, $query_two1);

        }
        if ($query) {

            return true;
        }
    }
}
//done
function Wo_CountFollowing($user_id,$active = true) {
    global $wo, $conn;
    $data = array();
    if (empty($user_id) or !is_numeric($user_id) or $user_id < 1) {
        return false;
    }
    $user_id    = Secure($user_id);
    $sub_sql    = '';
    if ($active === true) {
        $sub_sql = "AND `active` = '1'";
    }
    $query_text = "SELECT COUNT(`id`) AS count FROM `users` WHERE `id` IN (SELECT `following_id` FROM `followers` WHERE `follower_id` = {$user_id} AND `following_id` <> {$user_id} {$sub_sql}) {$sub_sql}";
    if (IS_LOGGED == true) {
        $u = auth();
        $logged_user_id = Secure($u->id);
        $query_text .= " AND `id` NOT IN (SELECT `block_userid` FROM `blocks` WHERE `id` = '{$logged_user_id}') AND `id` NOT IN (SELECT `user_id` FROM `blocks` WHERE `block_userid` = '{$logged_user_id}')";
    }
    $query        = mysqli_query($conn, $query_text);
    $fetched_data = mysqli_fetch_assoc($query);
    return $fetched_data['count'];
}
function Wo_AcceptFollowRequest($following_id = 0, $follower_id = 0) {
    global $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    if (!isset($following_id) or empty($following_id) or !is_numeric($following_id) or $following_id < 1) {
        return false;
    }
    if (!isset($follower_id) or empty($follower_id) or !is_numeric($follower_id) or $follower_id < 1) {
        return false;
    }
    $following_id = Secure($following_id);
    $follower_id  = Secure($follower_id);
    if (Wo_IsFollowRequested($following_id, $follower_id) === false) {
        return false;
    }
    $follower_data = Wo_UserData($follower_id);
    if (empty($follower_data['id'])) {
        return false;
    }
    $following_data = Wo_UserData($following_id);
    if (empty($following_data['id'])) {
        return false;
    }
    $query = mysqli_query($conn, "UPDATE `followers` SET `active` = '1' WHERE `following_id` = {$follower_id} AND `follower_id` = {$following_id} AND `active` = '0'");
//    if ($wo['config']['connectivitySystem'] == 1) {
//        $query_two = mysqli_query($conn, "INSERT INTO `followers` (`following_id`,`follower_id`,`active`) VALUES ({$following_id},{$follower_id},'1') ");
//    }
    if ($query) {
        if (isEndPointRequest()) {
            $Notif = LoadEndPointResource('Notifications',true);
        }else{
            $Notif = LoadEndPointResource('Notifications');
        }
        if ($Notif) {
            $n = $Notif->createNotification($following_data['web_device_id'], $follower_id, $following_id, 'friend_request_accepted', '', '/@' . $follower_data['username']);
            if ($n === true) {
                return true;
            } else {
                return false;
            }
        }
    }
}
function Wo_DeleteFollowRequest($following_id, $follower_id) {
    global $wo, $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    if (!isset($following_id) or empty($following_id) or !is_numeric($following_id) or $following_id < 1) {
        return false;
    }
    if (!isset($follower_id) or empty($follower_id) or !is_numeric($follower_id) or $follower_id < 1) {
        return false;
    }
    $following_id = Secure($following_id);
    $follower_id  = Secure($follower_id);
    if (Wo_IsFollowRequested($following_id, $follower_id) === false) {
        return false;
    } else {
        $query = mysqli_query($conn, " DELETE FROM `followers` WHERE `following_id` = {$follower_id} AND `follower_id` = {$following_id} ");
        if ($query) {
            return true;
        }
    }
}
function Wo_GetFollowRequests($user_id = 0, $search_query = '') {
    global $wo, $conn;
    if (IS_LOGGED == false) {
        return false;
    }
    $data = array();
    if (empty($user_id) or $user_id == 0) {
        $user_id = $wo['user']['user_id'];
    }
    if (!is_numeric($user_id) or $user_id < 1) {
        return false;
    }
    $user_id = Secure($user_id);
    $query   = "SELECT `user_id` FROM `users` WHERE `user_id` IN (SELECT `follower_id` FROM `followers` WHERE `follower_id` <> {$user_id} AND `following_id` = {$user_id} AND `active` = '0') AND `active` = '1' ";
    if (!empty($search_query)) {
        $search_query = Secure($search_query);
        $query .= " AND `name` LIKE '%$search_query%'";
    }
    $query .= " ORDER BY `user_id` DESC";
    $sql_query = mysqli_query($conn, $query);
    while ($sql_fetch = mysqli_fetch_assoc($sql_query)) {
        $data[] = Wo_UserData($sql_fetch['user_id']);
    }
    return $data;
}
//done
function Wo_CountFollowers($user_id) {
    global $wo, $conn;
    if (empty($user_id) or !is_numeric($user_id) or $user_id < 1) {
        return false;
    }
    $data       = array();
    $user_id    = Secure($user_id);
    $query_text = " SELECT COUNT(`id`) AS count FROM `users` WHERE `id` IN (SELECT `follower_id` FROM `followers` WHERE `follower_id` <> {$user_id} AND `following_id` = {$user_id} AND `active` = '1') AND `active` = '1'";
    if (IS_LOGGED == true) {
        $u = auth();
        $logged_user_id = Secure($u->id);
        $query_text .= " AND `id` NOT IN (SELECT `block_userid` FROM `blocks` WHERE `user_id` = '{$logged_user_id}') AND `id` NOT IN (SELECT `user_id` FROM `blocks` WHERE `block_userid` = '{$logged_user_id}')";
    }
    $query        = mysqli_query($conn, $query_text);
    $fetched_data = mysqli_fetch_assoc($query);
    return $fetched_data['count'];
}
function Wo_SearchFollowers($user_id, $filter = '', $limit = 10, $event_id = 0) {
    global $wo, $conn;
    $data = array();
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 1) {
        return false;
    }
    if (empty($event_id)) {
        return false;
    }
    $user_id = Secure($user_id);
    $filter  = Secure($filter);
    ;
    $query = " SELECT `user_id` FROM `users` WHERE `user_id` IN (SELECT `follower_id` FROM `followers` WHERE `follower_id` <> {$user_id} AND `following_id` = {$user_id} AND `active` = '1') AND `active` = '1'";
    if (!empty($filter)) {
        $query .= " AND (`username` LIKE '%$filter%' OR `first_name` LIKE '%$filter%' OR `last_name` LIKE '%$filter%')";
    }
    $query .= " AND `user_id` NOT IN (SELECT `invited_id` FROM " . T_EVENTS_INV . " WHERE `inviter_id` = '$user_id') ";
    $query .= " AND `user_id` NOT IN (SELECT `user_id` FROM " . T_EVENTS_GOING . " WHERE `event_id` = '$event_id') ";
    $query .= " AND `user_id` NOT IN (SELECT `poster_id` FROM " . T_EVENTS . " WHERE `id` = '$event_id') ";
    $query .= " LIMIT {$limit} ";
    $sql_query = mysqli_query($conn, $query);
    while ($fetched_data = mysqli_fetch_assoc($sql_query)) {
        $data[] = Wo_UserData($fetched_data['user_id']);
    }
    return $data;
}
function Wo_GetFollowing($user_id, $type = '', $limit = '', $after_user_id = '', $placement = array()) {
    global $wo, $conn;
    $data = array();
    if (empty($user_id) or !is_numeric($user_id) or $user_id < 1) {
        return false;
    }
    $user_id       = Secure($user_id);
    $after_user_id = Secure($after_user_id);
    $query         = "SELECT `user_id` FROM `users` WHERE `user_id` IN (SELECT `following_id` FROM `followers` WHERE `follower_id` = {$user_id} AND `following_id` <> {$user_id} AND `active` = '1') AND `active` = '1' ";
    if (!empty($after_user_id) && is_numeric($after_user_id)) {
        $query .= " AND `user_id` < {$after_user_id}";
    }
    if (IS_LOGGED == true) {
        $logged_user_id = Secure($wo['user']['user_id']);
        $query .= " AND `user_id` NOT IN (SELECT `block_userid` FROM `blocks` WHERE `user_id` = '{$logged_user_id}') AND `user_id` NOT IN (SELECT `user_id` FROM `blocks` WHERE `block_userid` = '{$logged_user_id}')";
    }
    if ($type == 'sidebar' && !empty($limit) && is_numeric($limit)) {
        $query .= " ORDER BY RAND() LIMIT {$limit}";
    }
    if ($type == 'profile' && !empty($limit) && is_numeric($limit)) {
        $query .= " ORDER BY `user_id` DESC LIMIT {$limit}";
    }
    if (!empty($placement)) {
        if ($placement['in'] == 'profile_sidebar' && is_array($placement['following_data'])) {
            foreach ($placement['following_data'] as $key => $id) {
                $user_data   = Wo_UserData($id, false);
                if (!empty($user_data)) {
                    $data[]  = $user_data;
                }
            }
            return $data;
        }
    }
    $sql_query = mysqli_query($conn, $query);
    while ($fetched_data = mysqli_fetch_assoc($sql_query)) {
        $user_data                  = Wo_UserData($fetched_data['user_id'], false);
        $user_data['family_member'] = Wo_GetFamalyMember($fetched_data['user_id'], $wo['user']['id']);
        $data[]                     = $user_data;
    }
    return $data;
}
function Wo_GetFollowers($user_id, $type = '', $limit = '', $after_user_id = '', $placement = array()) {
    global $wo, $conn;
    $data = array();
    if (empty($user_id) or !is_numeric($user_id) or $user_id < 1) {
        return false;
    }
    $user_id       = Secure($user_id);
    $after_user_id = Secure($after_user_id);
    $query         = " SELECT `id` FROM `users` WHERE `user_id` IN (SELECT `follower_id` FROM `followers` WHERE `follower_id` <> {$user_id} AND `following_id` = {$user_id} AND `active` = '1') AND `active` = '1'";
    if (!empty($after_user_id) && is_numeric($after_user_id)) {
        $query .= " AND `user_id` < {$after_user_id}";
    }
    if (IS_LOGGED == true) {
        $logged_user_id = Secure($wo['user']['user_id']);
        $query .= " AND `user_id` NOT IN (SELECT `block_userid` FROM `blocks` WHERE `user_id` = '{$logged_user_id}') AND `user_id` NOT IN (SELECT `user_id` FROM `blocks` WHERE `block_userid` = '{$logged_user_id}')";
    }
    if ($type == 'sidebar' && !empty($limit) && is_numeric($limit)) {
        $query .= " ORDER BY RAND()";
    }
    if ($type == 'profile' && !empty($limit) && is_numeric($limit)) {
        $query .= " ORDER BY `user_id` DESC";
    }
    $query .= " LIMIT {$limit} ";
    if (!empty($placement)) {
        if ($placement['in'] == 'profile_sidebar' && is_array($placement['followers_data'])) {
            foreach ($placement['followers_data'] as $key => $id) {
                $user_data   = Wo_UserData($id);
                if (!empty($user_data)) {
                    $data[]  = $user_data;
                }
            }
            return $data;
        }
    }
    $sql_query = mysqli_query($conn, $query);
    while ($fetched_data = mysqli_fetch_assoc($sql_query)) {
        $user_data                  = Wo_UserData($fetched_data['id']);
        $data[]                     = $user_data;
    }
    return $data;
}
function Wo_GetFollowButton($user_id = 0) {
    global $wo;
    if (IS_LOGGED == false) {
        return false;
    }
    if (!is_numeric($user_id) or $user_id < 0) {
        return false;
    }
    if ($user_id == $wo['user']['user_id']) {
        return false;
    }
    $account = $wo['follow'] = Wo_UserData($user_id);
    if (!isset($wo['follow']['user_id'])) {
        return false;
    }
    $user_id           = Secure($user_id);
    $logged_user_id    = Secure($wo['user']['user_id']);
    $follow_button     = 'buttons/follow';
    $unfollow_button   = 'buttons/unfollow';
    $add_frined_button = 'buttons/add-friend';
    $unfrined_button   = 'buttons/unfriend';
    $accept_button     = 'buttons/accept-request';
    $request_button    = 'buttons/requested';
    if (Wo_IsFollowing($user_id, $logged_user_id)) {
        if ($wo['config']['connectivitySystem'] == 1) {
            return Wo_LoadPage($unfrined_button);
        } else {
            return Wo_LoadPage($unfollow_button);
        }
    } else {
        if (Wo_IsFollowRequested($user_id, $logged_user_id)) {
            return Wo_LoadPage($request_button);
        } else if (Wo_IsFollowRequested($logged_user_id, $user_id)) {
            return Wo_LoadPage($accept_button);
        } else {
            if ($account['follow_privacy'] == 1) {
                if (Wo_IsFollowing($logged_user_id, $user_id)) {
                    if ($wo['config']['connectivitySystem'] == 1) {
                        return Wo_LoadPage($add_frined_button);
                    } else {
                        return Wo_LoadPage($follow_button);
                    }
                }
            } else if ($account['follow_privacy'] == 0) {
                if ($wo['config']['connectivitySystem'] == 1) {
                    return Wo_LoadPage($add_frined_button);
                } else {
                    return Wo_LoadPage($follow_button);
                }
            }
        }
    }
}
function SendQueueEmails(){
    global $config,$conn,$_LIBS;
    require_once($_LIBS . "PHPMailer/vendor/autoload.php");
    $mail = new PHPMailer;
    $data = array();
    $query_one = " SELECT * FROM `emails` WHERE `src` = 'admin' ORDER BY `id` DESC LIMIT 1";
    $sql       = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($sql) < 1) {
        return false;
    }
    while ($fetched_data = mysqli_fetch_assoc($sql)) {
        $email_sent = SendEmail($fetched_data['email_to'], $fetched_data['subject'], htmlspecialchars_decode($fetched_data['message']) );
        if($email_sent){
            $query_one_  = "DELETE FROM `emails` WHERE `id` = {$fetched_data['id']}";
            $sql_        = mysqli_query($conn, $query_one_);
        }
    }
    return $send;
}

function CheckPermission($permissions, $permission){
    if(empty( $permissions )){
        return false;
    }else{
        //$_permission = unserialize($permissions);
        if(is_array($permissions)){
            if(isset($permissions[$permission]) && $permissions[$permission] == "1") {
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
}

function is_avatar_approved($user_id, $avatar){
    global $wo, $conn, $config,$db;
    // if (IS_LOGGED == false) {
    //     return false;
    // }
    if (!is_numeric($user_id) or $user_id < 1) {
        return false;
    }
    if(empty($avatar)){
        return false;
    }
    if($config->review_media_files == '0'){
        return true;
    }
    $user_id = Secure($user_id);
    $userData = $db->where('id',$user_id)->objectbuilder()->getOne('users');
    if ($userData->src == 'Fake') {
        return true;
    }
    $avatar = str_replace( '_avater.' , '_full.', $avatar);
    $sql   = "SELECT `is_approved` FROM `mediafiles` WHERE `user_id` = $user_id AND `file` = '{$avatar}'";
    $query = mysqli_query($conn, $sql);
    if (mysqli_num_rows($query) > 0) {
        if(Sql_Result($query, 0) == '1'){
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}
function RegisterAffRevenue($user_id,$amount = 0){
    global $db,$config;
    $amount_percent_ref = $config->amount_percent_ref;
    $total_revinue = ( $amount * (int)$amount_percent_ref ) / 100;
    $me = $db->where('id',$user_id)->getOne('users');
    if($me){
        if($me['src'] !== 'Referrer'){
            return false;
        }
        $ref_user = $db->where('id',$me['referrer'])->getOne('users');
        $new_balance = (double)$ref_user['aff_balance'] + (double)$total_revinue ;
        $db->where('id',$ref_user['id'])->update('users', array('aff_balance' => floatval($new_balance)));
    }
    return false;
}
function GetPageTitle($page_name){
    global $config,$lang;
    $arr = json_decode($config->seo,true);
    if(isset($arr[$page_name])){
        $title       = str_replace('{SITE_TITLE}', $config->default_title, $arr[$page_name]['title']);
        $title = preg_replace_callback("/{LANG_KEY (.*?)}/", function($m) use ($lang) {
            return (isset($lang->{$m[1]})) ? $lang->{$m[1]} : '';
        }, $title);
        return $title;
    }else{
        return $config->default_title;
    }
}
function GetPageKeyword($page_name){
    global $config;
    $arr = json_decode($config->seo,true);
    if(isset($arr[$page_name])){
        $keyword     = str_replace('{SITE_KEYWORDS}', $config->meta_keywords, $arr[$page_name]['meta_keywords']);
        return $keyword;
    }else{
        return __($page_name);
    }
}
function GetPageDescription($page_name){
    global $config;
    $arr = json_decode($config->seo,true);
    if(isset($arr[$page_name])){
        $description = str_replace('{SITE_DESC}', $config->meta_description, $arr[$page_name]['meta_description']);
        return $description;
    }else{
        return __($page_name);
    }
}

function RecordDailyCredit($user_id = 0){
    global $config,$db;
    if (empty($user_id) && IS_LOGGED == false) {
        return false;
    }
    elseif (IS_LOGGED) {
        $user_id = auth()->id;
    }
    $user_id = Secure($user_id);
    if($config->credit_earn_system == 0) return false;
    $day_amount = (int)$config->credit_earn_day_amount;

    $today_start = strtotime(date('M')." ".date('d').", ".date('Y')." 12:00am");
    $today_end = strtotime(date('M')." ".date('d').", ".date('Y')." 11:59pm");
    $count = $db->where('user_id', $user_id)->where('created_at',$today_start,'>=')->where('created_at',$today_end,'<=')->objectbuilder()->get('daily_credits');
    if ($config->credit_earn_max_days <= count($count)) {
        foreach ($count as $key => $value) {
            if ($value->added == 1) {
                return false;
            }
        }
        
        return true;
    }
    else{
        $db->insert('daily_credits',array(
            "user_id" => $user_id,
            "created_at" => time()
        ));
        return true;
    }
    return false;
    

//     $dates = $db->where('user_id', $u->id)->get('daily_credits',null,array('count(*) as CountDays','TIMESTAMPDIFF(DAY, from_unixtime( max(created_at) ), from_unixtime( min(created_at) )) as TotalDays','TIMESTAMPDIFF(DAY, now() , from_unixtime( min(created_at) )) as DaysFromNow'));
//     $DaysFromNow = (int)abs($dates[0]['DaysFromNow']);
//     $TotalDays = (int)abs($dates[0]['TotalDays']);
//     $CountDays = (int)abs($dates[0]['CountDays']);
//     if($CountDays <= $max_days){
//         $add = false;
//         if( ( $CountDays === 0 || $CountDays === $DaysFromNow ) && $CountDays <= $DaysFromNow ){
//             $add = true;
//         }
//         if( $CountDays === 0 ){
//             $add = true;
//         }
//         if( ( $TotalDays > $max_days ) || ( $max_days === $TotalDays + 1) ){
//             $add = false;
//         }

//         if($add === true){
//             $db->insert('daily_credits',array(
//                 "user_id" => $u->id,
//                 "created_at" => time()
//             ));
//         }

//         if($DaysFromNow > 0 && $CountDays > 0 && $CountDays === $max_days) {


// //        var_dump(($max_days >= $CountDays && $u->reward_daily_credit == 0));
// //        var_dump($max_days);
// //        var_dump($TotalDays);
// //        var_dump($CountDays);
// //        var_dump($DaysFromNow);
// //        exit();

//             if (($max_days >= $CountDays && $u->reward_daily_credit == 0)) {
//                 //here we will update user credits
//                 $total_amount = $day_amount * $max_days;
//             $db->where('id', $u->id)->update('users',array(
//                 "balance" => $db->inc($total_amount),
//                 "reward_daily_credit" => 1
//             ));
//                 return true;
//             } else {
//                 return false;
//             }
//         }else{
//             return false;
//         }
//     }
}
function _getimagesize($file_name, $info=array()){
    global $config;
    if(empty($file_name)){
        return 0;
    }
    if ($config->amazone_s3 == 1) {
        if (!empty($config->amazone_s3_key) || !empty($config->amazone_s3_s_key) || !empty($config->region) || !empty($config->bucket_name)) {
            $ch = curl_init($file_name);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
            curl_setopt($ch, CURLOPT_HEADER, TRUE);
            curl_setopt($ch, CURLOPT_NOBODY, TRUE);
            $data = curl_exec($ch);
            $size = curl_getinfo($ch, CURLINFO_CONTENT_LENGTH_DOWNLOAD);
            curl_close($ch);
            return $size;
        }
    }else{
        if (strpos($file_name, "https://") === false) {
            return @getimagesize($file_name, $info);
        }else{
            $ch = curl_init($file_name);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
            curl_setopt($ch, CURLOPT_HEADER, TRUE);
            curl_setopt($ch, CURLOPT_NOBODY, TRUE);
            $data = curl_exec($ch);
            $size = curl_getinfo($ch, CURLINFO_CONTENT_LENGTH_DOWNLOAD);
            curl_close($ch);
            return $size;
        }

    }
}

function correctImageOrientation($filename) {
  if (function_exists('exif_read_data')) {
    $exif = @exif_read_data($filename);
    if($exif && isset($exif['Orientation'])) {
      $orientation = $exif['Orientation'];
      if($orientation != 1){
        $img = imagecreatefromjpeg($filename);
        $deg = 0;
        $image = imagecreatefromjpeg($filename);
        if (in_array($exif['Orientation'], [3, 4])) {
            $image = imagerotate($image, 180, 0);
        }
        if (in_array($exif['Orientation'], [5, 6])) {
            $image = imagerotate($image, -90, 0);
        }
        if (in_array($exif['Orientation'], [7, 8])) {
            $image = imagerotate($image, 90, 0);
        }
        if (in_array($exif['Orientation'], [2, 5, 7, 4])) {
            imageflip($image, IMG_FLIP_HORIZONTAL);
        }
        imagejpeg($image, $filename, 80);
      } // if there is some rotation necessary
    } // if have the exif orientation info
  } // if function exists
}
function CanLogin() {
    global $config,$db;
    if (IS_LOGGED == true) {
        return false;
    }
    $ip = get_ip_address();
    if (empty($ip)) {
        return true;
    }
    if ($config->lock_time < 1) {
        return true;
    }
    if ($config->bad_login_limit < 1) {
        return true;
    }

    $time      = time() - (60 * $config->lock_time);
    $login = $db->where('ip',$ip)->get('bad_login');
    if (count($login) >= $config->bad_login_limit) {
        $last = end($login);
        if ($last['time'] >= $time) {
            return false;
        }
    }
    $db->where('time',time()-(60 * $config->lock_time * 2),'<')->delete('bad_login');
    return true;
}
function AddBadLoginLog() {
    global $config,$db,$conn;
    if (IS_LOGGED == true) {
        return false;
    }
    $ip = get_ip_address();
    if (empty($ip)) {
        return true;
    }
    $time      = time();
    $query     = mysqli_query($conn, "INSERT INTO `bad_login` (`ip`, `time`) VALUES ('{$ip}', '{$time}')");
    if ($query) {
        return true;
    }
}
function CheckPaystackPayment($ref)
{
    global $config, $db;
    if (empty($ref) || IS_LOGGED == false) {
        return false;
    }
    $ref = Secure($ref);
    $user = $db->where('id',auth()->id)->where('paystack_ref',$ref)->getValue('users',"COUNT(*)");
    if ($user < 1) {
        return false;
    }
    $result = array();
    //The parameter after verify/ is the transaction reference to be verified
    $url = 'https://api.paystack.co/transaction/verify/'.$ref;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt(
      $ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer '.$config->paystack_secret_key]
    );
    $request = curl_exec($ch);
    curl_close($ch);

    if ($request) {
        $result = json_decode($request, true);
        if($result){
          if($result['data']){
            if($result['data']['status'] == 'success'){
                $db->where('id',auth()->id)->where('paystack_ref',$ref)->update('users',array('paystack_ref' => ''));
                return true;
            }else{
              die("Transaction was not successful: Last gateway response was: ".$result['data']['gateway_response']);
            }
          }else{
            die($result['message']);
          }

        }else{
          die("Something went wrong while trying to convert the request variable to json. Uncomment the print_r command to see what is in the result variable.");
        }
      }else{
        die("Something went wrong while executing curl. Uncomment the var_dump line above this line to see what the issue is. Please check your CURL command to make sure everything is ok");
      }
}
function GetPostComment($id)
{
    global $config, $db;
    if (!empty($id) && is_numeric($id) && $id > 0) {
        $id = Secure($id);
        $comment = $db->where('id',$id)->getOne('comments');
        $comment['publisher'] = userData($comment['user_id']);
        return $comment;
    }
    return array();
}
function StartCloudRecording($vendor,$region,$bucket,$accessKey,$secretKey,$cname,$uid,$post_id,$token)
{
    global $config, $db;
    $post_id = Secure($post_id);
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "https://api.agora.io/v1/apps/".$config->agora_app_id."/cloud_recording/acquire");
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Basic '.base64_encode($config->agora_customer_id.":".$config->agora_customer_certificate),'Content-Type: application/json;charset=utf-8'));
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_POSTFIELDS,'{
      "cname": "'.$cname.'",
      "uid": "'.$uid.'",
      "clientRequest":{
      }
    }');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response  = curl_exec($ch);
    curl_close($ch);
    $data = json_decode($response);
    $resourceId = $data->resourceId;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "https://api.agora.io/v1/apps/".$config->agora_app_id."/cloud_recording/resourceid/".$resourceId."/mode/mix/start");
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Basic '.base64_encode($config->agora_customer_id.":".$config->agora_customer_certificate),'Content-Type: application/json;charset=utf-8'));
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_POSTFIELDS,'{
    "cname":"'.$cname.'",
    "uid":"'.$uid.'",
    "clientRequest":{
        "token":"'.$token.'",
        "recordingConfig":{
            "channelType":1,
            "streamTypes":2,
            "audioProfile":1,
            "videoStreamType":1,
            "maxIdleTime":120,
            "transcodingConfig":{
                "width":480,
                "height":480,
                "fps":24,
                "bitrate":800,
                "maxResolutionUid":"1",
                "mixedVideoLayout":1
                }
            },
        "storageConfig":{
            "vendor":'.$vendor.',
            "region":'.$region.',
            "bucket":"'.$bucket.'",
            "accessKey":"'.$accessKey.'",
            "secretKey":"'.$secretKey.'",
            "fileNamePrefix": [
                "upload",
                "videos",
                "'.date('Y').'",
                "'.date('m').'"
              ]
        }
    }
} ');
    // curl_setopt($ch, CURLOPT_POSTFIELDS,'{
    //     "cname":"'.$cname.'",
    //     "uid":"'.$uid.'",
    //     "clientRequest":{
    //         "recordingConfig": {
    //             "maxIdleTime": 30,
    //             "streamTypes": 2,
    //             "channelType": 1,
    //             "videoStreamType": 1,
    //             "subscribeUidGroup": 0,
    //             "maxIdleTime": 30000
    //         },
    //         "storageConfig":{
    //             "vendor":'.$vendor.',
    //             "region":'.$region.',
    //             "bucket":"'.$bucket.'",
    //             "accessKey":"'.$accessKey.'",
    //             "secretKey":"'.$secretKey.'"
    //         }
    //     }
    // }
    // ');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response  = curl_exec($ch);
    curl_close($ch);
    $data = json_decode($response);
    if (!empty($data->sid) && !empty($resourceId)) {
        $db->where('id',$post_id)->update('posts',array('agora_resource_id' => $resourceId,
                                                        'agora_sid' => $data->sid));
    }
    return true;
}
function StopCloudRecording($data)
{
    global $config, $db;
    if (empty($data) || $config->agora_live_video != 1 || empty($data['resourceId']) || empty($data['sid']) || empty($data['cname']) || empty($data['uid']) || empty($data['post_id'])) {
        return false;
    }
    $post_id = Secure($data['post_id']);

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "https://api.agora.io/v1/apps/".$config->agora_app_id."/cloud_recording/resourceid/".$data['resourceId']."/sid/".$data['sid']."/mode/mix/stop");
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Basic '.base64_encode($config->agora_customer_id.":".$config->agora_customer_certificate),'Content-Type: application/json;charset=utf-8'));
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_POSTFIELDS,'{
      "cname": "'.$data['cname'].'",
      "uid": "'.$data['uid'].'",
      "clientRequest":{
        "token":"'.$data['token'].'"
      }
    }');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response  = curl_exec($ch);
    curl_close($ch);
    $data2 = json_decode($response);
    if (!empty($data2) && !empty($data2->serverResponse) && !empty($data2->serverResponse->fileList)) {
        $db->where('id',$post_id)->update('posts',array('postFile' => $data2->serverResponse->fileList));
    }
    return true;
}
function GetApp($app_id) {
    global $config, $db,$conn;
    if (IS_LOGGED == false) {
        return false;
    }
    if (empty($app_id) || !is_numeric($app_id) || $app_id < 1) {
        return false;
    }
    $app_id    = Secure($app_id);
    $query_one = mysqli_query($conn, "SELECT * FROM `apps` WHERE `id` = {$app_id}");
    //if ($query_one) {
        if (mysqli_num_rows($query_one) == 1) {
            $sql_query_one               = mysqli_fetch_assoc($query_one);
            $sql_query_one['app_onwer']  = userData($sql_query_one['app_user_id']);
            $sql_query_one['app_avatar'] = GetMedia($sql_query_one['app_avatar']);
            return $sql_query_one;
        }
    //}
    return false;

}
function GetApps($placement = '') {
    global $config, $db,$conn;
    if (IS_LOGGED == false) {
        return false;
    }
    $data       = array();
    $user_id    = auth()->id;
    $query_text = "SELECT `id` FROM `apps` ";
    if ($placement != 'admin') {
        $query_text .= " WHERE `app_user_id` = {$user_id}";
    }
    $query_one = mysqli_query($conn, $query_text);
    if (mysqli_num_rows($query_one)) {
        while ($fetched_data = mysqli_fetch_assoc($query_one)) {
            if (is_array($fetched_data)) {
                $data[] = GetApp($fetched_data['id']);
            }
        }
    }

    return $data;
}
function IsValidApp($app_id) {
    global $config, $db,$conn;
    if (empty($app_id)) {
        return false;
    }
    $app_id        = Secure($app_id);
    $query_one     = "SELECT `id` FROM `apps` WHERE `app_id` = '{$app_id}'";
    $sql_query_one = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($sql_query_one) == 1) {
        return true;
    }
    return false;
}
function GetIdFromAppID($app_id) {
    global $config, $db,$conn;
    if (empty($app_id)) {
        return false;
    }
    $app_id        = Secure($app_id);
    $query_one     = "SELECT `id` FROM `apps` WHERE `app_id` = '{$app_id}'";
    $sql_query_one = mysqli_query($conn, $query_one);
        if (mysqli_num_rows($sql_query_one) == 1) {
            $sql_fetch_one = mysqli_fetch_assoc($sql_query_one);
            return $sql_fetch_one['id'];
        }
    return false;

}
function AppHasPermission($user_id, $app_id) {
    global $config, $db,$conn;
    if (empty($app_id)) {
        return false;
    }
    $app_id        = Secure($app_id);
    $user_id       = Secure($user_id);
    $query_one     = "SELECT `id` FROM `apps_permission` WHERE `app_id` = '{$app_id}' AND `user_id` = '{$user_id}'";
    $sql_query_one = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($sql_query_one) > 0) {
        return true;
    } else {
        return false;
    }
}
function GenrateCode($user_id, $app_id) {
    global $config, $db,$conn;
    $app_id  = Secure($app_id);
    $user_id = Secure($user_id);
    if (empty($app_id) || empty($user_id)) {
        return false;
    }
    $token     = GenerateKey(40, 40);
    $query_two = mysqli_query($conn, "SELECT `id` FROM `codes` WHERE `app_id` = {$app_id} AND `user_id` = {$user_id}");
    if (mysqli_num_rows($query_two) > 0) {
        $query_three = mysqli_query($conn, "DELETE FROM `codes` WHERE `app_id` = {$app_id} AND `user_id` = {$user_id}");
    }
    $query_one     = "INSERT INTO `codes` (`user_id`,`app_id`,`code`,`time`) VALUES ('{$user_id}','{$app_id}','{$token}','" . time() . "')";
    $sql_query_one = mysqli_query($conn, $query_one);
    if ($sql_query_one) {
        return $token;
    }
}
function AcceptPermissions($app_id) {
    global $config, $db,$conn;
    if (IS_LOGGED == false) {
        return false;
    }
    $app_id  = Secure($app_id);
    $user_id = Secure(auth()->id);
    if (empty($app_id) || empty($user_id)) {
        return false;
    }
    $query_one     = "INSERT INTO `apps_permission` (`user_id`,`app_id`) VALUES ('{$user_id}','{$app_id}')";
    $sql_query_one = mysqli_query($conn, $query_one);
    if ($sql_query_one) {
        return true;
    }
}
function VerifyAPIApii($app_id = '', $secret_id = '') {
    global $config, $db,$conn;
    if (empty($app_id) || empty($secret_id)) {
        return false;
    }
    $app_id        = Secure($app_id);
    $secret_id     = Secure($secret_id);
    $query_one     = "SELECT `id` FROM `apps` WHERE `app_id` = '{$app_id}' AND `app_secret` = '$secret_id'";
    $sql_query_one = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($sql_query_one) == 1) {
        return true;
    }
    return false;
}
function GetCode($code = '') {
    global $config, $db,$conn;
    if (empty($code)) {
        return false;
    }
    $code      = Secure($code);
    $query_one = mysqli_query($conn, "SELECT * FROM `codes` WHERE `code` = '{$code}'");
    if (mysqli_num_rows($query_one)) {
        if (mysqli_num_rows($query_one) == 1) {
            $sql_query_one = mysqli_fetch_assoc($query_one);
            return $sql_query_one;
        }
    }
    return false;

}
function DeleteUserInvitation($col = '', $val = false) {
    global $config, $db,$conn;
    if (!$val && !$col) {
        return false;
    }
    $val = Secure($val);
    $col = Secure($col);
    return mysqli_query($conn, "DELETE FROM `invitation_links` WHERE `$col` = '$val'");
}
function GetAdminInvitation() {
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false || auth()->admin == 0) {
        return false;
    }
    $query = mysqli_query($conn, "SELECT * FROM `admininvitations` ORDER BY `id` DESC ");
    $data  = array();
    $site  = $site_url . '/register?invite=';
    if (mysqli_num_rows($query)) {
        while ($fetched_data = mysqli_fetch_assoc($query)) {
            $fetched_data['url'] = $site . $fetched_data['code'];
            $data[]              = $fetched_data;
        }
    }
    return $data;
}
function InsertAdminInvitation() {
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false || auth()->admin == 0) {
        return false;
    }
    $time  = time();
    $code  = uniqid(rand(), true);
    $sql   = "INSERT INTO `admininvitations` (`id`,`code`,`posted`) VALUES (NULL,'$code', '$time')";
    $site  = $site_url . '/register?invite=';
    $query = mysqli_query($conn, $sql);
    if ($query) {
        $last_id = mysqli_insert_id($conn);
        $data    = mysqli_query($conn, "SELECT * FROM `admininvitations` WHERE `id` = {$last_id}");
        if ($data && mysqli_num_rows($data) > 0) {
            $fetched_data        = mysqli_fetch_assoc($data);
            $fetched_data['url'] = $site . $fetched_data['code'];
            return $fetched_data;
        }
    }
    return false;
}
function DeleteAdminInvitation($col = '', $val = false) {
    global $config, $db,$conn,$site_url;
    if (!$val && !$col) {
        return false;
    }
    $val = Secure($val);
    $col = Secure($col);
    return mysqli_query($conn, "DELETE FROM `admininvitations` WHERE `$col` = '$val'");
}
function GetAvailableLinks($user_id)
{
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false || empty($user_id) || !is_numeric($user_id) || $user_id < 1) {
        return false;
    }
    $user_id = Secure($user_id);
    $time = 0;
    if ($config->expire_user_links == 'hour') {
        $time = time() - (60 * 60);
    }
    if ($config->expire_user_links == 'day') {
        $time = time() - (60 * 60 * 24);
    }
    if ($config->expire_user_links == 'week') {
        $time = time() - (60 * 60 * 24 * 7);
    }
    if ($config->expire_user_links == 'month') {
        $time = time() - (60 * 60 * 24 * date("t"));
    }
    if ($config->expire_user_links == 'year') {
        $time = time() - (60 * 60 * 24 * 365);
    }

    $query_one = " SELECT count(*) AS count FROM `invitation_links` WHERE `user_id` = '{$user_id}' AND `time` > '{$time}' ";
    $query = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($query)) {
        $fetched_data = mysqli_fetch_assoc($query);
        if ($config->user_links_limit > 0) {
            return $config->user_links_limit - $fetched_data['count'];
        }
        else{
            return __('unlimited');
        }
    }
    return false;
}

function GetGeneratedLinks($user_id)
{
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false || empty($user_id) || !is_numeric($user_id) || $user_id < 1) {
        return false;
    }
    $user_id = Secure($user_id);
    $time = 0;
    if ($config->expire_user_links == 'hour') {
        $time = time() - (60 * 60);
    }
    if ($config->expire_user_links == 'day') {
        $time = time() - (60 * 60 * 24);
    }
    if ($config->expire_user_links == 'week') {
        $time = time() - (60 * 60 * 24 * 7);
    }
    if ($config->expire_user_links == 'month') {
        $time = time() - (60 * 60 * 24 * date("t"));
    }
    if ($config->expire_user_links == 'year') {
        $time = time() - (60 * 60 * 24 * 365);
    }

    $query_one = " SELECT count(*) AS count FROM `invitation_links` WHERE `user_id` = '{$user_id}' AND `time` > '{$time}' ";
    $query = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($query)) {

        $fetched_data = mysqli_fetch_assoc($query);
        return $fetched_data['count'];
    }
    return false;
}
function GetUsedLinks($user_id)
{
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false || empty($user_id) || !is_numeric($user_id) || $user_id < 1) {
        return false;
    }
    $user_id = Secure($user_id);
    $time = 0;
    if ($config->expire_user_links == 'hour') {
        $time = time() - (60 * 60);
    }
    if ($config->expire_user_links == 'day') {
        $time = time() - (60 * 60 * 24);
    }
    if ($config->expire_user_links == 'week') {
        $time = time() - (60 * 60 * 24 * 7);
    }
    if ($config->expire_user_links == 'month') {
        $time = time() - (60 * 60 * 24 * date("t"));
    }
    if ($config->expire_user_links == 'year') {
        $time = time() - (60 * 60 * 24 * 365);
    }

    $query_one = " SELECT count(*) AS count FROM `invitation_links` WHERE `user_id` = '{$user_id}' AND `invited_id` != 0 AND `time` > '{$time}' ";
    $query = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($query)) {
        $fetched_data = mysqli_fetch_assoc($query);
        return $fetched_data['count'];
    }
    return false;
}
function IfCanGenerateLink($user_id)
{
    global $config, $db,$conn,$site_url;
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 1) {
        return false;
    }
    $user_id = Secure($user_id);
    $time = 0;
    if ($config->expire_user_links == 'hour') {
        $time = time() - (60 * 60);
    }
    if ($config->expire_user_links == 'day') {
        $time = time() - (60 * 60 * 24);
    }
    if ($config->expire_user_links == 'week') {
        $time = time() - (60 * 60 * 24 * 7);
    }
    if ($config->expire_user_links == 'month') {
        $time = time() - (60 * 60 * 24 * date("t"));
    }
    if ($config->expire_user_links == 'year') {
        $time = time() - (60 * 60 * 24 * 365);
    }

    $query_one = " SELECT count(*) AS count FROM `invitation_links` WHERE `user_id` = '{$user_id}' AND `time` > '{$time}' ";
    $query = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($query)) {
        $fetched_data = mysqli_fetch_assoc($query);
        if ($config->user_links_limit > 0) {
            if ($config->user_links_limit > $fetched_data['count']) {
                return true;
            }
            else{
                return false;
            }
        }
    }
    return true;
}
function GetMyInvitaionCodes($user_id)
{
    global $config, $db,$conn,$site_url;
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 1) {
        return false;
    }
    $user_id = Secure($user_id);
    $time = 0;
    if ($config->expire_user_links == 'hour') {
        $time = time() - (60 * 60);
    }
    if ($config->expire_user_links == 'day') {
        $time = time() - (60 * 60 * 24);
    }
    if ($config->expire_user_links == 'week') {
        $time = time() - (60 * 60 * 24 * 7);
    }
    if ($config->expire_user_links == 'month') {
        $time = time() - (60 * 60 * 24 * date("t"));
    }
    if ($config->expire_user_links == 'year') {
        $time = time() - (60 * 60 * 24 * 365);
    }
    $data = array();

    $query_one = " SELECT * FROM `invitation_links` WHERE `user_id` = '{$user_id}' AND `time` > '{$time}' ";
    $query = mysqli_query($conn, $query_one);
    if (mysqli_num_rows($query)) {
        while ($fetched_data = mysqli_fetch_assoc($query)) {
            $fetched_data['user_name'] = '';
            $fetched_data['user_url'] = '';
            if (!empty($fetched_data['invited_id'])) {
                $user_data = userData($fetched_data['invited_id']);
                $fetched_data['user_name'] = $user_data->username;
                $fetched_data['user_url'] = $site_url.'/@'.$user_data->username;
            }
            $data[]                    = $fetched_data;
        }
    }
    return $data;
}
function AddInvitedUser($user_id,$code)
{
    global $config, $db,$conn,$site_url;
    if (empty($user_id) || !is_numeric($user_id) || $user_id < 1 || empty($code)) {
        return false;
    }
    $user_id = Secure($user_id);
    $code = Secure($code);
    $db->where('code',$code)->update('invitation_links',array('invited_id' => $user_id));
}
function IsAdminInvitationExists($code = false) {
    global $config, $db,$conn,$site_url;
    if (!$code) {
        return false;
    }
    $code      = Secure($code);
    $data_rows = mysqli_query($conn, "SELECT `id` FROM `admininvitations` WHERE `code` = '$code'");
    return mysqli_num_rows($data_rows) > 0;
}
function IsUserInvitationExists($code = false) {
    global $config, $db,$conn,$site_url;
    if (!$code) {
        return false;
    }
    $code      = Secure($code);
    $data_rows = mysqli_query($conn, "SELECT `id` FROM `invitation_links` WHERE `code` = '$code' AND `invited_id` = 0");
    return mysqli_num_rows($data_rows) > 0;
}
function DeleteApp($id = false) {
    global $config, $db,$conn,$site_url;
    $result = false;
    if (IS_LOGGED == false) {
        return false;
    }
    if (auth()->admin == 0) {
        return false;
    }
    $result = mysqli_query($conn, "DELETE FROM `apps`  WHERE `id` = '$id'");
    if ($result) {
        return true;
    }
    return false;
}
function AutoUserLike($user_id = 0) {
    global $config, $db,$conn,$site_url;
    if (empty($user_id)) {
        return false;
    }
    if (!is_numeric($user_id) || $user_id == 0) {
        return false;
    }
    $user_id = Secure($user_id);
    $user_names = explode(',', $config->auto_user_like);
    if (!empty($user_names)) {
        foreach ($user_names as $key => $user_name) {
            $user_name = trim($user_name);
            $user_name = Secure($user_name);
            $id = UserIdFromUsername($user_name);
            $saved = $db->insert('likes', array(
                        'user_id' => $user_id,
                        'like_userid' => $id,
                        'is_like' => 1,
                        'is_dislike' => 0,
                        'created_at' => date('Y-m-d H:i:s')
                    ));
        }
        return true;
    } else {
        return false;
    }
}
function CheckRazorpayPayment($payment_id, $data) {
    global $config, $db,$conn,$site_url;
    if (empty($payment_id) || empty($data)) {
        return false;
    }
    $url        = 'https://api.razorpay.com/v1/payments/' . $payment_id . '/capture';
    $key_id     = $config->razorpay_key_id;
    $key_secret = $config->razorpay_key_secret;
    $params     = http_build_query($data);
    //cURL Request
    $ch         = curl_init();
    //set the url, number of POST vars, POST data
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_USERPWD, $key_id . ':' . $key_secret);
    curl_setopt($ch, CURLOPT_TIMEOUT, 60);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
    $request = curl_exec($ch);
    curl_close($ch);
    return json_decode($request);
}
function watermark_image($target) {
    global $config, $db,$conn,$site_url;
    require_once("libs/SimpleImage-master/vendor/autoload.php");
    if ($config->watermark_system != 1) {
        return false;
    }
    try {
        $theme_url = $config->uri . '/themes/' . $config->theme .'/';
        $image = new \claviska\SimpleImage();
        $image->fromFile($target)->autoOrient()->overlay($theme_url."assets/img/icon.png", 'top left', 1, 30, 30)->toFile($target, 'image/jpeg');
        return true;
    }
    catch (Exception $err) {
        return $err->getMessage();
    }
}
function GetInstagramAccessToken($code)
{
    global $config;
    if (IS_LOGGED == false) {
        return false;
    }
    if ($config->instagram_importer != 1) {
        return false;
    }
    if (empty($code)) {
        return false;
    }
    $data = array('status' => 400);
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, 'https://api.instagram.com/oauth/access_token');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    $post = array(
        'client_id' => $config->instagram_importer_app_id,
        'client_secret' => $config->instagram_importer_app_secret,
        'grant_type' => 'authorization_code',
        'redirect_uri' => $config->uri . '/settings-instagram',
        'code' => $code
    );
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post);

    $result = curl_exec($ch);
    if (curl_errno($ch)) {
        $data['message'] = curl_error($ch);
        return $data;
    }
    curl_close($ch);
    if (!empty($result)) {
        $result = json_decode($result,true);
        if (!empty($result) && !empty($result['access_token']) && !empty($result['user_id'])) {
            setcookie("instagram_access_token", Secure($result['access_token']), time() + (24 * 60 * 60), '/');
            setcookie("instagram_user_id", Secure($result['user_id']), time() + (24 * 60 * 60), '/');
            $data['status'] = 200;
            $data['message'] = __('you_are_ready_to_import_from');
        }
        elseif (!empty($result) && !empty($result['error_message'])) {
            $data['message'] = $result['error_message'];
        }
        else{
            $data['message'] = __('Something went wrong, please try again later.');
        }
    }
    else{
        $data['message'] = __('Something went wrong, please try again later.');
    }

    return $data;
}
function GetInstagramPosts($info)
{
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false) {
        return false;
    }
    if ($config->instagram_importer != 1) {
        return false;
    }
    if (empty($info)) {
        return false;
    }
    if (empty($info['instagram_access_token']) || empty($info['instagram_user_id'])) {
        return false;
    }
    $data = array('status' => 400);
    $ch = curl_init();
    $url = 'https://graph.instagram.com/me/media?fields=id,caption,media_url,media_type,thumbnail_url,shortcode,children{media_url,thumbnail_url,media_type,permalink},permalink&access_token='.$info['instagram_access_token'].'&limit=25';
    if (!empty($info['instagram_after'])) {
        $url = 'https://graph.instagram.com/me/media?fields=id,caption,media_url,media_type,thumbnail_url,shortcode,children{media_url,thumbnail_url,media_type,permalink},permalink&access_token='.$info['instagram_access_token'].'&limit=25&after='.$info['instagram_after'];
    }

    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    $result = curl_exec($ch);
    if (curl_errno($ch)) {
        $data['message'] = curl_error($ch);
        return $data;
    }
    curl_close($ch);
    if (!empty($result)) {
        $result = json_decode($result,true);
        if (!empty($result) && !empty($result['data'])) {
            $data = array('status' => 200,
                          'posts' => $result);
        }
        elseif (!empty($result) && !empty($result['error_message'])) {
            $data['message'] = $result['error_message'];
        }
        elseif (!empty($result) && !empty($result['error']) && !empty($result['error']['message'])) {
            $data['message'] = $result['error']['message'];
        }
    }
    else{
        $data['message'] = __('Something went wrong, please try again later.');
    }

    return $data;
}
function GetInstagramPostQuality($permalink)
{
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false) {
        return false;
    }
    if ($config->instagram_importer != 1) {
        return false;
    }
    if (empty($permalink)) {
        return false;
    }
    $ch = curl_init();
    $url = $permalink.'?__a=1';
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    $result = curl_exec($ch);

    if (curl_errno($ch)) {
        $data['message'] = curl_error($ch);
        return $data;
    }
    curl_close($ch);
    if (!empty($result)) {
        $result = json_decode($result,true);
        if (!empty($result) && !empty($result['graphql']) && !empty($result['graphql']['shortcode_media']) && !empty($result['graphql']['shortcode_media']['display_resources'])) {
            if (!empty($result['graphql']['shortcode_media']['display_resources'][2])) {
                return $result['graphql']['shortcode_media']['display_resources'][2]['src'];
            }
            elseif (!empty($result['graphql']['shortcode_media']['display_resources'][1])) {
                return $result['graphql']['shortcode_media']['display_resources'][1]['src'];
            }
            elseif (!empty($result['graphql']['shortcode_media']['display_resources'][0])) {
                return $result['graphql']['shortcode_media']['display_resources'][0]['src'];
            }
        }

    }
    return false;
}
function GetInstagramPostById($info)
{
    global $config, $db,$conn,$site_url;
    if (IS_LOGGED == false) {
        return false;
    }
    if ($config->instagram_importer != 1) {
        return false;
    }
    if (empty($info)) {
        return false;
    }
    if (empty($info['instagram_access_token']) || empty($info['instagram_user_id']) || empty($info['id'])) {
        return false;
    }
    $data = array('status' => 400);
    $ch = curl_init();
    $url = 'https://graph.instagram.com/'.$info['id'].'?fields=id,caption,media_url,media_type,thumbnail_url,children{media_url,thumbnail_url,media_type,permalink},permalink&access_token='.$info['instagram_access_token'];
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    $result = curl_exec($ch);

    if (curl_errno($ch)) {
        $data['message'] = curl_error($ch);
        return $data;
    }
    curl_close($ch);
    if (!empty($result)) {
        $result = json_decode($result,true);
        if (!empty($result['media_type']) && !empty($result['media_url']) && in_array($result['media_type'], array('VIDEO','IMAGE','CAROUSEL_ALBUM'))) {
            // if (!empty($result['permalink'])) {
            //     GetInstagramPostQuality($result['permalink']);
            // }
            if ($result['media_type'] == 'VIDEO' && !empty($result['thumbnail_url'])) {
                $file_url = ImportFileFromUrl($result['media_url'],$result['media_type']);
                if (!empty($file_url)) {
                    $thumbnail_url = ImportFileFromUrl($result['thumbnail_url'],'IMAGE');
                    if (!empty($thumbnail_url)) {
                        return array('status' => 200,
                                     'file_url' => $file_url,
                                     'thumbnail_url' => $thumbnail_url,
                                     'media_type' => $result['media_type'],
                                     'id' => $result['id']);

                    }
                }
            }
            elseif ($result['media_type'] == 'IMAGE') {
                $file_url = ImportFileFromUrl($result['media_url'],$result['media_type']);
                if (!empty($file_url)) {
                    return array('status' => 200,
                                 'file_url' => $file_url,
                                 'thumbnail_url' => '',
                                 'media_type' => $result['media_type'],
                                 'id' => $result['id']);
                }
            }
            elseif ($result['media_type'] == 'CAROUSEL_ALBUM' && !empty($result['children']) && !empty($result['children']['data'])){
                $return = array('status' => 200,
                                 'media_type' => $result['media_type'],
                                 'id' => $result['id']);
                $imported = array();
                foreach ($result['children']['data'] as $key => $value) {
                    if ($value['media_type'] == 'VIDEO' && !empty($value['thumbnail_url'])) {
                        $file_url = ImportFileFromUrl($value['media_url'],$value['media_type']);
                        if (!empty($file_url)) {
                            $thumbnail_url = ImportFileFromUrl($value['thumbnail_url'],'IMAGE');
                            if (!empty($thumbnail_url)) {
                                $imported[] = array('file_url' => $file_url,
                                                     'thumbnail_url' => $thumbnail_url,
                                                     'media_type' => $value['media_type'],
                                                     'id' => $value['id']);

                            }
                        }
                    }
                    elseif ($value['media_type'] == 'IMAGE') {
                        $file_url = ImportFileFromUrl($value['media_url'],$value['media_type']);
                        if (!empty($file_url)) {
                            $imported[] = array('file_url' => $file_url,
                                         'thumbnail_url' => '',
                                         'media_type' => $value['media_type'],
                                         'id' => $value['id']);
                        }

                    }
                }
                $return['imported'] = $imported;
                return $return;
            }
        }
        else{
            $data['message'] = __('post_not_found');
        }
    }
    else{
        $data['message'] = __('Something went wrong, please try again later.');
    }

    return $data;
}
function ImportFileFromUrl($url,$type,$upload_storage = true)
{
    global $config, $db,$conn,$site_url,$_UPLOAD,$_DS;
    if (empty($url) || empty($type) || !in_array($type, array('VIDEO','IMAGE'))) {
        return false;
    }
    if (!file_exists($_UPLOAD . 'photos' . $_DS . date('Y'))) {
        mkdir($_UPLOAD . $_DS . 'photos' . $_DS . date('Y'), 0777, true);
    }
    if (!file_exists($_UPLOAD . 'photos' . $_DS . date('Y') . $_DS . date('m'))) {
        mkdir($_UPLOAD . $_DS . 'photos' . $_DS . date('Y') . $_DS . date('m'), 0777, true);
    }
    if (!file_exists($_UPLOAD . 'videos' . $_DS . date('Y'))) {
        mkdir($_UPLOAD . 'videos' . $_DS . date('Y'), 0777, true);
    }
    if (!file_exists($_UPLOAD . 'videos' . $_DS . date('Y') . $_DS . date('m'))) {
        mkdir($_UPLOAD . 'videos' . $_DS . date('Y') . $_DS . date('m'), 0777, true);
    }
    $image_dir      = $_UPLOAD . '/photos' . $_DS . date('Y') . $_DS . date('m');
    $video_dir      = $_UPLOAD . '/videos' . $_DS . date('Y') . $_DS . date('m');
    $key      = GenerateKey();
    $image_path = $image_dir . $_DS . $key . '_avatar.jpg';
    $video_path = $video_dir . $_DS . $key . '_video.mp4';
    $file = fetchDataFromURL($url);
    if (!empty($file)) {
        if ($type == 'VIDEO') {
            $filePath = file_put_contents($video_path, $file);
            $org_file = 'upload/videos/' . date('Y') . '/' . date('m') . '/' . $key . '_video.mp4';
            if ($upload_storage) {
                if (is_file($org_file)) {
                    $upload_s3 = UploadToS3($org_file, array(
                        'amazon' => 0
                    ));
                }
            }
            return $org_file;
        }
        elseif ($type == 'IMAGE') {
            $filePath = file_put_contents($image_path, $file);
            $org_file = 'upload/photos/' . date('Y') . '/' . date('m') . '/' . $key . '_avatar.jpg';
            correctImageOrientation($image_path);
            if ($upload_storage) {
                if (is_file($org_file)) {
                    $upload_s3 = UploadToS3($org_file, array(
                        'amazon' => 0
                    ));
                }
            }
            return $org_file;
        }
    }
    return false;
}
function coinpayments_api_call($req = array()) {
    global $config, $db,$conn,$site_url,$_UPLOAD,$_DS;
    $result = array('status' => 400);

    // Generate the query string
    $post_data = http_build_query($req, '', '&');
    // echo $post_data;
    // echo "<br>";
    // Calculate the HMAC signature on the POST data
    $hmac = hash_hmac('sha512', $post_data, $config->coinpayments_secret);
    // echo $hmac;
    // exit();

    $ch = curl_init('https://www.coinpayments.net/api.php');
    curl_setopt($ch, CURLOPT_FAILONERROR, TRUE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('HMAC: '.$hmac));
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);

    // Execute the call and close cURL handle
    $data = curl_exec($ch);
    // Parse and return data if successful.

    if ($data !== FALSE) {
        $info = json_decode($data, TRUE);
        if (!empty($info) && !empty($info['result'])) {
            $result = array('status' => 200,
                            'data' => $info['result']);
        }
        else{
            $result['message'] = $info['error'];
        }
    } else {
        $result['message'] = 'cURL error: '.curl_error($ch);
    }
    return $result;
}
function GetNgeniusToken()
{
    global $config, $db,$conn,$site_url,$_UPLOAD,$_DS;
    $ch = curl_init();
    if ($config->ngenius_mode == 'sandbox') {
        curl_setopt($ch, CURLOPT_URL, "https://api-gateway.sandbox.ngenius-payments.com/identity/auth/access-token");
    }
    else{
        curl_setopt($ch, CURLOPT_URL, "https://identity-uat.ngenius-payments.com/auth/realms/ni/protocol/openid-connect/token");
    }
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        "accept: application/vnd.ni-identity.v1+json",
        "authorization: Basic ".$config->ngenius_api_key,
        "content-type: application/vnd.ni-identity.v1+json"
      ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS,  "{\"realmName\":\"ni\"}");
    $output = json_decode(curl_exec($ch));
    return $output;
}
function CreateNgeniusOrder($token,$postData)
{
    global $config, $db,$conn,$site_url,$_UPLOAD,$_DS;

    $json = json_encode($postData);
    $ch = curl_init();
    if ($config->ngenius_mode == 'sandbox') {
        curl_setopt($ch, CURLOPT_URL, "https://api-gateway.sandbox.ngenius-payments.com/transactions/outlets/".$config->ngenius_outlet_id."/orders");
    }
    else{
        curl_setopt($ch, CURLOPT_URL, "https://api-gateway-uat.ngenius-payments.com/transactions/outlets/".$config->ngenius_outlet_id."/orders");
    }
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    "Authorization: Bearer ".$token,
    "Content-Type: application/vnd.ni-payment.v2+json",
    "Accept: application/vnd.ni-payment.v2+json"));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $json);

    $output = json_decode(curl_exec($ch));
    curl_close ($ch);
    return $output;
}
function NgeniusCheckOrder($token,$ref)
{
    global $config, $db,$conn,$site_url,$_UPLOAD,$_DS;
    $ch = curl_init();
    if ($config->ngenius_mode == 'sandbox') {
        curl_setopt($ch, CURLOPT_URL, "https://api-gateway.sandbox.ngenius-payments.com/transactions/outlets/".$config->ngenius_outlet_id."/orders/".$ref);
    }
    else{
        curl_setopt($ch, CURLOPT_URL, "https://api-gateway-uat.ngenius-payments.com/transactions/outlets/".$config->ngenius_outlet_id."/orders/".$ref);
    }
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    "Authorization: Bearer ".$token));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $output = json_decode(curl_exec($ch));
    curl_close ($ch);
    return $output;
}
function BackblazeConnect($args=[])
{
    global $config,$db;

    $session = curl_init($args['apiUrl'] . $args['uri']);
    $content_type = '';

    if ($args['uri'] == '/b2api/v2/b2_list_buckets') {
        $data = array("accountId" => $args['accountId']);
        $post_fields = json_encode($data);
        curl_setopt($session, CURLOPT_POSTFIELDS, $post_fields); 
        curl_setopt($session, CURLOPT_POST, true); // HTTP POST
    }
    else if ($args['uri'] == '/b2api/v2/b2_get_upload_url' || $args['uri'] == '/b2api/v2/b2_list_file_names') {
        $data = array("bucketId" => $config->backblaze_bucket_id);
        $post_fields = json_encode($data);
        curl_setopt($session, CURLOPT_POSTFIELDS, $post_fields); 
        curl_setopt($session, CURLOPT_POST, true); // HTTP POST
    }
    else if ($args['uri'] == '/b2api/v2/b2_delete_file_version') {
        $data = array("fileId" => $args['fileId'], "fileName" => $args['fileName']);
        $post_fields = json_encode($data);
        curl_setopt($session, CURLOPT_POSTFIELDS, $post_fields); 
        curl_setopt($session, CURLOPT_POST, true); // HTTP POST
    }
    elseif (isset($args['file']) && !empty($args['file'])) {
        $handle = fopen($args['file'], 'r');
        $read_file = fread($handle,filesize($args['file']));
        curl_setopt($session, CURLOPT_POSTFIELDS, $read_file); 
    }

    // Add post fields
    
    

    // Add headers
    $headers = array();
    
    if ($args['uri'] == '/b2api/v2/b2_authorize_account') {
        $credentials = base64_encode($config->backblaze_access_key_id . ":" . $config->backblaze_access_key);
        $headers[] = "Accept: application/json";
        $headers[] = "Authorization: Basic " . $credentials;
        curl_setopt($session, CURLOPT_HTTPGET, true);
    }
    else if (isset($args['file']) && !empty($args['file'])) {
        $headers[] = "X-Bz-File-Name: " . $args['file'];
        $headers[] = "Content-Type: " . mime_content_type($args['file']);
        $headers[] = "X-Bz-Content-Sha1: " . sha1_file($args['file']);
        $headers[] = "X-Bz-Info-Author: " . "unknown";
        $headers[] = "X-Bz-Server-Side-Encryption: " . "AES256";
        $headers[] = "Authorization: " . $args['authorizationToken'];
    }
    else{
        $headers[] = "Authorization: " . $args['authorizationToken'];
    }

    curl_setopt($session, CURLOPT_HTTPHEADER, $headers); 

    
    curl_setopt($session, CURLOPT_RETURNTRANSFER, true);  // Receive server response
    $server_output = curl_exec($session); // Let's do this!
    curl_close ($session); // Clean up
    
    return $server_output;
}
function checkRecaptcha($recaptcha_data)
{
    if (empty($recaptcha_data) || !is_array($recaptcha_data)) {
        return false;
    }
    $verify = curl_init();
    curl_setopt($verify, CURLOPT_URL, "https://www.google.com/recaptcha/api/siteverify");
    curl_setopt($verify, CURLOPT_POST, true);
    curl_setopt($verify, CURLOPT_POSTFIELDS, http_build_query($recaptcha_data));
    curl_setopt($verify, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($verify, CURLOPT_RETURNTRANSFER, true);
    $response = curl_exec($verify);
    return json_decode($response);
}
function LoadAdminLinkSettings($link = '') {
    global $config;
    return $config->uri . '/admin-cp/' . $link;
}
function parse_size($size) {
  $unit = preg_replace('/[^bkmgtpezy]/i', '', $size); // Remove the non-unit characters from the size.
  $size = preg_replace('/[^0-9\.]/', '', $size); // Remove the non-numeric characters from the size.
  if ($unit) {
    // Find the position of the unit in the ordered string which is the power of magnitude to multiply a kilobyte by.
    return round($size * pow(1024, stripos('bkmgtpezy', $unit[0])));
  }
  else {
    return round($size);
  }
}
function file_upload_max_size() {
  static $max_size = -1;

  if ($max_size < 0) {
    // Start with post_max_size.
    $post_max_size = parse_size(ini_get('post_max_size'));
    if ($post_max_size > 0) {
      $max_size = $post_max_size;
    }

    // If upload_max_size is less, then reduce. Except if upload_max_size is
    // zero, which indicates no limit.
    $upload_max = parse_size(ini_get('upload_max_filesize'));
    if ($upload_max > 0 && $upload_max < $max_size) {
      $max_size = $upload_max;
    }
    
  }
  return $max_size;
}
function isfuncEnabled($func) {
    return is_callable($func) && false === stripos(ini_get('disable_functions'), $func);
}
function checkHTTPS() {
    if(!empty($_SERVER['HTTPS'])) {
        if($_SERVER['HTTPS'] !== 'off') {
          return true;
        }
    } else {
      if($_SERVER['SERVER_PORT'] == 443) {
        return true;
      }
    }
    if (!empty($_SERVER['HTTP_X_FORWARDED_PROTO'])) {
      if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
         return true;
      }
    }
    return false;
}
function url_origin( $s, $use_forwarded_host = false )
{
    $ssl      = ( ! empty( $s['HTTPS'] ) && $s['HTTPS'] == 'on' );
    $sp       = strtolower( $s['SERVER_PROTOCOL'] );
    $protocol = substr( $sp, 0, strpos( $sp, '/' ) ) . ( ( $ssl ) ? 's' : '' );
    $port     = $s['SERVER_PORT'];
    $port     = ( ( ! $ssl && $port=='80' ) || ( $ssl && $port=='443' ) ) ? '' : ':'.$port;
    $host     = ( $use_forwarded_host && isset( $s['HTTP_X_FORWARDED_HOST'] ) ) ? $s['HTTP_X_FORWARDED_HOST'] : ( isset( $s['HTTP_HOST'] ) ? $s['HTTP_HOST'] : null );
    $host     = isset( $host ) ? $host : $s['SERVER_NAME'] . $port;
    return $host;
}
function full_url( $s, $use_forwarded_host = false )
{
    return url_origin( $s, $use_forwarded_host ) . $s['REQUEST_URI'];
}

function getStatus($config = array()) {
    global $config,$db;

    $errors = [];

    
    if(!ini_get('allow_url_fopen') ) {
        $errors[] = ["type" => "error", "message" => "PHP function <strong>allow_url_fopen</strong> is disabled on your server, it is required to be enabled."];
    }
    if(!function_exists('mime_content_type')) {
        $errors[] = ["type" => "error", "message" => "PHP <strong>FileInfo</strong> extension is disabled on your server, it is required to be enabled."];
    }
    if (!class_exists('DOMDocument')) {
        $errors[] = ["type" => "error", "message" => "PHP <strong>dom & xml</strong> extensions are disabled on your server, they are required to be enabled."];
    }
    if (!is_writable('./upload')) {
        $errors[] = ["type" => "error", "message" => "The folder: <strong>/upload</strong> is not writable, upload folder and all subfolder(s) permission should be set to <strong>777</strong>."];
    }
    if (!is_writable('./sitemaps')) {
        $errors[] = ["type" => "error", "message" => "The folder: <strong>/sitemaps</strong> is not writable, sitemaps folder permission should be set to <strong>777</strong>."];
    }


    if ($config->amazone_s3 == 1 || $config->ftp_upload == 1 || $config->spaces == 1 || $config->wasabi_storage == 1 || $config->backblaze_storage == 1 || $config->cloud_upload == 1) {
        if (!is_writable('./upload/photos/d-avatar.jpg')) {
            $errors[] = ["type" => "error", "message" => "The file: <strong>./upload/photos/d-avatar.jpg</strong> is not writable, the file permission should be set to <strong>777</strong>.<br> Also make sure the file exists."];
        }

        // if (!is_writable('./upload/photos/d-cover.jpg')) {
        //     $errors[] = ["type" => "error", "message" => "The file: <strong>./upload/photos/d-cover.jpg</strong> is not writable, the file permission should be set to <strong>777</strong>.<br> Also make sure the file exists."];
        // }
        
        if (!is_writable('./upload/photos/d-blog.jpg')) {
            $errors[] = ["type" => "error", "message" => "The file: <strong>./upload/photos/d-blog.jpg</strong> is not writable, the file permission should be set to <strong>777</strong>.<br> Also make sure the file exists."];
        }
        
        // if (!is_writable('./upload/photos/app-default-icon.png')) {
        //     $errors[] = ["type" => "error", "message" => "The file: <strong>./upload/photos/app-default-icon.png</strong> is not writable, the file permission should be set to <strong>777</strong>.<br> Also make sure the file exists."];
        // }
        
    }


    if ($config->ffmpeg_sys == 1) {
        if (!isfuncEnabled("shell_exec")) {
            $errors[] = ["type" => "error", "message" => "The function: <strong>shell_exec</strong> is not enabled, please contact your hosting provider to enable it, it's required for <strong>FFMPEG</strong>."];
        }
        if ($config->ffmpeg_binary == "./libs/ffmpeg-php/ffmpeg" || $config->ffmpeg_binary == "libs/ffmpeg-php/ffmpeg") {
            if (!is_writable($config->ffmpeg_binary)) {
                $errors[] = ["type" => "error", "message" => "The file: <strong>/libs/ffmpeg-php/ffmpeg</strong> is not writable, file permission should be <strong>777</strong>."];
            }
        }
        
    }
    
    if (!is_writable('./sitemap-main.xml')) {
        $errors[] = ["type" => "error", "message" => "The file: <strong>./sitemap-main.xml</strong> is not writable, the file permission should be set to <strong>777</strong>."];
    }


    if (session_status() == PHP_SESSION_NONE) {
        $errors[] = ["type" => "error", "message" => "PHP Session can't start, please check the session settings on your server, the session path should be writable, contact your server for more Information."];
    }


    if (!empty($config->curl)) {
        $ch = curl_init ();
        $timeout = 10; 
        $myHITurl = "https://www.google.com";
        curl_setopt ( $ch, CURLOPT_URL, $myHITurl );
        curl_setopt ( $ch, CURLOPT_HEADER, 0 );
        curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, 1 );
        curl_setopt ( $ch, CURLOPT_CONNECTTIMEOUT, $timeout );
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        $file_contents = curl_exec ( $ch );
        if (curl_errno ( $ch )) {
            $errors[] = ["type" => "error", "message" => "<strong>cURL</strong> is not functioning, can't connect to the outside world, error found: <strong>" . curl_error ( $ch ) . "</strong>, please contact your hosting provider to fix it."];
        }
        curl_close ( $ch );
    }


    if (!empty($config->htaccess)) {
        if (!file_exists('./.htaccess')) {
            $errors[] = ["type" => "error", "message" => "The file: <strong>.htaccess</strong> is not uploaded to your server, make sure the file <strong>.htaccess</strong> is uploaded to your server."];
        } else {
            $file_gethtaccess = file_get_contents("./.htaccess");
            if (strpos($file_gethtaccess, "index.php?path") === false) {
                $errors[] = ["type" => "error", "message" => "The file: <strong>.htaccess</strong> is not updated, please re-upload the original .htaccess file."];
            }
        }
    }


    // if (!empty($config['nodejsport']) && $pt->config->server == "nodejs") {
    //     $parse = parse_url($pt->config->site_url);
    //     $host = $parse['host'];
    //     $ports = array($pt->config->server_port);
    //     foreach ($ports as $port)
    //     {
    //         $connection = @fsockopen($host, $port);

    //         if (!is_resource($connection))
    //         {
    //             $errors[] = ["type" => "error", "message" => "<strong>NodeJS</strong>is enabled, but the system can't connect to NodeJS server, <strong> " . $host . ':' . $port . " </strong>is down or port <strong>$port</strong> is blocked."];
    //         } 
    //     }
    // }


    $dirs = array_filter(glob('upload/*'), 'is_dir');
    foreach ($dirs as $key => $value) {
        if (!is_writable($value)) {
            $errors[] = ["type" => "error", "message" => "The folder: <strong>{$value}</strong> is not writable, folder permission should be set to <strong>777</strong>."];
        }
    }

    if (empty($config->smtp_host) && empty($config->smtp_username)) {
        $errors[] = ["type" => "error", "message" => "<strong>SMTP</strong> is not configured, it's recommended to setup <strong>SMTP</strong>, so the system can send e-mails from the server. <br> <a href=" . LoadAdminLinkSettings('email-settings') . ">Click Here To Setup SMTP</a>"];
    }




    if (!is_writable('./themes/' . $config->theme . '/assets/img')) {
        $errors[] = ["type" => "error", "message" => "The folder: <strong>/themes/{$config->theme}/assets/img</strong> is not writable, the path and all subfolder(s) permission should be set to <strong>777</strong>, including <strong>logo.png</strong>"];
    }
    

    if (file_exists('./install')) {
        $errors[] = ["type" => "error", "message" => "The folder: <strong>./install</strong> is not deleted or renamed, make sure the folder <strong>./install</strong> is deleted."];
    }

    

    // if (!empty($config->filesVersion)) {
    //     if ($config->filesVersion > $config->version) {
    //         $errors[] = ["type" => "error", "message" => "There is a conflict in database version and files version, your database version is: <strong>v{$config->version}</strong>, but script version is: <strong>v{$config->filesVersion}</strong>. <br> Please run <strong><a href='{$config->site_url}/update.php'>{$config->site_url}/update.php</a></strong> of <strong>v{$config->filesVersion}</strong>. <br><br><a href='https://docs.deepsoundscript.com/#updates'>Click Here For More Information.</a>"];
    //     } else if ($config->filesVersion < $config->version) {
    //         $errors[] = ["type" => "error", "message" => "There is a conflict in database version and files version, your database version is: <strong>v{$config->version}</strong>, but script version is: <strong>v{$config->filesVersion}</strong>. <br>Please upload the files of <strong>v{$config->filesVersion}</strong> using FTP or SFTP, file managers are not recommended."];
    //     }
    // } else {
    //     $errors[] = ["type" => "error", "message" => "There is a conflict in database version and files version, your database version is: <strong>v{$config->version}</strong>, but script version is: <strong>v{$config->filesVersion}</strong>, <br>Please upload the files of <strong>v{$config->filesVersion}</strong> using FTP or SFTP, file managers are not recommended."];
    // }

    if (!empty($config->cronjob_last_run)) {
        $now = strtotime("-15 minutes");
        if ($config->cronjob_last_run < $now) {
            $errors[] = ["type" => "error", "message" => "File <strong>cron-job.php</strong> last run exceeded 15 minutes, make sure it's added to cronjob list. <br> <a href=" . LoadAdminLinkSettings('cronjob_settings') . ">CronJob Settings</a>"];
        }
    }

    

    $getSqlModes = $db->rawQuery("SELECT @@sql_mode as modes;");
      if (!empty($getSqlModes[0]->modes)) {
         $results = @explode(',', strtolower($getSqlModes[0]->modes));
         if (in_array('strict_trans_tables', $results)) {
           $errors[] = ["type" => "error", "message" => "The sql-mode <b>strict_trans_tables</b> is enabled in your mysql server, please contact your host provider to disable it."];
         }
         if (in_array('only_full_group_by', $results)) {
           $errors[] = ["type" => "error", "message" => "The sql-mode <b>only_full_group_by</b> is enabled in your mysql server, this can cause some issues on your website, please contact your host provider to disable it."];
         }
      }

    $getUploadSize = file_upload_max_size();


    if ($getUploadSize < 1000000000) {
        $errors[] = ["type" => "warning", "message" => "Your server max upload size is less than 100MB, Current: <strong>" . formatBytes($getUploadSize). "</strong> Recommended is <strong>1024MB</strong>. You should update both: upload_max_filesize, post_max_size."];
    }


    if (ini_get('max_execution_time') < 100 && ini_get('max_execution_time') > 0) {
        $errors[] = ["type" => "warning", "message" => "Your server max_execution_time is less than 100 seconds, Current: <strong>" . ini_get('max_execution_time'). "</strong> Recommended is <strong>3000</strong>."];
    }


    if ($config->developer_mode == 1) {
        $errors[] = ["type" => "warning", "message" => "<strong>Developer Mode</strong> is enabled in <strong>Settings -> General Configuration</strong>, it's not recommended to enable <strong>Developer Mode</strong> if your website is live, some errors may show."];
    }


    if(!function_exists('exif_read_data')) {
        $errors[] = ["type" => "warning", "message" => "PHP <strong>exif</strong> extension is disabled on your server, it is recommended to be enabled."];
    }


    try {
        $getSqlWait = $db->rawQuery("show variables where Variable_name='wait_timeout';");
        if (!empty($getSqlWait[0]->Value)) {
            if ($getSqlWait[0]->Value < 1000) {
              $errors[] = ["type" => "warning", "message" => "The MySQL variable <b>wait_timeout</b> is {$getSqlWait[0]->Value}, minumum required is <strong>1000</strong>, please contact your host provider to update it."];
            }
        }
    } catch (Exception $e) {
        
    }

    return $errors;
}