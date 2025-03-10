<?php
Class Findapair extends Theme {
    public static $page_data = array('title' => 'Find a Pair');
    public static $partial = 'findapair';

    public static function init_data() {
        global $config, $db;
        parent::init_data();

        parent::$data['title'] = GetPageTitle(self::$partial);
        parent::$data['keywords'] = GetPageKeyword(self::$partial);
        parent::$data['description'] = GetPageDescription(self::$partial);

        parent::$data['name'] = self::$partial;

        self::LoadMatches();

        parent::$data['matches']      = self::Matches();
        parent::$data['matches_img']  = self::Matches_img();
        parent::$data['random_users'] = self::RandomUsers();
        parent::$data['find_match_data'] = array();
        if (!empty(auth()->find_match_data)) {
            parent::$data['find_match_data'] = json_decode(auth()->find_match_data, true);
        }
    }

    public static function show($partial = '') {
        self::init_data();
        parent::show(self::$partial);
    }

    public static function LoadMatches() {
        global $_AJAX, $_CONTROLLERS;
        $data            = '';
        $ajax_class      = realpath($_CONTROLLERS . 'aj.php');
        $ajax_class_file = realpath($_AJAX . 'loadmore.php');
        if (file_exists($ajax_class_file)) {
            require_once $ajax_class;
            require_once $ajax_class_file;
            $_POST['page'] = 1;
            $loadmore      = new Loadmore();
            if (!empty(auth()) && empty(auth()->lat) && empty(auth()->lng)) {
                $match_users   = array();
            } else {
                $match_users   = $loadmore->match_users();
            }
            parent::$data['matches_data'] = $match_users;
        }
        return $data;
    }

    public static function Matches() {
        $data = '';
        if (isset(parent::$data['matches_data']['html'])) {
            $data = parent::$data['matches_data']['html'];
        }
        return $data;
    }

    public static function Matches_img() {
        $data = '';
        if (isset(parent::$data['matches_data']['html_imgs'])) {
            $data = parent::$data['matches_data']['html_imgs'];
        }
        return $data;
    }

    public static function RandomUsers() {
        global $_AJAX, $_CONTROLLERS;
        $data            = '';
        $ajax_class      = realpath($_CONTROLLERS . 'aj.php');
        $ajax_class_file = realpath($_AJAX . 'loadmore.php');
        if (file_exists($ajax_class_file)) {
            require_once $ajax_class;
            require_once $ajax_class_file;
            $_POST['page'] = 1;
            $loadmore      = new Loadmore();
            $match_users   = $loadmore->random_users();
            if (isset($match_users['html'])) {
                $data = $match_users['html'];
            }
        }
        return $data;
    }
}
