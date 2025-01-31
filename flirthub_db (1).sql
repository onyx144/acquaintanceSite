-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Янв 17 2025 г., 11:44
-- Версия сервера: 8.0.40-0ubuntu0.22.04.1
-- Версия PHP: 8.3.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `flirthub_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admininvitations`
--

CREATE TABLE `admininvitations` (
  `id` int NOT NULL,
  `code` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `posted` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `affiliates_requests`
--

CREATE TABLE `affiliates_requests` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `amount` varchar(100) NOT NULL DEFAULT '0',
  `full_amount` varchar(100) NOT NULL DEFAULT '',
  `iban` text,
  `country` varchar(100) NOT NULL DEFAULT '',
  `full_name` varchar(150) NOT NULL DEFAULT '',
  `swift_code` text,
  `address` text,
  `transfer_info` varchar(150) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT '',
  `status` int NOT NULL DEFAULT '0',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `announcement`
--

CREATE TABLE `announcement` (
  `id` int NOT NULL,
  `text` text,
  `time` int NOT NULL DEFAULT '0',
  `active` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `announcement_views`
--

CREATE TABLE `announcement_views` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `announcement_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `apps`
--

CREATE TABLE `apps` (
  `id` int NOT NULL,
  `app_user_id` int NOT NULL DEFAULT '0',
  `app_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `app_website_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `app_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `app_avatar` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `app_callback_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `app_id` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `app_secret` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `active` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `apps_permission`
--

CREATE TABLE `apps_permission` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `app_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `audiocalls`
--

CREATE TABLE `audiocalls` (
  `id` int NOT NULL,
  `call_id` varchar(30) NOT NULL DEFAULT '0',
  `access_token` text,
  `call_id_2` varchar(30) NOT NULL DEFAULT '',
  `access_token_2` text,
  `from_id` int NOT NULL DEFAULT '0',
  `to_id` int NOT NULL DEFAULT '0',
  `room_name` varchar(50) NOT NULL DEFAULT '',
  `active` int NOT NULL DEFAULT '0',
  `called` int NOT NULL DEFAULT '0',
  `time` int NOT NULL DEFAULT '0',
  `declined` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `bad_login`
--

CREATE TABLE `bad_login` (
  `id` int NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `bank_receipts`
--

CREATE TABLE `bank_receipts` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `description` tinytext,
  `price` varchar(50) NOT NULL DEFAULT '0',
  `mode` varchar(50) NOT NULL DEFAULT '',
  `approved` int UNSIGNED NOT NULL DEFAULT '0',
  `receipt_file` varchar(250) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_at` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `banned_ip`
--

CREATE TABLE `banned_ip` (
  `id` int NOT NULL,
  `ip_address` varchar(32) NOT NULL DEFAULT '',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `blocks`
--

CREATE TABLE `blocks` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `block_userid` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `blog`
--

CREATE TABLE `blog` (
  `id` int NOT NULL,
  `title` varchar(120) NOT NULL DEFAULT '',
  `content` text,
  `description` text,
  `posted` varchar(300) DEFAULT '0',
  `category` int DEFAULT '0',
  `thumbnail` varchar(100) DEFAULT 'upload/photos/d-blog.jpg',
  `view` int DEFAULT '0',
  `shared` int DEFAULT '0',
  `tags` varchar(300) DEFAULT '',
  `created_at` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `codes`
--

CREATE TABLE `codes` (
  `id` int NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `app_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `user_id` int NOT NULL DEFAULT '0',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `post_id` int NOT NULL DEFAULT '0',
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `conversations`
--

CREATE TABLE `conversations` (
  `id` int UNSIGNED NOT NULL,
  `sender_id` int UNSIGNED NOT NULL DEFAULT '0',
  `receiver_id` int UNSIGNED NOT NULL DEFAULT '0',
  `from_delete` int UNSIGNED NOT NULL DEFAULT '0',
  `to_delete` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` int UNSIGNED DEFAULT '0',
  `status` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `conversations`
--

INSERT INTO `conversations` (`id`, `sender_id`, `receiver_id`, `from_delete`, `to_delete`, `created_at`, `status`) VALUES
(1, 1, 105, 0, 0, 1718791191, 0),
(2, 105, 1, 0, 0, 1718791191, 1),
(3, 106, 110, 0, 0, 1718387148, 0),
(4, 110, 106, 0, 0, 1718387148, 1),
(5, 1, 110, 0, 1, 1718689465, 0),
(6, 110, 1, 1, 0, 1718689465, 1),
(7, 2, 1, 0, 1, 1718696028, 1),
(8, 1, 2, 1, 0, 1718696028, 1),
(9, 115, 1, 0, 1, 1736714576, 0),
(10, 1, 115, 1, 0, 1736714576, 1),
(11, 115, 116, 0, 0, 1737108439, 1),
(12, 116, 115, 0, 0, 1737108439, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `custom_pages`
--

CREATE TABLE `custom_pages` (
  `id` int NOT NULL,
  `page_name` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_title` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_content` text COLLATE utf8mb3_unicode_ci,
  `page_type` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `daily_credits`
--

CREATE TABLE `daily_credits` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` int UNSIGNED NOT NULL DEFAULT '0',
  `added` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `daily_credits`
--

INSERT INTO `daily_credits` (`id`, `user_id`, `created_at`, `added`) VALUES
(1, 1, 1718031660, 1),
(2, 1, 1718031780, 1),
(3, 1, 1718031911, 1),
(4, 1, 1718031971, 1),
(5, 1, 1718033120, 1),
(6, 1, 1718037661, 1),
(7, 1, 1718037679, 1),
(8, 2, 1718037743, 0),
(9, 1, 1718037836, 1),
(10, 1, 1718049934, 1),
(11, 1, 1718050658, 1),
(12, 3, 1718054897, 0),
(13, 4, 1718091760, 0),
(14, 2, 1718095401, 0),
(15, 1, 1718096641, 0),
(16, 2, 1718101426, 0),
(17, 1, 1718101821, 0),
(18, 105, 1718123376, 0),
(19, 1, 1718125292, 0),
(20, 106, 1718125442, 0),
(21, 107, 1718135863, 0),
(22, 1, 1718139228, 0),
(23, 108, 1718178765, 0),
(24, 1, 1718192375, 0),
(25, 1, 1718192698, 0),
(26, 2, 1718203287, 0),
(27, 2, 1718211610, 0),
(28, 2, 1718218531, 0),
(29, 2, 1718219614, 0),
(30, 109, 1718277871, 0),
(31, 1, 1718291151, 0),
(32, 106, 1718350256, 0),
(33, 110, 1718359478, 0),
(34, 2, 1718380341, 0),
(35, 2, 1718381119, 0),
(36, 2, 1718383225, 0),
(37, 111, 1718391103, 0),
(38, 1, 1718453116, 0),
(39, 106, 1718455901, 0),
(40, 2, 1718458391, 0),
(41, 2, 1718459872, 0),
(42, 2, 1718627616, 0),
(43, 1, 1718627687, 0),
(44, 2, 1718633397, 0),
(45, 112, 1718699691, 0),
(46, 113, 1718726629, 0),
(47, 114, 1718738443, 0),
(48, 115, 1736713978, 0),
(49, 115, 1736714481, 0),
(50, 115, 1736714867, 0),
(51, 115, 1736787349, 0),
(52, 115, 1736789061, 0),
(53, 116, 1736802844, 0),
(54, 116, 1736803159, 0),
(55, 116, 1736855886, 0),
(56, 115, 1736866747, 0),
(57, 115, 1736879318, 0),
(58, 117, 1736890326, 0),
(59, 118, 1736891637, 0),
(60, 115, 1737107391, 0),
(61, 115, 1737107414, 0),
(62, 115, 1737107455, 0),
(63, 116, 1737108279, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `emails`
--

CREATE TABLE `emails` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `email_to` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `subject` varchar(32) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `message` text COLLATE utf8mb3_unicode_ci,
  `src` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'site'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `email_subscribers`
--

CREATE TABLE `email_subscribers` (
  `id` int NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `faqs`
--

CREATE TABLE `faqs` (
  `id` int NOT NULL,
  `question` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `favorites`
--

CREATE TABLE `favorites` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `fav_user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `followers`
--

CREATE TABLE `followers` (
  `id` int NOT NULL,
  `following_id` int NOT NULL DEFAULT '0',
  `follower_id` int NOT NULL DEFAULT '0',
  `active` int NOT NULL DEFAULT '1',
  `created_at` int UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `followers`
--

INSERT INTO `followers` (`id`, `following_id`, `follower_id`, `active`, `created_at`) VALUES
(2, 93, 108, 0, 1718179682),
(3, 97, 1, 0, 1718273967),
(4, 103, 1, 0, 1718273979),
(5, 2, 1, 1, 1718633464);

-- --------------------------------------------------------

--
-- Структура таблицы `gifts`
--

CREATE TABLE `gifts` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '',
  `media_file` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `gifts`
--

INSERT INTO `gifts` (`id`, `name`, `media_file`, `time`) VALUES
(5, 'Kitchen', 'upload/gifts/K4PvDQdpS6m1NaEH1mbQ_15_849f5c5cdbbe90733efa098e118fa26a_image.png', 1736972146);

-- --------------------------------------------------------

--
-- Структура таблицы `hot`
--

CREATE TABLE `hot` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `hot_userid` int UNSIGNED DEFAULT '0',
  `val` int UNSIGNED DEFAULT '0',
  `created_at` int UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `hot`
--

INSERT INTO `hot` (`id`, `user_id`, `hot_userid`, `val`, `created_at`) VALUES
(1, 115, 110, 1, 1737108877);

-- --------------------------------------------------------

--
-- Структура таблицы `invitation_links`
--

CREATE TABLE `invitation_links` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `invited_id` int NOT NULL DEFAULT '0',
  `code` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `langs`
--

CREATE TABLE `langs` (
  `id` bigint UNSIGNED NOT NULL,
  `ref` varchar(250) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `options` text COLLATE utf8mb4_general_ci,
  `lang_key` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `english` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `russian` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `ukrainian` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `langs`
--

INSERT INTO `langs` (`id`, `ref`, `options`, `lang_key`, `english`, `russian`, `ukrainian`) VALUES
(1, '', NULL, 'male', 'Male', 'Мужчина', 'Чоловічий'),
(2, '', NULL, 'english', 'english', 'английский', 'англійська'),
(4, '', NULL, 'sandy', 'Sandy', 'Сэнди', 'Сэнди'),
(5, '', NULL, 'about_a_minute_ago', 'about a minute ago', 'Около минуты назад', 'Близько хвилини тому'),
(6, '', NULL, 'female', 'Female', 'Женский', 'Жіночий'),
(7, '', NULL, '141_cm', '141 cm', '141 см', '141 см'),
(8, '', NULL, '143_cm', '143 cm', '143 см', '143 см'),
(9, '', NULL, 'white', 'White', 'Белый', 'Білий'),
(11, '', NULL, 'just_now', 'Just now', 'Прямо сейчас', 'Прямо зараз'),
(12, '', NULL, 'about', 'About', 'Около', 'Близько'),
(13, '', NULL, 'view_profile', 'View Profile', 'Просмотреть профиль', 'Переглянути профіль'),
(14, '', NULL, '_d_years_ago', '%d years ago', '%d лет назад', '%d років тому.'),
(15, '', NULL, 'find_matches', 'Find Matches', 'Знакомства', 'Знайомства'),
(16, '', NULL, 'premium', 'Premium', 'Premium', 'Premium'),
(17, '', NULL, 'boost_me_', 'Boost me!', 'Поддержи меня!', 'Підтримай мене!'),
(18, '', NULL, 'credits', 'Credits', 'Кредиты', 'Кредити'),
(19, '', NULL, 'profile', 'Profile', 'Профиль', 'Профіль'),
(20, '', NULL, 'matches', 'Matches', 'Лайки и симпатии', 'Лайки та симпатії'),
(21, '', NULL, 'visits', 'Visitors', 'Посетители', 'Відвідувачі'),
(22, '', NULL, 'likes', 'Likes', 'Нравится', 'Подобається'),
(23, '', NULL, 'people_i_liked', 'People I Liked', 'Люди, которые мне понравились', 'Люди, які мені сподобалися'),
(24, '', NULL, 'people_i_disliked', 'People I Disliked', 'Люди, которые мне не понравились', 'Люди, які мені не сподобалися'),
(25, '', NULL, 'settings', 'Settings', 'Настройки', 'Налаштування'),
(26, '', NULL, 'transactions', 'Transactions', 'Операции', 'Транзакції'),
(27, '', NULL, 'admin_panel', 'Admin Panel', 'Админ-панель', 'Адмін-панель'),
(28, '', NULL, 'log_out', 'Log Out', 'Выйти', 'Вийти'),
(29, '', NULL, 'messenger', 'Messenger', 'Мессенджер', 'Месенджер'),
(30, '', NULL, 'active_status', 'Active Status', 'Активный статус', 'Активний статус'),
(31, '', NULL, 'offline', 'Offline', 'Офлайн', 'Оффлайн'),
(32, '', NULL, 'online', 'Online', 'Онлайн', 'Онлайн'),
(33, '', NULL, 'mark_all_as_read', 'Mark all as read', 'Отметить все как прочитанное', 'Відзначити все як прочитане'),
(34, '', NULL, 'search_for_chats', 'Search for conversations', 'Поиск разговоров', 'Пошук розмов'),
(35, '', NULL, 'reset', 'Reset', 'Сброс', 'Скидання'),
(36, '', NULL, 'all', 'All', 'Все', 'Всі'),
(37, '', NULL, 'no_more_messages_to_show.', 'No more messages to show.', 'Нет больше сообщений, чтобы показать.', 'Немає більше повідомлень, щоб показати.'),
(38, '', NULL, 'load_more...', 'Load more', 'Загрузи больше', 'Завантаж більше'),
(39, '', NULL, 'stickers', 'Stickers', 'Наклейки', 'Наліпки'),
(40, '', NULL, 'very_low', 'Very low', 'Очень низкий', 'Дуже низький'),
(41, '', NULL, 'popularity', 'Popularity', 'Популярность', 'Популярність'),
(42, '', NULL, 'increase', 'Increase', 'Увеличить', 'Збільшити'),
(43, '', NULL, 'premium_users', 'Premium Users', 'Premium пользователи', 'Premium користувачі'),
(44, '', NULL, 'add_me', 'Add Me', 'Добавь меня', 'Додай мене'),
(45, '', NULL, 'who_ages', 'who ages', 'кто стареет', 'хто старіє'),
(46, '', NULL, 'located_within', 'located within', 'расположен в', 'розташований у'),
(47, '', NULL, 'km_of', 'km of', 'км', 'км'),
(48, '', NULL, 'apply_filters', 'Apply Filters', 'Фильтры', 'Фільтри'),
(49, '', NULL, 'close_filters', 'Close Filters', 'Закрыть фильтры', 'Закрити фільтри'),
(50, '', NULL, 'basic', 'Basic', 'Базовый', 'Базовий'),
(51, '', NULL, 'looks', 'Looks', 'Выглядит', 'Виглядає'),
(52, '', NULL, 'background', 'Background', 'Фон', 'Фон'),
(53, '', NULL, 'lifestyle', 'Lifestyle', 'Образ жизни', 'Спосіб життя'),
(54, '', NULL, 'more', 'More', 'Больше', 'Більше'),
(55, '', NULL, 'gender', 'Gender', 'Пол', 'Стать'),
(56, '', NULL, 'location', 'Location', 'Место нахождения', 'Місце знаходження'),
(57, '', NULL, 'start_typing..', 'Start typing..', 'Начните печатать ..', 'Почніть друкувати ...'),
(58, '', NULL, 'ages', 'Ages', 'Возраст', 'Вік'),
(59, '', NULL, 'distance', 'Distance', 'Расстояние', 'Відстань'),
(60, '', NULL, 'search', 'Search', 'Поиск', 'Пошук'),
(61, '', NULL, 'height', 'Height', 'Рост', 'Зріст'),
(62, '', NULL, 'body_type', 'Body type', 'Телосложение', 'Статура'),
(63, '', NULL, 'language', 'Language', 'Язык', 'Мова'),
(64, '', NULL, 'ethnicity', 'Ethnicity', 'Этнос', ''),
(65, '', NULL, 'religion', 'Religion', 'Религия', 'Релігія'),
(66, '', NULL, 'status', 'Status', 'Статус', 'Статус'),
(67, '', NULL, 'smokes', 'Smokes', 'Курение', 'Куріння'),
(68, '', NULL, 'drinks', 'Drinks', 'Напитки', 'Напої'),
(69, '', NULL, 'by_interest', 'By Interest', 'По интересам', 'За інтересами'),
(70, '', NULL, 'e.g.__singing', 'e.g Singing', 'Например, пение', 'Наприклад, спів'),
(71, '', NULL, 'education', 'Education', 'Образование', 'Освіта'),
(72, '', NULL, 'pets', 'Pets', 'Домашние питомцы', 'Домашні улюбленці'),
(73, '', NULL, 'no_more_users_to_show.', 'No more users to show', 'Нет больше пользователей, чтобы показать', 'Немає більше користувачів, щоб показати'),
(74, '', NULL, 'random_users', 'Random Users', 'Случайные пользователи', 'Випадкові користувачі'),
(75, '', NULL, 'copyright', 'Copyright', 'Авторское право', 'Авторське право'),
(76, '', NULL, 'all_rights_reserved', 'All rights reserved', 'Все права защищены', 'Усі права захищені'),
(77, '', NULL, 'about_us', 'About Us', 'Насчет нас', 'Щодо нас'),
(78, '', NULL, 'terms', 'Terms', 'Термины', 'Терміни'),
(79, '', NULL, 'privacy_policy', 'Privacy Policy', 'Политика конфиденциальности', 'Політика конфіденційності'),
(80, '', NULL, 'contact', 'Contact', 'Контакты', 'Контакти'),
(81, '', NULL, 'get_seen_more_by_people_around_you_in_find_match.', 'Get seen more by people around you in find match.', 'Будь замечен людьми вокруг тебя в поиске соответствия.', 'Будь помітний людьми навколо тебе у пошуку відповідності.'),
(82, '', NULL, 'this_service_costs_you', 'This service costs you', 'Эта услуга стоит вам', 'Ця послуга коштує вам'),
(83, '', NULL, 'credits_and_will_last_for', 'credits and will last for', 'кредиты и будет длиться', 'кредитів і триватиме протягом'),
(84, '', NULL, 'miuntes', 'miuntes', 'минут', 'міунт'),
(85, '', NULL, 'cancel', 'Cancel', 'Отменить', 'Скасувати'),
(86, '', NULL, 'boost_now', 'Boost Now', 'Повысьте сейчас', 'Повысьте сейчас'),
(87, '', NULL, 'ago', 'ago', 'тому назад', 'тому назад'),
(88, '', NULL, 'from_now', 'from now', 'отныне', 'відтепер'),
(89, '', NULL, 'any_moment_now', 'any moment now', 'в любой момент', 'у будь-який момент'),
(90, '', NULL, '_d_minutes_ago', '%d minutes ago', '%d минут назад', '%d хвилин тому'),
(91, '', NULL, 'about_an_hour_ago', 'about an hour ago', 'около часа назад', 'близько години тому'),
(92, '', NULL, '_d_hours_ago', '%d hours ago', '%d часов назад', '%d годин тому'),
(93, '', NULL, 'a_day_ago', 'a day ago', 'день назад', 'день тому'),
(94, '', NULL, '_d_days_ago', '%d days ago', '%d дней назад', '%d днів тому'),
(95, '', NULL, 'about_a_month_ago', 'about a month ago', 'Около месяца назад', 'Близько місяця тому'),
(96, '', NULL, '_d_months_ago', '%d months ago', '%d месяцев назад', '%d місяців тому'),
(97, '', NULL, 'about_a_year_ago', 'about a year ago', 'около года назад', 'близько року тому'),
(98, '', NULL, 'loading...', 'Loading..', 'Загрузка ..', 'Завантаження ...'),
(99, '', NULL, 'payment_declined', 'Payment declined', 'Платеж отклонен', 'Платіж відхилено'),
(100, '', NULL, 'amazing', 'Amazing', 'Удивительно', 'Дивовижно'),
(101, '', NULL, 'features_you_can___t_live_without', 'features you can’t live without', 'функции, без которых вы не можете жить', 'функції, без яких ви не можете жити'),
(102, '', NULL, 'activating_premium_will_help_you_meet_more_people__faster.', 'Activating Premium will help you meet more people, faster.', 'Активация Premium поможет вам быстрее встретить больше людей.', 'Активація Premium допоможе вам швидше зустріти більше людей.'),
(103, '', NULL, 'choose_a_plan', 'Choose a Plan', 'Выберите план', 'Оберіть тарифний план'),
(104, '', NULL, 'weekly', 'Weekly', 'Еженедельно', 'Щотижня'),
(105, '', NULL, 'monthly', 'Monthly', 'Ежемесячно', 'Щомісяця'),
(106, '', NULL, 'most_popular', 'Most popular', 'Самый популярный', 'Найпопулярніший'),
(107, '', NULL, 'yearly', 'Yearly', 'Каждый год', 'Щороку'),
(108, '', NULL, 'lifetime', 'Lifetime', 'Продолжительность жизни', 'Тривалість життя'),
(109, '', NULL, 'pay_using', 'Pay Using', 'Оплатить с помощью', 'Оплатити за допомогою'),
(110, '', NULL, 'paypal', 'PayPal', 'PayPal', ''),
(111, '', NULL, 'card', 'Card', 'Карта', 'Карта'),
(112, '', NULL, 'why_choose_premium_membership', 'Why Choose Premium Membership', 'Почему стоит выбрать премиум-участие', 'Чому варто обрати преміум-участь'),
(113, '', NULL, 'see_more_stickers_on_chat', 'Get more stickers in chat', 'Получить больше стикеров в чате', 'Отримати більше стікерів у чаті'),
(114, '', NULL, 'show_in_premium_bar', 'Show yourself in premium bar', 'Покажите себя в премиум баре', 'Покажи себе у преміум-барі'),
(115, '', NULL, 'see_likes_notifications', 'View likes notifications', 'Просмотр лайков', 'Перегляд лайків'),
(116, '', NULL, 'get_discount_when_buy_boost_me', 'Get a discount when using &quot;boost me&quot;', 'Получите скидку при использовании «boost me»', 'Отримайте знижку при використанні «boost me»'),
(117, '', NULL, 'display_first_in_find_matches', 'Display first in find matches', 'Отображать первым в поиске совпадений', 'Відображати першими у знайдених збігах'),
(118, '', NULL, 'display_on_top_in_random_users', 'Display on top in random users', 'Отображать сверху у случайных пользователей', 'Відображення зверху у випадкових користувачів'),
(119, '', NULL, 'your_popularity_', 'Your Popularity:', 'Ваша популярность:', 'Ваша популярність:'),
(120, '', NULL, 'increase_your_popularity_with_credits_and_enjoy_the_features.', 'Increase your popularity with credits and enjoy the features.', 'Увеличьте свою популярность с кредитами и наслаждайтесь функциями.', 'Збільште свою популярність із кредитами та насолоджуйтеся функціями.'),
(122, '', NULL, 'x10_visits', 'x10 Visits', 'x10 посещений', 'x10 посещений'),
(123, '', NULL, 'promote_your_profile_by_get_more_visits', 'Promote your profile by getting more visitors', 'Продвиньте свой профиль, получая больше посетителей', 'Просуньте свій профіль, отримуючи більше відвідувачів'),
(124, '', NULL, 'this_service_will_cost_you', 'this service will cost you', 'эта услуга будет стоить вам', 'ця послуга коштуватиме вам'),
(125, '', NULL, 'for', 'For', 'За', 'За'),
(126, '', NULL, 'minutes', 'Minutes', 'Минут', 'Хвилин'),
(127, '', NULL, 'buy_now', 'Buy Now', 'Купить сейчас', 'Купити зараз'),
(128, '', NULL, 'x3_matches', 'x3 Matches', 'х3 Матчи', 'х3 Матчі'),
(129, '', NULL, 'shown_more_and_rise_up_at_the_same_time', 'Shown more and rise up at the same time', 'Показано больше и подняться одновременно', 'Показано більше і піднятися одночасно'),
(130, '', NULL, 'x4_likes', 'x4 Likes', 'x4 Лайков', 'x4 Лайків'),
(131, '', NULL, 'tell_everyone_you_re_online_and_be_seen_by_users_who_want_to_chat', 'Tell everyone you&#039;re online and be seen by users who want to chat', 'Расскажите всем, что вы онлайн, и вас увидят пользователи, которые хотят общаться', 'Розкажіть усім, що ви онлайн, і вас побачать користувачі, які хочуть спілкуватися'),
(132, '', NULL, 'visited_you', 'visited you', 'посетил тебя', 'відвідав тебе'),
(133, '', NULL, 'your', 'Your', 'Ваш', 'Ваш'),
(134, '', NULL, 'credits_balance', 'Credits balance', 'Баланс кредитов', 'Баланс кредитів'),
(135, '', NULL, 'use_your_credits_to', 'Use your Credits to', 'Используйте свои кредиты для', 'Використовуйте свої кредити для'),
(136, '', NULL, 'boost_your_profile', 'Boost your profile', 'Повысьте свой профиль', 'Підвищіть свій профіль'),
(137, '', NULL, 'send_a_gift', 'Send a gift', 'Послать подарок', 'Послати подарунок'),
(138, '', NULL, 'get_seen_100x_in_discover', 'Get seen 100x in Discover', '100 раз вас увидят в Discover', '100 разів вас побачать у Discover'),
(139, '', NULL, 'put_yourself_first_in_search', 'Put yourself First in Search', 'Поставь себя первым в поиске', 'Постав себе першим у пошуку'),
(140, '', NULL, 'get_additional_stickers', 'Get additional Stickers', 'Получить дополнительные наклейки', 'Отримати додаткові наліпки'),
(141, '', NULL, 'double_your_chances_for_a_friendship', 'Double your chances for a friendship', 'Удвойте свои шансы на дружбу', 'Подвійте свої шанси на дружбу'),
(142, '', NULL, 'buy_credits', 'Buy Credits', 'Купить кредиты', 'Купити кредити'),
(143, '', NULL, 'bag_of_credits', 'Bag of Credits', 'Сумка кредитов', 'Сумка кредитів'),
(144, '', NULL, 'box_of_credits', 'Box of Credits', 'Коробка с кредитами', 'Коробка з кредитами'),
(145, '', NULL, 'chest_of_credits', 'Chest of Credits', 'Сундук с кредитами', 'Скриня з кредитами'),
(146, '', NULL, 'year', 'year', 'год', 'рік'),
(147, '', NULL, 'month', 'month', 'месяц', 'місяць'),
(148, '', NULL, 'day', 'day', 'день', 'день'),
(149, '', NULL, 'hour', 'hour', 'час', 'годину'),
(150, '', NULL, 'minute', 'minute', 'минут', 'хвилин'),
(151, '', NULL, 'second', 'second', 'второй', 'другий'),
(152, '', NULL, 'years', 'years', 'лет', 'років'),
(153, '', NULL, 'months', 'months', 'месяцы', 'місяці'),
(154, '', NULL, 'days', 'days', 'дней', 'днів'),
(155, '', NULL, 'hours', 'hours', 'часов', 'годин'),
(156, '', NULL, 'seconds', 'seconds', 'секунд', 'секунд'),
(157, '', NULL, 'please_enable_location_services_on_your_browser.', 'Please enable location services on your browser.', 'Пожалуйста, включите службы определения местоположения в вашем браузере.', 'Будь ласка, увімкніть служби визначення місця розташування у вашому браузері.'),
(158, '', NULL, 'change_photo', 'Change Avatar', 'Сменить аватар', 'Змінити аватар'),
(159, '', NULL, 'upgrade', 'Upgrade', 'Обновить', 'Оновити'),
(160, '', NULL, 'profile_completion', 'Profile Completion', 'Заполнение профиля', 'Заповнення профілю'),
(161, '', NULL, 'this_profile_is_verified', 'This profile is verified', 'Этот профиль подтвержден', 'Цей профіль підтверджено'),
(162, '', NULL, 'edit', 'Edit', 'Редактировать', 'Редагувати'),
(163, '', NULL, 'views', 'Views', 'Просмотры', 'Перегляди'),
(164, '', NULL, 'add_photos', 'Add Photos', 'Добавить фотографии', 'Додати фотографії'),
(165, '', NULL, 'interests', 'Interests', 'Интересы', 'Інтереси'),
(166, '', NULL, 'profile_info', 'Profile Info', 'Информация о профиле', 'Інформація про профіль'),
(167, '', NULL, 'preferred_language', 'Preferred Language', 'Предпочтительный язык', 'Переважна мова'),
(168, '', NULL, 'hair_color', 'Hair color', 'Цвет волос', 'Цвет волос'),
(169, '', NULL, 'upload_completion', 'Upload Completion', 'Завершение загрузки', 'Завершення завантаження'),
(170, '', NULL, 'general', 'General', 'Общий', 'Загальний'),
(171, '', NULL, 'privacy', 'Privacy', 'Конфиденциальность', 'Конфіденційність'),
(172, '', NULL, 'password', 'Password', 'Пароль', 'Пароль'),
(173, '', NULL, 'social_links', 'Social Links', 'Социальные ссылки', 'Соціальні посилання'),
(174, '', NULL, 'blocked_users', 'Blocked Users', 'Заблокированные пользователи', 'Заблоковані користувачі'),
(175, '', NULL, 'first_name', 'First Name', 'Имя', 'Ім&#039;я'),
(176, '', NULL, 'last_name', 'Last Name', 'Фамилия', 'Прізвище'),
(177, '', NULL, 'username', 'Username', 'Имя пользователя', 'Ім&#039;я користувача'),
(178, '', NULL, 'email', 'Email', 'Email', 'Email'),
(179, '', NULL, 'choose_your_country', 'Choose your country', 'Выберите вашу страну', 'Виберіть вашу країну'),
(180, '', NULL, 'country', 'Country', 'Страна', 'Країна'),
(181, '', NULL, 'mobile_number', 'Phone Number', 'Номер телефона', 'Номер телефону'),
(182, '', NULL, 'birth_date', 'Birthday', 'День рождения', 'День народження'),
(183, '', NULL, 'free_member', 'Free Member', 'Бесплатный участник', 'Безкоштовний учасник'),
(184, '', NULL, 'pro_member', 'Pro Member', 'Pro Member', 'Pro Member'),
(185, '', NULL, 'save', 'Save', 'Сохранить', 'Зберегти'),
(186, '', NULL, 'about_me', 'About Me', 'Обо мне', 'Про мене'),
(187, '', NULL, 'relationship_status', 'Relationship status', 'Семейное положение', 'Сімейний стан'),
(188, '', NULL, 'work_status', 'Work status', 'Рабочий статус', 'Робочий статус'),
(189, '', NULL, 'education_level', 'Education Level', 'Уровень образования', 'Рівень освіти'),
(190, '', NULL, 'character', 'Character', 'Характер', 'Характер'),
(191, '', NULL, 'children', 'Children', 'Дети', 'Діти'),
(192, '', NULL, 'friends', 'Friends', 'Друзья', 'Друзі'),
(193, '', NULL, 'i_live_with', 'I live with', 'Я живу с', 'Я живу з'),
(194, '', NULL, 'car', 'Car', 'Автомобиль', 'Автомобіль'),
(195, '', NULL, 'smoke', 'Smoke', 'Дым', 'Дим'),
(196, '', NULL, 'drink', 'Drink', 'Напиток', 'Напій'),
(197, '', NULL, 'travel', 'Travel', 'Путешествовать', 'Подорожувати'),
(198, '', NULL, 'music_genre', 'Music Genre', 'Музыкальный жанр', 'Музичний жанр'),
(199, '', NULL, 'dish', 'Dish', 'Блюдо', 'Страва'),
(200, '', NULL, 'song', 'Song', 'Песня', 'Пісня'),
(201, '', NULL, 'hobby', 'Hobby', 'Хобби', 'Хобі'),
(202, '', NULL, 'city', 'City', 'Город', 'Місто'),
(203, '', NULL, 'sport', 'Sport', 'Спорт', 'Спорт'),
(204, '', NULL, 'book', 'Book', 'Книга', 'Книга'),
(205, '', NULL, 'movie', 'Movie', 'Кино', 'Кино'),
(206, '', NULL, 'color', 'Color', 'Цвет', 'Колір'),
(207, '', NULL, 'tv_show', 'TV Show', 'ТВ шоу', 'ТБ шоу'),
(208, '', NULL, 'show_my_profile_on_google', 'Show my profile on search engines?', 'Показать мой профиль в поисковых системах?', 'Показати мій профіль у пошукових системах?'),
(209, '', NULL, 'show_my_profile_in_random_users', 'Show my profile in random users?', 'Показать мой профиль в случайных пользователях?', 'Показати мій профіль у випадкових користувачах?'),
(210, '', NULL, 'show_my_profile_in_match_profiles', 'Show my profile in find match page?', 'Показать мой профиль на странице поиска совпадений?', 'Показати мій профіль на сторінці пошуку збігів?'),
(211, '', NULL, 'new_password', 'New Password', 'Новый пароль', 'Новий пароль'),
(212, '', NULL, 'confirm_new_password', 'Confirm New Password', 'Подтвердите новый пароль', 'Підтвердіть новий пароль'),
(213, '', NULL, 'change', 'Change', '+ Изменить', '+ Змінити'),
(214, '', NULL, 'facebook', 'Facebook', 'facebook', ''),
(215, '', NULL, 'twitter', 'Twitter', 'щебет', ''),
(216, '', NULL, 'google_plus', 'Google Plus', 'Гугл плюс', ''),
(217, '', NULL, 'instagrem', 'instagrem', 'instagrem', ''),
(218, '', NULL, 'linkedin', 'LinkedIn', 'LinkedIn', ''),
(219, '', NULL, 'website', 'Website', 'Веб-сайт', 'Веб-сайт'),
(220, '', NULL, 'there_is_no_blocked_user_yet.', 'There are no blocked users found.', 'Заблокированных пользователей не найдено.', 'Заблокованих користувачів не знайдено.'),
(221, '', NULL, 'no_transactions_found.', 'No transactions found.', 'Транзакций не найдено.', 'Транзакцій не знайдено.'),
(222, '', NULL, 'login', 'Login', 'Вход', 'Вхід'),
(223, '', NULL, 'register', 'Register', 'Регистрация', 'Реєстрація'),
(224, '', NULL, 'meet_new_and_interesting_people.', 'Meet new and interesting people.', 'Встречайте новых и интересных людей.', 'Зустрічайте нових та цікавих людей.'),
(225, '', NULL, 'join', 'Join', 'Присоединиться', 'Приєднатися'),
(226, '', NULL, 'where_you_could_meet_anyone__anywhere_', 'where you could meet anyone, anywhere!', 'где вы могли встретить кого угодно, где угодно!', 'де можна було зустріти кого завгодно і де завгодно!'),
(227, '', NULL, 'get_started', 'Get Started', 'Начать', 'Почати'),
(228, '', NULL, 'know_more', 'Know More', 'Узнать больше', 'Узнать больше'),
(229, '', NULL, 'i_am_a', 'I am a', 'Я', 'Я'),
(230, '', NULL, 'i_m_looking_for_a', 'I&#039;m looking for a', 'Ищу', 'Шукаю'),
(231, '', NULL, 'between_ages', 'Between ages', 'Между возрастами', 'У різному віці'),
(232, '', NULL, 'and', 'and', 'а также', 'а також'),
(233, '', NULL, 'let_s_begin', 'Let&#039;s Begin', 'Давай начнем', 'Давай почнемо'),
(234, '', NULL, 'how', 'How', 'Как', 'Як'),
(235, '', NULL, 'works', 'Works', 'Работает', 'Працює'),
(236, '', NULL, 'create_account', 'Create Account', 'Зарегистрироваться', 'Зарегистрироваться'),
(237, '', NULL, 'register_for_free___create_up_your_good_looking_profile.', 'Register for free &amp; create up your good looking Profile.', 'Зарегистрируйтесь бесплатно и создайте свой красивый профиль.', 'Зареєструйтесь безкоштовно та створіть свій привабливий профіль.'),
(238, '', NULL, 'search___connect_with_matches_which_are_perfect_for_you.', 'Search &amp; Connect with Matches which are perfect for you.', 'Ищите и общайтесь с теми, кто идеально подходит вам.', 'Шукайте та знаходьте збіги, які ідеально вам підходять.'),
(239, '', NULL, 'start_dating', 'Start Dating', 'Заводить знакомства', 'Заводити знайомства'),
(240, '', NULL, 'start_doing_conversations_and_date_your_best_match.', 'Start doing conversations and date your best match.', 'Начните общаться и встречайтесь с лучшим вариантом.', 'Почніть спілкуватися та зустрічайтеся з найкращим варіантом.'),
(241, '', NULL, 'users_loves_us', 'Users Loves Us', 'Пользователи любят нас', 'Користувачі люблять нас'),
(243, '', NULL, 'best_match', 'Best Match', 'Лучший совпадения', 'Найкращий збіг'),
(244, '', NULL, 'based_on_your_location__we_find_best_and_suitable_matches_for_you.', 'Based on your location, we find best and suitable matches for you.', 'В зависимости от вашего местоположения мы находим для вас лучшие и подходящие варианты.', 'Виходячи з вашого місцезнаходження, ми знаходимо найкращі та найприйнятніші для вас варіанти.'),
(245, '', NULL, 'fully_secure', 'Fully Secure', 'Полностью Безопасный', 'Повністю Безпечний'),
(247, '', NULL, '100__privacy', '100% Privacy', '100% конфиденциальность', '100% конфіденційність'),
(248, '', NULL, 'you_have_full_control_over_your_personal_information_that_you_share.', 'You have full control over your personal information that you share.', 'У вас есть полный контроль над вашей личной информацией, которой вы делитесь.', 'У вас є повний контроль над вашою особистою інформацією, якою ви ділитеся.'),
(250, '', NULL, 'don_t_have_an_account_', 'Don&#039;t have an account?', 'У вас нет аккаунта?', 'У вас немає акаунта?'),
(251, '', NULL, 'welcome_back_', 'Welcome back,', 'Добро пожаловать,', 'Ласкаво просимо,'),
(252, '', NULL, 'please_login_to_your_account.', 'Login to your account to continue.', 'Войдите в свой аккаунт, чтобы продолжить.', 'Увійдіть у свій акаунт, щоб продовжити.'),
(253, '', NULL, 'username_or_email', 'Username or Email', 'Имя пользователя или e-mail', 'Ім&#039;я користувача або Email'),
(254, '', NULL, 'forgot_password_', 'Forgot Password?', 'Забыли пароль?', 'Забули пароль?'),
(255, '', NULL, 'login_with_facebook', 'Login with Facebook', 'Войти с Facebook', 'Увійти з Facebook'),
(256, '', NULL, 'login_with_twitter', 'Login with Twitter', 'Войти через Twitter', 'Увійти через Twitter'),
(257, '', NULL, 'login_with_google', 'Login with Google', 'Войти через Google', 'Войти через Google'),
(258, '', NULL, 'login_with_vk', 'Login with VK', 'Войти через ВКонтакте', 'Увійти через ВКонтакте'),
(259, '', NULL, 'already_have_an_account_', 'Already have an account?', 'Уже есть аккаунт?', 'Уже есть аккаунт?'),
(260, '', NULL, 'password_recovery_', 'Password recovery,', 'Восстановление пароля,', 'Відновлення пароля,'),
(261, '', NULL, 'please_enter_your_registered_email_to_proceed.', 'Please enter your registered email address to proceed.', 'Пожалуйста, введите ваш email адрес, чтобы продолжить.', 'Будь ласка, введіть ваш email адресу, щоб продовжити.'),
(262, '', NULL, 'proceed', 'Proceed', 'Проследовать', 'Прослідувати'),
(263, '', NULL, 'contact_us', 'Contact Us', 'Связаться с нами', 'Зв&#039;язатися з нами'),
(264, '', NULL, 'how_can_we_help_', 'How can we help?', 'Как мы можем помочь?', 'Як ми можемо допомогти?'),
(265, '', NULL, 'send', 'Send', 'Отправить', 'Відправити'),
(266, '', NULL, 'terms_of_use', 'Terms of use', 'Условия эксплуатации', 'Умови експлуатації'),
(267, '', NULL, 'get_started_', 'Get started,', 'Начать,', 'Начать,'),
(268, '', NULL, 'please_signup_to_continue_your_account.', 'Sign up to get started finding your partner!', 'Зарегистрируйтесь, чтобы начать поиск своего партнера!', 'Зареєструйтеся, щоб почати пошук свого партнера!'),
(269, '', NULL, 'confirm_password', 'Confirm Password', 'Подтвердите Пароль', 'Підтвердіть Пароль'),
(270, '', NULL, 'people_who_are_interested_in__', 'People who are interested in:', 'Люди, которые заинтересованы в:', 'Люди, які зацікавлені в:'),
(271, '', NULL, 'no_interested_people_found.', 'No interested people found.', 'Не найдено заинтересованных людей.', 'Не знайдено зацікавлених людей.'),
(272, '', NULL, 'like', 'Like', 'Нравится', 'Подобається'),
(273, '', NULL, 'dislike', 'Dislike', 'Не нравится', 'Не подобається'),
(274, '', NULL, 'disliked', 'Disliked', 'Не нрапится', 'Не подобається'),
(275, '', NULL, 'you_disliked', 'you disliked', 'которые тебе не понравились.', 'які тобі не сподобалися.'),
(276, '', NULL, 'delete_account', 'Delete Account', 'Удалить аккаунт', 'Видалити акаунт'),
(277, '', NULL, 'liked', 'Liked', 'Понравилось', 'Сподобалось.'),
(278, '', NULL, 'you_liked', 'you liked', 'тебе понравилось', 'тобі сподобалось'),
(279, '', NULL, 'message', 'Message', 'Сообщение', 'Повідомлення'),
(280, '', NULL, 'report_user.', 'Report user.', 'Пожаловаться на пользователя.', 'Поскаржитися на користувача.'),
(281, '', NULL, 'type_here_why_you_want_to_report_this_user.', 'Please let us know why you want to report this person.', 'Пожалуйста, дайте нам знать, почему вы хотите сообщить об этом человеке.', 'Будь ласка, повідомте нам, чому ви хочете повідомити про цю особу.'),
(282, '', NULL, 'report', 'Report', 'отчет', 'звіт'),
(283, '', NULL, 'send_gift_costs_', 'Send gift costs', 'Отправить стоимость подарка', 'Надіслати вартість подарунка'),
(284, '', NULL, 'chat', 'Chat', 'чат', 'чат'),
(285, '', NULL, 'you_have_reached_your_daily_limit', 'You have reached your daily limit', 'Вы достигли своего дневного лимита', 'Вы достигли своего дневного лимита'),
(286, '', NULL, 'you_can_chat_to_new_people_after', 'you can chat to new people after', 'Вы можете общаться с новыми людьми после', 'Ви можете спілкуватися з новими людьми після'),
(287, '', NULL, 'can_t_wait__this_service_costs_you', 'can&#039;t wait? this service costs you', 'не могу ждать? эта услуга стоит вам', 'не можеш чекати? ця послуга коштує тобі'),
(288, '', NULL, 'likes_you', 'likes you', 'вы нравитесь', 'ви подобаєтеся'),
(289, '', NULL, 'this_profile_is_not_verified', 'This profile is not verified yet', 'Этот профиль еще не подтвержден', 'Цей профіль ще не підтверджено'),
(290, '', NULL, 'block_user', 'Block', 'блок', 'блок'),
(291, '', NULL, 'report_user', 'Report', 'отчет', 'звіт'),
(292, '', NULL, 'buy_now.', 'Buy Now.', 'Купить сейчас.', 'Купити зараз.'),
(293, '', NULL, 'low', 'Low', 'Низкий', 'Низький'),
(294, '', NULL, 'matched_you', 'matched you', 'соответствует вам', 'відповідає вам'),
(295, '', NULL, 'user__1', 'User #1', 'Пользователь #1', 'Користувач #1'),
(297, '', NULL, 'user__2', 'User #2', 'Пользователь #2', 'Користувач #2'),
(298, '', NULL, 'user__3', 'User #3', 'Пользователь #3', 'Користувач #3'),
(299, '', NULL, 'user__4', 'User #4', 'Пользователь #4', 'Користувач #4'),
(308, '', NULL, 'unread_messages', 'Unread Messages', 'Непрочитанные сообщения', 'Непрочитані повідомлення'),
(309, '', NULL, 'there_is_no_new_notifications.', 'There are no new notifications', 'Нет новых уведомлений', 'Нет новых уведомлений'),
(310, '', NULL, '183_cm__6__039__0__', '183 cm (6 &#039;0&#039;)', '183 см (6 &#039;0&#039;)', '183 см (6 &#039;0&#039;)'),
(311, '', NULL, '184_cm', '184 cm', '184 см', '184 см'),
(312, '', NULL, '180_cm__5__039__11__', '180 cm (5 &#039;11&#039;)', '180 cm (5 &#039;11&#039;)', '180 см (5 &#039;11&#039;)'),
(313, '', NULL, 'wanna_get_more__get_premium__or_get_new_stickers_for', 'Wanna get more? get premium! OR get new stickers for', 'Хотите получить больше? получи premium! ИЛИ получите новые наклейки для', 'Хочете отримати більше? отримай premium! АБО отримайте нові наліпки для'),
(314, '', NULL, 'get_premium', 'Get premium', 'Получите premium', 'Отримайте premium'),
(315, '', NULL, 'buy_now_', 'Buy Now!', 'Купить сейчас!', 'Купити зараз!'),
(316, '', NULL, 'liked_you', 'liked you', 'понравился', 'сподобався'),
(317, '', NULL, 'arabic', 'Arabic', 'арабский', 'арабський'),
(318, '', NULL, 'dutch', 'dutch', 'dutch', 'Голландський'),
(319, '', NULL, 'french', 'French', 'Французский', 'Французький'),
(320, '', NULL, 'german', 'German', 'Немецкий', 'Німецький'),
(321, '', NULL, 'italian', 'Italian', 'итальянский', 'італійський'),
(322, '', NULL, 'portuguese', 'portuguese', 'portuguese', 'португальська'),
(323, '', NULL, 'russian', 'russian', 'русский', 'російська'),
(324, '', NULL, 'spanish', 'Spanish', 'испанский', ''),
(325, '', NULL, 'turkish', 'Turkish', 'турецкий', ''),
(405, '', NULL, 'brown', 'Brown', 'коричневый', 'коричневий'),
(406, '', NULL, 'black', 'Black', 'Черный', 'Черный'),
(407, '', NULL, 'gray_or_partially_gray', 'Gray or Partially Gray', 'Серый или частично серый', 'Сірий або частково сірий'),
(408, '', NULL, 'red_auburn', 'Red/Auburn', 'Красный/коричневый', 'Червоний/коричневий'),
(409, '', NULL, 'blond_strawberry', 'Blond/Strawberry', 'Русый / Клубничный', 'Русявий / Полуничний'),
(410, '', NULL, 'blue', 'Blue', 'Синий', 'Синій'),
(411, '', NULL, 'green', 'Green', 'Зеленый', 'Зелений'),
(412, '', NULL, 'orange', 'Orange', 'Оранжевый', 'Оранжевый'),
(413, '', NULL, 'pink', 'Pink', 'Розовый', 'Рожевий'),
(414, '', NULL, 'purple', 'Purple', 'Пурпурный', 'Пурпурний'),
(415, '', NULL, 'partly_or_completely_bald', 'Partly or Completely Bald', 'Частично или полностью лысый', 'Частково або повністю лисий'),
(416, '', NULL, 'other', 'Other', 'Другой', 'Інший'),
(417, '', NULL, 'single', 'Single', 'Не замужем', 'Незаміжня'),
(418, '', NULL, 'married', 'Married', 'Замужем', 'Заміжня'),
(419, '', NULL, 'i_m_studying', 'I&#039;m studying', 'Я учусь', 'Я вчуся'),
(420, '', NULL, 'i_m_working', 'I&#039;m working', 'Я работаю', 'Я працюю'),
(421, '', NULL, 'i_m_looking_for_work', 'I&#039;m looking for work', 'Я ищу работу', 'Я шукаю роботу'),
(422, '', NULL, 'i_m_retired', 'I&#039;m retired', 'Я ушел в отставку', 'Я пішов у відставку'),
(423, '', NULL, 'self-employed', 'Self-Employed', 'Частный предприниматель', 'Приватний підприємець'),
(424, '', NULL, 'secondary_school', 'Secondary school', 'Средняя школа', 'Середня школа'),
(425, '', NULL, 'iti', 'ITI', 'ITI', 'ITI'),
(426, '', NULL, 'college', 'College', 'Колледж', 'Колледж'),
(427, '', NULL, 'university', 'University', 'Университет', 'Університет'),
(428, '', NULL, 'advanced_degree', 'Advanced degree', 'Ученая степень', 'Ученая степень'),
(429, '', NULL, 'middle_eastern', 'Middle Eastern', 'Ближневосточный', 'Ближневосточный'),
(430, '', NULL, 'north_african', 'North African', 'Североафриканец', ''),
(431, '', NULL, 'latin_american', 'Latin American', 'Латиноамериканская', ''),
(432, '', NULL, 'mixed', 'Mixed', 'смешанный', ''),
(433, '', NULL, 'asian', 'Asian', 'азиатка', ''),
(434, '', NULL, 'slim', 'Slim', 'Худой', 'Худий'),
(435, '', NULL, 'sporty', 'Sporty', 'Спортивный', 'Спортивний'),
(436, '', NULL, 'curvy', 'Curvy', 'Пышная', 'Пишна'),
(437, '', NULL, 'round', 'Round', 'Круглый', 'Круглий'),
(438, '', NULL, 'supermodel', 'Supermodel', 'Супермодель', 'Супермодель'),
(439, '', NULL, 'average', 'Average', 'Средний', 'Середній'),
(440, '', NULL, 'accommodating', 'Accommodating', 'Вмещающий', 'Що вміщує'),
(441, '', NULL, 'adventurous', 'Adventurous', 'Предприимчивый', 'Заповзятливий'),
(442, '', NULL, 'calm', 'Calm', 'Штиль', 'Штиль'),
(443, '', NULL, 'careless', 'Careless', 'Неосторожный', 'Необережний'),
(444, '', NULL, 'cheerful', 'Cheerful', 'Веселый', 'Веселий'),
(445, '', NULL, 'demanding', 'Demanding', 'Требовательный', 'Вимогливий'),
(446, '', NULL, 'extroverted', 'Extroverted', 'Экстравертированный', 'Екстравертований'),
(447, '', NULL, 'honest', 'Honest', 'Честный', 'Чесний'),
(448, '', NULL, 'generous', 'Generous', 'Великодушный', 'Великодушный'),
(449, '', NULL, 'humorous', 'Humorous', 'Юмористический', 'Гумористичний'),
(450, '', NULL, 'introverted', 'Introverted', 'Интровертированный', 'Інтровертований'),
(451, '', NULL, 'liberal', 'Liberal', 'Либеральный', 'Ліберальний'),
(452, '', NULL, 'lively', 'Lively', 'Оживленный', 'Жвавий'),
(453, '', NULL, 'loner', 'Loner', 'Одиночка', 'Самотній'),
(454, '', NULL, 'nervous', 'Nervous', 'Нервное', 'Нервове'),
(455, '', NULL, 'possessive', 'Possessive', 'Притяжательный падеж', 'Присвійний відмінок'),
(456, '', NULL, 'quiet', 'Quiet', 'Тихо', 'Тихо'),
(457, '', NULL, 'reserved', 'Reserved', 'Зарезервированный', 'Зарезервований'),
(458, '', NULL, 'sensitive', 'Sensitive', 'Чувствительный', 'Чутливий'),
(459, '', NULL, 'shy', 'Shy', 'Застенчивый', ''),
(460, '', NULL, 'social', 'Social', 'Социальное', 'Соціальне'),
(461, '', NULL, 'spontaneous', 'Spontaneous', 'спонтанный', ''),
(462, '', NULL, 'stubborn', 'Stubborn', 'Упрямый', ''),
(463, '', NULL, 'suspicious', 'Suspicious', 'подозрительный', ''),
(464, '', NULL, 'thoughtful', 'Thoughtful', 'Вдумчивый', ''),
(465, '', NULL, 'proud', 'Proud', 'гордый', ''),
(466, '', NULL, 'considerate', 'Considerate', 'тактичный', ''),
(467, '', NULL, 'friendly', 'Friendly', 'Дружелюбный', ''),
(468, '', NULL, 'polite', 'Polite', 'любезный', ''),
(469, '', NULL, 'reliable', 'Reliable', 'надежный', ''),
(470, '', NULL, 'careful', 'Careful', 'Осторожный', ''),
(471, '', NULL, 'helpful', 'Helpful', 'полезный', ''),
(472, '', NULL, 'patient', 'Patient', 'Пациент', ''),
(473, '', NULL, 'optimistic', 'Optimistic', 'Оптимистичный', ''),
(474, '', NULL, 'no__never', 'No, never', 'Нет никогда', 'Ні ніколи'),
(475, '', NULL, 'someday__maybe', 'Someday, maybe', 'Возможно когда-нибудь', ''),
(476, '', NULL, 'expecting', 'Expecting', 'Ожидая', ''),
(477, '', NULL, 'i_already_have_kids', 'I already have kids', 'У меня уже есть дети', 'У мене вже є діти'),
(478, '', NULL, 'i_have_kids_and_don_t_want_more', 'I have kids and don&#039;t want more', 'У меня есть дети, и я не хочу больше', 'У мене є діти, і я не хочу більше'),
(479, '', NULL, 'no_friends', 'No friends', 'Нет друзей', 'Немає друзів'),
(480, '', NULL, 'some_friends', 'Some friends', 'Некоторые друзья', ''),
(481, '', NULL, 'many_friends', 'Many friends', 'Много друзей', 'Багато друзів'),
(482, '', NULL, 'only_good_friends', 'Only good friends', 'Только хорошие друзья', 'Тільки хороші друзі'),
(483, '', NULL, 'none', 'None', 'Никто', ''),
(484, '', NULL, 'have_pets', 'Have pets', 'Есть домашние животные', ''),
(485, '', NULL, 'alone', 'Alone', 'В одиночестве', ''),
(486, '', NULL, 'parents', 'Parents', 'Родители', ''),
(487, '', NULL, 'partner', 'Partner', 'партнер', ''),
(488, '', NULL, 'my_own_car', 'My own car', 'Моя собственная машина', ''),
(489, '', NULL, 'muslim', 'Muslim', 'мусульманка', ''),
(490, '', NULL, 'atheist', 'Atheist', 'атеист', ''),
(491, '', NULL, 'buddhist', 'Buddhist', 'буддист', ''),
(492, '', NULL, 'catholic', 'Catholic', 'католик', ''),
(493, '', NULL, 'christian', 'Christian', 'Кристиан', ''),
(494, '', NULL, 'hindu', 'Hindu', 'индус', ''),
(495, '', NULL, 'jewish', 'Jewish', 'иудейский', ''),
(496, '', NULL, 'agnostic', 'Agnostic', 'агностик', ''),
(497, '', NULL, 'sikh', 'Sikh', 'сикх', ''),
(498, '', NULL, 'never', 'Never', 'Никогда', ''),
(499, '', NULL, 'i_smoke_sometimes', 'I smoke sometimes', 'Я курю иногда', ''),
(500, '', NULL, 'chain_smoker', 'Chain Smoker', 'Заядлый курильщик', ''),
(501, '', NULL, 'i_drink_sometimes', 'I drink sometimes', 'Я пью иногда', ''),
(502, '', NULL, 'yes__all_the_time', 'Yes, all the time', 'Да все время', ''),
(503, '', NULL, 'yes__sometimes', 'Yes, sometimes', 'Да, иногда', ''),
(504, '', NULL, 'not_very_much', 'Not very much', 'Не очень много', ''),
(505, '', NULL, 'no', 'Norway', 'Норвегия', ''),
(507, '', NULL, 'avatar', 'Avatar', 'Аватар', ''),
(508, '', NULL, 'info', 'Info', 'Информация', 'Інформація'),
(509, '', NULL, 'finish', 'Finish', 'Конец', 'Кінець'),
(510, '', NULL, 'people_want_to_see_what_you_look_like_', 'people want to see what you look like!', 'люди хотят видеть как ты выглядишь!', 'люди хочуть бачити, як ти виглядаєш!'),
(511, '', NULL, 'upload_images_to_set_your_profile_picture_image.', 'Upload photos to set your profile picture.', 'Загрузите фотографии, чтобы установить изображение профиля.', 'Завантажте фотографії, щоб встановити зображення профілю.'),
(512, '', NULL, 'next', 'Next', 'Дальше', 'Далі'),
(513, '', NULL, 'birthdate', 'Birthday', 'День рождения', 'День народження'),
(514, '', NULL, 'congratulations_', 'Congratulations!', 'Поздравляем!', 'Вітаємо!'),
(515, '', NULL, 'you_have_successfully_registered.', 'You have successfully created your account, please wait..', 'Вы успешно создали свою учетную запись, пожалуйста, подождите ..', 'Ви успішно створили свій обліковий запис, будь ласка, зачекайте ...'),
(516, '', NULL, 'images_uploaded', 'Photos successfully uploaded.', 'Фотографии успешно загружены.', 'Фотографії успішно завантажено.'),
(517, '', NULL, 'now__select_any_one_image_that_you_want_to_set_as_your_profile_picture.', 'Now, choose which image you would like to be your avatar.', 'Теперь выберите изображение, которое вы хотели бы использовать в качестве аватара.', 'Тепер виберіть зображення, яке ви хотіли б використовувати як аватар.'),
(518, '', NULL, 'apply', 'Apply', 'Применять', 'Застосовувати'),
(519, '', NULL, 'please_verify_your_phone_number', 'Please verify your phone number.', 'Пожалуйста, подтвердите свой номер телефона', 'Будь ласка, підтвердіть свій номер телефону'),
(520, '', NULL, 'verify_now', 'verify now', 'Подтвердить сейчас', 'Підтвердити зараз'),
(522, '', NULL, 'user', 'User', 'Пользователь', 'Користувач'),
(523, '', NULL, 'admin', 'Admin', 'Админ', 'Адмін'),
(524, '', NULL, 'unreport', 'Delete report', 'Удалить отчет', 'Видалити звіт'),
(525, '', NULL, 'user_has_been_reported_successfully.', 'Your report has been record, thank you.', 'Пользователь был успешно зарегистрирован.', 'Користувач був успішно зареєстрований.'),
(526, '', NULL, 'remove_report', 'Remove report', 'Удалить отчет', 'Видалити звіт'),
(527, '', NULL, 'sent_image_to_you.', 'sent an image to you.', 'Отправлено изображение для вас.', 'Відправлено зображення для вас.'),
(528, '', NULL, 'very_high', 'Very high', 'Очень высоко', 'Дуже високо'),
(529, '', NULL, 'high', 'High', 'Высоко', 'Високо'),
(530, '', NULL, '180_cm__5__039__11_quot__', '180 cm (5&#039; 11&amp;quot;)', '180 см (5 &#039;11)', '180 см (5 &#039;11)'),
(531, '', NULL, 'get_premium_to_view_who_liked_you_', 'Get premium to view who liked you!', 'Отримайте premium, щоб побачити, кому ви сподобалися!', 'Отримайте premium, щоб побачити, кому ви сподобалися!'),
(532, '', NULL, '__sitename___brings_out_the_sense_of_adventure_in_me__the_website_is_so_easy_to_use_and_the_possibility_of_meeting_someone_from_another_culture_that_r', '{{sitename}} brings out the sense of adventure in me! The website is so easy to use and the possibility of meeting someone from another culture that relates to me is simply thrilling.', '{{sitename}} раскрывает во мне чувство приключения! Веб-сайт очень прост в использовании, и возможность встретить кого-то другого человека, относящегося ко мне, просто волнует.', '{{sitename}} пробуджує в мені почуття пригод! Веб-сайт дуже простий у використанні, а можливість зустріти когось з іншої культури, яка мені близька, просто захоплює.'),
(533, '', NULL, 'why___sitename___is_best', 'Why {{sitename}} is Best', 'Почему {{sitename}} лучше', 'Чому {{sitename}} краще'),
(534, '', NULL, 'your_account_is_safe_on___sitename__._we_never_share_your_data_with_third_party.', 'Your account is Safe on {{sitename}}. We never share your data with third party.', 'Ваш аккаунт в безопасности {{sitename}}. Мы никогда не передаем ваши данные третьим лицам.', 'Ваш акаунт у безпеці {{sitename}}. Ми ніколи не передаємо ваші дані третім особам.'),
(535, '', NULL, 'connect_with_your_perfect_soulmate_here__on___sitename__.', 'Connect with your perfect Soulmate here, on {{sitename}}.', 'Соединитесь со своим идеальным другом по душе здесь, {{sitename}}.', 'Соединитесь со своим идеальным другом по душе здесь, {{sitename}}.'),
(539, '', NULL, '142_cm__4__039__8_quot__', '142 cm (4&#039; 8&amp;quot;)', '142 см (4 &#039;8 )', '142 см (4 &#039;8 )'),
(588, '', NULL, 'users', 'users', 'пользователи', 'користувачі'),
(590, '', NULL, 'login_with_wowonder', 'Login with Wowonder', 'Войти с Wowonder', 'Увійти з Wowonder'),
(592, '', NULL, 'meet_more_people_with___sitename___credits', 'Meet more People with {{sitename}} Credits', 'Встречайте больше людей с {{sitename}} кредитами', 'Зустрічайте більше людей з {{sitename}} кредитами'),
(595, '', NULL, 'meet_more_people_with___sitename___credits.', 'Meet more People with {{sitename}} Credits.', 'Встречайте больше людей с {{sitename}} кредитами.', 'Зустрічайте більше людей з {{sitename}} кредитами.'),
(598, '', NULL, 'hack_attempt.', 'Hack attempt.', 'Попытка взлома.', 'Спроба злому.'),
(599, '', NULL, 'forbidden', 'Forbidden', 'Запрещено', 'Заборонено'),
(600, '', NULL, 'no_from_id_found.', 'No from id found.', 'Нет с идентификатором найдено.', 'Ні з ідентифікатором знайдено.'),
(601, '', NULL, 'please_recharge_your_credits.', 'please recharge your credits.', 'пожалуйста, пополните свои кредиты.', 'будь ласка, поповніть свої кредити.'),
(602, '', NULL, 'message_sent', 'Message sent', 'Сообщение отправлено', 'Повідомлення відправлено'),
(603, '', NULL, 'bad_request', 'Bad Request', 'Неверный запрос', 'Неправильний запит'),
(604, '', NULL, 'no_user_id_found.', 'No user ID found.', 'ID пользователя не найден.', 'ID користувача не знайдено.'),
(605, '', NULL, 'no_credit_available.', 'No credit available.', 'Нет доступных кредитов.', 'Нет доступных кредитов.'),
(606, '', NULL, 'user_buy_stickers_successfully.', 'User buy stickers successfully.', 'Пользователь успешно купил стикеры.', 'Користувач успішно купив стікери.'),
(607, '', NULL, 'error_while_save_like.', 'Error while save like.', 'Ошибка при сохранении вроде.', 'Помилка під час збереження начебто.'),
(608, '', NULL, 'no_chat_user_id_found.', 'No chat user ID found.', 'ID пользователя чата не найден.', 'ID користувача чату не знайдено.'),
(609, '', NULL, 'user_buy_new_chat_successfully.', 'User buy new chat successfully.', 'Пользователь успешно купил новый чат.', 'Користувач успішно купив новий чат.'),
(610, '', NULL, 'error_while_buy_more_chat_credit.', 'Error while buy more chat credit.', 'Ошибка при покупке более чата.', 'Помилка під час купівлі більше чату.'),
(611, '', NULL, 'no_page_number_found.', 'no page number found.', 'номер страницы не найден.', 'номер сторінки не знайдено.'),
(612, '', NULL, 'no_content', 'No Content', 'Нет контента', 'Немає контенту'),
(613, '', NULL, 'no_amount_passed', 'No amount passed', 'Сумма не передана', 'Не передано жодної суми'),
(614, '', NULL, 'amount_is_not_number', 'Amount is not number', 'Сумма не является числом', 'Сума не є числом'),
(615, '', NULL, 'no_description_passed', 'No description passed', 'Описание не передано', 'Опис не пройшов'),
(616, '', NULL, 'there_is_no_mode_set_for_this_call', 'There is no mode set for this call', 'Для этого вызова не установлен режим', 'Для цього виклику не встановлено режим'),
(617, '', NULL, 'link_generated_successfully', 'Link generated successfully', 'Ссылка успешно создана', 'Посилання успішно створено'),
(618, '', NULL, 'transaction_user_not_match_current_active_user', 'Transaction user not match current active user', 'Пользователь транзакции не соответствует текущему активному пользователю', 'Користувач транзакції не відповідає поточному активному користувачеві'),
(619, '', NULL, 'error_while_update_balance_after_charging', 'Error While update balance after charging', 'Ошибка при обновлении баланса после зарядки', 'Помилка під час оновлення балансу після заряджання'),
(620, '', NULL, 'missing__url__parameter.', 'Missing `url` parameter.', 'Отсутствует параметр `url`.', 'Відсутній параметр `url`.'),
(621, '', NULL, 'you_can_not_delete_your_profile_image__but_you_can_change_it_first.', 'You can not delete your profile image, but you can change it first.', 'Вы не можете удалить изображение своего профиля, но вы можете сначала изменить его.', 'Ви не можете видалити зображення свого профілю, але ви можете спочатку змінити його.'),
(622, '', NULL, 'file_deleted_successfully', 'File deleted successfully', 'Файл успешно удален', 'Файл успешно удален'),
(623, '', NULL, 'you_can_not_use_more_than_30_character_for_first_name.', 'you can not use more than 30 character for first name.', 'Вы не можете использовать более 30 символов для имени.', 'Ви не можете використовувати більше 30 символів для імені.'),
(624, '', NULL, 'you_can_not_use_more_than_30_character_for_last_name.', 'you can not use more than 30 character for last name.', 'Вы не можете использовать более 30 символов для фамилии.', 'Ви не можете використовувати більше 30 символів для прізвища.'),
(625, '', NULL, 'this_user_name_is_already_exist.', 'This User name is Already exist.', 'Это имя пользователя уже существует.', 'Це ім&#039;я користувача вже існує.'),
(626, '', NULL, 'this_user_name_is_reserved_word._please_choose_anther_username.', 'This User name is reserved word. please choose anther username.', 'Это имя пользователя является зарезервированным словом. Пожалуйста, выберите другое имя пользователя.', 'Це ім&#039;я користувача є зарезервованим словом. Будь ласка, виберіть інше ім&#039;я користувача.'),
(627, '', NULL, 'empty_user_name.', 'empty user name.', 'пустое имя пользователя.', 'порожнє ім&#039;я користувача.'),
(628, '', NULL, 'this_e-mail_is_invalid.', 'This e-mail is invalid.', 'Этот e-mail почты недействителен.', 'Цей e-mail є недійсною.'),
(629, '', NULL, 'this_email_is_already_exist.', 'This email is Already exist.', 'Это письмо уже существует.', 'Цей лист уже існує.'),
(630, '', NULL, 'profile_general_data_saved_successfully.', 'Profile general data saved successfully.', 'Общие данные профиля успешно сохранены.', 'Загальні дані профілю успішно збережено.'),
(631, '', NULL, 'error_while_saving_general_profile_settings.', 'Error while saving general profile settings.', 'Ошибка при сохранении общих настроек профиля.', 'Помилка під час збереження загальних налаштувань профілю.'),
(632, '', NULL, 'profile_data_saved_successfully.', 'Profile data saved successfully.', 'Данные профиля успешно сохранены.', 'Дані профілю успішно збережено.'),
(633, '', NULL, 'error_while_saving_profile_settings.', 'Error while saving profile settings.', 'Ошибка при сохранении настроек профиля.', 'Помилка під час збереження налаштувань профілю.'),
(634, '', NULL, 'profile_privacy_data_saved_successfully.', 'Profile privacy data saved successfully.', 'Данные о конфиденциальности профиля успешно сохранены.', 'Дані про конфіденційність профілю успішно збережено.'),
(635, '', NULL, 'passwords_don_t_match.', 'Passwords Don&#039;t Match.', 'Пароли не совпадают.', 'Паролі не збігаються.'),
(636, '', NULL, 'missing_new_password.', 'Missing New password.', 'Отсутствует новый пароль.', 'Відсутній новий пароль.'),
(637, '', NULL, 'password_is_too_short.', 'Password is too short.', 'Пароль слишком короткий.', 'Пароль занадто короткий.'),
(638, '', NULL, 'current_password_missing_.', 'Current password missing .', 'Текущий пароль отсутствует.', 'Поточний пароль відсутній.'),
(639, '', NULL, 'current_password_is_wrong__please_check_again.', 'Current password is wrong, please check again.', 'Неверный текущий пароль, пожалуйста, проверьте еще раз.', 'Неправильний поточний пароль, будь ласка, перевірте ще раз.'),
(640, '', NULL, 'password_updated_successfully.', 'Password updated successfully.', 'Пароль успешно обновлен.', 'Пароль успішно оновлено.'),
(641, '', NULL, 'error_while_update_your_password__please_check_again.', 'Error while update your password, please check again.', 'Ошибка при обновлении пароля, пожалуйста, проверьте еще раз.', 'Помилка під час оновлення пароля, будь ласка, перевірте ще раз.'),
(642, '', NULL, 'please_enter_just_facebook_profile_user.', 'Please enter just facebook profile user.', 'Пожалуйста, введите только профиль пользователя Facebook.', 'Будь ласка, введіть тільки профіль користувача Facebook.'),
(643, '', NULL, 'please_enter_just_twitter_profile_user.', 'Please enter just twitter profile user.', 'Пожалуйста, введите просто профиль пользователя Twitter.', 'Будь ласка, введіть просто профіль користувача Twitter.'),
(644, '', NULL, 'please_enter_just_google_profile_user.', 'Please enter just google profile user.', 'Пожалуйста, введите только профиль пользователя Google.', 'Будь ласка, введіть тільки профіль користувача Google.'),
(645, '', NULL, 'please_enter_just_instagrem_profile_user.', 'Please enter just instagrem profile user.', 'Пожалуйста, введите просто профиль пользователя instagrem.', 'Будь ласка, введіть просто профіль користувача instagrem.'),
(646, '', NULL, 'please_enter_just_linkedin_profile_user.', 'Please enter just linkedin profile user.', 'Пожалуйста, введите только профиль пользователя.', 'Будь ласка, введіть тільки профіль користувача.'),
(647, '', NULL, 'please_enter_valid_domain_name.', 'Please enter valid domain name.', 'Пожалуйста, введите действительное доменное имя.', 'Будь ласка, введіть дійсне доменне ім&#039;я.'),
(648, '', NULL, 'social_setting_updated_successfully.', 'Social setting updated successfully.', 'Социальная настройка успешно обновлена.', 'Соціальне налаштування успішно оновлено.'),
(649, '', NULL, 'error_while_saving_social_setting.', 'Error while saving social setting.', 'Ошибка при сохранении социальных настроек.', 'Помилка під час збереження соціальних налаштувань.'),
(650, '', NULL, 'emails_setting_saved_successfully.', 'Emails setting saved successfully.', 'Настройки электронной почты успешно сохранены.', 'Налаштування електронної пошти успішно збережено.'),
(651, '', NULL, 'error_while_saving_email_setting.', 'Error while saving email setting.', 'Ошибка при сохранении настроек электронной почты.', 'Помилка під час збереження налаштувань електронної пошти.'),
(652, '', NULL, 'missing__to__parameter.', 'Missing `to` parameter.', 'Отсутствует параметр `to`.', 'Відсутній параметр `to`.'),
(653, '', NULL, 'missing__gift_id__parameter.', 'Missing `gift_id` parameter.', 'Отсутствует параметр gift_id.', 'Відсутній параметр gift_id.'),
(654, '', NULL, 'gift_send_successfully.', 'Gift send successfully.', 'Подарок успешно отправлен.', 'Подарунок успішно відправлено.'),
(655, '', NULL, 'gift_send_failed.', 'Gift send failed.', 'Не удалось отправить подарок.', 'Не вдалося надіслати подарунок.'),
(656, '', NULL, 'missing__id__parameter.', 'Missing `id` parameter.', 'Отсутствует параметр `id`.', 'Відсутній параметр `id`.');
INSERT INTO `langs` (`id`, `ref`, `options`, `lang_key`, `english`, `russian`, `ukrainian`) VALUES
(657, '', NULL, 'user_buy_more_visits_successfully.', 'User buy more visits successfully.', 'Пользователь покупает больше посещений успешно.', 'Користувач купує більше відвідувань успішно.'),
(658, '', NULL, 'error_while_buy_more_visits.', 'Error while buy more visits.', 'Ошибка при покупке больше посещений.', 'Помилка під час купівлі більше відвідувань.'),
(659, '', NULL, 'user_buy_more_matches_successfully.', 'User buy more matches successfully.', 'Пользователь успешно купил больше матчей.', 'Користувач успішно купив більше матчів.'),
(660, '', NULL, 'error_while_buy_more_matches.', 'Error while buy more matches.', 'Ошибка при покупке большего количества совпадений.', 'Помилка під час купівлі більшої кількості збігів.'),
(661, '', NULL, 'user_buy_more_likes_successfully.', 'User buy more likes successfully.', 'Пользователь успешно купил больше лайков.', 'Користувач успішно купив більше лайків.'),
(662, '', NULL, 'error_while_buy_more_likes.', 'Error while buy more likes.', 'Ошибка пока покупай больше лайков.', 'Помилка поки купуй більше лайків.'),
(663, '', NULL, 'current_password_missing.', 'Current password missing.', 'Текущий пароль отсутствует.', 'Поточний пароль відсутній.'),
(664, '', NULL, 'your_account_deleted_successfully.', 'Your account deleted successfully.', 'Ваш аккаунт успешно удален.', 'Ваш акаунт успішно видалено.'),
(665, '', NULL, 'missing_e-mail', 'Missing E-mail', 'Отсутствует электронная почта', 'Відсутня електронна пошта'),
(666, '', NULL, 'this_e-mail_is_invalid', 'This E-mail is invalid', 'Этот адрес электронной почты недействителен', 'Ця адреса електронної пошти недійсна'),
(667, '', NULL, 'missing_message', 'Missing message', 'Сообщение отсутствует', 'Повідомлення відсутнє'),
(668, '', NULL, 'thank_you_for_contacting_us', 'Thank you for contacting us', 'Благодарим Вас за обращение к нам', 'Дякуємо Вам за звернення до нас'),
(669, '', NULL, 'message_sent_successfully', 'message sent successfully', 'Сообщение успешно отправлено', 'Повідомлення успішно відправлено'),
(670, '', NULL, 'can_not_send_message', 'can not send message', 'не могу отправить сообщение', 'не можу надіслати повідомлення'),
(671, '', NULL, 'no_token', 'No Token', 'Без токена', 'Без токена'),
(672, '', NULL, 'no_description', 'No description', 'Нет описания', 'Немає опису'),
(673, '', NULL, 'no_paytype', 'No payType', 'Нет payType', 'Нет payType'),
(674, '', NULL, 'payment_successfully', 'Payment successfully', 'Оплата успешно', 'Оплата успішно'),
(675, '', NULL, 'missing_username.', 'Missing username.', 'Отсутствует имя пользователя.', 'Відсутнє ім&#039;я користувача.'),
(676, '', NULL, 'missing_password.', 'Missing password.', 'Отсутствует пароль.', 'Відсутній пароль.'),
(677, '', NULL, 'this_e-mail_is_already_exist.', 'This E-mail is Already exist.', 'Этот E-mail уже существует.', 'Цей E-mail уже існує.'),
(678, '', NULL, 'username_must_be_between_5_32.', 'Username must be between 5/32.', 'Имя пользователя должно быть между 5/32.', 'Ім&#039;я користувача має бути між 5/32.'),
(679, '', NULL, 'invalid_username_characters.', 'Invalid username characters.', 'Неверные символы имени пользователя.', 'Неправильні символи імені користувача.'),
(680, '', NULL, 'registration_successfully', 'Registration successfully', 'Регистрация успешно', 'Реєстрація успішно'),
(681, '', NULL, 'incorrect_username_or_password.', 'Incorrect username or password.', 'Неверное имя пользователя или пароль.', 'Неправильне ім&#039;я користувача або пароль.'),
(682, '', NULL, 'resource_endpoint_class_file_not_found.', 'Resource endpoint class file not found.', 'Файл класса конечной точки ресурса не найден.', 'Файл класу кінцевої точки ресурсу не знайдено.'),
(683, '', NULL, 'login_successfully', 'Login successfully', 'Войти успешно', 'Увійти успішно'),
(684, '', NULL, 'an_error_occurred_while_processing_the_form.', 'An error occurred while processing the form.', 'Произошла ошибка при обработке формы.', 'Сталася помилка під час обробки форми.'),
(685, '', NULL, 'missing_e-mail.', 'Missing E-mail.', 'Отсутствует электронная почта.', 'Відсутня електронна пошта.'),
(686, '', NULL, 'this_e-mail', 'This E-mail', 'Это письмо', 'Цей лист'),
(687, '', NULL, 'is_not_registered.', 'is not registered.', 'не зарегистрировано', 'не зареєстровано'),
(688, '', NULL, 'password_reset.', 'password reset.', 'восстановление пароля.', 'відновлення пароля.'),
(689, '', NULL, 'reset_password_email_sent_successfully.', 'Reset password email sent successfully.', 'Сброс пароля электронная почта успешно отправлена.', 'Скидання пароля електронну пошту успішно надіслано.'),
(690, '', NULL, 'server_can_t_send_email_to', 'Server can&#039;t send email to', 'Сервер не может отправить письмо на', 'Сервер не може надіслати лист на'),
(691, '', NULL, 'right_now__please_try_again_later.', 'right now, please try again later.', 'сейчас, пожалуйста, попробуйте позже.', 'зараз, будь ласка, спробуйте пізніше.'),
(692, '', NULL, 'missing_email_code.', 'Missing email code.', 'Отсутствует код электронной почты.', 'Відсутній код електронної пошти.'),
(693, '', NULL, 'email_verified_successfully', 'Email verified successfully', 'Электронная почта подтверждена успешно', 'Електронна пошта підтверджена успішно'),
(694, '', NULL, 'wrong_email_verification_code.', 'Wrong email verification code.', 'Неправильный код подтверждения адреса электронной почты.', 'Неправильний код підтвердження адреси електронної пошти.'),
(695, '', NULL, 'no_user_found_with_this_email_or_code.', 'No user found with this email or code.', 'Пользователь с этим адресом электронной почты или кодом не найден.', 'Користувача з цією адресою електронної пошти або кодом не знайдено.'),
(696, '', NULL, 'you_are_not_allowed_to_open_this_page_directly.', 'You are not allowed to open this page directly.', 'Вы не можете открыть эту страницу напрямую.', 'Ви не можете відкрити цю сторінку безпосередньо.'),
(697, '', NULL, 'this_email_code_is_invalid.', 'This Email code is invalid.', 'Этот код электронной почты недействителен.', 'Цей код електронної пошти недійсний.'),
(698, '', NULL, 'empty_password.', 'Empty password.', 'Пустой пароль', 'Порожній пароль'),
(699, '', NULL, 'password_reset_successfully', 'Password reset successfully', 'Пароль успешно сброшен', 'Пароль успішно скинуто'),
(700, '', NULL, 'error_while_login_with_new_password.', 'Error While login with new password.', 'Ошибка при входе с новым паролем.', 'Помилка під час входу з новим паролем.'),
(701, '', NULL, 'error_while_save_new_password.', 'Error While save new password.', 'Ошибка при сохранении нового пароля.', 'Ошибка при сохранении нового пароля.'),
(702, '', NULL, 'missing_phone_number.', 'Missing phone number.', 'Отсутствует номер телефона.', 'Відсутній номер телефону.'),
(703, '', NULL, 'please_provide_international_number_with_your_area_code_starting_with__.', 'Please provide international number with your area code starting with +.', 'Пожалуйста, укажите международный номер с кодом города, начиная с +.', 'Будь ласка, вкажіть міжнародний номер із кодом міста, починаючи з +.'),
(704, '', NULL, 'please_enter_valid_number.', 'Please enter valid number.', 'Пожалуйста, введите правильный номер.', 'Будь ласка, введіть правильний номер.'),
(705, '', NULL, 'invalid_phone_number_characters.', 'Invalid phone number characters.', 'Неверный номер телефона символов.', 'Невірний номер телефону символів.'),
(706, '', NULL, 'this_mobile_number_is_already_exist.', 'This Mobile number is Already exist.', 'Этот номер мобильного телефона уже существует.', 'Цей номер мобільного телефону вже існує.'),
(707, '', NULL, 'mobile_activation_code.', 'Mobile Activation code.', 'Мобильный код активации.', 'Мобільний код активації.'),
(708, '', NULL, 'verification_sms_sent_successfully.', 'Verification sms sent successfully.', 'Подтверждение смс отправлено успешно.', 'Підтвердження смс відправлено успішно.'),
(709, '', NULL, 'can_t_send_verification_sms__please_try_again_later.', 'Can&#039;t send verification sms, please try again later.', 'Не удалось отправить смс, пожалуйста, попробуйте позже.', 'Не вдалося надіслати смс, будь ласка, спробуйте пізніше.'),
(710, '', NULL, 'missing_email.', 'Missing email.', 'Отсутствует электронная почта.', 'Відсутня електронна пошта.'),
(711, '', NULL, 'thank_you_for_your_registration.', 'Thank you for your registration.', 'Спасибо за вашу регистрацию.', 'Дякую за вашу реєстрацію.'),
(712, '', NULL, 'can_t_send_verification_email__please_try_again_later.', 'Can&#039;t send verification email, please try again later.', 'Не удалось отправить письмо с подтверждением, повторите попытку позже.', 'Не вдалося надіслати лист із підтвердженням, повторіть спробу пізніше.'),
(713, '', NULL, 'you_can_not_like_your_self.', 'You can not like your self.', 'Вы не можете любить себя.', 'Ви не можете любити себе.'),
(714, '', NULL, 'you_can_not_perform_this_action.', 'You can not perform this action.', 'Вы не можете выполнить это действие.', 'Ви не можете виконати цю дію.'),
(715, '', NULL, 'error_while_deleting_dislike.', 'Error while deleting dislike.', 'Ошибка при удалении нелюбовь.', 'Помилка під час видалення нелюбов.'),
(716, '', NULL, 'user_has_been_blocked_successfully.', 'User has been blocked successfully.', 'Пользователь был успешно заблокирован.', 'Користувача було успішно заблоковано.'),
(717, '', NULL, 'error_while_save_block.', 'Error while save block.', 'Ошибка при сохранении блока.', 'Помилка під час збереження блоку.'),
(718, '', NULL, 'user_has_been_unblocked_successfully.', 'User has been unblocked successfully.', 'Пользователь успешно разблокирован.', 'Користувача успішно розблоковано.'),
(719, '', NULL, 'error_while_delete_user_block.', 'Error while delete user block.', 'Ошибка при удалении пользовательского блока.', 'Помилка під час видалення користувацького блоку.'),
(720, '', NULL, 'error_while_save_report.', 'Error while save report.', 'Ошибка при сохранении отчета.', 'Помилка під час збереження звіту.'),
(721, '', NULL, 'user_has_been_unreported_successfully.', 'User has been unreported successfully.', 'Пользователь не был успешно зарегистрирован.', 'Пользователь не был успешно зарегистрирован.'),
(722, '', NULL, 'error_while_delete_user_report.', 'Error while delete user report.', 'Ошибка при удалении пользовательского отчета.', 'Помилка під час видалення користувацького звіту.'),
(723, '', NULL, 'email_verification.', 'Email Verification.', 'Подтверждение адреса электронной почты.', 'Підтвердження адреси електронної пошти.'),
(724, '', NULL, 'verification_email_sent_successfully.', 'Verification email sent successfully.', 'Письмо с подтверждением успешно отправлено.', 'Лист із підтвердженням успішно надіслано.'),
(725, '', NULL, 'error_while_update_email_activation.', 'Error while update email activation.', 'Ошибка при обновлении электронной почты активации.', 'Помилка під час оновлення електронної пошти активації.'),
(726, '', NULL, 'missing_sms_code.', 'Missing sms code.', 'Отсутствует смс код.', 'Отсутствует смс код.'),
(727, '', NULL, 'phone_verified_successfully', 'Phone verified successfully', 'Телефон успешно подтвержден', 'Телефон успішно підтверджено'),
(728, '', NULL, 'error_while_update_phone_activation.', 'Error while update phone activation.', 'Ошибка при обновлении телефона при активации.', 'Помилка під час оновлення телефону під час активації.'),
(729, '', NULL, 'wrong_phone_verification_code.', 'Wrong phone verification code.', 'Неправильный код подтверждения телефона.', 'Неправильный код подтверждения телефона.'),
(730, '', NULL, 'no_user_found_with_this_phone_number_or_code.', 'No user found with this phone number or code.', 'Пользователь с таким номером телефона или кодом не найден.', 'Пользователь с таким номером телефона или кодом не найден.'),
(731, '', NULL, 'user_boosted_successfully.', 'User boosted successfully.', 'Пользователь успешно увеличен.', 'Користувача успішно збільшено.'),
(732, '', NULL, 'error_while_boost_user.', 'Error while boost user.', 'Ошибка при повышении пользователя.', 'Помилка під час підвищення користувача.'),
(733, '', NULL, 'user_unmatched_successfully.', 'User unmatched successfully.', 'Пользователь не имеет аналогов.', 'Користувач не має аналогів.'),
(734, '', NULL, 'method_not_allowed', 'Method Not Allowed', 'Метод не разрешен', 'Метод не дозволений'),
(735, '', NULL, 'this_call_from_test_function', 'this call from test function', 'этот вызов из тестовой функции', 'цей виклик із тестової функції'),
(736, '', NULL, 'credit', 'Credit', 'Кредит', 'Кредит'),
(737, '', NULL, 'forgot_password', 'Forgot password', 'Забыли пароль', 'Забули пароль'),
(738, '', NULL, 'home', 'Home', 'Главная', 'Головна'),
(739, '', NULL, 'interest', 'Interest', 'Интерес', 'Інтерес'),
(740, '', NULL, 'people_liked_me', 'People liked me', 'Люди мне понравились', 'Люди мені сподобалися'),
(741, '', NULL, 'email_code_verification', 'Email code verification', 'Проверка кода электронной почты', 'Перевірка коду електронної пошти'),
(742, '', NULL, 'premium_membership', 'Premium Membership', 'Премиум-участник', 'Преміум-учасник'),
(743, '', NULL, 'premium_membership_success', 'Premium Membership Success', 'Успех премиум-участников', 'Успіх преміум-учасників'),
(744, '', NULL, 'reset_password', 'Reset Password', 'Сброс пароля', 'Скидання пароля'),
(745, '', NULL, 'general_settings', 'General Settings', 'Общие настройки', 'Загальні налаштування'),
(746, '', NULL, 'profile_settings_blocked', 'Profile Settings Blocked', 'Настройки профиля заблокированы', 'Налаштування профілю заблоковані'),
(747, '', NULL, 'delete_profile', 'Delete Profile', 'Удалить профиль', 'Видалити профіль'),
(748, '', NULL, 'profile_email_settings', 'Profile Email Settings', 'Настройки Email профиля', 'Налаштування Email профілю'),
(749, '', NULL, 'account_password_settings', 'Account Password Settings', 'Настройки пароля учетной записи', 'Налаштування пароля облікового запису'),
(750, '', NULL, 'privacy_setting', 'Privacy Setting', 'Настройки конфиденциальности', 'Налаштування конфіденційності'),
(751, '', NULL, 'profile_setting', 'Profile Setting', 'Настройка профиля', 'Налаштування профілю'),
(752, '', NULL, 'social_setting', 'Social Setting', 'Социальная настройка', 'Соціальне налаштування'),
(753, '', NULL, 'profile_steps', 'Profile steps', 'Шаги профиля', 'Кроки профілю'),
(754, '', NULL, 'verify_your_account', 'Verify your account', 'Подтвердите ваш аккаунт', 'Підтвердіть ваш акаунт'),
(755, '', NULL, 'verify_e-mail_address', 'Verify E-Mail address', 'Подтвердите адрес электронной почты', 'Підтвердіть адресу електронної пошти'),
(756, '', NULL, 'verify_phone', 'Verify Phone', 'Проверить телефон', 'Перевірити телефон'),
(757, '', NULL, 'sms_code_verification', 'SMS code verification', 'Проверка кода СМС', 'Перевірка коду СМС'),
(758, '', NULL, 'id_cannot_be_empty__or_character._only_numbers_allowed__or_you_have_call_undefined_method', 'ID cannot be empty, or character. only numbers allowed, or you have call undefined method', 'ID не может быть пустым или символьным. Допускаются только цифры или вы вызвали неопределенный метод', 'ID не може бути порожнім або символьним. Допускаються тільки цифри, або ви викликали невизначений метод'),
(759, '', NULL, 'bad_request__invalid_or_missing_parameter', 'Bad Request, Invalid or missing parameter', 'Неверный запрос, неверный или отсутствующий параметр', 'Неправильний запит, неправильний або відсутній параметр'),
(760, '', NULL, 'user_in_black_list', 'User in black list', 'Пользователь в черном списке', 'Користувач у чорному списку'),
(761, '', NULL, 'message_sent_successfully.', 'Message sent successfully.', 'Сообщение успешно отправлено.', 'Повідомлення успішно відправлено.'),
(762, '', NULL, 'operation_successfully.', 'Operation successfully.', 'Операция прошла успешно.', 'Операція пройшла успішно.'),
(763, '', NULL, 'options_loaded_successfully.', 'Options loaded successfully.', 'Параметры успешно загружены.', 'Параметри успішно завантажено.'),
(764, '', NULL, 'user_name_cannot_be_empty', 'User name cannot be empty', 'Имя пользователя не может быть пустым', 'Ім&#039;я користувача не може бути порожнім'),
(765, '', NULL, 'password_cannot_be_empty', 'Password cannot be empty', 'Пароль не может быть пустым', 'Пароль не може бути порожнім'),
(766, '', NULL, 'login_successfully__please_wait..', 'Login successfully, Please wait..', 'Успешный вход, пожалуйста, подождите...', 'Успішний вхід, будь ласка, зачекайте...'),
(767, '', NULL, 'could_not_save_session', 'Could not save session', 'Не удалось сохранить сеанс', 'Не вдалося зберегти сеанс'),
(768, '', NULL, 'user_not_exist', 'User Not Exist', 'Пользователь не существует', 'Користувач не існує'),
(769, '', NULL, 'wrong_password', 'Wrong password', 'Неправильный пароль', 'Невірний пароль'),
(770, '', NULL, 'user_data_unset', 'User data unset', 'Пользовательские данные сброшены', 'Пользовательские данные сброшены'),
(771, '', NULL, 'username_must_be_between_5_32', 'Username must be between 5/32', 'Имя пользователя должно быть между 5/32', 'Ім&#039;я користувача має бути між 5/32'),
(772, '', NULL, 'invalid_username_characters', 'Invalid username characters', 'Неверные символы имени пользователя', 'Неправильні символи імені користувача'),
(773, '', NULL, 'user_name_exists', 'User Name Exists', 'Имя пользователя существует', 'Ім&#039;я користувача існує'),
(774, '', NULL, 'email_cannot_be_empty', 'Email cannot be empty', 'Email не может быть пустым', 'Email не може бути порожнім'),
(775, '', NULL, 'email_already_exists', 'Email Already Exists', 'Адрес электронной почты уже существует', 'Адрес электронной почты уже существует'),
(776, '', NULL, 'registration_failed', 'Registration Failed', 'Регистрация не удалась', 'Реєстрація не вдалася'),
(777, '', NULL, 'successfully_joined.', 'Successfully joined.', 'Успешно присоединился.', 'Успішно приєднався.'),
(778, '', NULL, 'could_not_send_verification_email', 'Could not send verification email', 'Не удалось отправить подтверждение по электронной почте', 'Не вдалося надіслати підтвердження електронною поштою'),
(779, '', NULL, 'successfully_joined__please_wait..', 'Successfully joined, Please wait..', 'Успешно присоединился, пожалуйста, подождите ..', 'Успішно приєднався, будь ласка, зачекайте ...'),
(780, '', NULL, 'error__an_unknown_error_occurred._please_try_again_later', 'Error: an unknown error occurred. Please try again later', 'Ошибка: произошла неизвестная ошибка. Пожалуйста, попробуйте позже', 'Помилка: сталася невідома помилка. Будь ласка, спробуйте пізніше'),
(781, '', NULL, 'registration_success', 'Registration Success', 'Вы успешно зарегистрировались', 'Ви успішно зареєструвалися'),
(782, '', NULL, 'error_400_-_session_does_not_exist', 'Error 400 - Session does not exist', 'Ошибка 400 - сеанс не существует', 'Помилка 400 - сеанс не існує'),
(783, '', NULL, 'successfully_logged_out', 'Successfully logged out', 'Успешно вышел', 'Успішно вийшов'),
(784, '', NULL, 'no_user_email__sent', 'No user email  sent', 'Не отправлено ни одного письма от пользователя', 'Не надіслано жодного листа від користувача'),
(785, '', NULL, 'e-mail_is_not_exists', 'E-mail is not exists', 'Электронная почта не существует', 'Електронна пошта не існує'),
(786, '', NULL, 'a_reset_password_link_has_been_sent_to_your_e-mail_address', 'A reset password link has been sent to your e-mail address', 'Ссылка для сброса пароля была отправлена ​​на ваш адрес электронной почты', 'Посилання для скидання пароля було надіслано на вашу адресу електронної пошти'),
(787, '', NULL, 'you_enter_wrong_password', 'You enter wrong password', 'Вы ввели неправильный пароль', 'Ви ввели неправильний пароль'),
(788, '', NULL, 'profile_fetch_successfully', 'Profile fetch successfully', 'Получение профиля успешно', 'Отримання профілю успішно'),
(789, '', NULL, 'empty_username', 'Empty username', 'Пустое имя пользователя', 'Порожнє ім&#039;я користувача'),
(790, '', NULL, 'empty_password', 'Empty password', 'Пустой пароль', 'Порожній пароль'),
(791, '', NULL, 'id_cannot_be_empty__or_character._only_numbers_allowed', 'ID cannot be empty, or character. only numbers allowed', 'ID не может быть пустым или символьным. Допускаются только цифры', 'ID не може бути порожнім або символьним. Допускаються тільки цифри'),
(792, '', NULL, 'session_add_failed', 'Session add failed', 'Не удалось добавить сеанс', 'Не вдалося додати сеанс'),
(793, '', NULL, 'username_cannot_be_empty', 'Username cannot be empty', 'Имя пользователя не может быть пустым', 'Ім&#039;я користувача не може бути порожнім'),
(794, '', NULL, 'token_cannot_be_empty', 'Token cannot be empty', 'Токен не может быть пустым', 'Токен не может быть пустым'),
(795, '', NULL, 'could_not_ave_session', 'Could not ave session', 'Не удалось проложить сеанс', 'Не вдалося прокласти сеанс'),
(796, '', NULL, 'user_not_found', 'User not found', 'Пользователь не найден', 'Користувач не знайдений'),
(797, '', NULL, 'id_cannot_be_empty__or_character._only_numbers_allowed.', 'ID cannot be empty, or character. only numbers allowed.', 'ID не может быть пустым или символьным. Допускаются только цифры', 'ID не може бути порожнім або символьним. Допускаються тільки цифри.'),
(798, '', NULL, 'error_while_deleting__blocks__data.', 'Error while deleting &quot;Blocks&quot; data.', 'Ошибка удаления данных «Блоки».', 'Помилка при видаленні даних «Блоки».'),
(799, '', NULL, 'error_while_deleting__conversations__data.', 'Error while deleting &quot;Conversations&quot; data.', 'Ошибка удаления данных «Беседы».', 'Помилка при видаленні даних «Бесіди».'),
(800, '', NULL, 'error_while_deleting__likes__data.', 'Error while deleting &quot;Likes&quot; data.', 'Ошибка при удалении данных «Избранное».', 'Помилка при видаленні даних «Вподобання».'),
(801, '', NULL, 'error_while_deleting__media_files__data.', 'Error while deleting &quot;Media files&quot; data.', 'Ошибка при удалении данных &quot;Медиафайлы&quot;.', 'Помилка при видаленні даних «Медіафайли».'),
(802, '', NULL, 'error_while_deleting__messages__data.', 'Error while deleting &quot;Messages&quot; data.', 'Ошибка при удалении данных &quot;Сообщения&quot;.', 'Помилка при видаленні даних «Повідомлення».'),
(803, '', NULL, 'error_while_deleting__notifications__data.', 'Error while deleting &quot;Notifications&quot; data.', 'Ошибка при удалении данных Уведомления.', 'Помилка при видаленні даних «Сповіщення».'),
(804, '', NULL, 'error_while_deleting__reports__data.', 'Error while deleting &quot;Reports&quot; data.', 'Ошибка удаления данных &quot;Отчеты&quot;.', 'Помилка при видаленні даних «Звіти».'),
(805, '', NULL, 'error_while_deleting__gifts__data.', 'Error while deleting &quot;Gifts&quot; data.', 'Ошибка удаления данных «Подарки».', 'Помилка при видаленні даних «Подарунки».'),
(806, '', NULL, 'error_while_deleting__visits__data.', 'Error while deleting &quot;Visits&quot; data.', 'Ошибка при удалении данных посещения.', 'Помилка при видаленні даних «Відвідування».'),
(807, '', NULL, 'error_while_deleting__user__data.', 'Error while deleting &quot;User&quot; data.', 'Ошибка при удалении данных «Пользователь»..', 'Помилка при видаленні даних «Користувач».'),
(808, '', NULL, 'error_while_deleting__sessions__data.', 'Error while deleting &quot;Sessions&quot; data.', 'Ошибка при удалении данных сессии.', 'Помилка при видаленні даних «Сесії».'),
(809, '', NULL, 'error_while_deleting__payments__data.', 'Error while deleting &quot;Payments&quot; data.', 'Ошибка при удалении данных «Платежи».', 'Помилка при видаленні даних «Платежі».'),
(810, '', NULL, 'like_delete_successfully.', 'Like delete successfully.', 'Нравится удалить успешно.', 'Подобається видалити успішно.'),
(811, '', NULL, 'dislike_delete_successfully.', 'Dislike delete successfully.', 'Не нравится удалить успешно.', 'Не подобається видаляти успішно.'),
(812, '', NULL, 'user_unblocked_successfully.', 'User unblocked successfully.', 'Пользователь успешно разблокирован.', 'Користувача успішно розблоковано.'),
(813, '', NULL, 'user_blocked_successfully.', 'User blocked successfully.', 'Пользователь успешно заблокирован.', 'Користувача успішно заблоковано.'),
(814, '', NULL, 'user_unreported_successfully.', 'User unreported successfully.', 'Пользователь не зарегистрирован успешно.', 'Користувач не зареєстрований успішно.'),
(815, '', NULL, 'user_reported_successfully.', 'User reported successfully.', 'Пользователь сообщил об успешном.', 'Користувач повідомив про успіх.'),
(816, '', NULL, 'user_visited_successfully.', 'User visited successfully.', 'Пользователь успешно посетил', 'Користувач успішно відвідав'),
(817, '', NULL, 'could_not_save_user_visit', 'Could not save user visit', 'Не удалось сохранить визит пользователя', 'Не вдалося зберегти візит користувача'),
(818, '', NULL, 'gift_sent_successfully.', 'Gift sent successfully.', 'Подарок успешно отправлен.', 'Подарунок успішно відправлено.'),
(819, '', NULL, 'could_not_save_user_gift', 'Could not save user gift', 'Не удалось сохранить подарок пользователя', 'Не вдалося зберегти подарунок користувача'),
(820, '', NULL, 'search_fetch_successfully', 'Search fetch successfully', 'Поиск успешно', 'Пошук успішно'),
(821, '', NULL, 'profile_updated_successfully.', 'Profile updated successfully.', 'Профиль успешно обновлен.', 'Профіль успішно оновлено.'),
(822, '', NULL, 'can_not_update_profile.', 'Can not update profile.', 'Не могу обновить профиль.', 'Не можу оновити профіль.'),
(823, '', NULL, 'profile_avatar_updated_successfully.', 'Profile avatar updated successfully.', 'Профиль аватара успешно обновлен.', 'Профіль аватара успішно оновлено.'),
(824, '', NULL, 'can_not_upload_avatar_file.', 'Can not upload avatar file.', 'Не удается загрузить файл аватара.', 'Не удается загрузить файл аватара.'),
(825, '', NULL, 'google_key__post__is_missing', 'google_key (POST) is missing', 'google_key (POST) отсутствует', 'google_key (POST) отсутствует'),
(826, '', NULL, 'login_success', 'Login Success', 'Успешный вход в систему', 'Успішний вхід в систему'),
(827, '', NULL, 'empty_social_id', 'Empty social id', 'Пустой социальный идентификатор', 'Порожній соціальний ідентифікатор'),
(828, '', NULL, 'payment_processed_successfully', 'Payment processed successfully', 'Платеж успешно обработан', 'Платіж успішно оброблено'),
(829, '', NULL, 'error_while_payment_process', 'Error While Payment process', 'Ошибка при обработке платежа', 'Помилка під час обробки платежу'),
(830, '', NULL, 'visit_you', 'Visit you', 'Посетить вас', 'Завітати до вас'),
(831, '', NULL, 'like_you', 'Like you', 'Как ты', 'Як ти'),
(832, '', NULL, 'dislike_you', 'Dislike you', 'Не нравится тебе', 'Не подобається тобі'),
(833, '', NULL, 'send_gift_to_you', 'Send gift to you', 'Отправить подарок вам', 'Надіслати подарунок вам'),
(834, '', NULL, 'you_got_a_new_match__click_to_view_', 'You got a new match, click to view!', 'Вы получили новый матч, нажмите, чтобы посмотреть!', 'У вас новий матч, натисніть, щоб переглянути!'),
(835, '', NULL, 'choose_your_relationship_status', 'Choose your Relationship status', 'Выберите статус отношений', 'Оберіть статус стосунків'),
(836, '', NULL, 'choose_your_preferred_language', 'Choose your Preferred Language', 'Выберите предпочитаемый язык', 'Виберіть бажану мову'),
(837, '', NULL, 'choose_your_work_status', 'Choose your Work status', 'Выберите свой рабочий статус', 'Выберите свой рабочий статус'),
(838, '', NULL, 'choose_your_hair_color', 'Choose your Hair Color', 'Выберите цвет волос', 'Виберіть колір волосся'),
(839, '', NULL, 'live_with', 'Live with', 'Жить с', 'Жити з'),
(840, '', NULL, 'enter_a_tag__then_hit_enter', 'Enter a tag, then hit enter', 'Введите тег, затем нажмите Enter', 'Введіть тег, потім натисніть Enter'),
(841, '', NULL, '_tag__hit_enter_to_add_more', '+Tag, Hit enter to add more', '+ Tag, нажмите Enter, чтобы добавить больше', '+ Tag, натисніть Enter, щоб додати більше'),
(842, '', NULL, 'i__039_m_studying', 'I&#039;m studying', 'Я учусь', 'Я вчуся'),
(843, '', NULL, 'i__039_m_working', 'I&#039;m working', 'Я работаю', 'Я працюю'),
(844, '', NULL, 'i__039_m_looking_for_work', 'I&#039;m looking for work', 'Я ищу работу', 'Я шукаю роботу'),
(845, '', NULL, 'i__039_m_retired', 'I&#039;m retired', 'Я ушел в отставку', 'Я пішов у відставку'),
(877, '', NULL, 'i_have_kids_and_don__039_t_want_more', 'I have kids and don&#039;t want more', 'У меня есть дети, и я не хочу больше', 'У мене є діти, і я не хочу більше'),
(878, '', NULL, 'personality', 'Personality', 'Личность', 'Особистість'),
(879, '', NULL, 'favourites', 'Favourites', 'Избранные', 'Обрані'),
(880, '', NULL, 'notification_saved_successfully', 'Notification saved successfully', 'Уведомление успешно сохранено', 'Повідомлення успішно збережено'),
(881, '', NULL, 'error_found__please_try_again_later.', 'Error found, please try again later.', 'Ошибка найдена, повторите попытку позже.', 'Помилка знайдена, повторіть спробу пізніше.'),
(882, '', NULL, 'return_back', 'Return back', 'Вернуться назад', 'Повернутися назад'),
(1103, '', NULL, 'choose_your_gender', 'Choose your Gender', 'Выберите свой пол', 'Виберіть свою стать'),
(1111, '', NULL, 'enter_a_location', 'Enter a location', 'Введите местоположение', 'Введіть місцезнаходження'),
(1116, '', NULL, 'by_creating_your_account__you_agree_to_our', 'By creating your account, you agree to our', 'Создавая свой аккаунт, вы соглашаетесь с нашими', 'Створюючи свій акаунт, ви погоджуєтеся з нашими'),
(1117, '', NULL, 'this_phone_number_is_already_exist.', 'This Phone number is Already exist.', 'Этот номер телефона уже существует.', 'Цей номер телефону вже існує.'),
(1120, '', NULL, 'current_password', 'Current Password', 'Текущий пароль', 'Поточний пароль'),
(1153, '', NULL, 'delete_account_', 'Delete account?', 'Удалить аккаунт?', 'Видалити акаунт?'),
(1154, '', NULL, 'are_you_sure_you_want_to_delete_your_account__all_content_including_published_photos_and_other_data_will_be_permanetly_removed_', 'Are you sure you want to delete your account? All content including published photos and other data will be permanetly removed!', 'Вы уверены, что хотите удалить свой аккаунт? Весь контент, включая опубликованные фотографии и другие данные, будет окончательно удален!', 'Ви впевнені, що хочете видалити свій акаунт? Весь контент, включно з опублікованими фотографіями та іншими даними, буде остаточно видалено!'),
(1155, '', NULL, 'delete', 'Delete', 'Удалять', 'Видаляти'),
(1156, '', NULL, 'chat_conversations_fetch_successfully', 'Chat conversations fetch successfully', 'Разговоры в чате успешно загружаются', 'Розмови в чаті успішно завантажуються'),
(1158, '', NULL, 'bank_transfer', 'Bank Transfer', 'Банковский перевод', 'Банківський переказ'),
(1159, '', NULL, 'close', 'Close', 'Закрыть', 'Закрити'),
(1160, '', NULL, 'bank_information', 'Bank Information', 'Банковская информация', 'Банківська інформація'),
(1161, '', NULL, 'please_transfer_the_amount_of', 'Please transfer the amount of', 'Пожалуйста, перечислите сумму', 'Будь ласка, перерахуйте суму'),
(1162, '', NULL, 'to_this_bank_account_to_buy', 'to this bank account to purchase', 'на этот банковский счет для покупки', 'на цей банківський рахунок для купівлі'),
(1163, '', NULL, 'upload_receipt', 'Upload Receipt', 'Загрузить квитанцию', 'Завантажити квитанцію'),
(1164, '', NULL, 'confirm', 'Confirm', 'Подтвердить', 'Підтвердити'),
(1165, '', NULL, 'your_receipt_uploaded_successfully.', 'Your was receipt successfully uploaded.', 'Ваша квитанция была успешно загружена.', 'Вашу квитанцію було успішно завантажено.'),
(1166, '', NULL, 'date', 'Date', 'Дата', 'Дата'),
(1167, '', NULL, 'processed_by', 'Processed By', 'Обработано', 'Оброблено'),
(1168, '', NULL, 'amount', 'Amount', 'Количество', 'Кількість'),
(1169, '', NULL, 'type', 'Type', 'Тип', 'Тип'),
(1170, '', NULL, 'notes', 'Notes', 'Заметки', 'Нотатки'),
(1171, '', NULL, 'plan_premium_membership', 'Plan Premium Membership', 'План Премиум-участник', 'План Преміум-учасник'),
(1172, '', NULL, 'your_boost_will_expire_in', 'Your boost will expire in', 'Ваш буст истекает через', 'Ваш буст закінчується через'),
(1173, '', NULL, 'hide', 'Hide', 'Спрятать', 'Сховати'),
(1174, '', NULL, 'you_reach_the_max_of_swipes_per_day._you_have_to_wait__0__hours_before_you_can_redo_likes_or_upgrade_to_pro_to_for_unlimited.', 'You have reached the maximum amuont of swipes per day, you have to wait {0} hours before you can redo swipes, OR upgrade now to Pro Membership for unlimited swipes and likes.', 'Вы достигли максимального количества свайпов в день, вам придется подождать {0} часов, прежде чем вы сможете повторить свайпы, ИЛИ перейти на Pro Membership, чтобы получить неограниченное количество свайпов и предпочтений.', 'Ви досягли максимальної кількості свайпів на день, вам доведеться почекати {0} годин, перш ніж ви зможете повторити свайпи, АБО перейти на Pro Membership, щоб отримати необмежену кількість свайпів і вподобань.'),
(1175, '', NULL, 'your_payment_was_processed_successfully.', 'Your payment was successfully processed.', 'Ваш платеж успешно обработан.', 'Ваш платіж успішно оброблено.'),
(1176, '', NULL, 'sms', 'SMS', 'СМС', 'СМС'),
(1177, '', NULL, 'sent_you_message_', 'sent you a message!', 'отправил вам сообщение!', 'надіслав вам повідомлення!'),
(1178, '', NULL, 'sent_you_a_message_', 'sent you a message!', 'отправил вам сообщение!', 'надіслав вам повідомлення!'),
(1179, '', NULL, 'accept', 'Accept', 'Принять', 'Прийняти'),
(1180, '', NULL, 'decline', 'Decline', 'Снижение', 'Зниження'),
(1181, '', NULL, 'calling', 'Calling', 'Вызов', 'Виклик'),
(1182, '', NULL, 'please_wait_for_your_friend_answer.', 'Please wait for your friend&#039;s answer.', 'Пожалуйста, подождите ответа вашего друга.', 'Будь ласка, почекайте відповіді вашого друга.'),
(1183, '', NULL, 'no_answer', 'No answer', 'Нет ответа', 'Немає відповіді'),
(1184, '', NULL, 'please_try_again_later.', 'Please try again later.', 'Пожалуйста, попробуйте позже.', 'Будь ласка, спробуйте пізніше.'),
(1185, '', NULL, 'new_video_call', 'New incoming video call', 'Входящий видеозвонок', 'Вхідний відеодзвінок'),
(1186, '', NULL, 'wants_to_video_chat_with_you.', 'wants to video chat with you.', 'хочет с тобой видеочат', 'хоче з тобою відеочат'),
(1187, '', NULL, 'call_declined', 'Call declined', 'Звонок отклонен', 'Дзвінок відхилено'),
(1188, '', NULL, 'the_recipient_has_declined_the_call__please_try_again_later.', 'The recipient has declined the call, please try again later.', 'Абонент отклонил звонок, пожалуйста, попробуйте позвонить по телефону позже.', 'Абонент відхилив дзвінок, будь ласка, спробуйте зателефонувати пізніше.'),
(1189, '', NULL, 'accept___start', 'Accept &amp; Start', 'Принять и начать', 'Прийняти та розпочати'),
(1190, '', NULL, 'answered__', 'Answered!', 'Ответил!', 'Відповів!'),
(1191, '', NULL, 'please_wait..', 'Please wait..', 'Пожалуйста, подождите..', 'Будь ласка, зачекайте..'),
(1192, '', NULL, 'video_call', 'Video Call', 'Видеозвонок', 'Відеодзвінок'),
(1193, '', NULL, 'new_audio_call', 'New incoming audio call', 'Новый входящий аудиозвонок', 'Новий вхідний аудіовиклик'),
(1194, '', NULL, 'wants_to_talk_with_you.', 'wants to talk with you.', 'хочет поговорить с тобой.', 'хоче поговорити з тобою.'),
(1195, '', NULL, 'audio_call', 'Audio call', 'Аудио звонок', 'Аудіо дзвінок'),
(1196, '', NULL, 'talking_with', 'talking with', 'говорить с', 'розмовляти з'),
(1197, '', NULL, 'this_website_uses_cookies_to_ensure_you_get_the_best_experience_on_our_website.', 'This website uses cookies to ensure you get the best experience on our website.', 'Этот веб-сайт использует куки-файлы, чтобы обеспечить вам максимальную отдачу от нашего веб-сайта.', 'Цей сайт використовує файли cookie, щоб забезпечити вам найкращий досвід роботи на нашому сайті.'),
(1198, '', NULL, 'got_it_', 'Got It!', 'Понял!', 'Got It!'),
(1199, '', NULL, 'learn_more', 'Learn More', 'Учить больше', 'Дізнатися більше'),
(1200, '', NULL, 'no_result_found', 'No result found', 'Результатов не найдено', 'Не знайдено жодного результату'),
(1201, '', NULL, 'send_gif', 'Send GIF', 'Отправить GIF', 'Надіслати GIF'),
(1202, '', NULL, 'search_gifs', 'Search GIFs', 'Поиск GIF-файлов', 'Пошук GIF-файлів'),
(1203, '', NULL, 'sticker_added', 'Sticker added', 'Стикер добавлен', 'Стікер додано'),
(1204, '', NULL, 'your_phone_number_is_required.', 'Your phone number is required.', 'Ваш номер телефона требуется.', 'Ваш номер телефону є обов&#039;язковим.'),
(1205, '', NULL, 'select_your_country.', 'Please select your country.', 'Пожалуйста, выберите вашу страну.', 'Будь ласка, виберіть вашу країну.'),
(1206, '', NULL, 'select_your_birth_date.', 'Please select your birthday.', 'Пожалуйста, выберите свой день рождения.', 'Будь ласка, оберіть свій день народження.'),
(1207, '', NULL, 'my_location', 'My Location', 'Мое местонахождение', 'Місцезнаходження'),
(1208, '', NULL, 'or', 'OR', 'ИЛИ ЖЕ', 'АБО'),
(1209, '', NULL, 'instagram', 'Instagram', 'Instagram', 'Instagram'),
(1210, '', NULL, 'disable', 'disable', 'запрещать', 'забороняти'),
(1211, '', NULL, 'enable', 'enable', 'включить', 'включити'),
(1212, '', NULL, 'travel_to_another_country__and_relocate_', 'Travel to another country, and relocate!', 'Отправляйся в другую страну и переезжай!', 'Вирушай в іншу країну і переїжджай!'),
(1213, 'gender', NULL, '4525', 'Male', 'Мужчина', 'Чоловік'),
(1214, 'gender', NULL, '4526', 'Female', 'Женский', 'Жіночий'),
(1215, '', NULL, 'about_you', 'About You', 'О вас', 'Про вас'),
(1216, '', NULL, 'km', 'Comoros', 'Км', 'Км'),
(1217, '', NULL, 'message_requests', 'Message requests', 'Запросы сообщений', 'Запити на повідомлення'),
(1218, '', NULL, 'all_conversations', 'All conversations', 'Все разговоры', 'Всі розмови'),
(1219, '', NULL, 'you_can_chat_with_this_user_after', 'You can chat with this profile after', 'Вы можете общаться с этим профилем после', 'Ви можете спілкуватися з цим профілем після того, як'),
(1220, '', NULL, 'hours.', 'hours.', 'ч.', 'ч.'),
(1221, '', NULL, 'this_user_decline_your_chat_before_so_you_can_chat_with_this_user_after', 'This user has declined your chat before, you&#039;ll be able to chat with this user after', 'Этот пользователь отклонил ваш чат раньше, вы сможете общаться с этим пользователем после того, как', 'Цей користувач відхилив ваш чат раніше, ви зможете поспілкуватися з ним після того, як'),
(1222, '', NULL, 'active', 'active', 'активный', 'активний'),
(1223, '', NULL, 'declined', 'Declined', 'Отклонено', 'Відхилено'),
(1224, '', NULL, 'pending', 'Pending', 'в ожидании', 'На розгляді'),
(1225, '', NULL, 'night_mode', 'Night mode', 'Темный', 'Темний'),
(1226, '', NULL, 'day_mode', 'Day mode', 'Светлый', 'Світлий'),
(1227, '', NULL, 'we___ll_be_back_soon_', 'We’ll be back soon!', 'Мы скоро вернемся!', 'Ми скоро повернемося!'),
(1228, '', NULL, 'sorry_for_the_inconvenience_but_we_rsquo_re_performing_some_maintenance_at_the_moment._if_you_need_help_you_can_always', 'Sorry for the inconvenience but we&#039;re performing some maintenance at the moment. If you need help you can always', 'Приносим извинения за неудобства, но в настоящее время мы проводим техническое обслуживание. Если вам нужна помощь, вы всегда можете', 'Вибачте за незручності, але зараз ми проводимо технічне обслуговування. Якщо вам потрібна допомога, ви завжди можете'),
(1229, '', NULL, 'otherwise_we_rsquo_ll_be_back_online_shortly_', 'otherwise we&#039;ll be back online shortly!', 'в противном случае мы скоро вернемся онлайн!', 'інакше ми незабаром повернемося в онлайн!'),
(1230, '', NULL, 'declined_your_message_request_', 'declined your message request!', 'отклонил ваш запрос на сообщение!', 'відхилив ваш запит на повідомлення!'),
(1231, '', NULL, 'accepted_your_message_request_', 'accepted your message request!', 'принял ваш запрос на сообщение!', 'прийняв ваш запит на повідомлення!'),
(1232, '', NULL, 'we_have_rejected_your_bank_transfer__please_contact_us_for_more_details', 'We have rejected your bank transfer, please contact us for more details.', 'Мы отклонили ваш банковский перевод, пожалуйста, свяжитесь с нами для получения более подробной информации.', 'Ми відхилили ваш банківський переказ, будь ласка, зв&#039;яжіться з нами для отримання додаткової інформації.'),
(1233, '', NULL, 'we_approved_your_bank_transfer_of__d_', 'We approved your bank transfer of %d!', 'Мы подтвердили ваш банковский перевод на сумму %d!', 'Ми підтвердили ваш банківський переказ на суму %d!'),
(1234, '', NULL, 'note', 'Note', 'Заметка', 'Нотатка'),
(1235, '', NULL, 'delete_chat', 'Delete chat', 'Удалить чат', 'Видалити чат'),
(1236, '', NULL, 'your_x3_matches_will_expire_in', 'Your x3 matches will expire in', 'Ваши матчи х3 истекают через', 'Ваші матчі x3 закінчаться через'),
(1237, '', NULL, 'to_get_your_profile_verified_you_have_to_verify_these.', 'To get your profile verified you have to verify these.', 'Чтобы подтвердить свой профиль, вы должны подтвердить это.', 'Щоб ваш профіль був підтверджений, ви повинні підтвердити ці дані.'),
(1238, '', NULL, 'upload_at_least_5_image.', 'Upload at least 5 image.', 'Загрузите как минимум 5 изображений.', 'Завантажте мінімум 5 зображень.'),
(1239, '', NULL, 'unblock', 'Unblock', 'Разблокировать', 'Розблокувати'),
(1240, '', NULL, 'phone_number__e.g__90..', 'Phone number, e.g +90..', 'Номер телефона, например, +38 ..', 'Номер телефону, наприклад +38...'),
(1241, '', NULL, 'phone_verification_needed', 'Phone verification required', 'Требуется подтверждение телефона', 'Потрібне підтвердження телефону'),
(1242, '', NULL, 'phone', 'Phone', 'Телефон', 'Телефон'),
(1243, '', NULL, 'send_otp', 'Send OTP', 'Отправить OTP', 'Надіслати OTP'),
(1244, '', NULL, 'phone_activiation_', 'Phone activiation,', 'Активация телефона,', 'Активація телефону,'),
(1245, '', NULL, 'please_enter_the_verification_code_sent_to_your_phone', 'Please enter the verification code that was sent to your phone.', 'Пожалуйста, введите проверочный код, который был отправлен на ваш телефон.', 'Будь ласка, введіть код підтвердження, який було надіслано на ваш телефон.'),
(1246, '', NULL, 'resend', 'Re-send', 'Отправить', 'Відправити'),
(1247, '', NULL, 'please_verify_your_email_address', 'Please verify your email address.', 'Пожалуйста, подтвердите ваш адрес электронной почты.', 'Будь ласка, підтвердіть вашу адресу електронної пошти.'),
(1248, '', NULL, 'error_while_sending_an_sms__please_try_again_later.', 'Error while sending the SMS, please try again later.', 'Ошибка при отправке SMS, повторите попытку позже.', 'Помилка при відправці SMS, будь ласка, повторіть спробу пізніше.'),
(1249, '', NULL, 'error_while_submitting_form.', 'Error while submitting form.', 'Ошибка при отправке формы.', 'Помилка при відправці форми.'),
(1250, '', NULL, 'email_verification_needed', 'Email verification required', 'Требуется проверка электронной почты', 'Потрібна перевірка електронної пошти'),
(1251, '', NULL, 'email_activiation_', 'Email activiation,', 'Активация электронной почты,', 'Активація електронною поштою,'),
(1252, '', NULL, 'please_enter_the_verification_code_sent_to_your_email', 'Please enter the verification code that was sent to your E-mail.', 'Пожалуйста, введите проверочный код, который был отправлен на ваш E-mail.', 'Будь ласка, введіть код підтвердження, надісланий на вашу електронну пошту.'),
(1253, '', NULL, 'video_and_audio_calls_to_all_users', 'Create unlimited video and audio calls.', 'Создавайте неограниченные видео и аудио звонки.', 'Створюйте необмежену кількість відео-та аудіовикликів.'),
(1254, '', NULL, 'latest_users', 'Latest Users', 'Новые Пользователи', 'Нові Користувачі'),
(1255, '', NULL, 'wanna_get_more__get_new_stickers_for', 'Wanna get more? get new stickers for', 'Хотите получить больше? получить новые наклейки для', 'Хочеш більше? Отримай нові наклейки для'),
(1256, '', NULL, 'this_image_now_is_private.', 'This photo is private.', 'Это частное фото', 'Ця фотографія є приватною.'),
(1257, '', NULL, 'emails', 'Emails', 'Сообщения электронной почты', 'Сообщения электронной почты'),
(1258, '', NULL, 'email_me_when_someone_views_your_profile', 'Email me when someone views my profile.', 'Напишите мне, когда кто-нибудь просмотрит мой профиль.', 'Напишіть мені, коли хтось перегляне мій профіль.'),
(1259, '', NULL, 'email_me_when_you_get_a_new_message', 'Email me when I get a new message.', 'Напишите мне, когда я получу новое сообщение.', 'Напишіть мені, коли я отримаю нове повідомлення.'),
(1260, '', NULL, 'email_me_when_someone_like_your_profile', 'Email me when someone like me.', 'Напишите мне, когда кто-то, как я.', 'Напишіть мені, коли я комусь сподобаюсь.'),
(1261, '', NULL, 'email_me_purchase_notifications', 'Email me my purchase notifications.', 'Отправьте мне по электронной почте мои уведомления о покупке.', 'Сповіщення про покупки надсилайте мені на електронну пошту.'),
(1262, '', NULL, 'email_me_special_offers___promotions', 'Email me special offers &amp; promotions.', 'Отправляйте мне специальные предложения и акции.', 'Надсилайте мені спеціальні пропозиції та акції.'),
(1263, '', NULL, 'email_me_feature_announcements', 'Email me future announcements.', 'Дальнейшие новости присылайте мне на электронную почту.', 'Подальші анонси надсилайте мені на електронну пошту.'),
(1264, '', NULL, 'email_me_when_someone_like_my_profile', 'Email me when someone like my profile.', 'Напишите мне, когда кому-то понравится мой профиль.', 'Напишіть мені, коли комусь сподобається мій профіль.'),
(1265, '', NULL, 'email_me_when_i_get_new_gift', 'Email me when I get a new gift.', 'Напишите мне, когда я получу новый подарок.', 'Напишіть мені, коли я отримаю новий подарунок.'),
(1266, '', NULL, 'email_me_when_i_get_new_match', 'Email me when I get a new match.', 'Напишите мне, когда я получу новое совпадение.', 'Напишіть мені, коли я отримаю новий збіг.'),
(1267, '', NULL, 'email_me_when_i_get_new_chat_request', 'Email me when I get a new chat request.', 'Напишите мне, когда я получу новый запрос чата.', 'Напишіть мені, коли я отримаю новий запит на чат.'),
(1268, '', NULL, 'why__0__is_best', 'Why {0} is Best', 'Почему {0} лучше', 'Чому {0} найкращий'),
(1269, '', NULL, 'your_account_is_safe_on__0_._we_never_share_your_data_with_third_party.', 'Your account is safe on {0}. We never share your data with third party.', 'Ваш аккаунт в безопасности {0}. Мы никогда не передаем ваши данные третьим лицам.', 'Ваш обліковий запис у безпеці на {0}. Ми ніколи не передаємо ваші дані третім особам.'),
(1270, '', NULL, 'connect_with_your_perfect_soulmate_here__on__0_.', 'Connect with your perfect Soulmate here, on {0}.', 'Найдите свою идеальную вторую половинку здесь, на {0}.', 'Знайдіть свою ідеальну другу половинку тут, на {0}.'),
(1271, '', NULL, 'verification', 'Verification', 'Верификация', 'Верифікація'),
(1272, '', NULL, 'you_have_been_exceed_the_activation_request_limit.', 'You have exceeded the activation request limit.', 'Вы превысили лимит запросов на активацию.', 'Ви перевищили ліміт запитів на активацію.'),
(1273, '', NULL, 'you_have_to_wait', 'You have to wait', 'Вам придется подождать', 'Вам доведеться зачекати'),
(1274, '', NULL, 'minutes_before_you_try_to_activate_again.', 'minutes before you try to activate again.', 'минут, прежде чем пытаться активировать снова.', 'за кілька хвилин до того, як ви спробуєте активувати знову.'),
(1275, '', NULL, 'we_have_rejected_your_bank_transfer__please_contact_us_for_more_details.', 'We have rejected your bank transfer, please contact us for more details.', 'Мы отклонили ваш банковский перевод, пожалуйста, свяжитесь с нами для получения более подробной информации.', 'Ми відхилили ваш банківський переказ, будь ласка, зв&#039;яжіться з нами для отримання додаткової інформації.'),
(1276, '', NULL, 'you_transmitting_spam_messages._the_system_automatically_restricts_chat_for_you__so_you_can_chat_again_after', 'You transmitting spam messages. the system automatically restricts chat for you, so you can chat again after', 'Вы отправляете спам-сообщение. система автоматически ограничивает чат для вас, чтобы вы могли снова общаться после того, как', 'Ви надсилаєте спам-повідомлення. система автоматично обмежує чат для вас, щоб ви могли знову спілкуватися після того, як'),
(1277, '', NULL, 'options', 'options', 'опции', 'опції'),
(1278, '', NULL, 'blog', 'Blog', 'Блог', 'Блог'),
(1279, '', NULL, 'success_stories', 'Success stories', 'Истории успеха', 'Історії успіху'),
(1280, '', NULL, 'add_new_story', 'Add your story', 'Добавьте свою историю', 'Додайте свою історію'),
(1281, '', NULL, 'create_story', 'Create story', 'Создать историю', 'Створити історію'),
(1282, '', NULL, 'no_more_stories_to_show.', 'No more stories to show.', 'Нет больше историй, чтобы показать.', 'Більше немає історій для показу.'),
(1283, '', NULL, 'add_new_success_stories', 'Add your successful story', 'Добавьте свою успешную историю', 'Додайте свою успішну історію'),
(1284, '', NULL, 'story__html_allowed_', 'Story (HTML allowed)', 'История (HTML допускается)', 'Історія (дозволений HTML)'),
(1285, '', NULL, 'quote', 'Quote', 'Цитата', 'Цитата'),
(1286, '', NULL, 'story_date', 'When this story happened?', 'Когда случилась эта история?', 'Коли сталася ця історія?'),
(1287, '', NULL, 'please_select_user_first.', 'Please choose with whom you had this story.', 'Пожалуйста, выберите, с кем у вас была эта история.', 'Будь ласка, виберіть, з ким у вас була ця історія.'),
(1288, '', NULL, 'please_select_when_story_started.', 'Please select when the story occurred.', 'Пожалуйста, выберите, когда история произошла.', 'Будь ласка, оберіть, коли сталася ця історія.'),
(1289, '', NULL, 'please_enter_quote.', 'Please enter a quote.', 'Пожалуйста, введите цитату.', 'Будь ласка, введіть цитату.'),
(1290, '', NULL, 'please_enter_your_story.', 'Please enter your story.', 'Пожалуйста, введите вашу историю.', 'Будь ласка, введіть свою історію.'),
(1291, '', NULL, 'story_add_successfully', 'Your story has been added successfully.', 'Ваша история была успешно добавлена.', 'Ваша історія успішно додана.'),
(1292, '', NULL, 'story_add_successfully__please_wait_while_admin_approve_this_story_and_it_will_show_on_site.', 'Your story has been added successfully, please wait while we review your story and approve it.', 'Ваша история была успешно добавлена, пожалуйста, подождите, пока мы рассмотрим вашу историю и одобрим ее.', 'Ваша історія була успішно додана, будь ласка, зачекайте, поки ми перевіримо і затвердимо її.'),
(1293, '', NULL, 'story', 'Story', 'История', 'Історія'),
(1294, '', NULL, '1309', 'Comedy', 'Комедия', 'Comedy');
INSERT INTO `langs` (`id`, `ref`, `options`, `lang_key`, `english`, `russian`, `ukrainian`) VALUES
(1295, '', NULL, '1310', 'Cars and Vehicles', 'Автомобили и транспортные средства', 'Автомобілі та транспортні засоби'),
(1296, '', NULL, '1311', 'Economics and Trade', 'Экономика и торговля', 'Економіка та торгівля'),
(1297, '', NULL, '1312', 'Education', 'Образование', 'Освіта'),
(1298, '', NULL, '1313', 'Entertainment', 'Развлечения', 'Розваги'),
(1299, '', NULL, '1314', 'Movies &amp; Animation', 'Кино &amp;  Анимация', 'Кіно &amp; Анімація'),
(1300, '', NULL, '1315', 'Gaming', 'Игры', 'Ігри'),
(1301, '', NULL, '1316', 'History and Facts', 'История и факты', 'Історія та факти'),
(1302, '', NULL, '1317', 'Live Style', 'Стиль жизни', 'Стиль життя'),
(1303, '', NULL, '1318', 'Natural', 'Натуральный', 'Натуральний'),
(1304, '', NULL, '1319', 'News and Politics', 'Новости и Политика', 'Новини та політика'),
(1305, '', NULL, '1320', 'People and Nations', 'Люди и народы', 'Люди та нації'),
(1306, '', NULL, '1321', 'Pets and Animals', 'Домашние животные и животные', 'Домашні улюбленці і тварини'),
(1307, '', NULL, '1322', 'Places and Regions', 'Места и Регионы', 'Місця і регіони'),
(1308, '', NULL, '1323', 'Science and Technology', 'Наука и технология', 'Наука і технології'),
(1309, '', NULL, '1324', 'Sport', 'Спорт', 'Спорт'),
(1310, '', NULL, '1325', 'Travel and Events', 'Путешествия и События', 'Подорожі та Події'),
(1311, '', NULL, '1326', 'Other', 'Другой', 'Інший'),
(1312, '', NULL, 'read_more', 'Read more', 'Читать дальше', 'Читати далі'),
(1313, '', NULL, 'categories', 'Categories', 'Категории', 'Категорії'),
(1314, '', NULL, 'no_more_articles_to_show.', 'No more articles to show.', 'Нет больше статей, чтобы показать.', 'Більше немає статей для показу.'),
(1315, '', NULL, 'article', 'Article', 'Статья', 'Стаття'),
(1316, '', NULL, 'share_to', 'Share to', 'Поделиться с', 'Поділитися з'),
(1317, '', NULL, 'hot_or_not', 'Hot OR Not', 'Горячий или нет', 'Гаряче АБО Ні'),
(1318, '', NULL, 'image_verification', 'Image Verification', 'Проверка изображения', 'Перевірка зображення'),
(1319, '', NULL, 'verify_your', 'Verify your', 'Проверьте свой', 'Підтвердіть свій'),
(1320, '', NULL, 'account', 'account', 'учетная запись', 'обліковий запис'),
(1321, '', NULL, 'you_will_be_required_to_take_a_selfie_holding_the_id_document_next_to_your_face__so_we_can_compare_your_photo_with_your_actual_look.this_is_just_an_additional_security_measure', 'You will be required to take a selfie holding the ID document next to your face, so we can compare your photo with your actual look. This is just an additional security measure.', 'Вам нужно будет сделать селфи, держа удостоверение личности рядом с вашим лицом, чтобы мы могли сравнить вашу фотографию с вашим реальным видом. Это всего лишь дополнительная мера безопасности.', 'Вам потрібно буде зробити селфі, тримаючи документ, що посвідчує особу, поруч з обличчям, щоб ми могли порівняти вашу фотографію з вашим реальним виглядом. Це просто додатковий захід безпеки.'),
(1322, '', NULL, 'take_snapshot', 'Take Snapshot', 'Сделать снимок', 'Зробити знімок'),
(1323, '', NULL, 'retake_snapshot', 'Retake Snapshot', 'Повторный снимок', 'Повторний знімок'),
(1324, '', NULL, 'back', 'Back', 'Назад', 'Назад'),
(1325, '', NULL, 'keyword', 'Keyword', 'Ключевое слово', 'Ключове слово'),
(1326, '', NULL, 'no_articles_found', 'No articles found', 'Статьи не найдены', 'Статті не знайдено'),
(1327, '', NULL, 'tags', 'Tags', 'Теги', 'Теги'),
(1328, '', NULL, 'free', 'Free', 'Бесплатно', 'Безкоштовно'),
(1329, '', NULL, 'brings_out_the_sense_of_adventure_in_me__the_website_is_so_easy_to_use_and_the_possibility_of_meeting_someone_from_another_culture_that_relates_to_me_is_simply_thrilling.', 'Brings out the sense of adventure in me! The website is so easy to use and the possibility of meeting someone from another culture that relates to me is simply thrilling.', 'Вызывает во мне чувство приключения! Веб-сайт очень прост в использовании, и возможность встретить кого-то другого человека, относящегося ко мне, просто волнует.', 'Викликає в мені почуття пригод! Веб-сайт дуже простий у використанні, а можливість зустріти когось з іншої культури, яка мені близька, просто захоплює.'),
(1330, '', NULL, 'brings_out_the_feelings_of_adventure_in_me__the_website_is_so_easy_to_use_and_the_possibility_of_meeting_someone_from_another_culture_that_relates_to_me_is_simply_thrilling.', 'Brings out the feelings of adventure in me! The website is so easy to use and the possibility of meeting someone from another culture that relates to me is simply thrilling.', 'Вызывает во мне чувство происшествия! Веб-сайт очень прост в использовании, а возможность встретить кого-то из другой культуры, которая мне близка, просто увлекает. Вызывает во мне чувство происшествия! Веб-сайт очень прост в использовании, а возможность встретить кого-то из другой культуры, которая мне близка, просто увлекает.', 'Викликає в мені почуття пригоди! Веб-сайт дуже простий у використанні, а можливість зустріти когось з іншої культури, яка мені близька, просто захоплює. Викликає в мені почуття пригоди! Веб-сайт дуже простий у використанні, а можливість зустріти когось з іншої культури, яка мені близька, просто захоплює.'),
(1331, '', NULL, 'produce_out_the_sense_of_adventure_in_me__the_website_is_so_easy_to_use_and_the_possibility_of_meeting_someone_from_another_culture_that_relates_to_me_is_simply_thrilling.', 'produce out the sense of adventure in me! The website is so easy to use and the possibility of meeting someone from another culture that relates to me is simply thrilling.', 'Вызывает во мне чувство приключений! Веб-сайт очень прост в использовании, а возможность познакомиться с кем-то из другой культуры, которая мне близка, просто увлекает.', 'Викликає в мені почуття пригод! Веб-сайт дуже простий у використанні, а можливість познайомитися з кимось із іншої культури, яка мені близька, просто захоплює.'),
(1332, '', NULL, 'bring_out_the_sense_of_adventure_in_me__the_website_is_so_easy_to_use_and_the_possibility_of_meeting_someone_from_another_culture_that_relates_to_me_is_simply_thrilling.', 'bring out the sense of adventure in me! The website is so easy to use and the possibility of meeting someone from another culture that relates to me is simply thrilling.', 'выявить чувство приключения во мне! Веб-сайт очень прост в использовании, и возможность встретить кого-то другого человека, относящегося ко мне, просто волнует.', 'розбудити в мені почуття пригод! Веб-сайт дуже простий у використанні, а можливість познайомитися з кимось із іншої культури, яка мені близька, просто захоплює.'),
(1333, '', NULL, 'this_profile_is_verified_by_photos', 'This profile is verified by user picture.', 'Этот профиль подтвержден фотографией пользователя.', 'Цей профіль підтверджено фотографією користувача.'),
(1334, '', NULL, 'your_account_wait_admin_photo_verification._please_try_again_later.', 'Your account is under review, Please wait until we review your picture and try again later.', 'Ваша учетная запись находится на рассмотрении. Подождите, пока мы просмотрим Вашу фотографию, и повторите попытку позже.', 'Ваш обліковий запис знаходиться на розгляді, будь ласка, зачекайте, поки ми перевіримо вашу фотографію і спробуйте ще раз пізніше.'),
(1335, '', NULL, 'your_camera_is_off_or_disconnected__please_connect_your_camera_and_try_again.', 'Your camera is off or disconnected, Please connect your camera and try again.', 'Ваша камера выключена или отключена. Пожалуйста, подключите камеру и попробуйте снова.', 'Ваша камера вимкнена або від&#039;єднана, будь ласка, підключіть її і спробуйте ще раз.'),
(1336, '', NULL, 'try_again', 'Try again', 'Попытайтесь еще раз.', 'Спробуйте ще раз.'),
(1337, '', NULL, 'you_have_previous_story_with_this_user', 'You have previous story with this user', 'Вы уже общались с этим пользователем', 'Ви вже спілкувалися з цим користувачем'),
(1338, '', NULL, 'with', 'With', 'С', 'З'),
(1339, '', NULL, 'create_story_with_you', 'created a story with you.', 'создал историю с вами.', 'створили з вами історію.'),
(1340, '', NULL, 'approved_your_story_', 'approved your story!', 'одобрил вашу историю!', 'одобрил вашу историю!'),
(1341, '', NULL, 'has_rejected_your_story.', 'has rejected your story.', 'отклонил вашу историю.', 'відхилив вашу історію.'),
(1342, '', NULL, 'approve_story', 'Approve story', 'Одобрить историю', 'Схвалити історію'),
(1343, '', NULL, 'disapprove_story', 'Disapprove story', 'Отклонить историю', 'Отклонить историю'),
(1344, '', NULL, 'you_have_story_with', 'You have a story with', 'У вас есть история с', 'У вас є історія з'),
(1345, '', NULL, 'on', 'on', 'на', 'на'),
(1346, '', NULL, 'story_approved_successfully.', 'Your story has been approved.', 'Ваша история была одобрена.', 'Вашу історію було схвалено.'),
(1347, '', NULL, 'story_disapproved_successfully.', 'Your story has been declined.', 'Ваша история была отклонена.', 'Вашу історію відхилили.'),
(1348, '', NULL, 'social_accounts', 'Social accounts', 'Социальные аккаунты', 'Соціальні акаунти'),
(1349, '', NULL, 'publish', 'Publish', 'Публиковать', 'Опублікувати'),
(1350, '', NULL, 'thank_you_for_your_story__we_have_sent_the_story_to__0___once_approved_your_story_will_be_published.', 'Thank you for your story, we have sent the story to {0}, once approved your story will be published.', 'Спасибо за вашу историю. Мы отправили историю в {0}, после того как ваша история будет опубликована.', 'Дякуємо за вашу історію, ми надіслали її на адресу {0}, після схвалення ваша історія буде опублікована.'),
(1351, '', NULL, 'no_user_found_with_this_name', 'No user found with this name', 'Пользователь с таким именем не найден', 'Користувачів з таким ім&#039;ям не знайдено'),
(1352, '', NULL, 'vk', 'VK', 'VK', ''),
(1353, '', NULL, 'type_a_message', 'Type a message', 'Введите сообщение', 'Введіть повідомлення'),
(1354, '', NULL, 'boost_for_free', 'Boost For Free', 'Повысьте бесплатно', 'Підвищити безкоштовно'),
(1355, '', NULL, 'boost_your_profile_for_free_for', 'Boost your profile for free for', 'Повысьте свой профиль бесплатно для', 'Підвищіть свій профіль безкоштовно для'),
(1356, '', NULL, 'this_profile_is_verified_by_phone', 'This profile is verified by phone', 'Этот профиль подтвержден по телефону', 'Цей профіль підтверджено за телефоном'),
(1357, '', NULL, 'your_height_is_required.', 'Your height is required.', 'Ваша высота не требуется.', 'Ваша висота не потрібна.'),
(1358, '', NULL, 'name', 'Name', 'Имя', 'Ім&#039;я'),
(1359, '', NULL, 'card_number', 'Card Number', 'Номер карты', 'Номер картки'),
(1360, '', NULL, 'pay', 'Pay', 'Оплатить', 'Заплати'),
(1361, '', NULL, 'please_check_your_details', 'Please check your details', 'Пожалуйста, проверьте свои данные', 'Будь ласка, перевірте свої дані'),
(1362, '', NULL, 'manage_sessions', 'Manage Sessions', 'Управление сессиями', 'Керування сесіями'),
(1363, '', NULL, 'platform', 'Platform', 'Платформа', 'Платформа'),
(1364, '', NULL, 'last_seen', 'Last seen', 'В последний раз видел', 'Останній раз бачили'),
(1365, '', NULL, 'os', 'OS', 'ОС', 'ОС'),
(1366, '', NULL, 'browser', 'Browser', 'Браузер', 'Браузер'),
(1367, '', NULL, 'action', 'Action', 'Действие', 'Дія'),
(1368, '', NULL, 'error_while_deleting_session__please_try_again_later.', 'Error while deleting session, please try again later.', 'Ошибка при удалении сеанса, повторите попытку позже.', 'Помилка при видаленні сесії, будь ласка, спробуйте пізніше.'),
(1369, '', NULL, 'session_deleted_successfully.', 'Session has been deleted successfully.', 'Сессия была успешно удалена.', 'Сесію успішно видалено.'),
(1370, '', NULL, 'two-factor_authentication', 'Two-factor authentication', 'Двухфакторная аутентификация', 'Двофакторна автентифікація'),
(1371, '', NULL, 'turn_on_2-step_login_to_level-up_your_account_s_security__once_turned_on__you_ll_use_both_your_password_and_a_6-digit_security_code_sent_to_your_phone_or_email_to_log_in.', 'Turn on 2-step login to level-up your account&#039;s security, Once turned on, you&#039;ll use both your password and a 6-digit security code sent to your phone or email to log in.', 'Включите 2-этапный вход, чтобы повысить безопасность вашей учетной записи. После этого вы будете использовать пароль и 6-значный код безопасности, отправленный на ваш телефон или электронную почту для входа.', 'Увімкніть 2-етапний вхід, щоб підвищити рівень безпеки вашого облікового запису. Після цього ви будете використовувати пароль і 6-значний код безпеки, надісланий на ваш телефон або електронну пошту для входу.'),
(1372, '', NULL, 'two-factor_authentication_data_saved_successfully.', 'Two-factor authentication data saved successfully.', 'Данные двухфакторной аутентификации успешно сохранены.', 'Дані двофакторної автентифікації успішно збережено.'),
(1373, '', NULL, 'a_confirmation_email_has_been_sent.', 'A confirmation email has been sent.', 'Письмо с подтверждением было отправлено.', 'Підтвердження надіслано на електронну пошту.'),
(1374, '', NULL, 'we_have_sent_an_email_that_contains_the_confirmation_code_to_enable_two-factor_authentication.', 'We have sent an email that contains the confirmation code to enable Two-factor authentication.', 'Мы отправили электронное письмо с кодом подтверждения для включения двухфакторной аутентификации.', 'Ми надіслали електронного листа, який містить код підтвердження для ввімкнення двофакторної автентифікації.'),
(1375, '', NULL, 'confirmation_code', 'Confirmation code', 'Код подтверждения', 'Код підтвердження'),
(1376, '', NULL, 'please_check_your_details.', 'Please check your details.', 'Пожалуйста, проверьте ваши данные.', 'Please check your details.'),
(1377, '', NULL, 'your_e-mail_has_been_successfully_verified.', 'Your e-mail has been successfully verified.', 'Ваш адрес электронной почты был успешно подтвержден.', 'Вашу адресу електронної пошти було успішно підтверджено.'),
(1378, '', NULL, 'phone_number_should_be_as_this_format___90..', 'Phone number should be as this format: +90..', 'Номер телефона должен быть в следующем формате: +38.', 'Номер телефону повинен бути в такому форматі: +38..'),
(1379, '', NULL, 'your_phone_number_and_e-mail_have_been_successfully_verified.', 'Your phone number and e-mail have been successfully verified.', 'Ваш номер телефона и e-mail успешно подтверждены.', 'Ваш номер телефону та e-mail успішно підтверджено.'),
(1380, '', NULL, 'unusual_login', 'Unusual Login', 'Необычный логин', 'Незвичайний логін'),
(1381, '', NULL, 'to_log_in__you_need_to_verify_your_identity.', 'To log in, you need to verify your identity.', 'Для входа необходимо подтвердить свою личность.', 'Щоб увійти в систему, вам потрібно підтвердити свою особу.'),
(1382, '', NULL, 'we_have_sent_you_the_confirmation_code_to_your_phone_and_to_your_email_address.', 'We have sent you the confirmation code to your phone and to your email address.', 'Мы отправили вам код подтверждения на ваш телефон и на ваш адрес электронной почты.', 'Ми надіслали вам код підтвердження на ваш телефон та електронну адресу.'),
(1383, '', NULL, 'we_have_sent_you_the_confirmation_code_to_your_email_address.', 'We have sent you the confirmation code to your email address.', 'Мы отправили вам код подтверждения на ваш адрес электронной почты.', 'Ми надіслали вам код підтвердження на вашу електронну адресу.'),
(1384, '', NULL, 'please_enter_confirmation_code.', 'Please enter confirmation code.', 'Пожалуйста, введите код подтверждения.', 'Будь ласка, введіть код підтвердження.'),
(1385, '', NULL, 'something_went_wrong__please_try_again_later.', 'Something went wrong, please try again later.', 'Что-то пошло не так. Пожалуйста, повторите попытку позже.', 'Щось пішло не так, будь ласка, спробуйте пізніше.'),
(1386, '', NULL, 'wrong_confirmation_code.', 'Wrong confirmation code.', 'Неверный код подтверждения.', 'Неверный код подтверждения.'),
(1387, '', NULL, 'error_while_login__please_try_again_later.', 'Error while login, please try again later.', 'Ошибка при входе, повторите попытку позже.', 'Помилка під час входу, будь ласка, спробуйте пізніше.'),
(1388, '', NULL, 'invalid_user_id', 'Invalid User ID', 'Неверный идентификатор пользователя', 'Невірний ідентифікатор користувача'),
(1389, '', NULL, 'invalid_confirmation_code', 'Invalid confirmation code', 'неверный код подтверждения', 'Невірний код підтвердження'),
(1390, '', NULL, 'find_potential_matches_by_country', 'Find potential matches by country', 'Найти потенциальные совпадения по стране', 'Знайдіть потенційні збіги за країною'),
(1391, '', NULL, 'manage_notifications', 'Manage Notifications', 'Управление уведомлениями', 'Керування сповіщеннями'),
(1392, '', NULL, 'custom_field', 'Custom field', 'Пользовательское поле', 'Користувацьке поле'),
(1393, '', NULL, 'food', 'food', 'питание', 'питание'),
(1394, '', NULL, 'add_media', 'Add Media', 'Добавить медиа', 'Додати медіа'),
(1395, '', NULL, 'add_video', 'Add Video', 'Добавить видео', 'Додати відео'),
(1396, '', NULL, 'add_photo', 'Add Photo', 'Добавить фото', 'Додати фото'),
(1397, '', NULL, 'upload', 'Upload', 'Загрузить', 'Завантажити'),
(1398, '', NULL, 'video_title', 'Video Title', 'Название видео', 'Название видео'),
(1399, '', NULL, 'public', 'Public', 'Общественного', 'Общественного'),
(1400, '', NULL, 'private', 'Private', 'Частный', 'Приватний'),
(1401, '', NULL, 'thumbnail', 'Thumbnail', 'Эскиз', 'Ескіз'),
(1402, '', NULL, 'my_affiliates', 'My affiliates', 'Мои филиалы', 'Мої партнери'),
(1403, '', NULL, 'your_affiliate_link_is', 'Your affiliate link is', 'Ваша партнерская ссылка', 'Ваше партнерське посилання'),
(1404, '', NULL, 'my_balance', 'My balance', 'Мой баланс', 'Мій баланс'),
(1405, '', NULL, 'earn_up_to', 'Earn up to', 'Заработай до', 'Зароби до'),
(1406, '', NULL, 'for_each_user_your_refer_to_us__', 'for each user your refer to us !', 'за каждого пользователя, которого вы приведете к нам!', 'за кожного користувача, якого ви приведете до нас!'),
(1407, '', NULL, 'joined', 'joined', 'присоединился', 'приєднався'),
(1408, '', NULL, 'payments', 'Payments', 'Платежи', 'Платежі'),
(1409, '', NULL, 'your_balance_is', 'Your balance is', 'Ваш баланс', 'Ваш баланс'),
(1410, '', NULL, '__minimum_withdrawal_request_is', ', minimum withdrawal request is', 'минимальный запрос на вывод средств составляет', 'мінімальний запит на виведення коштів становить'),
(1411, '', NULL, 'paypal_email', 'PayPal email', 'Электронная почта PayPal', 'Електронна пошта PayPal'),
(1412, '', NULL, 'request_withdrawal', 'Request withdrawal', 'Запрос на снятие', 'Запит на зняття'),
(1413, '', NULL, 'your_request_has_been_sent__you__039_ll_receive_an_email_regarding_the_payment_details_soon.', 'Your request has been sent, you&#039;ll receive an email regarding the payment details soon.', 'Ваш запрос послан, в ближайшее время вы получите письмо с реквизитами для оплаты.', 'Ваш запит надіслано, найближчим часом ви отримаєте лист з реквізитами для оплати.'),
(1414, '', NULL, 'requested', 'requested', 'запрошенный', 'запитаний'),
(1415, '', NULL, 'payment_history', 'Payment history', 'История платежей', 'Історія платежів'),
(1416, '', NULL, 'approved', 'approved', 'одобренный', 'схвалений'),
(1417, '', NULL, 'invalid_amount_value__your_amount_is_', 'Invalid amount value, your amount is:', 'Неверное значение суммы, ваша сумма:', 'Неправильне значення суми, ваша сума:'),
(1418, '', NULL, 'add_friend', 'Add Friend', 'Добавить друга', 'Додати друга'),
(1419, '', NULL, 'unfriend', 'UnFriend', 'Удалить из друзей', 'Видалити з друзів'),
(1420, '', NULL, 'friend_request_sent', 'Friend request sent', 'Запрос на добавление в друзья', 'Запит на додавання в друзі'),
(1421, '', NULL, 'you_already_sent_friend_request.', 'You have already sent a request.', 'Вы уже отправили запрос.', 'Ви вже надіслали запит.'),
(1422, '', NULL, 'success', 'Success', 'Успех', 'Успіх'),
(1423, '', NULL, 'confirm_request_when_someone_follows_you__', 'Confirm request when someone follows you?', 'Подтверждать запрос, когда кто-нибудь следит за вами?', 'Підтверджувати запит, коли хтось стежить за вами?'),
(1424, '', NULL, 'confirm_request_when_someone_request_friend_you__', 'Confirm request when someone request to be a friend with you?', 'Подтверждать запрос, когда кто просит добавить вас в друзья?', 'Підтверджувати запит, коли хтось просить додати вас у друзі?'),
(1425, '', NULL, 'created_a_story_with_you.', 'created a story with you.', 'создал историю с вами.', 'створили з вами історію.'),
(1426, '', NULL, 'accepted_your_friend_request.', 'accepted your friend request.', 'принял твой запрос на дружбу.', 'прийняв твій запит на дружбу.'),
(1427, '', NULL, 'declined_your_friend_request.', 'declined your friend request.', 'отклонил ваш запрос на добавление в друзья.', 'відхилив ваш запит на додавання в друзі.'),
(1428, '', NULL, 'send_friend_request_to_you.', 'requested to be a friend with you.', 'попросил подружиться с тобой.', 'попросив потоваришувати з тобою.'),
(1429, '', NULL, 'friend_requests', 'Friend requests', 'Запросы в друзья', 'Запити в друзі'),
(1430, '', NULL, 'is_now_in_friend_list.', 'is now in your friend list.', 'теперь в вашем списке друзей.', 'тепер у вашому списку друзів.'),
(1431, '', NULL, 'decline_request', 'Decline request', 'Отклонить запрос', 'Відхилити запит'),
(1432, '', NULL, 'accept_request', 'Accept request', 'Принять запрос', 'Прийняти запит'),
(1433, '', NULL, 'request_your_friendship.', 'requested to be your friend.', 'попросил стать твоим другом.', 'попросив стати твоїм другом.'),
(1434, '', NULL, 'can_not_create_notification', 'can not create notification', 'не может создать уведомление', 'не вдається створити сповіщення'),
(1435, '', NULL, 'pending_review', 'pending review', 'ожидает оценки', 'очікує на розгляд'),
(1436, '', NULL, 'the_username_is_blacklisted_and_not_allowed__please_choose_another_username.', 'The username is blacklisted and not allowed, please choose another username.', 'Имя пользователя занесено в черный список и не допускается, выберите другое имя пользователя.', 'Ім&#039;я користувача знаходиться в чорному списку і не дозволено, будь ласка, виберіть інше ім&#039;я користувача.'),
(1437, '', NULL, 'the_email_provider_is_blacklisted_and_not_allowed__please_choose_another_email_provider.', 'The email provider is blacklisted and not allowed, please choose another email provider.', 'Поставщик электронной почты находится в черном списке и не допускается, выберите другого поставщика электронной почты.', 'Постачальник послуг електронної пошти знаходиться в чорному списку і не дозволений, будь ласка, виберіть іншого постачальника послуг електронної пошти.'),
(1438, '', NULL, 'latest__0__users.', 'Latest {0} users.', 'Последние {0} пользователей.', 'Останні {0} користувачів.'),
(1439, '', NULL, 'you_reach_to_limit_of_media_uploads.', 'You have reached the limit of media uploads.', 'Вы достигли лимита загрузки медиафайлов.', 'Ви досягли ліміту завантаження медіафайлів.'),
(1440, '', NULL, 'email_sent_to', 'Email sent to', 'Е-мейл отправлен', 'Електронну пошту надіслано на адресу'),
(1441, '', NULL, 'error_while_sending_emails', 'Error while sending emails', 'Ошибка при отправке электронной почты', 'Помилка під час надсилання електронних листів'),
(1442, '', NULL, 'under_review', 'Under Review', 'На рассмотрении', 'На розгляді'),
(1443, '', NULL, 'id', 'Indonesia', 'Индонезия', 'Індонезія'),
(1444, '', NULL, 'ref', 'ref', 'реф', 'реф'),
(1445, '', NULL, 'lang_key', 'lang_key', 'lang_key', 'lang_key'),
(1446, '', NULL, 'unlock_private_photo_payment', 'Unlock Private Photo Feature', 'Разблокировать частную функцию фото', 'Розблокувати функцію приватних фотографій'),
(1447, '', NULL, 'to_unlock_private_photo_feature_in_your_account__you_have_to_pay', 'To unlock private photo feature in your account, you can purchase it.', 'Чтобы разблокировать функцию приватной фотографии в своей учетной записи, вы можете приобрести ее.', 'Щоб розблокувати функцію приватних фото у своєму акаунті, ви можете придбати її.'),
(1448, '', NULL, 'unlock_private_photo_feature', 'Unlock Private Photo Feature', 'Разблокировать частную функцию фото', 'Розблокувати функцію приватних фотографій'),
(1449, '', NULL, 'to_unlock_video_upload_feature_in_your_account__you_have_to_pay', 'To unlock private photo feature in your account, you can purchase it.', 'Чтобы разблокировать функцию приватной фотографии в своей учетной записи, вы можете приобрести ее.', 'Щоб розблокувати функцію приватних фото у своєму акаунті, ви можете придбати її.'),
(1450, '', NULL, 'unlock_upload_video_feature', 'Unlock Upload Video Feature', 'Разблокировать Загрузить видео', 'Розблокувати функцію завантаження відео'),
(1451, '', NULL, 'unlock_video_upload_feature', 'Unlock Upload Video Feature', 'Разблокировать Загрузить видео', 'Розблокувати функцію завантаження відео'),
(1452, '', NULL, 'please_upload_a_photo_with_your_passport___id____your_distinct_photo', 'Please upload a photo with your passport / ID  &amp; your distinct picture.', 'Пожалуйста, загрузите фотографию с вашим паспортом / удостоверением личности и отличной фотографией.', 'Будь ласка, завантажте фотографію з вашим паспортом / посвідченням особи та вашим чітким зображенням.'),
(1453, '', NULL, 'credit_reward', 'Credit Reward', 'Кредитное вознаграждение', 'Кредитна винагорода'),
(1454, '', NULL, 'congratulation_._you_login_to_our_site_for', 'Congratulation! you logged in to our site for', 'Поздравляем! Вы вошли на наш сайт для того, чтобы', 'Вітаємо! Ви увійшли на наш сайт для того, щоб'),
(1455, '', NULL, 'and_you_earn', 'and you will earn', 'и вы заработаете', 'і ви заробите'),
(1456, '', NULL, 'user_who_logs_in_consecutively_for', 'Anyone who logs in consecutively for', 'Любой, кто входит в систему последовательно для', 'Будь-хто, хто увійде в систему послідовно протягом'),
(1457, '', NULL, 'you_currently_logged_in_for', 'You currently logged in for', 'Вы вошли в систему для', 'Ви увійшли в систему для'),
(1458, '', NULL, 'your_account_is_waiting_admin_approval.', 'Thank you, Your account is waiting admin approval.', 'Спасибо. Ваш аккаунт ожидает одобрения администратора.', 'Дякуємо, ваш обліковий запис очікує на схвалення адміністратора.'),
(1459, '', NULL, 'friend-requests', 'Friend Requests', 'Запросы в друзья', 'Запити друзів'),
(1460, '', NULL, 'notifications_single', 'Notifications', 'Уведомления', 'Сповіщення'),
(1461, '', NULL, 'for_each_user_your_refer_to_us_and_bought_a_pro_package___credit', 'For every user your refer to us and bought a pro package or credits', 'Для каждого пользователя вы обращаетесь к нам и покупаете профессиональный пакет или кредиты', 'За кожного користувача, якого ви привели до нас і який придбав професійний пакет або кредити'),
(1462, '', NULL, 'find-matches', 'find-matches', 'найденные совпадения', 'знайдені збіги'),
(1463, '', NULL, 'gifts', 'Gifts', 'Подарки', 'Подарунки'),
(1464, '', NULL, 'send_to_you', 'sent to you.', 'отправил вам.', 'надісланий вам.'),
(1465, '', NULL, 'no_more_gifts_to_show.', 'No gifts to show.', 'Нет подарков для показа.', 'Немає подарунків для показу.'),
(1466, 'country', '+93', 'AF', 'Afghanistan', 'Afghanistan', ''),
(1467, 'country', '+358', 'AX', 'Åland Islands', 'Åland Islands', ''),
(1468, 'country', '+355', 'AL', 'Albania', 'Albania', ''),
(1469, 'country', '+213', 'DZ', 'Algeria', 'Algeria', ''),
(1470, 'country', '+1684', 'AS', 'American Samoa', 'American Samoa', ''),
(1471, 'country', '+376', 'AD', 'Andorra', 'Andorra', ''),
(1472, 'country', '+244', 'AO', 'Angola', 'Angola', ''),
(1473, 'country', '+1264', 'AI', 'Anguilla', 'Anguilla', ''),
(1474, 'country', '+672', 'AQ', 'Antarctica', 'Antarctica', ''),
(1475, 'country', '+1268', 'AG', 'Antigua and Barbuda', 'Antigua and Barbuda', ''),
(1476, 'country', '+54', 'AR', 'Argentina', 'Argentina', ''),
(1477, 'country', '+374', 'AM', 'Armenia', 'Armenia', ''),
(1478, 'country', '+297', 'AW', 'Aruba', 'Aruba', ''),
(1479, 'country', '+61', 'AU', 'Australia', 'Australia', ''),
(1480, 'country', '+43', 'AT', 'Austria', 'Austria', ''),
(1481, 'country', '+994', 'AZ', 'Azerbaijan', 'Azerbaijan', ''),
(1482, 'country', '+1242', 'BS', 'Bahamas', 'Bahamas', ''),
(1483, 'country', '+973', 'BH', 'Bahrain', 'Bahrain', ''),
(1484, 'country', '+880', 'BD', 'Bangladesh', 'Bangladesh', ''),
(1485, 'country', '+1246', 'BB', 'Barbados', 'Barbados', ''),
(1486, 'country', '+375', 'BY', 'Belarus', 'Belarus', ''),
(1487, 'country', '+32', 'BE', 'Belgium', 'Belgium', ''),
(1488, 'country', '+501', 'BZ', 'Belize', 'Belize', ''),
(1489, 'country', '+229', 'BJ', 'Benin', 'Benin', ''),
(1490, 'country', '+1441', 'BM', 'Bermuda', 'Bermuda', ''),
(1491, 'country', '+975', 'BT', 'Bhutan', 'Bhutan', ''),
(1492, 'country', '+591', 'BO', 'Bolivia', 'Bolivia', ''),
(1493, 'country', '+387', 'BA', 'Bosnia and Herzegovina', 'Bosnia and Herzegovina', ''),
(1494, 'country', '+267', 'BW', 'Botswana', 'Botswana', ''),
(1495, 'country', '+55', 'BV', 'Bouvet Island', 'Bouvet Island', ''),
(1496, 'country', '+55', 'BR', 'Brazil', 'Brazil', ''),
(1497, '', NULL, 'gift_added', 'Gift added', 'Подарок добавил', 'Подарунок додав'),
(1498, '', NULL, 'send_a_gift_to_you.', 'sent a gift to you.', 'отправил вам подарок.', 'надіслав тобі подарунок.'),
(1499, '', NULL, 'you_must_signup_using__0__only.', 'you must signup using {0} only.', 'вы должны зарегистрироваться, используя только {0}.', 'ви повинні зареєструватися, використовуючи тільки {0}.'),
(1500, '', NULL, 'no_hash', 'No hash', 'Нет хеш', 'Ні хеш'),
(1501, '', NULL, 'no_friend_request_found', 'No friend requests found', 'Не найдено запросов на дружбу', 'Не знайдено запитів на дружбу'),
(1502, '', NULL, 'friend_request_received', 'Friend request received', 'Запрос на добавление в друзья', 'Запит на додавання в друзі'),
(1503, '', NULL, 'you_are_a_pro_now.', 'You are a pro now.', 'Вы профессионал.', 'Ви професіонал.'),
(1504, '', NULL, 'cashfree', 'CashFree', 'Безналичная оплата', 'Безготівкова оплата'),
(1505, '', NULL, 'phone_number', 'phone number', 'телефонный номер', 'номер телефону'),
(1506, '', NULL, 'please_wait', 'please wait', 'пожалуйста, подождите', 'Будь ласка, зачекайте.'),
(1507, '', NULL, 'iyzipay', 'Iyzipay', 'Iyzipay', 'Iyzipay'),
(1508, '', NULL, 'unknown_error', 'Unknown error occured', 'Произошла неизвестная ошибка', 'Виникла невідома помилка'),
(1509, '', NULL, '2checkout', '2Checkout', '2Checkout', '2Checkout'),
(1510, '', NULL, 'check_out', 'Check out', 'Проверить', 'Перевірити'),
(1511, '', NULL, 'address', 'address', 'адрес', 'адреса'),
(1512, '', NULL, 'state', 'state', 'состояние', 'стан'),
(1513, '', NULL, 'zip', 'zip', 'zip', 'zip'),
(1514, '', NULL, 'please_check_details', 'please check your details.', 'Пожалуйста, проверьте ваши данные.', 'будь ласка, перевірте свої дані.'),
(1515, '', NULL, 'paystack', 'PayStack', 'Платный плата', ''),
(1516, '', NULL, 'my_information', 'My Information', 'Моя информация', 'Моя інформація'),
(1517, '', NULL, 'please_choose_which_information_you_would_like_to_download', 'Please choose which information you would like to download', 'Пожалуйста, выберите, какую информацию вы хотите скачать', 'Будь ласка, оберіть, яку інформацію ви хотіли б завантажити'),
(1518, '', NULL, 'generate_file', 'Generate file', 'Генерировать файл', 'Генерувати файл'),
(1519, '', NULL, 'missing_fields', 'Missing fields', 'Пропущенные поля', 'Пропущені поля'),
(1520, '', NULL, 'cover', 'Cover', 'Обложка', 'Обкладинка'),
(1521, '', NULL, 'member_type', 'Member Type', 'Тип участника', 'Тип учасника'),
(1522, '', NULL, 'sessions', 'Sessions', 'Сеансы', 'Сеанси'),
(1523, '', NULL, 'media', 'Media', 'Медиа', 'Медіа'),
(1524, '', NULL, 'your_file_is_ready_to_download_', 'Your file is ready to download!', 'Ваш файл готов скачать!', 'Ваш файл готовий завантажити!'),
(1525, '', NULL, 'bank', 'Bank', 'Банк', 'Банк'),
(1526, '', NULL, 'withdraw_method', 'Withdraw Method', 'Способ вывода средств', 'Спосіб виведення коштів'),
(1527, '', NULL, 'iban', 'iban', 'iban', 'iban'),
(1528, '', NULL, 'full_name', 'Full Name', 'Полное имя', 'Повне ім&#039;я'),
(1529, '', NULL, 'swift_code', 'Swift Code', 'Свифтный код', 'Свіфтний код'),
(1530, '', NULL, 'you_have_already_a_pending_request.', 'You have already a pending request.', 'У вас уже есть запрос на рассмотрение.', 'У вас вже є запит на розгляд.'),
(1531, '', NULL, 'stream_has_ended', '{{user}} stream has ended.', '{{user}} поток закончился.', '{{user}} потік закінчився.'),
(1532, '', NULL, 'paystack', 'PayStack', 'Платный плата', ''),
(1533, '', NULL, 'end_call', 'End Call', 'Конец связи', 'Кінець зв&#039;язку'),
(1534, '', NULL, 'live', 'Live', 'Live', 'Live'),
(1535, '', NULL, 'end_live', 'End Live', 'Конец прямого эфира', 'Кінець прямого ефіру'),
(1536, '', NULL, 'go_live', 'Go Live', 'Начинаем трансляцию.', 'Починаємо трансляцію.'),
(1537, '', NULL, 'mic_source', 'Mic Source', 'Источник микрофона', 'Джерело мікрофона'),
(1538, '', NULL, 'cam_source', 'Cam Source', 'Источник камеры', 'Джерело камери'),
(1539, '', NULL, 'live_videos', 'Live Videos', 'Видео в прямом эфире', 'Відео в прямому ефірі'),
(1540, '', NULL, 'live_users', 'Live Users', 'Живые Пользователи', 'Живі Користувачі'),
(1541, '', NULL, 'live-users', 'live-users', 'живые пользователи', 'живі користувачі'),
(1542, '', NULL, 'video', 'video', 'видео', 'відео'),
(1543, '', NULL, 'is_live', 'is Live', 'в прямом эфире', 'у прямому ефірі'),
(1544, '', NULL, 'was_live', 'was Live', 'был в прямом эфире', 'був у прямому ефірі'),
(1545, '', NULL, 'write_a_comment', 'Write a comment', 'Написать комментарий', 'Написати коментар'),
(1546, '', NULL, 'user-live', 'user-live', 'user-live.', 'user-live'),
(1547, '', NULL, 'no_more_videos_to_show.', 'No more videos to show.', 'Больше нет видео, чтобы показать.', 'Більше немає відео для показу.'),
(1548, '', NULL, 'login_with_qq', 'Login with QQ', 'Войти с помощью QQ', 'Увійдіть за допомогою QQ'),
(1549, '', NULL, 'login_with_wechat', 'Login with WeChat', 'Войти с wechat.', 'Увійдіть за допомогою WeChat'),
(1550, '', NULL, 'login_with_discord', 'Login with Discord', 'Вход с помощью Discord', 'Вхід за допомогою Discord'),
(1551, '', NULL, 'login_with_mailru', 'Login with Mailru', 'Войти с Mailru.', ''),
(1552, '', NULL, 'developers', 'Developers', 'Разработчики', 'Розробники'),
(1553, '', NULL, 'create-app', 'create-app', 'создавать приложение', 'створювати додаток'),
(1554, '', NULL, 'create_new_app', 'Create new App', 'Создать новое приложение', 'Створити новий додаток'),
(1555, '', NULL, 'domain', 'Domain', 'Домен', 'Домен'),
(1556, '', NULL, 'redirect_uri', 'Redirect URI', 'Перенаправление URI', 'Перенаправлення URI'),
(1557, '', NULL, 'description', 'Description', 'Описание', 'Опис'),
(1558, '', NULL, 'app', 'app', 'приложение', 'додаток'),
(1559, '', NULL, 'your_application_name._this_is_used_to_attribute_the_source_user-facing_authorization_screens._32_characters_max.', 'Your application name. This is used to attribute the source user-facing authorization screens. 32 characters max.', 'Название программы. Это имя используется для атрибуции экранов авторизации для источников пользователей. Максимум 32 символа.', 'Назва вашої програми. Це ім&#039;я використовується для атрибуції екранів авторизації для користувачів джерела. Максимум 32 символи.'),
(1560, '', NULL, 'your_application_s_publicly_accessible_home_page.', 'Your application&#039;s publicly accessible home page.', 'Общедоступная домашняя страница вашего приложения.', 'Загальнодоступна домашня сторінка вашого додатку.'),
(1561, '', NULL, 'where_should_we_return_after_successfully_authenticating_', 'Where should we return after successfully authenticating?', 'Куда возвращаться после успешной аутентификации?', 'Куди повертатися після успішної автентифікації?'),
(1562, '', NULL, 'your_application_description__which_will_be_shown_in_user-facing_authorization_screens._between_10_and_200_characters_max.', 'Your application description, which will be shown in user-facing authorization screens. Between 10 and 200 characters max.', 'Описание вашей заявки, которое будет показано на экранах авторизации, обращенных к пользователю. От 10 до 200 символов максимум.', 'Опис вашої заявки, який буде показано на екранах авторизації, звернених до користувача. Від 10 до 200 символів максимум.'),
(1563, '', NULL, 'image', 'Image', 'Изображение', 'Зображення'),
(1564, '', NULL, 'your_application_thumbnail', 'Your application thumbnail', 'Ваше миниатюру приложения', 'Ваше мініатюру додатка'),
(1565, '', NULL, 'choose_image', 'choose image', 'выберите изображение', 'вибрати зображення'),
(1566, '', NULL, 'apps', 'Apps', 'Программы', 'Програми'),
(1567, '', NULL, 'create', 'Create', 'Создавать', 'Створити'),
(1568, '', NULL, 'create_app', 'Create App', 'Создать приложение', 'Создать приложение'),
(1569, '', NULL, 'oauth', 'oauth', 'oauth', 'oauth'),
(1570, '', NULL, 'app_permissions', 'App Permissions', 'Разрешения приложений', 'Дозволи додатків'),
(1571, '', NULL, 'invalid_url', 'Invalid Url', 'Неверный URL-адрес', 'Неправильний URL-адресу'),
(1572, '', NULL, 'are_you_sure_you_want_to_remove_the_video', 'Are you sure you want to remove the video?', 'Вы уверены, что хотите удалить видео?', 'Ви впевнені, що хочете видалити відео?'),
(1573, '', NULL, 'authorize.net', 'Authorize.net', 'Auralize.net.', ''),
(1574, '', NULL, 'are_you_sure_you_want_to_remove_this_comment', 'Are you sure you want to remove this comment?', 'Вы уверены, что хотите удалить этот комментарий?', 'Ви впевнені, що хочете видалити цей коментар?'),
(1575, '', NULL, 'securionpay', 'Securionpay', 'Securionpay.', 'Securionpay'),
(1576, '', NULL, 'discussion', 'Discussion', 'Обсуждение', 'Обсуждение'),
(1577, '', NULL, 'invitation_links', 'Invitation Links', 'Пригласительные ссылки', 'Посилання на запрошення'),
(1578, '', NULL, 'available_links', 'Available links', 'Доступные ссылки', 'Доступні посилання'),
(1579, '', NULL, 'generated_links', 'Generated links', 'Сгенерированные ссылки', 'Згенеровані посилання'),
(1580, '', NULL, 'used_links', 'Used links', 'Подержанные ссылки', 'Уживані посилання'),
(1581, '', NULL, 'generate_link', 'Generate link', 'Генерировать ссылку', 'Генерувати посилання'),
(1582, '', NULL, 'url', 'url', 'url', 'url'),
(1583, '', NULL, 'invited_user', 'invited user', 'приглашенный пользователь', 'запрошений користувач'),
(1584, '', NULL, 'copy', 'copy', 'скопировать', 'скопіювати'),
(1585, '', NULL, 'code_successfully_generated', 'Code successfully generated', 'Код успешно сгенерирован', 'Код успішно згенеровано'),
(1586, '', NULL, 'copied', 'copied', 'скопировано', 'скопировано'),
(1587, '', NULL, 'function_not_found', 'Function not found', 'Функция не найдена', 'Функцію не знайдено'),
(1588, '', NULL, 'coinpayments_canceled', 'Your payment using CoinPayments has been canceled', 'Ваш платеж с использованием CoinPayments был отменен', ''),
(1589, '', NULL, 'coinpayments_approved', 'Your payment using CoinPayments has been approved', 'Ваш платеж с использованием CoinPayments был утвержден', ''),
(1590, 'country', NULL, 'ngenius', 'Ngenius', 'Нгений', ''),
(1591, '', NULL, 'terms_register_text', 'By creating your account, you agree to our {terms} &amp; {privacy}', 'Создавая свою учетную запись, вы соглашаетесь с нашими {условиями} и {частностью}', 'Створюючи свій обліковий запис, ви погоджуєтеся з нашими {умовами} та {приватністю}'),
(1592, 'country', NULL, 'BQ', 'Bonaire, Sint Eustatius and Saba', 'Bonaire, Sint Eustatius и Saba', ''),
(1593, 'country', NULL, 'IO', 'British Indian Ocean Territory', 'Британская территория Индийского океана', ''),
(1594, 'country', NULL, 'BN', 'Brunei Darussalam', 'Бруней-Даруссалам', ''),
(1595, 'country', NULL, 'BG', 'Bulgaria', 'Болгария', ''),
(1596, 'country', NULL, 'BF', 'Burkina Faso', 'Буркина-Фасо', ''),
(1597, 'country', NULL, 'BI', 'Burundi', 'Бурунди', ''),
(1598, 'country', NULL, 'KH', 'Cambodia', 'Камбоджа', ''),
(1599, 'country', NULL, 'CM', 'Cameroon', 'Камерун', ''),
(1600, 'country', NULL, 'CA', 'Canada', 'Канада', ''),
(1601, 'country', NULL, 'CV', 'Cape Verde', 'Кабо-Верде', ''),
(1602, 'country', NULL, 'KY', 'Cayman Islands', 'Каймановы острова', ''),
(1603, 'country', NULL, 'CF', 'Central African Republic', 'Центрально-Африканская Республика', ''),
(1604, 'country', NULL, 'TD', 'Chad', 'Чад', ''),
(1605, 'country', NULL, 'CL', 'Chile', 'Чили', ''),
(1606, 'country', NULL, 'CN', 'China', 'Китай', ''),
(1607, 'country', NULL, 'CX', 'Christmas Island', 'Остров Рождества', ''),
(1608, 'country', NULL, 'CC', 'Cocos (Keeling) Islands', 'Кокос (Килинг) Острова', ''),
(1609, 'country', NULL, 'CO', 'Colombia', 'Колумбия', ''),
(1610, 'country', NULL, 'KM', 'Comoros', 'Коморос', ''),
(1611, 'country', NULL, 'CG', 'Congo', 'Конго', ''),
(1612, 'country', NULL, 'CD', 'Congo, Democratic Republic of the Congo', 'Конго, Демократическая Республика Конго', ''),
(1613, 'country', NULL, 'CK', 'Cook Islands', 'Острова Кука', ''),
(1614, 'country', NULL, 'CR', 'Costa Rica', 'Коста -Рика', ''),
(1615, 'country', NULL, 'CI', 'Cote D`Ivoire', 'Cote D`ivoire', ''),
(1616, 'country', NULL, 'HR', 'Croatia', 'Хорватия', ''),
(1617, 'country', NULL, 'CU', 'Cuba', 'Куба', ''),
(1618, 'country', NULL, 'CW', 'Curacao', 'Кюрасао', ''),
(1619, 'country', NULL, 'CY', 'Cyprus', 'Кипр', ''),
(1620, 'country', NULL, 'CZ', 'Czech Republic', 'Чешская Республика', ''),
(1621, 'country', NULL, 'DK', 'Denmark', 'Дания', ''),
(1622, 'country', NULL, 'DJ', 'Djibouti', 'Джибути', ''),
(1623, 'country', NULL, 'DM', 'Dominica', 'Доминика', ''),
(1624, 'country', NULL, 'DO', 'Dominican Republic', 'Доминиканская Республика', ''),
(1625, 'country', NULL, 'EC', 'Ecuador', 'Эквадор', ''),
(1626, 'country', NULL, 'EG', 'Egypt', 'Египет', ''),
(1627, 'country', NULL, 'SV', 'El Salvador', 'Сальвадор', ''),
(1628, 'country', NULL, 'GQ', 'Equatorial Guinea', 'Экваториальная Гвинея', ''),
(1629, 'country', NULL, 'ER', 'Eritrea', 'Эритрея', ''),
(1630, 'country', NULL, 'EE', 'Estonia', 'Эстония', ''),
(1631, 'country', NULL, 'ET', 'Ethiopia', 'Эфиопия', ''),
(1632, 'country', NULL, 'FK', 'Falkland Islands (Malvinas)', 'Фолклендские острова (Мальвинс)', ''),
(1633, 'country', NULL, 'FO', 'Faroe Islands', 'Фарерские острова', ''),
(1634, 'country', NULL, 'FJ', 'Fiji', 'Фиджи', ''),
(1635, 'country', NULL, 'FI', 'Finland', 'Финляндия', ''),
(1636, 'country', NULL, 'FR', 'France', 'Франция', ''),
(1637, 'country', NULL, 'GF', 'French Guiana', 'Французская Гвиана', ''),
(1638, 'country', NULL, 'PF', 'French Polynesia', 'Французская Полинезия', ''),
(1639, 'country', NULL, 'TF', 'French Southern Territories', 'Южные Французские Территории', ''),
(1640, 'country', NULL, 'GA', 'Gabon', 'Габон', ''),
(1641, 'country', NULL, 'GM', 'Gambia', 'Гамбия', ''),
(1642, 'country', NULL, 'GE', 'Georgia', 'Грузия', ''),
(1643, 'country', NULL, 'DE', 'Germany', 'Германия', ''),
(1644, 'country', NULL, 'GH', 'Ghana', 'Гана', ''),
(1645, 'country', NULL, 'GI', 'Gibraltar', 'Гибралтар', ''),
(1646, 'country', NULL, 'GR', 'Greece', 'Греция', ''),
(1647, 'country', NULL, 'GL', 'Greenland', 'Гренландия', ''),
(1648, 'country', NULL, 'GD', 'Grenada', 'Гренада', ''),
(1649, 'country', NULL, 'GP', 'Guadeloupe', 'Гваделупа', ''),
(1650, 'country', NULL, 'GU', 'Guam', 'Гуам', ''),
(1651, 'country', NULL, 'GT', 'Guatemala', 'Гватемала', ''),
(1652, 'country', NULL, 'GG', 'Guernsey', 'Гернси', ''),
(1653, 'country', NULL, 'GN', 'Guinea', 'Гвинея', ''),
(1654, 'country', NULL, 'GW', 'Guinea-Bissau', 'Гвинея-Бисау', ''),
(1655, 'country', NULL, 'GY', 'Guyana', 'Гайана', ''),
(1656, 'country', NULL, 'HT', 'Haiti', 'Гаити', ''),
(1657, 'country', NULL, 'HM', 'Heard Island and Mcdonald Islands', 'Херд острова и острова Макдональдс', ''),
(1658, 'country', NULL, 'VA', 'Holy See (Vatican City State)', 'Святой Пресз (штат Ватикан)', ''),
(1659, 'country', NULL, 'HN', 'Honduras', 'Гондурас', ''),
(1660, 'country', NULL, 'HK', 'Hong Kong', 'Гонконг', ''),
(1661, 'country', NULL, 'HU', 'Hungary', 'Венгрия', ''),
(1662, 'country', NULL, 'IS', 'Iceland', 'Исландия', ''),
(1663, 'country', NULL, 'IN', 'India', 'Индия', ''),
(1664, 'country', NULL, 'ID', 'Indonesia', 'Индонезия', ''),
(1665, 'country', NULL, 'IR', 'Iran, Islamic Republic of', 'Иран, Исламская Республика', ''),
(1666, 'country', NULL, 'IQ', 'Iraq', 'Ирак', ''),
(1667, 'country', NULL, 'IE', 'Ireland', 'Ирландия', ''),
(1668, 'country', NULL, 'IM', 'Isle of Man', 'Остров Мэн', ''),
(1669, 'country', NULL, 'IL', 'Israel', 'Израиль', ''),
(1670, 'country', NULL, 'IT', 'Italy', 'Италия', ''),
(1671, 'country', NULL, 'JM', 'Jamaica', 'Ямайка', ''),
(1672, 'country', NULL, 'JP', 'Japan', 'Япония', ''),
(1673, 'country', NULL, 'JE', 'Jersey', 'Джерси', ''),
(1674, 'country', NULL, 'JO', 'Jordan', 'Иордания', ''),
(1675, 'country', NULL, 'KZ', 'Kazakhstan', 'Казахстан', ''),
(1676, 'country', NULL, 'KE', 'Kenya', 'Кения', ''),
(1677, 'country', NULL, 'KI', 'Kiribati', 'Кирибати', ''),
(1678, 'country', NULL, 'KP', 'Korea, Democratic People`s Republic of', 'Корея, Демократическая Народная Республика', ''),
(1679, 'country', NULL, 'KR', 'Korea, Republic of', 'Корея, Республика', ''),
(1680, 'country', NULL, 'XK', 'Kosovo', 'Косово', ''),
(1681, 'country', NULL, 'KW', 'Kuwait', 'Кувейт', ''),
(1682, 'country', NULL, 'KG', 'Kyrgyzstan', 'Кыргизстан', ''),
(1683, 'country', NULL, 'LA', 'Lao People`s Democratic Republic', 'Лаосная Демократическая Республика', ''),
(1684, 'country', NULL, 'LV', 'Latvia', 'Латвия', ''),
(1685, 'country', NULL, 'LB', 'Lebanon', 'Ливан', ''),
(1686, 'country', NULL, 'LS', 'Lesotho', 'Лесото', ''),
(1687, 'country', NULL, 'LR', 'Liberia', 'Либерия', ''),
(1688, 'country', NULL, 'LY', 'Libyan Arab Jamahiriya', 'Ливийская арабская джамахирия', ''),
(1689, 'country', NULL, 'LI', 'Liechtenstein', 'Лихтенштейн', ''),
(1690, 'country', NULL, 'LT', 'Lithuania', 'Литва', ''),
(1691, 'country', NULL, 'LU', 'Luxembourg', 'Люксембург', ''),
(1692, 'country', NULL, 'MO', 'Macao', 'Макао', ''),
(1693, 'country', NULL, 'MK', 'Macedonia, the Former Yugoslav Republic of', 'Македония, бывшая Югославская Республика', ''),
(1694, 'country', NULL, 'MG', 'Madagascar', 'Мадагаскар', ''),
(1695, 'country', NULL, 'MW', 'Malawi', 'Малави', ''),
(1696, 'country', NULL, 'MY', 'Malaysia', 'Малайзия', ''),
(1697, 'country', NULL, 'MV', 'Maldives', 'Мальдивы', ''),
(1698, 'country', NULL, 'ML', 'Mali', 'Мали', ''),
(1699, 'country', NULL, 'MT', 'Malta', 'Мальта', ''),
(1700, 'country', NULL, 'MH', 'Marshall Islands', 'Маршалловы острова', ''),
(1701, 'country', NULL, 'MQ', 'Martinique', 'Мартиника', ''),
(1702, 'country', NULL, 'MR', 'Mauritania', 'Мавритания', ''),
(1703, 'country', NULL, 'MU', 'Mauritius', 'Маврикий', ''),
(1704, 'country', NULL, 'YT', 'Mayotte', 'Майотт', ''),
(1705, 'country', NULL, 'MX', 'Mexico', 'Мексика', ''),
(1706, 'country', NULL, 'FM', 'Micronesia, Federated States of', 'Микронезия, федеративные состояния', ''),
(1707, 'country', NULL, 'MD', 'Moldova, Republic of', 'Молдова, Республика', ''),
(1708, 'country', NULL, 'MC', 'Monaco', 'Монако', ''),
(1709, 'country', NULL, 'MN', 'Mongolia', 'Монголия', ''),
(1710, 'country', NULL, 'ME', 'Montenegro', 'Черногория', ''),
(1711, 'country', NULL, 'MS', 'Montserrat', 'Монтсеррат', ''),
(1712, 'country', NULL, 'MA', 'Morocco', 'Марокко', ''),
(1713, 'country', NULL, 'MZ', 'Mozambique', 'Мозамбик', ''),
(1714, 'country', NULL, 'MM', 'Myanmar', 'Мьянма', ''),
(1715, 'country', NULL, 'NA', 'Namibia', 'Намибия', ''),
(1716, 'country', NULL, 'NR', 'Nauru', 'Науру', ''),
(1717, 'country', NULL, 'NP', 'Nepal', 'Непал', ''),
(1718, 'country', NULL, 'NL', 'Netherlands', 'Нидерланды', ''),
(1719, 'country', NULL, 'AN', 'Netherlands Antilles', 'Нидерландские Антильские острова', ''),
(1720, 'country', NULL, 'NC', 'New Caledonia', 'Новая Каледония', ''),
(1721, 'country', NULL, 'NZ', 'New Zealand', 'Новая Зеландия', ''),
(1722, 'country', NULL, 'NI', 'Nicaragua', 'Никарагуа', ''),
(1723, 'country', NULL, 'NE', 'Niger', 'Нигер', ''),
(1724, 'country', NULL, 'NG', 'Nigeria', 'Нигерия', ''),
(1725, 'country', NULL, 'NU', 'Niue', 'Ниуэ', ''),
(1726, 'country', NULL, 'NF', 'Norfolk Island', 'Остров Норфолк', ''),
(1727, 'country', NULL, 'MP', 'Northern Mariana Islands', 'Северные Марианские острова', ''),
(1728, 'country', NULL, 'NO', 'Norway', 'Норвегия', ''),
(1729, 'country', NULL, 'OM', 'Oman', 'Оман', ''),
(1730, 'country', NULL, 'PK', 'Pakistan', 'Пакистан', ''),
(1731, 'country', NULL, 'PW', 'Palau', 'Палау', ''),
(1732, 'country', NULL, 'PS', 'Palestinian', 'Палестинский', ''),
(1733, 'country', NULL, 'PA', 'Panama', 'Панама', ''),
(1734, 'country', NULL, 'PG', 'Papua New Guinea', 'Папуа - Новая Гвинея', ''),
(1735, 'country', NULL, 'PY', 'Paraguay', 'Парагвай', ''),
(1736, 'country', NULL, 'PE', 'Peru', 'Перу', ''),
(1737, 'country', NULL, 'PH', 'Philippines', 'Филиппины', ''),
(1738, 'country', NULL, 'PN', 'Pitcairn', 'Питкэрн', ''),
(1739, 'country', NULL, 'PL', 'Poland', 'Польша', ''),
(1740, 'country', NULL, 'PT', 'Portugal', 'Португалия', ''),
(1741, 'country', NULL, 'PR', 'Puerto Rico', 'Пуэрто-Рико', ''),
(1742, 'country', NULL, 'QA', 'Qatar', 'Катар', ''),
(1743, 'country', NULL, 'RE', 'Reunion', 'Воссоединение', ''),
(1744, 'country', NULL, 'RO', 'Romania', 'Румыния', ''),
(1745, 'country', NULL, 'RU', 'Russian Federation', 'Российская Федерация', ''),
(1746, 'country', NULL, 'RW', 'Rwanda', 'Руанда', ''),
(1747, 'country', NULL, 'BL', 'Saint Barthelemy', 'Святой Бартелми', ''),
(1748, 'country', NULL, 'SH', 'Saint Helena', 'Святая Елена', ''),
(1749, 'country', NULL, 'KN', 'Saint Kitts and Nevis', 'Сент-Китс и Невис', ''),
(1750, 'country', NULL, 'LC', 'Saint Lucia', 'Сент-Люсия', ''),
(1751, 'country', NULL, 'MF', 'Saint Martin', 'Святой Мартин', ''),
(1752, 'country', NULL, 'PM', 'Saint Pierre and Miquelon', 'Сент -Пьер и Микелон', ''),
(1753, 'country', NULL, 'VC', 'Saint Vincent and the Grenadines', 'Святой Винсент и Гренадины', ''),
(1754, 'country', NULL, 'WS', 'Samoa', 'Самоа', ''),
(1755, 'country', NULL, 'SM', 'San Marino', 'Сан -Марино', ''),
(1756, 'country', NULL, 'ST', 'Sao Tome and Principe', 'Sao Tome и Principe', ''),
(1757, 'country', NULL, 'SA', 'Saudi Arabia', 'Саудовская Аравия', ''),
(1758, 'country', NULL, 'SN', 'Senegal', 'Сенегал', ''),
(1759, 'country', NULL, 'RS', 'Serbia', 'Сербия', ''),
(1760, 'country', NULL, 'CS', 'Serbia and Montenegro', 'Сербия и Черногория', ''),
(1761, 'country', NULL, 'SC', 'Seychelles', 'Сейшельские острова', ''),
(1762, 'country', NULL, 'SL', 'Sierra Leone', 'Сьерра-Леоне', ''),
(1763, 'country', NULL, 'SG', 'Singapore', 'Сингапур', ''),
(1764, 'country', NULL, 'SX', 'Sint Maarten', 'Синт Мартен', ''),
(1765, 'country', NULL, 'SK', 'Slovakia', 'Словакия', ''),
(1766, 'country', NULL, 'SI', 'Slovenia', 'Словения', ''),
(1767, 'country', NULL, 'SB', 'Solomon Islands', 'Соломоновы острова', ''),
(1768, 'country', NULL, 'SO', 'Somalia', 'Сомали', '');
INSERT INTO `langs` (`id`, `ref`, `options`, `lang_key`, `english`, `russian`, `ukrainian`) VALUES
(1769, 'country', NULL, 'ZA', 'South Africa', 'Южная Африка', ''),
(1770, 'country', NULL, 'GS', 'South Georgia and the South Sandwich Islands', 'Южная Грузия и Южные Сэндвич Острова', ''),
(1771, 'country', NULL, 'SS', 'South Sudan', 'южный Судан', ''),
(1772, 'country', NULL, 'ES', 'Spain', 'Испания', ''),
(1773, 'country', NULL, 'LK', 'Sri Lanka', 'Шри -Ланка', ''),
(1774, 'country', NULL, 'SD', 'Sudan', 'Судан', ''),
(1775, 'country', NULL, 'SR', 'Suriname', 'Суринам', ''),
(1776, 'country', NULL, 'SJ', 'Svalbard and Jan Mayen', 'Ширбард и Ян Мейэн', ''),
(1777, 'country', NULL, 'SZ', 'Swaziland', 'Свазиленд', ''),
(1778, 'country', NULL, 'SE', 'Sweden', 'Швеция', ''),
(1779, 'country', NULL, 'CH', 'Switzerland', 'Швейцария', ''),
(1780, 'country', NULL, 'SY', 'Syrian Arab Republic', 'Сирийская Арабская Республика', ''),
(1781, 'country', NULL, 'TW', 'Taiwan, Province of China', 'Тайвань, провинция Китая', ''),
(1782, 'country', NULL, 'TJ', 'Tajikistan', 'Таджикистан', ''),
(1783, 'country', NULL, 'TZ', 'Tanzania, United Republic of', 'Танзания, Объединенная Республика', ''),
(1784, 'country', NULL, 'TH', 'Thailand', 'Таиланд', ''),
(1785, 'country', NULL, 'TL', 'Timor-Leste', 'Тимор-Лешт', ''),
(1786, 'country', NULL, 'TG', 'Togo', 'Идти', ''),
(1787, 'country', NULL, 'TK', 'Tokelau', 'Токелау', ''),
(1788, 'country', NULL, 'TO', 'Tonga', 'Тонга', ''),
(1789, 'country', NULL, 'TT', 'Trinidad and Tobago', 'Тринидад и Тобаго', ''),
(1790, 'country', NULL, 'TN', 'Tunisia', 'Тунис', ''),
(1791, 'country', NULL, 'TR', 'Turkey', 'Турция', ''),
(1792, 'country', NULL, 'TM', 'Turkmenistan', 'Туркменистан', ''),
(1793, 'country', NULL, 'TC', 'Turks and Caicos Islands', 'Турки и острова Кайкос', ''),
(1794, 'country', NULL, 'TV', 'Tuvalu', 'Тувалу', ''),
(1795, 'country', NULL, 'UG', 'Uganda', 'Уганда', ''),
(1796, 'country', '+380', 'UA', 'Ukraine', 'Украина', 'Україна'),
(1797, 'country', NULL, 'AE', 'United Arab Emirates', 'Объединенные Арабские Эмираты', ''),
(1798, 'country', NULL, 'GB', 'United Kingdom', 'объединенное Королевство', ''),
(1799, 'country', NULL, 'US', 'United States', 'Соединенные Штаты', ''),
(1800, 'country', NULL, 'UM', 'United States Minor Outlying Islands', 'Малые отдаленные острова США', ''),
(1801, 'country', NULL, 'UY', 'Uruguay', 'Уругвай', ''),
(1802, 'country', NULL, 'UZ', 'Uzbekistan', 'Узбекистан', ''),
(1803, 'country', NULL, 'VU', 'Vanuatu', 'Вануату', ''),
(1804, 'country', NULL, 'VE', 'Venezuela', 'Венесуэла', ''),
(1805, 'country', NULL, 'VN', 'Viet Nam', 'Вьетнам', ''),
(1806, 'country', NULL, 'VG', 'Virgin Islands, British', 'Виргинские острова, британские', ''),
(1807, 'country', NULL, 'VI', 'Virgin Islands, U.s.', 'Виргинские острова, США', ''),
(1808, 'country', NULL, 'WF', 'Wallis and Futuna', 'Уоллис и Футуна', ''),
(1809, 'country', NULL, 'EH', 'Western Sahara', 'Западная Сахара', ''),
(1810, 'country', NULL, 'YE', 'Yemen', 'Йемен', ''),
(1811, 'country', NULL, 'ZM', 'Zambia', 'Замбия', ''),
(1812, 'country', NULL, 'ZW', 'Zimbabwe', 'Зимбабве', ''),
(1813, '', NULL, 'verified', 'Verified', 'Проверенный', 'Перевірений'),
(1814, '', NULL, 'unverified', 'Unverified', 'Неверный', 'Неверный'),
(1815, '', NULL, 'coinbase', 'Coinbase', 'Coinbase', ''),
(1816, '', NULL, 'yoomoney', 'Yoomoney', 'Yoomoney', ''),
(1817, '', NULL, 'pay_from_wallet', 'Pay By Wallet', 'Оплата по кошельку', 'Оплата за гаманцем'),
(1818, '', NULL, 'pay_to_upgrade', 'You are about to upgrade to a PRO memeber.', 'Вы собираетесь перейти на уровень участника PRO.', 'Ви збираєтеся перейти на рівень PRO учасника.'),
(1819, '', NULL, 'please_top_up_credits', 'You don&#039;t have enough balance to purchase, please buy credits.', 'У вас недостаточно средств для покупки, пожалуйста, приобретите кредиты.', 'У вас недостатньо коштів для покупки, будь ласка, придбайте кредити.'),
(1820, '', NULL, 'pay_from_credits', 'Pay By Credits', 'Оплатить кредитами', 'Оплатити кредитами'),
(1821, '', NULL, 'pay_to_unlock_private_photo', 'You are about to unlock private photo feature.', 'Вы сейчас разблокировать функцию приватных фотографий.', 'Ви зараз розблокуєте функцію приватних фотографій.'),
(1822, '', NULL, 'pay_to_unlock_private_video', 'You are about to unlock private video feature.', 'Вы сейчас разблокируете функцию приватного видео.', 'Ви зараз розблокуєте функцію приватного відео.'),
(1823, '', NULL, 'razorpay', 'Razorpay', 'Razorpay', ''),
(1824, '', NULL, 'login_with_linkedin', 'Login with linkedin', 'Войдите с LinkedIn', ''),
(1825, '', NULL, 'login_with_okru', 'Login with OkRu', 'Войдите с Okru', ''),
(1826, '', NULL, 'faqs', 'FAQs', 'Часто задаваемые вопросы', 'Часті запитання'),
(1827, '', NULL, 'refund', 'Refund', 'Возвращать деньги', 'Повернення коштів'),
(1828, '', NULL, 'get_mobile_apps', 'Get Mobile Apps', 'Получите мобильные приложения', 'Отримати мобільні додатки'),
(1829, '', NULL, 'apps', 'Apps', 'Программы', ''),
(1830, '', NULL, 'start_import', 'Start Importing', 'Начните импортировать', 'Почати імпорт'),
(1831, '', NULL, 'you_are_ready_to_import_from', 'You are ready to start import from instagram', 'Вы готовы начать импорт из Instagram', 'Ви готові розпочати імпорт з instagram'),
(1832, '', NULL, 'link_instagram_account', 'Link your instagram account', 'Привяжите свой аккаунт в Instagram', 'Прив&#039;яжіть свій акаунт в Instagram'),
(1833, '', NULL, 'instagram_importer', 'Instagram Importer', 'Импортер Instagram', 'Імпортер Instagram'),
(1834, '', NULL, 'import', 'Import', 'Импорт', 'Імпорт'),
(1835, '', NULL, 'token_expired', 'token expired', 'срок действия токена истек', 'термін дії токену закінчився'),
(1836, '', NULL, 'imported', 'Imported', 'Импортирован', 'Імпортовано'),
(1837, '', NULL, 'post_not_found', 'Post not found', 'Сообщение не найдено', 'Повідомлення не знайдено'),
(1838, '', NULL, 'album', 'Album', 'Альбом', 'Альбом'),
(1839, '', NULL, 'check_after_some', 'This process may take some time please check after few minutes', 'Этот процесс может занять некоторое время, пожалуйста, проверьте через несколько минут', 'Цей процес може зайняти деякий час, будь ласка, перевірте через кілька хвилин'),
(1840, '', NULL, 'fortumo', 'Fortumo', 'Формумо', 'Фортумо'),
(1841, '', NULL, 'coinpayments', 'CoinPayments', 'Coinpayments', ''),
(1842, '', NULL, 'coinpayments_canceled', 'Your payment using CoinPayments has been canceled', 'Ваш платеж с использованием CoinPayments был отменен', ''),
(1843, '', NULL, 'coinpayments_approved', 'Your payment using CoinPayments has been approved', 'Ваш платеж с использованием CoinPayments был утвержден', ''),
(1844, '', NULL, 'pending_request_please_try', 'You already have a pending request , Please try again later', 'У вас уже есть ожидающий запрос, попробуйте еще раз позже', 'У вас вже є запит на обробку, будь ласка, спробуйте ще раз пізніше'),
(1845, '', NULL, 'import_from_instagram', 'Import From Instagram', 'Импорт из Instagram', 'Імпорт з Instagram'),
(1846, '', NULL, 'terms_of_use_page', '<h4>1- Write your Terms Of Use here.</h4>\r\n      <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut aliqu', '<h4> 1- Напишите свои условия использования здесь. </h4>\r\n      ', ''),
(1847, '', NULL, 'about_page', '<h4>1- Write your About us here.</h4>\r\n      <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut aliquip e', '<h4> 1- Напишите свое о нас здесь. </h4>\r\n      ', ''),
(1848, '', NULL, 'privacy_policy_page', '<h4>1- Write your Privacy Policy here.</h4>\r\n      <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut ali', '<h4> 1- Напишите свою политику конфиденциальности здесь. </h4>\r\n      ', ''),
(1849, '', NULL, 'refund_terms_page', '<h4>1- Write your Privacy Refund here.</h4>\r\n      <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut ali', '<h4> 1- Напишите свой возврат конфиденциальности здесь. </h4>\r\n      ', ''),
(1850, '', NULL, 'ngenius', 'Ngenius', 'Нгений', ''),
(1851, '', NULL, 'aamarpay', 'Aamarpay', 'Аамарпай', ''),
(1852, '', NULL, 'link_insta', 'Link Instagram', 'Ссылка Instagram', 'Посилання Instagram'),
(1853, '', NULL, 'link_insta_desc', 'Now you can link your Instagram account to the seamless import of your Instagram media.', 'Теперь вы можете связать свою учетную запись в Instagram с бесшовным импортом вашего Instagram Media.', 'Тепер ви можете прив&#039;язати свій обліковий запис Instagram до безперешкодного імпорту медіа з Instagram.'),
(1854, '', NULL, 'account_not_verified_text', 'Your account is being reviewed, we will let you know once it is approved.', 'Ваша учетная запись проверяется, мы сообщим вам, как только он будет утвержден.', 'Ваш обліковий запис розглядається, ми повідомимо вам, як тільки він буде схвалений.'),
(1855, '', NULL, 'premium_member', 'Premium Member', 'Премиум-участник', 'Преміум-учасник'),
(1856, '', NULL, 'fluttewave', 'Fluttewave', 'FlutterWave', ''),
(1857, '', NULL, 'index', 'index', 'индекс', 'індекс'),
(1858, '', NULL, 'wallet', 'wallet', 'кошелек', 'гаманець'),
(1859, '', NULL, 'one_of_three_step', '1 of 3 steps to complete to access PRO upgrade, features', '1 из 3 шагов, которые нужно выполнить, чтобы получить доступ к обновлению PRO, функции', '1 з 3 кроків, які потрібно виконати, щоб отримати доступ до оновлення PRO, функції'),
(1860, '', NULL, 'two_of_three_step', '2 of 3 steps to complete to access PRO upgrade, features', 'Нужно выполнить 2 из 3 шагов, чтобы получить доступ к обновлению PRO, функции', 'Потрібно виконати 2 з 3 кроків, щоб отримати доступ до оновлення PRO, функції'),
(1861, '', NULL, 'three_of_three_step', '3 of 3 steps to complete to access PRO upgrade, features', 'Требуется выполнить 3 из 3 шагов, чтобы получить доступ к обновлению PRO, функции', 'Потрібно виконати 3 з 3 кроків, щоб отримати доступ до оновлення PRO, функції'),
(1862, '', NULL, 'sign_up', 'Sign Up', 'Зарегистрироваться', 'Зареєструватися'),
(1863, '', NULL, 'let_s_begin_finding_matches', 'Let&#039;s Begin Finding Matches', 'Приступаем к поиску совпадений', 'Починаємо пошук збігів'),
(1864, '', NULL, 'best_dating_website_for_any_age', 'Best dating website for any age', 'Лучший сайт знакомств для любого возраста', 'Найкращий сайт знайомств для будь-якого віку'),
(1865, '', NULL, 'terms_and_conditions', 'Terms and Conditions', 'Условия и положения', 'Умови та положення'),
(1866, '', NULL, 'frequently_asked_questions', 'Frequently Asked Questions', 'Часто задаваемые вопросы', 'Часті запитання'),
(1867, '', NULL, 'follow_us_', 'Follow us!', 'Подписывайтесь на нас!', 'Підписуйтесь на нас!'),
(1868, '', NULL, 'anytime___anywhere', 'Anytime &amp; Anywhere', 'В любое время и в любом месте', 'У будь-який час і в будь-якому місці'),
(1869, '', NULL, 'quick_links', 'Quick Links', 'Быстрые ссылки', 'Швидкі посилання'),
(1870, '', NULL, 'why_quickdate_is_the_best_platform_', 'Why FlirtHab is the best platform?', 'Почему FlirtHab — лучшая платформа?', 'Чому FlirtHab - найкраща платформа?'),
(1871, '', NULL, '100__data_privacy', '100% data privacy', '100% конфиденциальность данных', '100% конфіденційність даних'),
(1872, '', NULL, 'fully_secure___encrypted', 'Fully secure &amp; encrypted', 'Полностью безопасный и зашифрованный', 'Повністю захищені та зашифровані'),
(1873, '', NULL, 'start_dating', 'Start Dating', 'Начните знакомства', 'Почніть знайомства'),
(1874, '', NULL, 'find_your_best_match', 'Find your best match', 'Найдите свою лучшую пару', 'Знайдіть свою найкращу пару'),
(1875, '', NULL, 'how_it_works', 'How it works', 'Как это работает', 'Як це працює'),
(1876, '', NULL, 'create_account', 'Create Account', 'Зарегистрироваться', 'Зарегистрироваться'),
(1877, '', NULL, 'go_premium', 'Go Premium', 'Перейти Premium', 'Перейти до Premium'),
(1878, '', NULL, 'go_live_now', 'Go Live Now', 'Перейти в прямом эфире сейчас', 'Переходьте на прямий ефір зараз'),
(1879, '', NULL, 'story_begins', 'Story Begins', 'История начинается', 'Історія починається'),
(1880, '', NULL, 'search_your_match', 'Search your match', 'Ищите свой вариант', 'Шукайте свій варіант'),
(1881, '', NULL, 'just_for_you', 'Just for you', 'Только для тебя', 'Тільки для тебе'),
(1882, '', NULL, 'apply_filter', 'Apply Filter', 'Применять фильтр', 'Застосувати фільтр'),
(1883, '', NULL, 'other_users___profiles', 'Other users &amp; profiles', 'Другие пользователи и профили', 'Інші користувачі та профілі'),
(1884, '', NULL, 'from', 'from', 'от', 'від'),
(1885, '', NULL, 'visited', 'Visited', 'Посетил', 'Відвідав'),
(1886, '', NULL, 'started', 'Started', 'Начал', 'Почав'),
(1887, '', NULL, 'view_details', 'View Details', 'Посмотреть детали', 'Переглянути деталі'),
(1888, '', NULL, 'price', 'Price', 'Цена', 'Ціна'),
(1889, '', NULL, 'last_update', 'Last Update', 'Последнее обновление', 'Останнє оновлення'),
(1890, '', NULL, 'daily_tribute', 'Daily Tribute', 'Ежедневные бонусы', 'Щоденні бонуси'),
(1891, '', NULL, 'blocked', 'Blocked', 'Заблокировано', 'Заблоковано'),
(1892, '', NULL, 'my_info', 'My Info', 'Моя информация', 'Моя інформація'),
(1893, '', NULL, 'affiliates', 'Affiliates', 'Партнеры', 'Партнери'),
(1894, '', NULL, 'invitation', 'Invitation', 'Приглашение', 'Запрошення'),
(1895, '', NULL, 'two_factor', 'Two Factor', 'Двухфакторный', 'Двофакторний'),
(1896, '', NULL, 'notifications', 'Notifications', 'Уведомления', 'Сповіщення'),
(1897, '', NULL, 'logout_all_sessions', 'Logout all sessions', 'Выйти из всех сеансов', 'Вийдіть з усіх сеансів'),
(1898, '', NULL, 'add_thumbnail', 'Add Thumbnail', 'Добавить миниатюру', 'Додати мініатюру'),
(1899, '', NULL, 'package', 'Package', 'Упаковка', 'Упаковка'),
(1900, '', NULL, 'choose_plan', 'Choose Plan', 'Выберите тарифный план', 'Оберіть тарифний план'),
(1901, '', NULL, 'special', 'Special', 'Специальный', 'Спеціальний'),
(1902, '', NULL, 'yr_age', 'yrs age', 'лет возраст', 'років вік'),
(1903, '', NULL, 'search_blog_you_want...', 'Search for articles', 'Поиск статей', 'Пошук статей'),
(1904, '', NULL, 'articles_of_the_day', 'Articles of the day', 'Статьи дня', 'Статті дня'),
(1905, '', NULL, 'read_now', 'Read Now', 'Прочитай сейчас', 'Читати зараз'),
(1906, '', NULL, 'topic_match_for_you', 'Topics match for you', 'Вам подходят темы', 'Теми підходять для вас'),
(1907, '', NULL, 'continue_reading', 'Continue Reading', 'Продолжить чтение', 'Продовжувати читання'),
(1908, '', NULL, 'more_topic', 'More Topics', 'Больше тем', 'Більше тем'),
(1909, '', NULL, 'we_have_made_it_easy_for_you_to_have_fun_while_you_use_our_quickdate_platform.', 'We have made it easy for you to have fun while you use our FlirtHub platform.', 'Мы сделали все возможное, чтобы вы получали удовольствие от использования нашей платформы FlirtHub.', 'Ми зробили все можливе, щоб ви отримували задоволення від користування нашою платформою FlirtHub.'),
(1910, '', NULL, 'register_your_account_with_quick_and_easy_steps__when_you_finish_you_will_get_a_good_looking_profile.', 'Register your account with quick and easy steps, when you finish you will get a good looking profile.', 'Зарегистрируйте свою учетную запись с помощью быстрых и простых шагов, когда вы закончите, вы получите красивый профиль.', 'Зареєструйте свій обліковий запис за допомогою швидких і простих кроків, після чого ви отримаєте гарний профіль.'),
(1911, '', NULL, 'search___connect_with_matches_which_are_perfect_for_you_to_date__it_s_easy___a_complete_fun.', 'Search &amp; connect with matches which are perfect for you to date, it&#039;s easy &amp; a complete fun.', 'Ищите и связывайтесь с совпадениями, которые идеально подходят для вас на сегодняшний день, это легко и весело.', 'Шукайте та знайомтеся з ідеальними для вас парами, це легко і весело.'),
(1912, '', NULL, 'based_on_your_location__we_find_best_and_suitable_matches_for_you.', 'Based on your location, we find best and suitable matches for you.', 'В зависимости от вашего местоположения мы находим для вас лучшие и подходящие варианты.', 'Виходячи з вашого місцезнаходження, ми знаходимо найкращі та найприйнятніші для вас варіанти.'),
(1913, '', NULL, 'your_account_is_safe_on_quickdate._we_never_share_your_data_with_third_party.', 'Your account is safe on FlirtHub. We never share your data with third party.', 'Ваша учетная запись в безопасности на FlirtHub. Мы никогда не передаем ваши данные третьим лицам.', 'Ваш обліковий запис в безпеці на FlirtHub. Ми ніколи не передаємо ваші дані третім особам.'),
(1914, '', NULL, 'you_have_full_control_over_your_personal_information_that_you_share.', 'You have full control over your personal information that you share.', 'У вас есть полный контроль над вашей личной информацией, которой вы делитесь.', 'У вас є повний контроль над вашою особистою інформацією, якою ви ділитеся.'),
(1915, '', NULL, 'always_up_to_date_with_our_latest_offers_and_discounts_', 'Always up to date with our latest offers and discounts!', 'Всегда в курсе наших последних предложений и скидок!', 'Завжди в курсі наших останніх пропозицій та знижок!'),
(1916, '', NULL, 'join_quickdate__where_you_could_meet_anyone__anywhere__it_s_a_complete_fun_to_find_a_perfect_match_for_you_and_continue_to_hook_up', 'Join FlirtHub, where you could meet anyone, anywhere! It&#039;s a complete fun to find a perfect match for you and continue to hook up.', 'Присоединяйтесь к FlirtHub, где вы можете встретить кого угодно и где угодно! Найти идеальную пару для себя и продолжить знакомство – это сплошное удовольствие.', 'Приєднуйтесь до FlirtHub, де ви можете зустріти кого завгодно і де завгодно! Знайти ідеальну пару для себе і продовжити знайомство - це суцільне задоволення.'),
(1917, '', NULL, 'quickdate__where_you_could_meet_anyone_digitally__it_s_a_complete_fun_to_find_a_perfect_match_for_you_and_continue_to_hook_up._real_time_messaging___lot_of_features_that_keeps_you_connected_with_your_love_24x365_days.', 'FlirtHub, where you could meet anyone digitally! It&#039;s a complete fun to find a perfect match for you and continue to hook up. Real time messaging &amp; lot of features that keeps you connected with your love 24x365 days.', 'FlirtHub, где вы могли познакомиться с кем-либо в цифровом формате! Найти идеальную пару и продолжить знакомство – это сплошное удовольствие. Обмен сообщениями в реальном времени и множество функций, позволяющих вам оставаться на связи с любимым человеком 24x365 дней.', 'FlirtHub, де ви могли познайомитися з будь-ким у цифровому форматі! Знайти ідеальну пару та продовжити знайомство - це суцільне задоволення. Обмін повідомленнями в реальному часі та безліч функцій, які дозволять вам залишатися на зв&#039;язку з коханою людиною 24x365 днів.'),
(1918, '', NULL, 'age_block_text', 'You are under 18 you can&#039;t access this site for {hour} hour(s).', 'Вам меньше 18 лет, вы не можете получить доступ к этому сайту в течение {hour} часов.', 'Якщо вам менше 18 років, ви не зможете отримати доступ до цього сайту протягом {hour} години(-ів).'),
(1919, '', NULL, 'age_block_extra', 'Please note that if you are under 18, you won&#039;t be able to access this site.', 'Обратите внимание, что если вам меньше 18 лет, вы не сможете получить доступ к этому сайту.', 'Зверніть увагу, що якщо вам не виповнилося 18 років, ви не зможете отримати доступ до цього сайту.'),
(1920, '', NULL, 'age_block_modal', 'Are you 18 years old or above?', 'Вам 18 лет или больше?', 'Вам 18 років або більше?'),
(1921, '', NULL, 'nopop', 'No', 'Нет', 'Ні'),
(1922, '', NULL, 'yes', 'Yes', 'Да', 'Так'),
(1923, '', NULL, 'disallowed_username', 'This username is not allowed, please choose another username.', 'Это имя пользователя не разрешено, пожалуйста, выберите другое имя пользователя.', 'Це ім&#039;я користувача не дозволено, будь ласка, оберіть інше ім&#039;я користувача.'),
(1924, '', NULL, 'skrill', 'Skrill', 'Скрилл', 'Скрилл'),
(1925, '', NULL, 'transfer_to', 'Transfer to', 'Передать', 'Переведіть на'),
(1926, '', NULL, 'please_select_payment_method', 'Please select a payment method', 'Пожалуйста, выберите способ оплаты', 'Будь ласка, оберіть спосіб оплати'),
(1927, '', NULL, 'times', 'times', 'раз', 'разів'),
(1928, '', NULL, 'no_currently_live', 'No users are currently live', 'Нет активных пользователей', 'Наразі немає активних користувачів'),
(1929, '', NULL, 'go_premium', 'Go Premium', 'Перейти Премиум', 'Перейти до Premium'),
(1930, '', NULL, 'successfully_subscribed', 'Successfully subscribed', 'Успешная подписка', 'Успішна підписка'),
(1931, '', NULL, 'already_subscribed', 'Already subscribed', 'Уже подписан', 'Вже підписаний'),
(1932, '', NULL, 'please_check_recaptcha', 'Please check recaptcha', 'Пожалуйста, проверьте recaptcha', 'Будь ласка, перевірте recaptcha'),
(1933, '', NULL, 'reCaptcha_error', 'reCaptcha error', 'ошибка reCaptcha', 'Помилка reCaptcha'),
(1934, '', NULL, 'confirmation_code_sent', 'We have sent you the confirmation code', 'Мы отправили вам код подтверждения', 'Ми надіслали вам код підтвердження'),
(1935, '', NULL, 'view_no_more_to_show', 'No more users to show, update your filters to view more.', 'Нет больше пользователей для отображения, обновите фильтры, чтобы увидеть больше.', 'Немає більше користувачів для показу, оновіть фільтри, щоб переглянути більше.'),
(1936, '', NULL, 'please_enable_location', 'Please enable your location in your browser settings to list poeple nearby.', 'Включите свое местоположение в настройках браузера, чтобы отображать людей поблизости.', 'Будь ласка, увімкніть ваше місцезнаходження в налаштуваннях вашого браузера, щоб побачити список людей поблизу.'),
(1937, '', NULL, 'unlock_private_video_payment', 'Unlock Private Video Feature', 'Разблокировать функцию приватного видео', 'Розблокувати функцію приватного відео'),
(1938, '', NULL, 'to_unlock_private_video_feature_in_your_account__you_have_to_pay', 'To unlock private video feature in your account, you can purchase it.', 'Чтобы разблокировать функцию приватного видео в своей учетной записи, вы можете приобрести ее.', 'Щоб розблокувати функцію приватного відео у своєму акаунті, ви можете придбати її.'),
(1939, '', NULL, 'you_have_to_match_with_media', 'You have to match with {X} to view their hidden photos and videos.', 'Вы должны сопоставить с {X}, чтобы просмотреть их скрытые фотографии и видео.', 'Щоб переглянути їхні приховані фото та відео, ви маєте збігтися з {X}.'),
(1940, '', NULL, 'all_countries', 'All countries', 'Все страны', 'Усі країни'),
(1941, '', NULL, 'located_at', 'located at', 'находится в', 'знаходиться в'),
(1942, '', NULL, 'match_ignore', 'Ignore', 'Игнорировать', 'Ігнорувати'),
(1943, '', NULL, 'match_ignore', 'Ignore', 'Игнорировать', 'Ігнорувати'),
(1944, '', NULL, 'meet', 'Meet', 'Знакомьтесь', 'Знайомтеся'),
(1945, '', NULL, 'new_and_interesting', 'new and interesting', 'новое и интересное', 'нове та цікаве'),
(1946, '', NULL, 'people.', 'people.', 'люди.', 'люди.'),
(1947, '', NULL, 'join_quickdate__where_you_could_meet_anyone__anywhere__it_s_a_complete_fun_to_find_a_perfect_match_for_you_and_continue_to_hook_up.', 'Join FlirtHub, where you could meet anyone, anywhere! It\\&#039;s a complete fun to find a perfect match for you and continue to hook up.', 'Присоединяйтесь к FlirtHub, где вы можете встретить кого угодно и где угодно! Найти идеальную пару для себя и продолжить знакомство – это полное наслаждение.', 'Приєднуйтесь до FlirtHub, де ви можете зустріти кого завгодно і де завгодно! Знайти ідеальну пару для себе і продовжити знайомство - це цілковита насолода.'),
(1948, '', NULL, 'interact_using_our_user_friendly_platform__initiate_conversations_in_mints._date_your_best_matches.', 'Interact using our user friendly platform, Initiate conversations in mints. Date your best matches.', 'Общайтесь с помощью нашей удобной платформы, начинайте разговоры в матчах. Назначайте свидание своим лучшим собеседникам.', 'Спілкуйтеся за допомогою нашої зручної платформи, розпочинайте розмови в матчах. Призначайте побачення своїм найкращим співрозмовникам.'),
(1949, '', NULL, 'hi_', 'Hi,', 'Привет,', 'Привіт,'),
(1950, '', NULL, 'visitors', 'Visitors', 'Посетители', 'Відвідувачі'),
(1951, '', NULL, 'steps', 'steps', 'шаги', 'кроки'),
(1952, '', NULL, 'pro', 'pro', 'pro', 'pro'),
(1953, '', 'ukrainian', 'ukrainian', 'ukrainian', 'украинский', 'українська'),
(1956, '', 'ukrainian', 'ukrainian', 'ukrainian', 'украинский', 'українська'),
(1957, '', 'Ukraine', 'Ukraine', 'Ukraine', 'Украина', 'Україна'),
(1959, '', 'ukrainian', 'ukrainian', 'ukrainian', 'украинский', 'українська'),
(1960, '', 'portuguese', 'portuguese', 'portuguese', 'portuguese', 'Португальська'),
(1961, '', 'Ukraine', 'Ukraine', 'Ukraine', 'Украина', 'Україна'),
(1962, '', 'ukrainian', 'ukrainian', 'ukrainian', 'украинский', 'українська'),
(1964, '', 'ukrainian', 'ukrainian', 'ukrainian', 'украинский', 'українська'),
(1965, '', 'ukrainian', 'ukrainian', 'ukrainian', 'украинский', 'українська'),
(1966, '', 'dutch', 'dutch', 'dutch', 'dutch', ''),
(1967, '', 'turkish', 'turkish', 'turkish', 'turkish', ''),
(1968, '', NULL, 'english', 'english', 'английский', 'англійська'),
(1969, '', 'ukrainian', 'ukrainian', 'ukrainian', 'украинский', 'українська'),
(1970, '', 'belorussian', 'belorussian', 'belorussian', 'belorussian', ''),
(1971, '', NULL, 'english', 'english', 'английский', 'англійська');

-- --------------------------------------------------------

--
-- Структура таблицы `likes`
--

CREATE TABLE `likes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `like_userid` int UNSIGNED DEFAULT '0',
  `is_like` int UNSIGNED DEFAULT '0',
  `is_dislike` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `like_userid`, `is_like`, `is_dislike`, `created_at`) VALUES
(1, 3, 2, 0, 1, '2024-06-10 21:31:48'),
(2, 105, 104, 0, 1, '2024-06-11 16:34:20'),
(3, 105, 102, 0, 1, '2024-06-11 16:34:22'),
(4, 105, 100, 0, 1, '2024-06-11 16:34:26'),
(5, 105, 98, 0, 1, '2024-06-11 16:34:28'),
(6, 105, 96, 0, 1, '2024-06-11 16:34:29'),
(7, 105, 94, 0, 1, '2024-06-11 16:34:31'),
(8, 106, 2, 1, 0, '2024-06-11 17:19:27'),
(9, 106, 92, 1, 0, '2024-06-11 17:19:59'),
(13, 1, 2, 1, 0, '2024-06-13 08:41:55'),
(14, 109, 108, 0, 1, '2024-06-13 11:28:37'),
(15, 109, 104, 0, 1, '2024-06-13 11:28:39'),
(16, 109, 102, 0, 1, '2024-06-13 11:29:10'),
(17, 109, 100, 1, 0, '2024-06-13 11:29:15'),
(18, 109, 99, 0, 1, '2024-06-13 11:29:18'),
(19, 109, 97, 1, 0, '2024-06-13 11:29:24'),
(20, 109, 96, 0, 1, '2024-06-13 11:29:29'),
(21, 109, 95, 1, 0, '2024-06-13 11:29:33'),
(22, 2, 1, 1, 0, '2024-06-13 12:38:15'),
(23, 1, 109, 0, 1, '2024-06-15 12:06:02'),
(24, 2, 109, 1, 0, '2024-06-15 13:37:43'),
(25, 2, 105, 0, 1, '2024-06-15 13:39:26'),
(26, 2, 104, 0, 1, '2024-06-15 13:40:22'),
(27, 106, 109, 0, 1, '2024-06-15 13:41:27'),
(28, 106, 101, 0, 1, '2024-06-15 13:41:33'),
(29, 106, 96, 1, 0, '2024-06-15 13:42:25'),
(30, 106, 95, 1, 0, '2024-06-15 13:42:30'),
(31, 106, 102, 1, 0, '2024-06-17 11:19:29'),
(32, 2, 106, 1, 0, '2024-06-18 06:13:59'),
(33, 112, 97, 1, 0, '2024-06-18 08:36:44'),
(35, 115, 1, 1, 0, '2025-01-12 20:42:39'),
(36, 115, 101, 1, 0, '2025-01-13 17:24:48'),
(37, 115, 100, 1, 0, '2025-01-13 17:24:50'),
(38, 115, 104, 1, 0, '2025-01-17 09:57:06'),
(39, 115, 103, 1, 0, '2025-01-17 09:57:07'),
(40, 115, 102, 1, 0, '2025-01-17 09:57:08'),
(43, 115, 116, 1, 0, '2025-01-17 10:07:09'),
(44, 116, 115, 1, 0, '2025-01-17 10:07:46'),
(45, 115, 73, 0, 1, '2025-01-17 10:10:52'),
(46, 115, 70, 0, 1, '2025-01-17 10:10:53'),
(47, 115, 71, 0, 1, '2025-01-17 10:10:54'),
(48, 115, 80, 0, 1, '2025-01-17 10:10:55'),
(49, 115, 78, 0, 1, '2025-01-17 10:10:56'),
(50, 115, 74, 0, 1, '2025-01-17 10:10:57'),
(51, 115, 68, 0, 1, '2025-01-17 10:10:57'),
(52, 115, 110, 1, 0, '2025-01-17 10:29:10'),
(53, 115, 93, 0, 1, '2025-01-17 10:29:20'),
(54, 115, 97, 1, 0, '2025-01-17 10:30:22'),
(55, 115, 91, 1, 0, '2025-01-17 10:30:23');

-- --------------------------------------------------------

--
-- Структура таблицы `live_sub_users`
--

CREATE TABLE `live_sub_users` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `post_id` int NOT NULL DEFAULT '0',
  `is_watching` int NOT NULL DEFAULT '0',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `mediafiles`
--

CREATE TABLE `mediafiles` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `file` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `is_private` int UNSIGNED DEFAULT '0',
  `private_file` varchar(250) COLLATE utf8mb4_general_ci DEFAULT '',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_video` int UNSIGNED DEFAULT '0',
  `video_file` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '',
  `is_confirmed` int UNSIGNED DEFAULT '0',
  `is_approved` int UNSIGNED DEFAULT '1',
  `instagram_post_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `mediafiles`
--

INSERT INTO `mediafiles` (`id`, `user_id`, `file`, `is_private`, `private_file`, `created_at`, `is_video`, `video_file`, `is_confirmed`, `is_approved`, `instagram_post_id`) VALUES
(1, 2, 'upload/photos/2024/06/HnKGpuY1R9yJ2ukqldtw_full.jpeg', 0, '', '2024-06-10 16:42:39', 0, '', 0, 1, '0'),
(2, 3, 'upload/photos/2024/06/m8abStK7y2OQVZF6eA9j_full.jpg', 0, '', '2024-06-10 21:29:55', 0, '', 0, 1, '0'),
(3, 4, 'upload/photos/2024/06/ghkzvcumx5bMvKqZwHR6_full.jpg', 0, '', '2024-06-11 07:43:18', 0, '', 0, 1, '0'),
(4, 105, 'upload/photos/2024/06/cyhJaGoLmjK351YjPhhV_full.jpg', 0, '', '2024-06-11 16:30:12', 0, '', 0, 1, '0'),
(5, 106, 'upload/photos/2024/06/v5XQvwoCuyu6kP2eatXW_full.jpg', 0, '', '2024-06-11 17:06:18', 0, '', 0, 1, '0'),
(6, 106, '', 0, '', '2024-06-11 17:08:10', 1, 'upload/videos/2024/06/H9JMYmIGwcbzLXKh8gwj.mp4', 0, 1, '0'),
(8, 106, '', 0, '', '2024-06-11 17:09:33', 1, 'upload/videos/2024/06/SdZbM4kQENAgsuACQLW8.mp4', 0, 1, '0'),
(9, 106, '', 0, '', '2024-06-11 17:09:33', 1, 'upload/videos/2024/06/lBh1GtW145KpFaUcaXHX.mp4', 0, 1, '0'),
(10, 106, 'upload/photos/2024/06/VXaaMZg4YYpYENrp6vJW.jpg', 0, '', '2024-06-11 17:09:33', 1, 'upload/videos/2024/06/tjX2aTCWISQiZyqnb9xE.mp4', 1, 1, '0'),
(12, 108, 'upload/photos/2024/06/rXJLu4QvIt1CPcBrUpDx_full.jpeg', 0, '', '2024-06-12 07:54:52', 0, '', 0, 1, '0'),
(13, 109, 'upload/photos/2024/06/uRTAz1AxgxUoatpkfcje_full.jpg', 0, '', '2024-06-13 11:25:58', 0, '', 0, 1, '0'),
(14, 110, 'upload/photos/2024/06/dfaVaRA1fHQXIrDsgPaU_full.jpg', 0, '', '2024-06-14 10:05:55', 0, '', 0, 1, '0'),
(15, 110, 'upload/photos/2024/06/8B27bJdWwBPCgjoAzfYw_full.jpg', 0, '', '2024-06-14 10:05:56', 0, '', 0, 1, '0'),
(16, 111, 'upload/photos/2024/06/oN2rt99WEwTdxP5MUIQD_full.jpg', 0, '', '2024-06-14 18:52:25', 0, '', 0, 1, '0'),
(17, 111, 'upload/photos/2024/06/6EJPxxeIQdwfnagnevDZ_full.jpg', 0, '', '2024-06-14 18:53:26', 0, '', 0, 1, '0'),
(18, 112, 'upload/photos/2024/06/XWDPcnyyz2pf1CvjRB4X_full.jpg', 0, '', '2024-06-18 08:35:26', 0, '', 0, 1, '0'),
(21, 94, 'upload/photos/2025/01/qXaWnc19JdyOCp54nKLz_full.jpg', 0, '', '2025-01-13 17:26:53', 0, '', 0, 1, '0'),
(22, 94, 'upload/photos/2025/01/cj6D96jm4OOifgbRyszq_full.jpg', 0, '', '2025-01-13 17:27:08', 0, '', 0, 1, '0'),
(24, 115, 'upload/photos/2025/01/Sety3viUGfKuuUz1sWaZ_full.png', 0, '', '2025-01-14 15:48:48', 0, '', 0, 1, '0'),
(25, 115, 'upload/photos/2025/01/GVQA9OdyWWiSZnJE1AyO_full.png', 0, '', '2025-01-14 15:49:03', 0, '', 0, 1, '0'),
(26, 115, 'upload/photos/2025/01/HqrStEJhWATS4Rr9K4UN_full.png', 0, '', '2025-01-14 15:49:06', 0, '', 0, 1, '0');

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int NOT NULL,
  `from` int NOT NULL DEFAULT '0',
  `from_delete` int DEFAULT '0',
  `to` int NOT NULL DEFAULT '0',
  `to_delete` int DEFAULT '0',
  `text` text COLLATE utf8mb4_general_ci,
  `media` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '',
  `sticker` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '',
  `seen` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `from`, `from_delete`, `to`, `to_delete`, `text`, `media`, `sticker`, `seen`, `created_at`) VALUES
(1, 1, 0, 105, 0, 'джлждлж🤠джлждлж', NULL, NULL, 0, '2024-06-13 10:09:38'),
(2, 1, 0, 105, 0, 'ысвымсмс', NULL, NULL, 0, '2024-06-13 10:09:45'),
(3, 1, 0, 105, 0, 'орпорпо <br>😶', NULL, NULL, 0, '2024-06-13 10:09:55'),
(4, 106, 0, 110, 0, 'привет', NULL, NULL, 0, '2024-06-14 17:45:48'),
(5, 1, 1, 110, 0, 'mn nm nm mn nm nm', NULL, NULL, 0, '2024-06-17 14:08:13'),
(6, 1, 1, 110, 0, 'lkj;lkj;', NULL, NULL, 0, '2024-06-17 14:08:20'),
(7, 1, 1, 110, 0, 'bhnbn', NULL, NULL, 0, '2024-06-18 05:44:25'),
(8, 106, 0, 110, 0, NULL, 'upload/chat/2024/06/kxfReONfiIkWdvzZs1gL_m.jpg', '', 0, '2024-06-18 05:53:17'),
(9, 1, 0, 105, 0, 'cvsdvdcv', NULL, NULL, 0, '2024-06-18 05:56:14'),
(10, 1, 0, 105, 0, NULL, 'upload/chat/2024/06/bwxbizBSBacWKwKJakdI_m.jpg', '', 0, '2024-06-18 05:56:27'),
(11, 2, 1, 1, 0, 'привет', NULL, NULL, 1718691722, '2024-06-18 06:07:38'),
(12, 2, 1, 1, 0, NULL, 'upload/chat/2024/06/dZkAW3KT3KsIw4UNKx5W_m.jpeg', '', 1718691722, '2024-06-18 06:07:53'),
(13, 2, 1, 1, 0, NULL, 'upload/chat/2024/06/Ng7ATBcmZLo6xceiilV4_m.jpeg', '', 1718691722, '2024-06-18 06:08:03'),
(14, 2, 1, 1, 0, '⛳', NULL, NULL, 1718691722, '2024-06-18 06:09:00'),
(15, 106, 0, 110, 0, NULL, 'upload/chat/2024/06/vTuBZeZjmRUkdiFYBFa3_m.jpg', '', 0, '2024-06-18 06:11:19'),
(16, 106, 0, 2, 0, NULL, 'upload/chat/2024/06/D5eDu6JJw6TQtsMYB3WY_m.jpg', '', 0, '2024-06-18 06:13:10'),
(17, 1, 0, 2, 0, '👍', NULL, NULL, 1718692283, '2024-06-18 06:22:22'),
(18, 1, 0, 2, 0, 'эти картинки копятся у нас на сервере', NULL, NULL, 1718692283, '2024-06-18 06:23:42'),
(19, 1, 0, 2, 0, 'плохо что нельзя увидеть, прочитал ты сообщение или нет', NULL, NULL, 1718692283, '2024-06-18 06:24:31'),
(20, 2, 0, 1, 0, 'еу так в жтом и фишка) купи прем и будешь видеть', NULL, NULL, 1718694386, '2024-06-18 06:32:17'),
(21, 2, 0, 1, 0, 'ну будет место занимать на сервере', NULL, NULL, 1718694386, '2024-06-18 06:32:41'),
(22, 1, 0, 2, 0, 'а видно кстати что ты просмотрел', NULL, NULL, 1718695985, '2024-06-18 07:20:49'),
(23, 2, 0, 1, 0, 'а ну тогда и так сойдет) а особенно прикольно когла в тг увидомления будут призодить', NULL, NULL, 1718698681, '2024-06-18 07:33:48'),
(24, 1, 0, 105, 0, 'олборбьо', NULL, NULL, 0, '2024-06-19 09:59:51'),
(25, 115, 1, 1, 0, ',jk,j', NULL, NULL, 0, '2025-01-12 20:42:56'),
(26, 115, 1, 1, 0, NULL, 'upload/chat/2025/01/TS3t2wf4bPsHWoFJtw6R_m.png', '', 0, '2025-01-12 20:43:03'),
(27, 115, 1, 1, 0, NULL, 'upload/chat/2025/01/e3JBc48LG7tn84jrhLIm_m.jpg', '', 0, '2025-01-12 20:43:14'),
(28, 115, 1, 1, 0, NULL, 'upload/chat/2025/01/kwG8EhhFKz5hxY5Bu9u9_m.jpg', '', 0, '2025-01-12 20:45:46'),
(29, 115, 0, 116, 0, '', 'https://media0.giphy.com/media/IMDSOJvLn9RaU/200.gif', NULL, 1737108420, '2025-01-17 10:06:52'),
(30, 116, 0, 115, 0, '🤩', NULL, NULL, 1737108443, '2025-01-17 10:07:19');

-- --------------------------------------------------------

--
-- Структура таблицы `notifications`
--

CREATE TABLE `notifications` (
  `id` int UNSIGNED NOT NULL,
  `notifier_id` int UNSIGNED NOT NULL DEFAULT '0',
  `recipient_id` int UNSIGNED NOT NULL DEFAULT '0',
  `seen` int UNSIGNED DEFAULT '0',
  `type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `text` varchar(250) COLLATE utf8mb4_general_ci DEFAULT '',
  `url` varchar(150) COLLATE utf8mb4_general_ci DEFAULT '',
  `full_url` varchar(150) COLLATE utf8mb4_general_ci DEFAULT '',
  `push_sent` int UNSIGNED DEFAULT '0',
  `created_at` int UNSIGNED DEFAULT '0',
  `admin` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `notifications`
--

INSERT INTO `notifications` (`id`, `notifier_id`, `recipient_id`, `seen`, `type`, `text`, `url`, `full_url`, `push_sent`, `created_at`, `admin`) VALUES
(1, 1, 94, 0, 'visit', '', '/@admin', '', 0, 1718096980, 0),
(2, 1, 3, 0, 'visit', '', '/@admin', '', 0, 1718098414, 0),
(3, 2, 103, 0, 'visit', '', '/@after_dark', '', 0, 1718120549, 0),
(4, 1, 55, 0, 'visit', '', '/@admin', '', 0, 1718125336, 0),
(5, 1, 84, 0, 'visit', '', '/@admin', '', 0, 1718125348, 0),
(6, 1, 83, 0, 'visit', '', '/@admin', '', 0, 1718125361, 0),
(7, 106, 92, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718126396, 0),
(13, 108, 93, 0, 'visit', '', '/@Qwerty', '', 0, 1718179662, 0),
(14, 108, 93, 0, 'friend_request', '', '/@Qwerty', '', 0, 1718179682, 0),
(15, 108, 82, 0, 'visit', '', '/@Qwerty', '', 0, 1718179704, 0),
(32, 1, 2, 1718277338, 'send_gift', '', '/@admin/opengift/2', '', 0, 1718268142, 0),
(35, 1, 105, 0, 'message', '', '/@admin/chat_request', '', 0, 1718273378, 0),
(37, 1, 97, 0, 'visit', '', '/@admin', '', 0, 1718273965, 0),
(38, 1, 97, 0, 'friend_request', '', '/@admin', '', 0, 1718273967, 0),
(39, 1, 103, 0, 'visit', '', '/@admin', '', 0, 1718273978, 0),
(40, 1, 103, 0, 'friend_request', '', '/@admin', '', 0, 1718273979, 0),
(47, 2, 1, 1718350155, 'got_new_match', '', '/@after_dark', '', 0, 1718282295, 0),
(48, 1, 2, 1718282300, 'got_new_match', '', '/@admin', '', 0, 1718282295, 0),
(49, 2, 1, 1718350155, 'like', '', '/@after_dark', '', 0, 1718282295, 0),
(51, 106, 110, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718387136, 0),
(52, 106, 110, 0, 'message', '', '/@Kolomoyskiy/chat_request', '', 0, 1718387148, 0),
(56, 2, 105, 0, 'visit', '', '/@after_dark', '', 0, 1718458765, 0),
(57, 2, 104, 0, 'visit', '', '/@after_dark', '', 0, 1718458774, 0),
(59, 106, 95, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718458948, 0),
(61, 2, 108, 0, 'visit', '', '/@after_dark', '', 0, 1718558572, 0),
(62, 106, 103, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718622036, 0),
(63, 106, 108, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718622056, 0),
(64, 106, 104, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718622113, 0),
(66, 106, 102, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718622194, 0),
(70, 1, 105, 0, 'visit', '', '/@admin', '', 0, 1718631112, 0),
(72, 106, 93, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718632042, 0),
(76, 1, 110, 0, 'message', '', '/@admin/chat_request', '', 0, 1718633293, 0),
(79, 1, 2, 1718636371, 'friend_request', '', '/@admin', '', 0, 1718633464, 0),
(82, 1, 2, 1718641094, 'friend_request_accepted', '', '/@admin', '', 0, 1718636375, 0),
(83, 2, 1, 1718636382, 'friend_request_accepted', '', '/@after_dark', '', 0, 1718636375, 0),
(86, 106, 105, 0, 'visit', '', '/@Kolomoyskiy', '', 0, 1718654650, 0),
(87, 1, 108, 0, 'visit', '', '/@admin', '', 0, 1718689577, 0),
(89, 2, 1, 1718691761, 'visit', '', '/@after_dark', '', 0, 1718690848, 0),
(91, 2, 110, 0, 'visit', '', '/@after_dark', '', 0, 1718690957, 0),
(92, 106, 1, 1718691761, 'visit', '', '/@Kolomoyskiy', '', 0, 1718691164, 0),
(93, 106, 2, 1718691233, 'visit', '', '/@Kolomoyskiy', '', 0, 1718691181, 0),
(94, 2, 106, 0, 'visit', '', '/@after_dark', '', 0, 1718691235, 0),
(95, 2, 106, 0, 'got_new_match', '', '/@after_dark', '', 0, 1718691239, 0),
(96, 106, 2, 1718691241, 'got_new_match', '', '/@Kolomoyskiy', '', 0, 1718691239, 0),
(97, 1, 2, 1718692368, 'accept_chat_request', '', '/@admin/chat_request', '', 0, 1718691724, 0),
(98, 1, 2, 1718692368, 'visit', '', '/@admin', '', 0, 1718691756, 0),
(99, 1, 110, 0, 'visit', '', '/@admin', '', 0, 1718791340, 0),
(101, 115, 1, 0, 'like', '', '/@flirthub', '', 0, 1736714559, 0),
(102, 115, 1, 0, 'message', '', '/@flirthub/chat_request', '', 0, 1736714576, 0),
(103, 115, 1, 0, 'visit', '', '/@flirthub', '', 0, 1736717461, 0),
(104, 115, 102, 0, 'visit', '', '/@flirthub', '', 0, 1736789092, 0),
(105, 115, 94, 0, 'visit', '', '/@flirthub', '', 0, 1736789200, 0),
(109, 115, 110, 0, 'visit', '', '/@flirthub', '', 0, 1736907956, 0),
(110, 115, 111, 0, 'visit', '', '/@flirthub', '', 0, 1736978474, 0),
(112, 115, 116, 1737108376, 'visit', '', '/@flirthub', '', 0, 1737108366, 0),
(113, 116, 115, 1737108385, 'visit', '', '/@Yevhen', '', 0, 1737108379, 0),
(115, 116, 115, 1737108433, 'accept_chat_request', '', '/@Yevhen/chat_request', '', 0, 1737108421, 0),
(116, 116, 115, 1737108482, 'got_new_match', '', '/@Yevhen', '', 0, 1737108466, 0),
(117, 115, 116, 0, 'got_new_match', '', '/@flirthub', '', 0, 1737108466, 0),
(118, 116, 115, 1737108482, 'like', '', '/@Yevhen', '', 0, 1737108466, 0),
(119, 115, 97, 0, 'visit', '', '/@flirthub', '', 0, 1737109678, 0),
(120, 115, 91, 0, 'visit', '', '/@flirthub', '', 0, 1737109734, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `options`
--

CREATE TABLE `options` (
  `id` bigint UNSIGNED NOT NULL,
  `option_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `option_value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `options`
--

INSERT INTO `options` (`id`, `option_name`, `option_value`, `created_at`) VALUES
(1, 'load_config_in_session', '0', '2018-11-04 21:00:00'),
(2, 'meta_description', 'FlirtHub - лучший сайт знакомств в мире. Общайтесь с местными одиночками и начните свое приключение в сети! Наслаждайтесь знакомствами по всему миру с захватывающим онлайн-чатом и многим другим.', '2018-11-04 21:00:00'),
(3, 'meta_keywords', 'Lorem Ipsum - это просто фиктивный текст, используемый в полиграфии и типографском деле.', '2018-11-04 21:00:00'),
(4, 'default_title', 'FlirtHub', '2018-11-04 21:00:00'),
(5, 'site_name', 'FlirtHub', '2018-11-04 21:00:00'),
(6, 'default_language', 'ukrainian', '2018-11-04 21:00:00'),
(7, 'smtp_or_mail', 'mail', '2018-11-04 21:00:00'),
(8, 'smtp_host', '', '2018-11-04 21:00:00'),
(9, 'smtp_username', '', '2018-11-04 21:00:00'),
(10, 'smtp_password', '0c1we99wibOICT00aiqECA==', '2018-11-04 21:00:00'),
(11, 'smtp_encryption', 'ssl', '2018-11-04 21:00:00'),
(12, 'smtp_port', '', '2018-11-04 21:00:00'),
(13, 'siteEmail', 'admin@spinchat.space', '2018-11-04 21:00:00'),
(14, 'theme', 'todate', NULL),
(15, 'AllLogin', '0', '2018-11-04 21:00:00'),
(16, 'googleLogin', '0', '2018-11-04 21:00:00'),
(17, 'facebookLogin', '0', '2018-11-04 21:00:00'),
(18, 'twitterLogin', '0', '2018-11-04 21:00:00'),
(19, 'linkedinLogin', '0', '2018-11-04 21:00:00'),
(20, 'VkontakteLogin', '0', '2018-11-04 21:00:00'),
(21, 'facebookAppId', '', '2018-11-04 21:00:00'),
(22, 'facebookAppKey', '', '2018-11-04 21:00:00'),
(23, 'googleAppId', '', '2018-11-04 21:00:00'),
(24, 'googleAppKey', '', '2018-11-04 21:00:00'),
(25, 'twitterAppId', '', '2018-11-04 21:00:00'),
(26, 'twitterAppKey', '', '2018-11-04 21:00:00'),
(27, 'linkedinAppId', '', '2018-11-04 21:00:00'),
(28, 'linkedinAppKey', '', '2018-11-04 21:00:00'),
(29, 'VkontakteAppId', '', '2018-11-04 21:00:00'),
(30, 'VkontakteAppKey', '', '2018-11-04 21:00:00'),
(31, 'instagramAppId', '', '2018-11-04 21:00:00'),
(32, 'instagramAppkey', '', '2018-11-04 21:00:00'),
(33, 'instagramLogin', '1', '2018-11-04 21:00:00'),
(34, 'sms_or_email', 'mail', '2018-11-09 08:28:39'),
(37, 'sms_phone_number', '', '2018-11-04 21:00:00'),
(38, 'paypal_id', '', '2018-11-09 08:36:37'),
(39, 'paypal_secret', '', '2018-11-09 08:36:49'),
(40, 'paypal_mode', 'sandbox', '2018-11-09 08:36:09'),
(41, 'currency', 'USD', '2018-11-09 09:57:45'),
(42, 'last_backup', '00-00-0000', NULL),
(44, 'amazone_s3', '0', '2018-11-09 08:43:47'),
(45, 'bucket_name', '', '2018-11-09 08:44:13'),
(46, 'amazone_s3_key', '', '2018-11-09 08:44:34'),
(47, 'amazone_s3_s_key', '', '2018-11-09 08:44:51'),
(48, 'region', 'us-east-1', '2018-11-09 08:45:22'),
(50, 'sms_t_phone_number', '', '2018-11-04 21:00:00'),
(52, 'sms_twilio_username', '', '2018-11-04 21:00:00'),
(53, 'sms_twilio_password', '', '2018-11-04 21:00:00'),
(54, 'sms_provider', 'twilio', NULL),
(55, 'profile_picture_width_crop', '400', '2018-11-09 10:04:07'),
(56, 'profile_picture_height_crop', '400', '2018-11-09 10:04:09'),
(57, 'userDefaultAvatar', 'upload/photos/d-avatar.jpg', '2018-11-09 10:08:31'),
(58, 'profile_picture_image_quality', '80', '2018-11-09 10:10:08'),
(59, 'emailValidation', '0', '2018-11-09 08:28:58'),
(60, 'stripe_secret', '', '2018-11-09 08:35:37'),
(61, 'stripe_id', '', '2018-11-09 08:35:52'),
(62, 'push_id', 'f799dc13-ec22-4d1f-9306-b9fbde7d6106', NULL),
(63, 'push_key', 'NWFjODkxZDQtYWRhYy00NTJiLTlmYTItMmEwNmIwYWZlMTcx', NULL),
(64, 'push_id_2', NULL, NULL),
(65, 'push_key_2', NULL, NULL),
(68, 'terms', '                <h4>1- Write your Terms Of Use here.</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n                <br>\n                <h4>2- Random title</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', NULL),
(69, 'about', '                <h4>1- Write your About us here.</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n                <br>\n                <h4>2- Random title</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', NULL),
(70, 'privacy_policy', '                <h4>1- Write your Privacy Policy here.</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n                <br>\n                <h4>2- Random title</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', NULL),
(71, 'facebook_url', 'http://facebook.com', '2018-11-09 09:42:51'),
(72, 'twitter_url', 'http://twitter.com', '2018-11-09 09:42:53'),
(73, 'google_url', 'http://google.com', '2018-11-09 09:42:53'),
(74, 'currency_symbol', '$', '2018-11-09 09:18:29'),
(75, 'bag_of_credits_price', '50', '2018-11-09 09:12:55'),
(76, 'bag_of_credits_amount', '1000', '2018-11-09 09:13:00'),
(77, 'box_of_credits_price', '100', '2018-11-09 09:12:57'),
(78, 'box_of_credits_amount', '5000', '2018-11-09 09:13:01'),
(79, 'chest_of_credits_price', '150', '2018-11-09 09:13:03'),
(80, 'chest_of_credits_amount', '10000', '2018-11-09 09:13:05'),
(81, 'weekly_pro_plan', '8', '2018-11-09 09:13:07'),
(82, 'monthly_pro_plan', '25', '2018-11-09 09:24:48'),
(83, 'yearly_pro_plan', '280', '2018-11-09 09:24:50'),
(84, 'lifetime_pro_plan', '500', '2018-11-09 09:24:52'),
(85, 'worker_updateDelay', '4000', '2018-11-09 09:30:26'),
(87, 'profile_record_views_minute', '1', NULL),
(90, 'cost_per_gift', '50', '2018-11-09 09:37:38'),
(91, 'deleteAccount', '1', '2018-11-09 08:29:15'),
(92, 'user_registration', '1', '2018-11-09 08:28:24'),
(93, 'maxUpload', '96000000', NULL),
(94, 'mime_types', 'text/plain,video/mp4,video/mov,video/mpeg,video/flv,video/avi,video/webm,audio/wav,audio/mpeg,video/quicktime,audio/mp3,image/png,image/jpeg,image/gif,application/pdf,application/msword,application/zip,application/x-rar-compressed,text/pdf,application/x-pointplus,text/css', NULL),
(95, 'normal_boost_me_credits_price', '70', '2018-11-14 06:39:56'),
(96, 'more_stickers_credits_price', '45', '2018-11-14 06:39:59'),
(97, 'pro_boost_me_credits_price', '35', '2018-11-16 03:23:30'),
(98, 'boost_expire_time', '4', '2018-11-16 03:23:49'),
(99, 'not_pro_chat_limit_daily', '4', '2018-11-16 03:24:06'),
(100, 'not_pro_chat_credit', '30', NULL),
(101, 'not_pro_chat_stickers_credit', '25', '2018-11-16 03:25:55'),
(102, 'not_pro_chat_stickers_limit', '24', '2018-11-16 03:26:16'),
(103, 'cost_per_xvisits', '25', NULL),
(104, 'xvisits_expire_time', '5', NULL),
(105, 'cost_per_xmatche', '35', NULL),
(106, 'xmatche_expire_time', '5', NULL),
(107, 'cost_per_xlike', '45', NULL),
(108, 'xlike_expire_time', '5', NULL),
(109, 'google_place_api', 'AIzaSyB7rRpQJyQJZYzxrvStRGFkbB0MxXWGrO0', NULL),
(110, 'wowonder_login', '0', NULL),
(111, 'wowonder_app_ID', '7d0f02f7d38c30f78cd5', NULL),
(112, 'wowonder_app_key', 'e91365ad84d413a1d017d28522e555d14225d9d', NULL),
(113, 'wowonder_domain_uri', 'https://demo.wowonder.com', NULL),
(114, 'wowonder_domain_icon', 'https://demo.wowonder.com/themes/default/img/icon.png', NULL),
(115, 'bank_transfer_note', 'In order to confirm the bank transfer, you will need to upload a receipt or take a screenshot of your transfer within 1 day from your payment date. If a bank transfer is made but no receipt is uploaded within this period, your order will be cancelled. We will verify and confirm your receipt within 3 working days from the date you upload it.', NULL),
(116, 'max_swaps', '50', NULL),
(117, 'stripe_version', 'v1', NULL),
(118, 'paysera_project_id', '0', NULL),
(119, 'paysera_password', '', NULL),
(120, 'paysera_test_mode', 'test', NULL),
(121, 'message_request_system', 'on', NULL),
(122, 'video_chat', '0', NULL),
(123, 'audio_chat', '0', NULL),
(124, 'video_accountSid', '', NULL),
(125, 'video_apiKeySid', '', NULL),
(126, 'video_apiKeySecret', '098765', NULL),
(127, 'giphy_api', 'GIjbMwjlfGcmNEgB0eqphgRgwNCYN8gh', NULL),
(128, 'default_unit', 'km', NULL),
(129, 'maintenance_mode', '0', NULL),
(130, 'displaymode', 'night', NULL),
(131, 'bank_description', '&lt;div class=&quot;dt_settings_header bg_gradient&quot;&gt;\r\n                    &lt;div class=&quot;dt_settings_circle-1&quot;&gt;&lt;/div&gt;\r\n                    &lt;div class=&quot;dt_settings_circle-2&quot;&gt;&lt;/div&gt;\r\n                    &lt;div class=&quot;bank_info_innr&quot;&gt;\r\n                        &lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 24 24&quot;&gt;&lt;path fill=&quot;currentColor&quot; d=&quot;M11.5,1L2,6V8H21V6M16,10V17H19V10M2,22H21V19H2M10,10V17H13V10M4,10V17H7V10H4Z&quot;&gt;&lt;/path&gt;&lt;/svg&gt;\r\n                        &lt;h4 class=&quot;bank_name&quot;&gt;BANK NAME&lt;/h4&gt;\r\n                        &lt;div class=&quot;row&quot;&gt;\r\n                            &lt;div class=&quot;col s12&quot;&gt;\r\n                                &lt;div class=&quot;bank_account&quot;&gt;\r\n                                    &lt;p&gt;4796824372433055&lt;/p&gt;\r\n                                    &lt;span class=&quot;help-block&quot;&gt;Account number / IBAN&lt;/span&gt;\r\n                                &lt;/div&gt;\r\n                            &lt;/div&gt;\r\n                            &lt;div class=&quot;col s12&quot;&gt;\r\n                                &lt;div class=&quot;bank_account_holder&quot;&gt;\r\n                                    &lt;p&gt;Antoian Kordiyal&lt;/p&gt;\r\n                                    &lt;span class=&quot;help-block&quot;&gt;Account name&lt;/span&gt;\r\n                                &lt;/div&gt;\r\n                            &lt;/div&gt;\r\n                            &lt;div class=&quot;col s6&quot;&gt;\r\n                                &lt;div class=&quot;bank_account_code&quot;&gt;\r\n                                    &lt;p&gt;TGBATRISXXX&lt;/p&gt;\r\n                                    &lt;span class=&quot;help-block&quot;&gt;Routing code&lt;/span&gt;\r\n                                &lt;/div&gt;\r\n                            &lt;/div&gt;\r\n                            &lt;div class=&quot;col s6&quot;&gt;\r\n                                &lt;div class=&quot;bank_account_country&quot;&gt;\r\n                                    &lt;p&gt;Turkey&lt;/p&gt;\r\n                                    &lt;span class=&quot;help-block&quot;&gt;Country&lt;/span&gt;\r\n                                &lt;/div&gt;\r\n                            &lt;/div&gt;\r\n                        &lt;/div&gt;\r\n                    &lt;/div&gt;\r\n                &lt;/div&gt;', NULL),
(132, 'version', '1.7', '2019-05-08 11:18:08'),
(133, 'google_tag_code', NULL, '2019-05-08 11:18:10'),
(134, 'avcall_pro', '1', '2019-05-08 11:18:11'),
(135, 'pro_system', '1', '2019-05-08 11:18:13'),
(136, 'img_blur_amount', '50', '2019-05-08 11:18:15'),
(137, 'emailNotification', '1', '2019-05-08 11:18:17'),
(138, 'activation_limit_system', '1', '2019-05-09 18:06:09'),
(139, 'max_activation_request', '5', '2019-05-09 18:06:09'),
(140, 'activation_request_time_limit', '5', '2019-05-09 18:06:09'),
(141, 'free_features', '0', '2019-08-22 14:10:20'),
(142, 'opposite_gender', '1', '2019-08-22 14:10:22'),
(143, 'image_verification', '0', '2019-08-22 14:10:24'),
(145, 'pending_verification', '0', '2019-08-22 14:10:27'),
(146, 'push', '1', '2019-08-30 19:18:56'),
(147, 'spam_warning', '1', '2019-08-30 19:18:57'),
(148, 'image_verification_start', '0', '2019-08-30 19:18:59'),
(149, 'two_factor', '1', '2020-02-23 14:17:03'),
(150, 'two_factor_type', 'email', '2020-02-23 14:17:03'),
(151, 'affiliate_system', '1', '2020-02-23 14:17:04'),
(152, 'affiliate_type', NULL, '2020-02-23 14:17:04'),
(153, 'm_withdrawal', NULL, '2020-02-23 14:17:04'),
(154, 'amount_ref', NULL, '2020-02-23 14:17:04'),
(155, 'amount_percent_ref', NULL, '2020-02-23 14:17:04'),
(156, 'connectivitySystem', '0', '2020-02-23 14:17:04'),
(157, 'connectivitySystemLimit', '5000', '2020-02-23 14:17:04'),
(158, 'show_user_on_homepage', '1', '2020-02-23 14:17:04'),
(159, 'showed_user', '150', '2020-02-23 14:17:04'),
(160, 'max_photo_per_user', '12', '2020-02-23 14:17:04'),
(161, 'review_media_files', '0', '2020-02-23 14:17:04'),
(162, 'ffmpeg_sys', '0', '2020-02-23 14:17:04'),
(163, 'max_video_duration', '30', '2020-02-23 14:17:04'),
(164, 'ffmpeg_binary', './ffmpeg/ffmpeg', '2020-02-23 14:17:04'),
(165, 'disable_phone_field', 'on', '2020-07-30 15:29:34'),
(166, 'social_media_links', 'off', '2020-07-30 15:29:35'),
(167, 'yt_api', '', '2020-07-30 15:29:37'),
(168, 'seo', '{\"about\":{\"title\":\"{LANG_KEY about} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"apps\":{\"title\":\"{LANG_KEY my_apps} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"blog\":{\"title\":\"{LANG_KEY blog} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"contact\":{\"title\":\"{LANG_KEY contact_us} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"create-app\":{\"title\":\"{LANG_KEY create_app} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"create-story\":{\"title\":\"{LANG_KEY create_story} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"credit\":{\"title\":\"{LANG_KEY credits} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"developers\":{\"title\":\"{LANG_KEY developers} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"disliked\":{\"title\":\"{LANG_KEY disliked} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"faqs\":{\"title\":\"{LANG_KEY faqs} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"find-matches\":{\"title\":\"{LANG_KEY find_matches} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"forgot\":{\"title\":\"{LANG_KEY forgot_password} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"friend-requests\":{\"title\":\"{LANG_KEY friend-requests} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"friends\":{\"title\":\"{LANG_KEY friends} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"gifts\":{\"title\":\"{LANG_KEY gifts} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"hot\":{\"title\":\"{LANG_KEY hot_or_not} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"interest\":{\"title\":\"{LANG_KEY interest} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"liked\":{\"title\":\"{LANG_KEY liked} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"likes\":{\"title\":\"{LANG_KEY likes} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"live\":{\"title\":\"{LANG_KEY live} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"live-users\":{\"title\":\"{LANG_KEY live_users} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"maintenance\":{\"title\":\"{LANG_KEY sorry_for_the_inconvenience_but_we_rsquo_re_performing_some_maintenance_at_the_moment._if_you_need_help_you_can_always} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"matches\":{\"title\":\"{LANG_KEY matches} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"refund\":{\"title\":\"{LANG_KEY refund} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"register\":{\"title\":\"{LANG_KEY register} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"settings\":{\"title\":\"{LANG_KEY settings} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"},\"stories\":{\"title\":\"{LANG_KEY success_stories} - {SITE_TITLE}\",\"meta_keywords\":\"{SITE_KEYWORDS}\",\"meta_description\":\"{SITE_DESC}\"}}', '2020-07-30 15:29:39'),
(169, 'lock_private_photo', '0', '2020-07-30 15:29:40'),
(170, 'lock_private_photo_fee', '30', '2020-07-30 15:29:42'),
(171, 'lock_pro_video', '0', '2020-07-30 15:29:43'),
(172, 'lock_pro_video_fee', '40', '2020-07-30 15:29:45'),
(173, 'verification_on_signup', '0', '2020-07-30 15:29:46'),
(174, 'credit_earn_system', '1', '2020-07-30 15:29:48'),
(175, 'credit_earn_max_days', '10', '2020-07-30 15:29:50'),
(176, 'credit_earn_day_amount', '50', '2020-07-30 15:29:51'),
(177, 'specific_email_signup', NULL, '2021-03-21 12:15:32'),
(178, 'push1', '0', '2021-03-21 12:15:32'),
(179, 'checkout_payment', 'yes', '2021-03-21 12:15:32'),
(180, 'checkout_mode', 'sandbox', '2021-03-21 12:15:32'),
(181, 'checkout_currency', 'USD', '2021-03-21 12:15:33'),
(182, 'checkout_seller_id', '', '2021-03-21 12:15:33'),
(183, 'checkout_publishable_key', '', '2021-03-21 12:15:33'),
(184, 'checkout_private_key', '', '2021-03-21 12:15:33'),
(185, 'cashfree_payment', 'yes', '2021-03-21 12:15:34'),
(186, 'cashfree_mode', 'sandBox', '2021-03-21 12:15:34'),
(187, 'cashfree_client_key', '', '2021-03-21 12:15:34'),
(188, 'cashfree_secret_key', '', '2021-03-21 12:15:34'),
(189, 'iyzipay_payment', 'yes', '2021-03-21 12:15:35'),
(190, 'iyzipay_mode', '1', '2021-03-21 12:15:35'),
(191, 'iyzipay_key', '', '2021-03-21 12:15:35'),
(192, 'iyzipay_buyer_id', '', '2021-03-21 12:15:35'),
(193, 'iyzipay_secret_key', '', '2021-03-21 12:15:36'),
(194, 'iyzipay_buyer_name', '', '2021-03-21 12:15:36'),
(195, 'iyzipay_buyer_surname', '', '2021-03-21 12:15:36'),
(196, 'iyzipay_buyer_gsm_number', '', '2021-03-21 12:15:37'),
(197, 'iyzipay_buyer_email', '', '2021-03-21 12:15:37'),
(198, 'iyzipay_identity_number', '', '2021-03-21 12:15:37'),
(199, 'iyzipay_address', '', '2021-03-21 12:15:37'),
(200, 'iyzipay_city', '', '2021-03-21 12:15:38'),
(201, 'iyzipay_country', '', '2021-03-21 12:15:38'),
(202, 'iyzipay_zip', '', '2021-03-21 12:15:38'),
(203, 'google_map_api_key', '', '2021-03-21 12:15:38'),
(204, 'payu_payment', 'no', '2021-03-21 12:15:38'),
(205, 'payu_mode', '1', '2021-03-21 12:15:38'),
(206, 'payu_merchant_id', '', '2021-03-21 12:15:38'),
(207, 'payu_secret_key', '', '2021-03-21 12:15:38'),
(208, 'payu_buyer_name', '', '2021-03-21 12:15:38'),
(209, 'payu_buyer_surname', '', '2021-03-21 12:15:38'),
(210, 'payu_buyer_gsm_number', '', '2021-03-21 12:15:38'),
(211, 'payu_buyer_email', '', '2021-03-21 12:15:38'),
(212, 'prevent_system', '0', '2021-08-08 12:15:24'),
(213, 'bad_login_limit', '4', '2021-08-08 12:15:24'),
(214, 'lock_time', '10', '2021-08-08 12:15:24'),
(215, 'paystack_payment', 'no', '2021-08-08 12:15:25'),
(216, 'paystack_secret_key', '', '2021-08-08 12:15:25'),
(217, 'twilio_chat_call', '0', '2021-08-08 12:15:25'),
(218, 'agora_chat_call', '0', '2021-08-08 12:15:25'),
(219, 'agora_chat_app_id', '', '2021-08-08 12:15:26'),
(220, 'agora_chat_app_certificate', '', '2021-08-08 12:15:26'),
(221, 'agora_chat_customer_id', '', '2021-08-08 12:15:26'),
(222, 'agora_chat_customer_secret', '', '2021-08-08 12:15:26'),
(223, 'live_video', '1', '2021-08-08 12:15:26'),
(224, 'live_video_save', '0', '2021-08-08 12:15:26'),
(225, 'agora_live_video', '0', '2021-08-08 12:15:27'),
(226, 'agora_app_id', '', '2021-08-08 12:15:27'),
(227, 'agora_app_certificate', '', '2021-08-08 12:15:27'),
(228, 'agora_customer_id', '', '2021-08-08 12:15:27'),
(229, 'agora_customer_certificate', '', '2021-08-08 12:15:27'),
(230, 'amazone_s3_2', '0', '2021-08-08 12:15:27'),
(231, 'bucket_name_2', '', '2021-08-08 12:15:27'),
(232, 'amazone_s3_key_2', '', '2021-08-08 12:15:28'),
(233, 'amazone_s3_s_key_2', '', '2021-08-08 12:15:28'),
(234, 'region_2', 'us-east-1', '2021-08-08 12:15:28'),
(235, 'qqAppId', '', '2021-08-08 12:15:30'),
(236, 'qqAppkey', '', '2021-08-08 12:15:30'),
(237, 'WeChatAppId', '', '2021-08-08 12:15:30'),
(238, 'WeChatAppkey', '', '2021-08-08 12:15:30'),
(239, 'DiscordAppId', '', '2021-08-08 12:15:30'),
(240, 'DiscordAppkey', '', '2021-08-08 12:15:30'),
(241, 'MailruAppId', '', '2021-08-08 12:15:30'),
(242, 'MailruAppkey', '', '2021-08-08 12:15:31'),
(243, 'qqLogin', '0', '2021-08-08 12:15:31'),
(244, 'WeChatLogin', '0', '2021-08-08 12:15:31'),
(245, 'DiscordLogin', '0', '2021-08-08 12:15:31'),
(246, 'MailruLogin', '0', '2021-08-08 12:15:31'),
(247, 'twilio_provider', '0', '2021-08-08 12:15:31'),
(248, 'bulksms_provider', '0', '2021-08-08 12:15:31'),
(249, 'bulksms_username', '', '2021-08-08 12:15:32'),
(250, 'bulksms_password', '', '2021-08-08 12:15:32'),
(251, 'messagebird_provider', '0', '2021-08-08 12:15:32'),
(252, 'messagebird_key', '', '2021-08-08 12:15:32'),
(253, 'messagebird_phone', '', '2021-08-08 12:15:32'),
(254, 'authorize_payment', 'no', '2021-08-08 12:15:33'),
(255, 'authorize_login_id', '', '2021-08-08 12:15:33'),
(256, 'authorize_transaction_key', '', '2021-08-08 12:15:33'),
(257, 'authorize_test_mode', 'SANDBOX', '2021-08-08 12:15:33'),
(258, 'securionpay_payment', 'no', '2021-08-08 12:15:33'),
(259, 'securionpay_public_key', '', '2021-08-08 12:15:34'),
(260, 'securionpay_secret_key', '', '2021-08-08 12:15:34'),
(261, 'invite_links_system', '1', '2021-08-08 12:15:35'),
(262, 'user_links_limit', '10', '2021-08-08 12:15:35'),
(263, 'expire_user_links', 'month', '2021-08-08 12:15:35'),
(264, 'infobip_provider', '0', '2021-08-08 12:15:35'),
(265, 'infobip_username', '', '2021-08-08 12:15:35'),
(266, 'infobip_password', '', '2021-08-08 12:15:35'),
(267, 'msg91_provider', '0', '2021-08-08 12:15:35'),
(268, 'msg91_authKey', '', '2021-08-08 12:15:36'),
(269, 'auto_user_like', '5', '2021-08-08 12:15:36'),
(270, 'developers_page', '1', '2021-08-08 12:15:36'),
(271, 'filter_by_country', 'PRO', '2021-08-08 12:15:36'),
(272, 'spaces', '0', '2021-08-08 12:15:36'),
(273, 'space_name', '', '2021-08-08 12:15:36'),
(274, 'spaces_key', '', '2021-08-08 12:15:36'),
(275, 'spaces_secret', '', '2021-08-08 12:15:36'),
(276, 'space_region', 'nyc3', '2021-08-08 12:15:36'),
(277, 'wasabi_storage', '0', '2021-08-08 12:15:36'),
(278, 'wasabi_bucket_name', '', '2021-08-08 12:15:36'),
(279, 'wasabi_access_key', '', '2021-08-08 12:15:36'),
(280, 'wasabi_secret_key', '', '2021-08-08 12:15:36'),
(281, 'wasabi_bucket_region', 'us-east-1', '2021-08-08 12:15:36'),
(282, 'ftp_upload', '0', '2021-08-08 12:15:36'),
(283, 'ftp_host', '', '2021-08-08 12:15:36'),
(284, 'ftp_username', '', '2021-08-08 12:15:36'),
(285, 'ftp_password', '', '2021-08-08 12:15:36'),
(286, 'ftp_port', '', '2021-08-08 12:15:36'),
(287, 'ftp_path', '', '2021-08-08 12:15:36'),
(288, 'ftp_endpoint', '', '2021-08-08 12:15:36'),
(289, 'cloud_upload', '0', '2021-08-08 12:15:36'),
(290, 'cloud_bucket_name', '', '2021-08-08 12:15:36'),
(291, 'cloud_file', '', '2021-08-08 12:15:36'),
(292, 'cloud_file_path', '', '2021-08-08 12:15:36'),
(293, 'geo_username', '', '2021-08-08 12:15:36'),
(294, 'filter_by_cities', '0', '2021-08-08 12:15:36'),
(295, 'coinbase_payment', '0', '2021-08-08 12:15:36'),
(296, 'coinbase_key', '', '2021-08-08 12:15:36'),
(297, 'credit_price', '100', '2021-08-08 12:15:36'),
(298, 'yoomoney_payment', '0', '2021-08-08 12:15:36'),
(299, 'yoomoney_wallet_id', '', '2021-08-08 12:15:36'),
(300, 'yoomoney_notifications_secret', '', '2021-08-08 12:15:36'),
(301, 'paypal_payment', '0', '2021-08-08 12:15:36'),
(302, 'stripe_payment', '0', '2021-08-08 12:15:36'),
(303, 'bank_payment', '0', '2021-08-08 12:15:36'),
(304, 'paysera_payment', '0', '2021-08-08 12:15:36'),
(305, 'razorpay_payment', '0', '2021-08-08 12:15:36'),
(306, 'razorpay_key_id', '', '2021-08-08 12:15:36'),
(307, 'razorpay_key_secret', '', '2021-08-08 12:15:36'),
(308, 'OkLogin', '0', '2021-08-08 12:15:36'),
(309, 'OkAppId', '', '2021-08-08 12:15:36'),
(310, 'OkAppPublickey', '', '2021-08-08 12:15:36'),
(311, 'OkAppSecretkey', '', '2021-08-08 12:15:36'),
(312, 'refund', '                <h4>1- Write your Privacy Policy here.</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adisdpisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n                <br>\n                <h4>2- Random title</h4>\n                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', '2021-08-08 12:15:36'),
(313, 'native_android_url', '', '2021-08-08 12:15:36'),
(314, 'native_ios_url', '', '2021-08-08 12:15:36'),
(315, 'watermark_system', '0', '2021-08-08 12:15:36'),
(316, 'instagram_importer', '0', '2021-08-08 12:15:36'),
(317, 'instagram_importer_app_id', '', '2021-08-08 12:15:36'),
(318, 'instagram_importer_app_secret', '', '2021-08-08 12:15:36'),
(319, 'fortumo_payment', '0', '2021-08-08 12:15:36'),
(320, 'fortumo_service_id', '', '2021-08-08 12:15:36'),
(321, 'coinpayments', '0', '2021-08-08 12:15:36'),
(322, 'coinpayments_secret', '', '2021-08-08 12:15:36'),
(323, 'coinpayments_id', '', '2021-08-08 12:15:36'),
(324, 'coinpayments_public_key', '', '2021-08-08 12:15:36'),
(325, 'coinpayments_coins', '', '2021-08-08 12:15:36'),
(326, 'coinpayments_coin', '', '2021-08-08 12:15:36'),
(327, 'currency_array', '{\"0\":\"USD\",\"1\":\"EUR\",\"2\":\"JPY\",\"3\":\"TRY\",\"4\":\"GBP\",\"6\":\"PLN\",\"7\":\"ILS\"}', '2021-08-08 12:15:36'),
(328, 'currency_symbol_array', '{\"USD\":\"&#36;\",\"EUR\":\"&#8364;\",\"JPY\":\"&#165;\",\"TRY\":\"&#8378;\",\"GBP\":\"&#163;\",\"PLN\":\"&#122;&#322;\",\"ILS\":\"&#8362;\"}', '2021-08-08 12:15:36'),
(329, 'exchange', '', '2021-08-08 12:15:36'),
(330, 'exchange_update', '', '2021-08-08 12:15:36'),
(331, 'paypal_currency', 'USD', '2021-08-08 12:15:36'),
(332, 'stripe_currency', 'USD', '2021-08-08 12:15:36'),
(333, 'paystack_currency', 'NGN', '2021-08-08 12:15:36'),
(334, 'cashfree_currency', 'INR', '2021-08-08 12:15:36'),
(335, 'iyzipay_currency', 'TL', '2021-08-08 12:15:36'),
(336, 'ngenius_payment', '0', '2021-08-08 12:15:36'),
(337, 'ngenius_api_key', '', '2021-08-08 12:15:36'),
(338, 'ngenius_outlet_id', '', '2021-08-08 12:15:36'),
(339, 'ngenius_mode', 'sandbox', '2021-08-08 12:15:36'),
(340, 'aamarpay_payment', '0', '2021-08-08 12:15:36'),
(341, 'aamarpay_mode', 'sandbox', '2021-08-08 12:15:36'),
(342, 'aamarpay_store_id', '', '2021-08-08 12:15:36'),
(343, 'aamarpay_signature_key', '', '2021-08-08 12:15:36'),
(344, 'fluttewave_payment', '0', '2018-11-04 21:00:00'),
(345, 'fluttewave_secret_key', '', '2018-11-04 21:00:00'),
(346, 'success_stories_system', '1', '2018-11-04 21:00:00'),
(347, 'msg91_dlt_id', '', '2018-11-04 21:00:00'),
(348, 'backblaze_storage', '0', '2018-11-04 21:00:00'),
(349, 'backblaze_bucket_id', '', '2018-11-04 21:00:00'),
(350, 'backblaze_bucket_name', '', '2018-11-04 21:00:00'),
(351, 'backblaze_bucket_region', '', '2018-11-04 21:00:00'),
(352, 'backblaze_access_key_id', '', '2018-11-04 21:00:00'),
(353, 'backblaze_access_key', '', '2018-11-04 21:00:00'),
(354, 'backblaze_endpoint', '', '2018-11-04 21:00:00'),
(355, 'developer_mode', '0', '2018-11-04 21:00:00'),
(356, 'pop_up_18', 'off', '2018-11-04 21:00:00'),
(357, 'time_18', '1', '2018-11-04 21:00:00'),
(358, 'reserved_usernames_system', '0', '2018-11-04 21:00:00'),
(359, 'reserved_usernames', '404,about,age-block,app,apps,article,base,blog,contact,create-app,create-story,credit,developers,disliked,faqs,find-matches,forgot,friend-requests,friends,gifts,hot,index,info,interest,liked,likes,live-users,live,login,mail-otp,maintenance,matches,my-info,myprofile,oauth,page,popularity,privacy,pro-success,pro,profile,refund,register,reset,settings-2fa,settings-affiliate,settings-blocked,settings-delete,settings-email,settings-instagram,settings-links,settings-password,settings-payments,settings-privacy,settings-profile,settings-sessions,settings-social,settings,steps,stories,story,terms,third-party-payment,third-party-theme,transactions,unusual-login,user-live,user-info,userverify,verifymail,verifymailotp,verifyphone,verifyphoneotp,video-call,video,visits', '2018-11-04 21:00:00'),
(360, 'withdrawal_payment_method', '{\"paypal\":1,\"bank\":0,\"skrill\":0,\"custom\":0}', '2018-11-04 21:00:00'),
(361, 'custom_name', '', '2018-11-04 21:00:00'),
(362, 'bulksms_phone_number', '', '2018-11-04 21:00:00'),
(363, 'infobip_phone_number', '', '2018-11-04 21:00:00'),
(364, 'msg91_phone_number', '', '2018-11-04 21:00:00'),
(365, 'cost_admob', '5', '2018-11-04 21:00:00'),
(366, 'alipay_payment', '0', '2018-11-04 21:00:00'),
(367, 'alipay_server', 'global', '2018-11-04 21:00:00'),
(368, 'recaptcha', 'off', '2018-11-04 21:00:00'),
(369, 'recaptcha_site_key', '', '2018-11-04 21:00:00'),
(370, 'recaptcha_secret_key', '', '2018-11-04 21:00:00'),
(371, 'english', '1', '2022-12-20 09:20:12'),
(372, 'arabic', '1', '2022-12-20 09:20:12'),
(373, 'dutch', '1', '2022-12-20 09:20:12'),
(374, 'french', '1', '2022-12-20 09:20:12'),
(375, 'german', '1', '2022-12-20 09:20:12'),
(376, 'italian', '1', '2022-12-20 09:20:12'),
(377, 'portuguese', '1', '2022-12-20 09:20:12'),
(378, 'russian', '1', '2022-12-20 09:20:12'),
(379, 'spanish', '1', '2022-12-20 09:20:12'),
(380, 'turkish', '1', '2022-12-20 09:20:12'),
(381, 'ukrainian', '1', '2022-12-20 09:20:12');

-- --------------------------------------------------------

--
-- Структура таблицы `payments`
--

CREATE TABLE `payments` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '0',
  `type` varchar(15) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pro_plan` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '',
  `credit_amount` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '0',
  `via` varchar(100) COLLATE utf8mb4_general_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `postType` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `postFile` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `stream_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `agora_token` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `live_time` int NOT NULL DEFAULT '0',
  `live_ended` int NOT NULL DEFAULT '0',
  `agora_resource_id` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `agora_sid` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `time` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `profilefields`
--

CREATE TABLE `profilefields` (
  `id` int NOT NULL,
  `name` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8mb3_unicode_ci,
  `type` text COLLATE utf8mb3_unicode_ci,
  `length` int NOT NULL DEFAULT '0',
  `placement` varchar(32) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'profile',
  `registration_page` int NOT NULL DEFAULT '0',
  `profile_page` int NOT NULL DEFAULT '0',
  `select_type` varchar(32) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'none',
  `active` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `reports`
--

CREATE TABLE `reports` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `report_userid` int UNSIGNED DEFAULT '0',
  `report_text` text COLLATE utf8mb4_general_ci,
  `seen` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE `sessions` (
  `id` int NOT NULL,
  `session_id` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `user_id` int NOT NULL DEFAULT '0',
  `platform` varchar(30) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'web',
  `platform_details` text COLLATE utf8mb4_general_ci,
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `sessions`
--

INSERT INTO `sessions` (`id`, `session_id`, `user_id`, `platform`, `platform_details`, `time`) VALUES
(18, '6b543a55c81d9022047eb5717091394c65e531a2bfd57075fed948fb823ed680908625e96941536377431ca7981f1f1483ae8a58bcbb6e0e', 1, 'web', 'a:5:{s:9:\"userAgent\";s:117:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"125.0.0.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718051427),
(19, '728b575d5a6f3f7d4fa8818fd2f1b333e3c9f8c9f5d9df0c54f186dc79347be32dd5eeb732978245d02e9bdc27a894e882fa0c9055c99722', 3, 'web', 'a:5:{s:9:\"userAgent\";s:111:\"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"125.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718054897),
(21, 'bf50b64daf650b849cec31c54baf8c363383d89513f18f7ee4f9a3965c193d6961d3a4d935422170b9937273f2b46912b56d09c8faa7da23', 4, 'web', 'a:5:{s:9:\"userAgent\";s:160:\"Mozilla/5.0 (Linux; Android 11; CPH2239 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/124.0.6367.179 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:3:\"4.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718091760),
(24, '8871426309df35b084e3368fcc868870ed64484ba21fed52ea33a64233769bebf066ab3e3578853008ae6a26b7cb089ea588e94aed36bd15', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718101426),
(25, '9f1f9415a1b6439685e8c735d286696630b2c2dd12a371cafdbbab2896a45da55489f54032841703cd17d3ce3b64f227987cd92cd701cc58', 1, 'web', 'a:5:{s:9:\"userAgent\";s:111:\"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"125.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718101821),
(26, '59147eaa022b486037c204d731ae806d2a3b4d00cac8859cab3b713ad96991090aff88a8732186808ef897e468650c19f3f31529712fc500', 105, 'web', 'a:5:{s:9:\"userAgent\";s:163:\"Mozilla/5.0 (Linux; Android 13; 23106RN0DA Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/124.0.6367.179 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:3:\"4.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718123376),
(31, 'fd28d527799bccc11056bd7480ff4a84b9fb349f1bcd4127bc52ab9baf6357c8fc761f10614471212f2cd5c753d3cee48e47dbb5bbaed331', 108, 'web', 'a:5:{s:9:\"userAgent\";s:147:\"Mozilla/5.0 (iPhone; CPU iPhone OS 17_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1 OPT/4.7.0\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"17.5\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718178765),
(34, '9245832f7bd16efd89dd1b28be776243e191dcf78d69b83f5f457b58046be91863883b3b9980973850285433069b9faf53c900cd2642fa9d', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718203287),
(35, '67b6c8765494b58e69556ef7f6f266f0dbeb1f81445c93bcbebc52929ba621b44dbe5053626001628cc0225cb9ed2421038a1325a46c562a', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718211610),
(36, 'b6962b57bdad963381db02f0f32daa493861aac2bc264e4da669be65ad384d69789ecfff86421336040ca38cefb1d9226d79c05dd25469cb', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718218531),
(37, '69b730f541f42c42170b9f5e48b6414d705fb66516af2548f15d8eb4d1e75040cd781335280584044e093aa7417fe0881bc5fbda7322a74e', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718219614),
(38, '14faea5a2cbe8df3fc465445ae58bc74779ea7d207978cb8b9623b576952c7dbda37a372557444309e6adb1432c4a75a33d48693328e4159', 109, 'web', 'a:5:{s:9:\"userAgent\";s:111:\"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"125.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718277871),
(39, '3996269bdf94a23232a71b37bc5e3e62138f2a0c9c1667ce1625ee8f0dfa596cc678d37b59870645be341249df108cb23c312ae62b6565cd', 1, 'web', 'a:5:{s:9:\"userAgent\";s:125:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36 Edg/125.0.0.0\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"125.0.0.0\";s:8:\"platform\";s:7:\"windows\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718291151),
(41, '866804dbc53a4e9d4dec8b197b86b31e3230e594378abcdee4bddc536a92b59cf3374caa633537882adafb1b5d684e6c15a2d063367be012', 110, 'web', 'a:5:{s:9:\"userAgent\";s:111:\"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"119.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718359478),
(42, '9366d1af98af8bb144ee5994a5e5a585dcd824b14d8c626e336f0fc25df2c3c5f3fe656c400600193e5190eeb51ebe6c5bbc54ee8950c548', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718380341),
(43, 'a1b1ee2f924daeceefc28b75f8582ee2cec340b35522d917524f5f0d56653288f332bfae968277728386fa112ba70c3f60b6907d3812bb9e', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718381119),
(44, 'ae50ba2446975d55807fb049871a638ab03844aef58734b7553347609a27761115c7e99f72429176ba5451d3c91a0f982f103cdbe249bc78', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718383225),
(45, 'f6b9e584a505ed7faad9e16d31adfcb2131a10b998e541e35b67dcc5f453f42e322d9fcb258976897beadac50e1ce55dc31343cc1a89ac5c', 111, 'web', 'a:5:{s:9:\"userAgent\";s:143:\"Mozilla/5.0 (Linux; Android 11; HV6FsbqtjV; U; en) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.5414.85 Mobile Tenta/7.3.0 Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:13:\"109.0.5414.85\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718391103),
(47, '13a799f18b87159b8bd268950bb42244a89d4cd978dafabd8138c78cee6ac8141874c7b879658762e61eaa38aed621dd776d0e67cfeee366', 106, 'web', 'a:5:{s:9:\"userAgent\";s:111:\"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"125.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718455901),
(48, '2a25ce9b3bf98a6a42569acd09928ad615edb510126779a03c038f755c7883359dd8ce0b52029364048e2f1447691907b18b2a37e7ed2322', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718458391),
(49, 'b01aea0c54ef560c6f28373500ad02710c9cb5aabcdba202770a5af5153690fa589489a147013369a7b23e6eefbe6cf04b8e62a6f0915550', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718459872),
(50, '0ce2e50e875b158455ad6c632e4c938b3d71469ac6b9944ebc80914ae66acef87e63438c381454425f8a7deb15235a128fcd99ad6bfde11e', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718627616),
(51, '2d85aee509fc46ca897c21e28791369c9e5989bbd90a4bbbdcc1e0c6b82dfa81ae988cab6981051129405e2a4c22866a205f557559c7fa4b', 1, 'web', 'a:5:{s:9:\"userAgent\";s:131:\"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"124.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718627687),
(52, 'c2b5c938438eea326ff7826632fca428d56f41624f3ca35340c3ce3c5126fbd80cf1d1091570020306563f3b418fe57f8fc331872343ce44', 2, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718633397),
(53, '1c6e34e6b6d1b575bf109e202f941b706aabc1f0703739cb3b1129dcb9b0dfc6653b9ef592472790948f847055c6bf156997ce9fb59919be', 112, 'web', 'a:5:{s:9:\"userAgent\";s:111:\"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"125.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718699691),
(55, '173117b82dc11f38e1044f50810e1c044493b4594573b75dd8748ed854cda0667233cc9863011880fc1a36821b02abbd2503fd949bfc9131', 114, 'web', 'a:5:{s:9:\"userAgent\";s:80:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:114.0) Gecko/20100101 Firefox/114.0\";s:4:\"name\";s:15:\"Mozilla Firefox\";s:7:\"version\";s:5:\"114.0\";s:8:\"platform\";s:7:\"windows\";s:7:\"pattern\";s:67:\"#(?<browser>Version|Firefox|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1718738443),
(58, 'a50df89984e0736e728bfe5c62bae4ea3bbd7bf91e92c8c8bd8eea3b1c918f1d0f93046e66577520885cb47f87718a2cd8641ae79113eeea', 115, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.3\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1736714867),
(59, 'c1de103d76e01a380650318295c751b16049f7d0e557742d8ea66ea115c94843710d52425358893423ef5cf238a3b88085d95adf94c24a25', 115, 'web', 'a:5:{s:9:\"userAgent\";s:117:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"131.0.0.0\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1736787349),
(60, 'c15311e66f0abb6b59360a6935c15842b1ea499717ebd24bada21e50cd784be9012b32a8711930977ec2442aa04c157590b2fa1a7d093a33', 115, 'web', 'a:5:{s:9:\"userAgent\";s:188:\"Mozilla/5.0 (Linux; Android 13; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.260 Mobile Safari/537.36 Telegram-Android/11.6.1 (Xiaomi M2103K19G; Android 13; SDK 33; AVERAGE)\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:14:\"131.0.6778.260\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1736789061),
(66, '2c7296f957fb64062ba9eada5113e0be6ed2c0a14dcca5cabb865027096b168bddd16b8e1207341103573b32b2746e6e8ca98b9123f2249b', 117, 'web', 'a:5:{s:9:\"userAgent\";s:118:\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 OPR/89.0.4447.51\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"114.0.0.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1736890326),
(67, 'eb080f03b7a83518cd27a8b00802a0b090d2cf8b64d1dbd0a4adeb8c3ae16a8cebabe3ad36481038515b9d40500ef7d05007b5668991fc7c', 118, 'web', 'a:5:{s:9:\"userAgent\";s:78:\"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:114.0) Gecko/20100101 Firefox/114.0\";s:4:\"name\";s:15:\"Mozilla Firefox\";s:7:\"version\";s:5:\"114.0\";s:8:\"platform\";s:5:\"linux\";s:7:\"pattern\";s:67:\"#(?<browser>Version|Firefox|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1736891637),
(68, '9145039ed937594961f0d88c459336b2895874d4a47e0e3a92184a1ccf8b359d246f88ad113317279379c23ac12dc94053207373040bc791', 115, 'web', 'a:5:{s:9:\"userAgent\";s:125:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36 OPR/115.0.0.0\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"130.0.0.0\";s:8:\"platform\";s:7:\"windows\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1737107391),
(69, '1be908926b8d7ef6ab467b19aeda838403482a3de8f2a2d6c8e50ca56784f375961dc6b8135704968b1ecf6d8049bb062a356f1cc812e69e', 115, 'web', 'a:5:{s:9:\"userAgent\";s:135:\"Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1\";s:4:\"name\";s:12:\"Apple Safari\";s:7:\"version\";s:4:\"18.3\";s:8:\"platform\";s:3:\"mac\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Safari|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1737107414),
(70, '428e825356823fe141ac9b511c06c1f91d2655350ad7f0925a810ba1fa68ad123c8a5b0a8793615246384036044a604b6b3316fc167fc15f', 115, 'web', 'a:5:{s:9:\"userAgent\";s:125:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"131.0.0.0\";s:8:\"platform\";s:7:\"windows\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1737107455),
(71, '48776d4bee430b76a2844c4e85c6aae1cd746443a0f28a082807b9f01e2be44170695b5855738286a14185bf0c82b3369f86efb3cac5ad28', 116, 'web', 'a:5:{s:9:\"userAgent\";s:125:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 OPR/116.0.0.0\";s:4:\"name\";s:13:\"Google Chrome\";s:7:\"version\";s:9:\"131.0.0.0\";s:8:\"platform\";s:7:\"windows\";s:7:\"pattern\";s:66:\"#(?<browser>Version|Chrome|other)[/ ]+(?<version>[0-9.|a-zA-Z.]*)#\";}', 1737108279);

-- --------------------------------------------------------

--
-- Структура таблицы `site_ads`
--

CREATE TABLE `site_ads` (
  `id` int NOT NULL,
  `placement` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `code` text COLLATE utf8mb4_general_ci,
  `active` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `site_ads`
--

INSERT INTO `site_ads` (`id`, `placement`, `code`, `active`) VALUES
(1, 'header', '', 0),
(2, 'footer', '', 0),
(3, 'home_side_bar', '', 0),
(4, 'profile_side_bar', '', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `stickers`
--

CREATE TABLE `stickers` (
  `id` bigint UNSIGNED NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `is_pro` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `stickers`
--

INSERT INTO `stickers` (`id`, `file`, `is_pro`, `created_at`) VALUES
(1, 'upload/stickers/GMXF3qmItDZlFW1IwBo8_15_3ed0b62dd948d8b11f4a59b7c0a9006d_image.png', 1, '2025-01-15 02:25:47'),
(2, 'upload/stickers/7JSSCTYmHUpKzuYc7DDq_15_038f788b12bd4e36687fa8ee0b15bdce_image.png', 1, '2025-01-15 20:16:26');

-- --------------------------------------------------------

--
-- Структура таблицы `success_stories`
--

CREATE TABLE `success_stories` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `story_user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `quote` varchar(250) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8mb4_general_ci,
  `story_date` date DEFAULT NULL,
  `status` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `userfields`
--

CREATE TABLE `userfields` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `first_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `last_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `avater` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'upload/photos/d-avatar.jpg  ',
  `address` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `gender` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `facebook` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `google` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `twitter` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `linkedin` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `okru` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `mailru` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `discord` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `wechat` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `qq` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `website` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `instagram` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `web_device_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '',
  `language` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'english',
  `email_code` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `src` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'Undefined',
  `ip_address` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'user',
  `phone_number` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `timezone` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `lat` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `lng` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `about` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `birthday` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '0000-00-00',
  `country` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '',
  `registered` int UNSIGNED DEFAULT '0',
  `lastseen` int UNSIGNED DEFAULT '0',
  `smscode` int UNSIGNED DEFAULT '0',
  `pro_time` int UNSIGNED DEFAULT '0',
  `last_location_update` int UNSIGNED DEFAULT '0',
  `balance` decimal(11,2) UNSIGNED DEFAULT '0.00',
  `verified` enum('0','1') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `status` enum('0','1','2','3') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `active` enum('0','1','2') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `admin` enum('0','1','2') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `start_up` enum('0','1','2','3') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `is_pro` enum('0','1') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `pro_type` enum('0','1','2','3','4') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `social_login` enum('0','1') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `mobile_device_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `web_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `mobile_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `height` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `hair_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `web_token_created_at` int DEFAULT '0',
  `mobile_token_created_at` int DEFAULT '0',
  `web_device` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `mobile_device` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `interest` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `cc_phone_number` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '',
  `zip` int UNSIGNED DEFAULT '0',
  `state` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '',
  `relationship` int UNSIGNED DEFAULT '0',
  `work_status` int UNSIGNED DEFAULT '0',
  `education` int UNSIGNED DEFAULT '0',
  `ethnicity` int UNSIGNED DEFAULT '0',
  `body` int UNSIGNED DEFAULT '0',
  `character` int UNSIGNED DEFAULT '0',
  `children` int UNSIGNED DEFAULT '0',
  `friends` int UNSIGNED DEFAULT '0',
  `pets` int UNSIGNED DEFAULT '0',
  `live_with` int UNSIGNED DEFAULT '0',
  `car` int UNSIGNED DEFAULT '0',
  `religion` int UNSIGNED DEFAULT '0',
  `smoke` int UNSIGNED DEFAULT '0',
  `drink` int UNSIGNED DEFAULT '0',
  `travel` int UNSIGNED DEFAULT '0',
  `music` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `dish` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `song` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `hobby` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `sport` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `book` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `movie` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `colour` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `tv` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `privacy_show_profile_on_google` int UNSIGNED DEFAULT '0',
  `privacy_show_profile_random_users` int UNSIGNED DEFAULT '0',
  `privacy_show_profile_match_profiles` int UNSIGNED DEFAULT '0',
  `email_on_profile_view` int UNSIGNED DEFAULT '0',
  `email_on_new_message` int UNSIGNED DEFAULT '0',
  `email_on_profile_like` int UNSIGNED DEFAULT '0',
  `email_on_purchase_notifications` int UNSIGNED DEFAULT '0',
  `email_on_special_offers` int UNSIGNED DEFAULT '0',
  `email_on_announcements` int UNSIGNED DEFAULT '0',
  `phone_verified` int UNSIGNED DEFAULT '0',
  `online` int UNSIGNED DEFAULT '0',
  `is_boosted` int UNSIGNED DEFAULT '0',
  `boosted_time` int UNSIGNED DEFAULT '0',
  `is_buy_stickers` int UNSIGNED DEFAULT '0',
  `user_buy_xvisits` int UNSIGNED DEFAULT '0',
  `xvisits_created_at` int UNSIGNED DEFAULT '0',
  `user_buy_xmatches` int UNSIGNED DEFAULT '0',
  `xmatches_created_at` int UNSIGNED DEFAULT '0',
  `user_buy_xlikes` int UNSIGNED DEFAULT '0',
  `xlikes_created_at` int UNSIGNED DEFAULT '0',
  `show_me_to` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `email_on_get_gift` int UNSIGNED DEFAULT '0',
  `email_on_got_new_match` int UNSIGNED DEFAULT '0',
  `email_on_chat_request` int UNSIGNED DEFAULT '0',
  `last_email_sent` int UNSIGNED DEFAULT '0',
  `approved_at` int UNSIGNED DEFAULT '0',
  `snapshot` varchar(250) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `hot_count` int UNSIGNED DEFAULT '0',
  `spam_warning` int UNSIGNED DEFAULT '0',
  `activation_request_count` int UNSIGNED DEFAULT '0',
  `last_activation_request` int UNSIGNED DEFAULT '0',
  `two_factor` int UNSIGNED DEFAULT '0',
  `two_factor_verified` int UNSIGNED DEFAULT '0',
  `two_factor_email_code` varchar(250) COLLATE utf8mb4_general_ci DEFAULT '',
  `new_email` varchar(250) COLLATE utf8mb4_general_ci DEFAULT '',
  `new_phone` varchar(250) COLLATE utf8mb4_general_ci DEFAULT '',
  `permission` text COLLATE utf8mb4_general_ci,
  `referrer` int UNSIGNED DEFAULT '0',
  `aff_balance` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '0',
  `paypal_email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '',
  `confirm_followers` enum('0','1') COLLATE utf8mb4_general_ci DEFAULT '1',
  `reward_daily_credit` int UNSIGNED DEFAULT '0',
  `lock_pro_video` int UNSIGNED DEFAULT '1',
  `lock_private_photo` int UNSIGNED DEFAULT '1',
  `conversation_id` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `info_file` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `paystack_ref` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `securionpay_key` int NOT NULL DEFAULT '0',
  `coinbase_hash` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `coinbase_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `yoomoney_hash` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `coinpayments_txn_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_estonian_ci NOT NULL DEFAULT '',
  `fortumo_hash` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `ngenius_ref` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `aamarpay_tran_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `find_match_data` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `telegram_id` bigint UNSIGNED DEFAULT NULL,
  `telegram_auth_date` int UNSIGNED DEFAULT NULL COMMENT 'Last Telegram Auth Date'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `avater`, `address`, `gender`, `facebook`, `google`, `twitter`, `linkedin`, `okru`, `mailru`, `discord`, `wechat`, `qq`, `website`, `instagram`, `web_device_id`, `language`, `email_code`, `src`, `ip_address`, `type`, `phone_number`, `timezone`, `lat`, `lng`, `about`, `birthday`, `country`, `registered`, `lastseen`, `smscode`, `pro_time`, `last_location_update`, `balance`, `verified`, `status`, `active`, `admin`, `start_up`, `is_pro`, `pro_type`, `social_login`, `created_at`, `updated_at`, `deleted_at`, `mobile_device_id`, `web_token`, `mobile_token`, `height`, `hair_color`, `web_token_created_at`, `mobile_token_created_at`, `web_device`, `mobile_device`, `interest`, `location`, `cc_phone_number`, `zip`, `state`, `relationship`, `work_status`, `education`, `ethnicity`, `body`, `character`, `children`, `friends`, `pets`, `live_with`, `car`, `religion`, `smoke`, `drink`, `travel`, `music`, `dish`, `song`, `hobby`, `city`, `sport`, `book`, `movie`, `colour`, `tv`, `privacy_show_profile_on_google`, `privacy_show_profile_random_users`, `privacy_show_profile_match_profiles`, `email_on_profile_view`, `email_on_new_message`, `email_on_profile_like`, `email_on_purchase_notifications`, `email_on_special_offers`, `email_on_announcements`, `phone_verified`, `online`, `is_boosted`, `boosted_time`, `is_buy_stickers`, `user_buy_xvisits`, `xvisits_created_at`, `user_buy_xmatches`, `xmatches_created_at`, `user_buy_xlikes`, `xlikes_created_at`, `show_me_to`, `email_on_get_gift`, `email_on_got_new_match`, `email_on_chat_request`, `last_email_sent`, `approved_at`, `snapshot`, `hot_count`, `spam_warning`, `activation_request_count`, `last_activation_request`, `two_factor`, `two_factor_verified`, `two_factor_email_code`, `new_email`, `new_phone`, `permission`, `referrer`, `aff_balance`, `paypal_email`, `confirm_followers`, `reward_daily_credit`, `lock_pro_video`, `lock_private_photo`, `conversation_id`, `info_file`, `paystack_ref`, `securionpay_key`, `coinbase_hash`, `coinbase_code`, `yoomoney_hash`, `coinpayments_txn_id`, `fortumo_hash`, `ngenius_ref`, `aamarpay_tran_id`, `find_match_data`, `telegram_id`, `telegram_auth_date`) VALUES
(1, 'qweqwe', 'qweqwe@qweqwe.qwe', '$2y$10$Cvmqz/b5l7l6piw8K/REbOQ0lifnKevewI/VK2ZOfjDIAWEqj1Nie', '', '', 'upload/photos/d-avatar.jpg  ', '', '4525', '', '', '', '', '', '', '', '', '', '', NULL, '', 'english', '1818', 'installation', '', 'admin', '', '', '0', '0', NULL, '0000-00-00', '', 1718031531, 1718791198, 5999, 1718031531, 1718791345, 99999760.00, '1', '0', '1', '1', '3', '1', '4', '0', '2024-06-10 14:58:51', NULL, NULL, '', '2d85aee509fc46ca897c21e28791369c9e5989bbd90a4bbbdcc1e0c6b82dfa81ae988cab6981051129405e2a4c22866a205f557559c7fa4b', '', '', '', 1718627687, 0, 'a:4:{s:2:\"ip\";s:36:\"2a03:7380:156:6fae:4f:875a:b9ca:9b5f\";s:7:\"browser\";s:23:\"Google Chrome 124.0.0.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1718455102, 0, 1, 1718269164, 0, 0, 1, 1718269170, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '{\"lat\":\"51.048457\",\"lng\":\"12.1416524\",\"located\":125}', NULL, NULL),
(2, 'after_dark', 'Spasskiy.vadim@gmail.com', '$2y$11$mkS3Hor4TDHD9nF4JfeEmOyAKk2RuN.5nSELDTUY3DbQIT34hFFMu', 'Вадим', 'Анатольевич', 'upload/photos/2024/06/HnKGpuY1R9yJ2ukqldtw_avater.jpeg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'english', '6471', 'site', '185.237.74.70', 'user', '000', 'UTC', '50.437417793530415', '30.622998713322197', '', '2006-06-11', 'AF', 1718037743, 1718699425, 3010, 0, 1718698936, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-10 16:42:23', NULL, NULL, '', 'c2b5c938438eea326ff7826632fca428d56f41624f3ca35340c3ce3c5126fbd80cf1d1091570020306563f3b418fe57f8fc331872343ce44', '', '176', '', 1718633397, 0, 'a:4:{s:2:\"ip\";s:13:\"185.237.74.70\";s:7:\"browser\";s:17:\"Apple Safari 18.0\";s:2:\"os\";s:3:\"mac\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', '{\"add-countries\":0,\"add-genders\":0,\"add-language\":0,\"add-new-article\":0,\"add-new-custom-page\":0,\"add-new-gift\":0,\"add-new-profile-field\":0,\"add-new-sticker\":0,\"affiliates-settings\":0,\"amazon-settings\":0,\"auto-like\":1,\"ban-users\":0,\"bank-receipts\":0,\"change-site-desgin\":0,\"changelog\":0,\"changelogs.html\":0,\"chat-settings\":0,\"custom-design\":0,\"dashboard\":1,\"edit-article\":0,\"edit-countries\":0,\"edit-custom-page\":0,\"edit-genders\":0,\"edit-lang\":0,\"edit-profile-field\":0,\"edit-success-stories\":0,\"edit-terms-pages\":0,\"edit-user-permissions\":0,\"email-settings\":0,\"fake-users\":0,\"general-settings\":0,\"index.html\":0,\"live\":1,\"manage-announcements\":0,\"manage-apps\":1,\"manage-articles\":1,\"manage-blog-categories\":0,\"manage-countries\":0,\"manage-currencies\":0,\"manage-custom-pages\":0,\"manage-faqs\":0,\"manage-genders\":0,\"manage-gifts\":0,\"manage-invitation\":1,\"manage-invitation-keys\":1,\"manage-languages\":0,\"manage-payments\":0,\"manage-photos\":0,\"manage-profile-fields\":0,\"manage-reports\":1,\"manage-stickers\":0,\"manage-success-stories\":0,\"manage-themes\":0,\"manage-updates\":0,\"manage-user-verification\":0,\"manage-users\":1,\"manage-verification-requests\":0,\"manage-website-ads\":0,\"manage_emails\":0,\"manage_terms_pages\":0,\"mock-email\":0,\"pages-seo\":0,\"payment-requests\":0,\"payment-settings\":0,\"payments\":0,\"push-notifications-system\":0,\"referrals-list\":0,\"site-features\":0,\"site-settings\":0,\"social-login\":0,\"system_status\":0,\"video-settings\":0}', 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '{\"lat\":\"50.437396836366254\",\"lng\":\"30.6230067496897\",\"located\":125}', NULL, NULL),
(3, 'Yejene56', 'yejene5549@noefa.com', '$2y$11$x6qpFj8Hvd5PenQmM9d37.dkTaZJfD0eHA3BHLrftI9uz..T7iB0e', 'Raja', 'R', 'upload/photos/2024/06/m8abStK7y2OQVZF6eA9j_avater.jpg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'english', '1922', 'site', '2409:408d:1d82:509f:af49:af63:', 'user', '8610560839', 'UTC', '0', '0', '', '2002-06-10', 'IN', 1718054897, 1718055088, 2643, 0, 1718055134, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-10 21:28:17', NULL, NULL, '', '728b575d5a6f3f7d4fa8818fd2f1b333e3c9f8c9f5d9df0c54f186dc79347be32dd5eeb732978245d02e9bdc27a894e882fa0c9055c99722', '', '162', '2', 1718054897, 0, 'a:4:{s:2:\"ip\";s:38:\"2409:408d:1d82:509f:af49:af63:ef56:29a\";s:7:\"browser\";s:23:\"Google Chrome 125.0.0.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(4, 'Sahil', 'sahilsheoran1748@gmail.com', '$2y$11$2qyOz6d05K0lxC44YaAmKuj6zpKuHwMzvOlTyVLWjfI.WMmAUeKG6', 'Sahil', 'Sheoran', 'upload/photos/d-avatar.jpg', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', 'english', '5142', 'site', '2409:4051:2e42:c0f5:78d1:dd54:', 'user', '', 'UTC', '0', '0', '', '0000-00-00', '', 1718091760, 1718091760, 1645, 0, 1718091789, 0.00, '0', '0', '1', '0', '0', '0', '0', '0', '2024-06-11 07:42:40', NULL, NULL, '', 'bf50b64daf650b849cec31c54baf8c363383d89513f18f7ee4f9a3965c193d6961d3a4d935422170b9937273f2b46912b56d09c8faa7da23', '', '', '', 1718091760, 0, 'a:4:{s:2:\"ip\";s:39:\"2409:4051:2e42:c0f5:78d1:dd54:c057:a1be\";s:7:\"browser\";s:17:\"Google Chrome 4.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(5, 'dovie74_911', 'pietro_jenkins_884@yahoo.com', '$2y$11$MfemWZrwMt8ShUKR0J.euuw/zu3DZUqf606Q7dEYVI/I2jaOQUKT6', 'Valentine Armstrong Sr.', 'Lind', 'upload/photos/2024/06/2tVWYKEBJ3RMhCo71R81_avatar.jpg', '6423 Wilkinson Point Apt. 546\nNew Webster, IA 76921', '4526', 'Lynch, Schmitt and Zulauf', 'Roob-Treutel', 'Bahringer, Okuneva and Zulauf', 'Auer PLC', '', '', '', '', '', 'Lockman, Roberts and Jacobs', 'Cormier-Kling', '', 'english', '3692', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '787.950.0309 x708', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BE', 1718096915, 1718096915, 2437, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(6, 'ggrady_317', 'chuels_516@yahoo.com', '$2y$11$iGTZ6//nM5hb4P4Xogc5R.hxkePyLS78TxszTRIYQXI1BI1sPJIOO', 'Henri Howe', 'Macejkovic', 'upload/photos/2024/06/1U7FmGZ66MtdtjEurQYs_avatar.jpg', '25051 Turner Radial Apt. 956\nEast Velvabury, OH 88358-2241', '4526', 'Kilback LLC', 'Schamberger-Stark', 'Wehner PLC', 'Greenfelder-Mayert', '', '', '', '', '', 'Tillman-Kshlerin', 'Lebsack PLC', '', 'english', '1324', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-584-648-6401 x786', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'CN', 1718096915, 1718096915, 5765, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(7, 'giovanny96_500', 'darrion_swift_911@yahoo.com', '$2y$11$W8q5HTe/Dt6opJnva9E8m.D5rv7eo39ZX1uJClGHbgqrZzvc2DcTO', 'Immanuel Legros', 'Schmidt', 'upload/photos/2024/06/muMJifqa2rt8uA2DM8K3_avatar.jpg', '555 Cremin Radial\nWest Benny, DC 72622', '4525', 'Wehner-Pfeffer', 'Kohler-Erdman', 'Breitenberg Ltd', 'Stokes, Weimann and Hoppe', '', '', '', '', '', 'Hirthe, Bradtke and Frami', 'Wolff, Schroeder and Walker', '', 'english', '7481', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-928-631-1563', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AW', 1718096915, 1718096915, 6739, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(8, 'mable.swift_583', 'swaniawski_peter_689@yahoo.com', '$2y$11$MbaZxJz1pd40JjxduJm72.uBcAmdoOpxyoFgKgbQcWfjUEGBjmN5q', 'Britney Dare', 'Stracke', 'upload/photos/2024/06/lCwoMb6YICH3CzHahurk_avatar.jpg', '17422 Mills Meadow Apt. 136\nWest Vaughnview, CT 48602-1793', '4525', 'McDermott PLC', 'Rohan PLC', 'West Ltd', 'Goldner Group', '', '', '', '', '', 'Lind and Sons', 'Berge, Little and Goyette', '', 'english', '7694', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-812-361-7886', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'ST', 1718096915, 1718096915, 3067, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(9, 'marc40_420', 'josefina_vandervort_130@yahoo.com', '$2y$11$opRO7zxSnhcrZuEvecZvVuOefHtsjyXjhoOY1PVu9jeURoFae/3fe', 'Shanny Renner', 'Shanahan', 'upload/photos/2024/06/R7CUzDIWq2pRlzRMXmRk_avatar.jpg', '934 Adrien Mountains\nSouth Marielle, IA 37185-5208', '4526', 'Terry Inc', 'Schultz, Littel and Roberts', 'Denesik PLC', 'Franecki, Kohler and Bogan', '', '', '', '', '', 'Koelpin Group', 'Thiel-Bogisich', '', 'english', '5531', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-950-619-9576', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'TV', 1718096915, 1718096915, 1332, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(10, 'barry.sipes_466', 'runte_ellsworth_583@yahoo.com', '$2y$11$W.lhfHrtgxrDpokGUQkSt.ssiGx4M7SI.d2/emDuKzalp7SmmjoeS', 'Dr. Maxine Watsica MD', 'Wiegand', 'upload/photos/2024/06/o8kfO6zT2QcSgsQ8RXUW_avatar.jpg', '95777 Vilma Views\nGarlandfurt, WV 74316', '4525', 'Gorczany, Rice and O\\&#039;Kon', 'Corkery Ltd', 'Leffler, Schmeler and Ratke', 'Wolf Inc', '', '', '', '', '', 'Bailey-Runolfsson', 'Lehner-Schneider', '', 'english', '7574', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-585-406-7299', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PW', 1718096915, 1718096915, 5819, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(11, 'myundt_871', 'gail96_469@yahoo.com', '$2y$11$Fy8QgzmozFEhIJKoaCKntOHFim11.eIl/oIy3yVLgTfGdgldW3IWG', 'Dr. Jennifer Howe MD', 'Crona', 'upload/photos/2024/06/mdimWaEb1zLGNowVlUi8_avatar.jpg', '285 Lindgren Shoals Suite 391\nSouth Florianstad, NM 11656', '4525', 'Kunze, Harber and Hane', 'Block-Predovic', 'McClure-Nitzsche', 'Parker, Funk and Rutherford', '', '', '', '', '', 'Ratke Ltd', 'Hills LLC', '', 'english', '2621', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-215-602-7879', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'YE', 1718096915, 1718096915, 7950, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(12, 'derrick70_634', 'little_marta_939@yahoo.com', '$2y$11$Cp1NFcZR1Rr9zvLsBS0.bua09x0iGJCT8qbbrlMwTbsk4P79UIkbm', 'Ezequiel Kling', 'Jakubowski', 'upload/photos/2024/06/m1LVoZt8HoMXVXllt7VV_avatar.jpg', '9138 Willms Villages\nNew Kadinmouth, SC 85639', '4526', 'O\\&#039;Connell, Kassulke and Purdy', 'Wehner, Kling and Ratke', 'Rippin Inc', 'Walsh LLC', '', '', '', '', '', 'Baumbach Inc', 'Crooks-Roberts', '', 'english', '6503', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '951.427.1926', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BO', 1718096915, 1718096915, 7456, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:35', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(13, 'kschmeler_311', 'germaine_hamill_957@yahoo.com', '$2y$11$1kuk35PA48AgH.hGcBA9h.Gf2pyVEa2UlIFbUm7c72ZPo6MfYoSIe', 'Mohamed Schiller', 'Witting', 'upload/photos/2024/06/KoLHfd7OLUly6pNG9hbj_avatar.jpg', '727 Orn Spring\nSouth Medaton, IN 51706-5588', '4525', 'Goldner, Labadie and Witting', 'Huels, Jenkins and Roob', 'Olson PLC', 'Walter Group', '', '', '', '', '', 'Bogisich and Sons', 'Wilkinson, Auer and Huel', '', 'english', '3977', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '429-279-7648', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BB', 1718096916, 1718096916, 6196, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(14, 'angeline.ferry_940', 'nolan_torp_920@yahoo.com', '$2y$11$ZUMAK6RLfizqXuojrIMLjuFsVmZNqK6xErvm0fQWwm6iBmEbh7Mcm', 'Dr. Amari Langosh Sr.', 'Marquardt', 'upload/photos/2024/06/4GKvw62wWogBzLIPJqWI_avatar.jpg', '447 Bogan Loaf\nOrtizstad, NH 23944-0476', '4526', 'Williamson, Stroman and Feeney', 'Sanford-Heller', 'Graham-Johnston', 'Prosacco-Stehr', '', '', '', '', '', 'Treutel-Kunze', 'Luettgen-Buckridge', '', 'english', '6800', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '953-963-2788 x035', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'VN', 1718096916, 1718096916, 7329, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(15, 'missouri59_455', 'gwalter_413@yahoo.com', '$2y$11$eWoEhUanod85XwpRGHU3N.R1LkEAJwXKFHMi1SRp6bk8ygdMp7/Yq', 'Trenton Kris', 'Bashirian', 'upload/photos/2024/06/W3MfA4T7AGfHFh9fhawl_avatar.jpg', '10256 Kendrick Land Suite 808\nArmstrongport, NC 31919', '4525', 'Stokes Inc', 'Smith Group', 'Erdman PLC', 'Heaney-Eichmann', '', '', '', '', '', 'Torphy LLC', 'Paucek-Quigley', '', 'english', '5317', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '451-602-5766', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GS', 1718096916, 1718096916, 4178, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(16, 'slindgren_407', 'btromp_340@yahoo.com', '$2y$11$5fa4gtX5ZK982s9t7/z9duLAeNRGl1b/NBxhQFkBp5uDDorB/3N7W', 'Tracey Hintz', 'Vandervort', 'upload/photos/2024/06/DrdsP1AEA7semNnOQCLn_avatar.jpg', '77679 Emmerich Pike\nEast Willy, CT 29436-4991', '4526', 'Lakin-Lebsack', 'Mayer and Sons', 'Schroeder, Hand and Klein', 'Heller Inc', '', '', '', '', '', 'McCullough-Lueilwitz', 'Kozey, Becker and Welch', '', 'english', '2435', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '419-355-5696 x347', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'EC', 1718096916, 1718096916, 1251, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(17, 'marks.zetta_439', 'pollich_maybelle_697@yahoo.com', '$2y$11$iMFGFYpdiBs5dLC9HVDUyuPKbKcW.xsj10rVUPpJA7YHZr3vAugIW', 'Stella Barrows', 'Wintheiser', 'upload/photos/2024/06/JUtPgcffbkfYDTUluJPs_avatar.jpg', '77286 Katheryn Land Suite 082\nDagmarstad, IL 49733-6595', '4526', 'Wunsch, Bins and Murphy', 'Heidenreich, Thiel and Upton', 'Osinski-Gerhold', 'Schroeder, Farrell and Schneider', '', '', '', '', '', 'Bayer LLC', 'Heller, Hegmann and Kemmer', '', 'english', '9053', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '843.773.8063 x048', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BO', 1718096916, 1718096916, 7069, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(18, 'wellington78_480', 'jennifer38_420@yahoo.com', '$2y$11$MNxoKVyaDlBSizHFFYaq5u.VZSvpHpEDeCobORoSBw2nnAokLvlci', 'Prof. Adalberto Cummerata IV', 'Predovic', 'upload/photos/2024/06/wHpZ1VlOIn4HZbSi1bYh_avatar.jpg', '867 Conn Track Apt. 692\nLake Gwendolynhaven, RI 25794-9226', '4525', 'Blick, Kuvalis and Kiehn', 'Hahn and Sons', 'Larkin, Jaskolski and Schimmel', 'Berge, Konopelski and Maggio', '', '', '', '', '', 'Jast, O\\&#039;Keefe and Tromp', 'Farrell and Sons', '', 'english', '4598', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '351-479-0953', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MT', 1718096916, 1718096916, 9303, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(19, 'weimann.alek_766', 'hubert79_575@yahoo.com', '$2y$11$OnGicV0mWk7sbCON23EUNe9N5oi45TR5ZLJAFqVdcxFII1bZhzDai', 'Dr. Jaquelin Murray', 'Turner', 'upload/photos/2024/06/g4sghFoXPl51yQ5Pj6Vy_avatar.jpg', '930 Mills Terrace\nCollinstown, DE 82296', '4526', 'Gleason Group', 'Brakus, Emmerich and Pollich', 'Bartoletti, O\\&#039;Reilly and Davis', 'Haag LLC', '', '', '', '', '', 'Kertzmann-Rodriguez', 'Runte, Bruen and Hoeger', '', 'english', '4424', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-394-508-1655', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'ZA', 1718096916, 1718096916, 3954, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(20, 'ohara.montana_786', 'iernser_853@yahoo.com', '$2y$11$aBm2ytWrf3JDNLWxNBlDH.86cm1jmvMLBNDm.qBNAbj9xzhggaY06', 'Dell Walsh', 'Nitzsche', 'upload/photos/2024/06/W8JRy5F4QrAUiMKIm2tO_avatar.jpg', '8581 Tamia Estate\nTillmanside, VT 71283-0292', '4526', 'Carter-Stanton', 'Lemke-Jast', 'Bartoletti PLC', 'Kuphal-Bogisich', '', '', '', '', '', 'Crooks-Veum', 'Ondricka, Grady and Herman', '', 'english', '2583', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-837-652-4681', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'OM', 1718096916, 1718096916, 5574, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:36', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(21, 'van50_779', 'gleason_alexys_226@yahoo.com', '$2y$11$.YQ1Nbt4niPv5u9JESYh0.gkZBIqaVtTjNVIvwVtxDc3cGYzQOxau', 'Winifred Kutch', 'Price', 'upload/photos/2024/06/DEljVTcQuFe5IQDOZPor_avatar.jpg', '144 McGlynn Ridges Apt. 428\nJarrellstad, WA 92491', '4526', 'Wiegand LLC', 'Trantow Inc', 'Harris, Konopelski and Krajcik', 'Carter-O\\&#039;Connell', '', '', '', '', '', 'Moore-Huel', 'Mante, Marquardt and Kovacek', '', 'english', '4966', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-489-678-9965', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PS', 1718096917, 1718096917, 4384, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:37', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(22, 'carter.verna_340', 'oconner_cynthia_479@yahoo.com', '$2y$11$S2Vq6TndyqjEtUFKaqctfuYurjxXeLGGoEDOeTekzm.Dn59gcyETm', 'Wendy Kunze', 'Koss', 'upload/photos/2024/06/2jaAgxKoJ3uoUqUMaDco_avatar.jpg', '52242 Esmeralda Stravenue Apt. 984\nEmelieton, MS 33865', '4525', 'Watsica Ltd', 'Cole-Donnelly', 'Roob, Feest and Anderson', 'Quitzon-O\\&#039;Keefe', '', '', '', '', '', 'Wolff LLC', 'Franecki-Reynolds', '', 'english', '6975', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '931.599.4900', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AE', 1718096917, 1718096917, 9619, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:37', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(23, 'sschmidt_786', 'vquitzon_192@yahoo.com', '$2y$11$W1JFzJinQ6ZXS9hfsleueuaH3odHPpwdeuCL20UqV.db1ljhFmvPG', 'Orpha Schulist', 'Cronin', 'upload/photos/2024/06/yCJelBage3BrHKvTjuxR_avatar.jpg', '15634 Jabari Port\nAlexandrachester, IL 74432', '4525', 'O\\&#039;Reilly Inc', 'Cremin LLC', 'Mann, Roberts and Crooks', 'Beahan, Ebert and Stokes', '', '', '', '', '', 'Romaguera PLC', 'Dickens LLC', '', 'english', '3003', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-284-451-2047 x78121', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GG', 1718096917, 1718096917, 8256, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:37', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(24, 'hkuhic_601', 'xdach_326@yahoo.com', '$2y$11$9N2u3OKZFzXiNRSZs8BHOOLHa5GFig/hUIMWq9xM4yy1Mbdk5wl3W', 'Mozell Koepp', 'Considine', 'upload/photos/2024/06/QqVnQnK22GoFmNx8KIbn_avatar.jpg', '84884 Kuhlman Ford Suite 650\nPort Ashtyn, NV 93593', '4525', 'Schumm-Mitchell', 'Stanton-Grimes', 'Kunze Group', 'Purdy, Hayes and Morissette', '', '', '', '', '', 'Kris-Stokes', 'Hegmann-Graham', '', 'english', '1583', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '898.838.0699', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MY', 1718096917, 1718096917, 1282, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:37', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(25, 'ernie85_510', 'audrey_gulgowski_715@yahoo.com', '$2y$11$SVp6.sh2i8RAqBGMxEkasOysWHRAxOIEjLC7c0MJp3f8W74VZXVBm', 'Lauryn Fadel', 'Daugherty', 'upload/photos/2024/06/JPgEHnl4MtU31FUVF9yi_avatar.jpg', '4875 Verda Light\nPort Amaliaport, DE 68173-9118', '4526', 'Kreiger Ltd', 'Heidenreich-Cormier', 'Cremin, Goodwin and Schaden', 'Boyle Group', '', '', '', '', '', 'Abbott-Boyle', 'Schimmel, Muller and Durgan', '', 'english', '1141', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-937-860-3018', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MF', 1718096917, 1718096917, 8928, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:37', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(26, 'blick.loyal_635', 'newell94_791@yahoo.com', '$2y$11$wQfugkB4NF6HCPnbkSHfVe6/oKsofq7NUimUJs2jQ4zUmUksoVake', 'Lucio Kovacek Jr.', 'O\\&#039;Connell', 'upload/photos/2024/06/27Xak4jZJwAMVThfPlGA_avatar.jpg', '467 Bednar Parkway\nPort Majorside, NY 81273', '4525', 'Rau, Auer and Marquardt', 'Daniel-Christiansen', 'Hermann, Jacobson and Ullrich', 'Larson-Armstrong', '', '', '', '', '', 'Mueller-Parker', 'Boyer, Runte and Heathcote', '', 'english', '4576', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(559) 312-3249', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PG', 1718096917, 1718096917, 2076, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:37', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(27, 'lschroeder_598', 'dallas_emmerich_531@yahoo.com', '$2y$11$R5CouTvYy6q7BAcK.nPlGu3FCdsVMW4yOh9kVPt51oVfODaNtAPFu', 'Clifton Von', 'Johns', 'upload/photos/2024/06/mNJwN6dUdPDVs9Uw2DGp_avatar.jpg', '1193 Ilene Extension\nWest Camrynview, SC 19674-6686', '4526', 'Gibson PLC', 'Douglas-Balistreri', 'Bosco, Baumbach and Nicolas', 'Lang-Streich', '', '', '', '', '', 'Bartoletti-Renner', 'Haley-Wehner', '', 'english', '3693', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-562-782-1111 x5509', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AD', 1718096917, 1718096917, 3982, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:37', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(28, 'julien28_940', 'stracke_alberto_967@yahoo.com', '$2y$11$nlm/zqCqaOyTgqbgC6OV0eEdfOyjPX8mI1BsuA5DWQQOdZFZ0QtcC', 'Marjolaine Pfeffer', 'Franecki', 'upload/photos/2024/06/pdDBDQcKar8cIDxWlWz4_avatar.jpg', '7126 Helene Inlet\nNew Johnathon, WI 01978-9059', '4525', 'Fadel-Schaden', 'Boyle Ltd', 'Sawayn-Pouros', 'Kohler, Raynor and Moen', '', '', '', '', '', 'Wisozk-Kemmer', 'Daniel PLC', '', 'english', '3720', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-376-307-1944 x908', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'TH', 1718096918, 1718096918, 2098, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(29, 'chasity.predovic_489', 'heathcote_barry_847@yahoo.com', '$2y$11$R4ZdukdT/bKD9M0wuUu9HupM4aTw2lyXKfIonA5LlP8pjNZ/KPpfK', 'Godfrey Langosh', 'Ebert', 'upload/photos/2024/06/sMzrAdzu7kX45c5MPCju_avatar.jpg', '62512 Lincoln Causeway\nEast Milesstad, OH 55981', '4526', 'Homenick, Rau and Reichel', 'Roob, Rowe and Leffler', 'Schaden-Yundt', 'Hessel-Conroy', '', '', '', '', '', 'Bergnaum LLC', 'Stark, Labadie and McClure', '', 'english', '7093', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+13695348655', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PL', 1718096918, 1718096918, 1676, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(30, 'jovany39_914', 'theodora62_636@yahoo.com', '$2y$11$AuIfMDtEPwWjmo.Zu34Cku3eGooyqE8xu2QEUhvix1N3o.67PuonK', 'Shemar Deckow', 'Schroeder', 'upload/photos/2024/06/UHZlNLPWXapeDUXDLgx5_avatar.jpg', '5193 Rogers Inlet Suite 534\nWest Lailaville, VA 17524', '4526', 'Rodriguez PLC', 'Block-Bashirian', 'Bartoletti, Lubowitz and Fisher', 'Fisher-Lowe', '', '', '', '', '', 'Littel-Cruickshank', 'Miller-Bosco', '', 'english', '8173', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-859-667-3752', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'TF', 1718096918, 1718096918, 4021, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(31, 'romaguera.jamie_616', 'bstracke_468@yahoo.com', '$2y$11$pEfPBng9kDZbGJtcTenWY.47gIc0K4yqqJ0wzl1Qpsp97KDJW28d6', 'Arturo Ryan', 'Windler', 'upload/photos/2024/06/8Ybtvhjbzu4xf6sxh5Re_avatar.jpg', '11496 Mitchell Forest Suite 728\nSouth Leopoldport, MT 13954-8538', '4525', 'Pouros-Jenkins', 'Hodkiewicz LLC', 'Abbott LLC', 'Lockman, Ruecker and Friesen', '', '', '', '', '', 'Goldner, Jenkins and Ruecker', 'Schulist Inc', '', 'english', '9858', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '843.727.6677', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'RE', 1718096918, 1718096918, 9755, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(32, 'kaitlyn48_469', 'jettie00_883@yahoo.com', '$2y$11$E4Yu/DnB9SQjZu31dyFdmeDLIQtx87Qm0YdGGddlkyxQ4V8Bg.0xW', 'Prof. Wilmer Rolfson IV', 'Mante', 'upload/photos/2024/06/8KkxzJkACZ2p9HFSgNpX_avatar.jpg', '454 Kuhic Junction\nPort Russell, ID 10133', '4525', 'Johns-Jerde', 'Stamm, Schaden and Predovic', 'Swift-Trantow', 'Dare, Gorczany and Kihn', '', '', '', '', '', 'Denesik-Rice', 'O\\&#039;Conner LLC', '', 'english', '2905', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '931.436.2966', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AF', 1718096918, 1718096918, 8549, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(33, 'zwhite_296', 'gking_723@yahoo.com', '$2y$11$2.D1xGsOKvrTStiWK6w4XuMC4wtRxs7xDeWXJ2u75H7GfCFicYFz2', 'Anabel Weber', 'Adams', 'upload/photos/2024/06/iblUsWMQ2tkXjHzzsuFB_avatar.jpg', '457 Madonna Terrace\nNew Gladys, UT 19175-7784', '4526', 'Terry Group', 'Stiedemann Ltd', 'Boyer-Zieme', 'Mosciski-White', '', '', '', '', '', 'Considine, Farrell and Okuneva', 'Walsh PLC', '', 'english', '3305', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-986-870-8827', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'DO', 1718096918, 1718096918, 3296, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(34, 'shanna56_874', 'dulce98_600@yahoo.com', '$2y$11$w3Y/ADyy/L8sbykCbYJXPeyVUnV6DXwzB0U65At9gn0fv9bboPJHy', 'Mr. Judge Dicki', 'Bogan', 'upload/photos/2024/06/ybSWFHEg2Rj8wfNhVu6B_avatar.jpg', '4921 Pfeffer Crescent\nSkilesville, MS 17390-1885', '4526', 'Wiegand, Kshlerin and Murray', 'Predovic Ltd', 'Kling-Zemlak', 'Green Ltd', '', '', '', '', '', 'Ward-Bauch', 'Turcotte PLC', '', 'english', '2956', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '774-508-6157', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'FI', 1718096918, 1718096918, 6234, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(35, 'thompson.cornelius_952', 'qrosenbaum_646@yahoo.com', '$2y$11$NXfgBYLTBg7teaJZrZSKVe.NHep6fBmgxmRplq9m3UVXvClXW611O', 'Eldon Smith', 'Prohaska', 'upload/photos/2024/06/1lw5zgaDmigv9yPpERth_avatar.jpg', '1863 Diego Terrace\nEast Katrineville, VT 58429', '4526', 'Wintheiser Group', 'Dickinson, Abernathy and Wilderman', 'Hirthe PLC', 'Pacocha-Rempel', '', '', '', '', '', 'Paucek, VonRueden and Metz', 'Roob, Gaylord and Sporer', '', 'english', '8430', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(652) 653-5289', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MK', 1718096918, 1718096918, 9480, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:38', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(36, 'eichmann.kyler_420', 'istehr_151@yahoo.com', '$2y$11$4cJuWrdOBtDOQgDC/Zzq0.5CZe7N6EW2..pOxr82DL710zWU0QgGS', 'Carleton Robel', 'Smith', 'upload/photos/2024/06/MpYAg22lQm3WObtrDQ1c_avatar.jpg', '42567 Mertz Mission Apt. 235\nKatelynland, MO 66338', '4526', 'Renner Group', 'Haag-Larson', 'Corwin, Hauck and Nikolaus', 'Casper and Sons', '', '', '', '', '', 'Ruecker-Quitzon', 'Marvin-Kub', '', 'english', '8884', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(569) 903-8916 x59587', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GR', 1718096919, 1718096919, 9940, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(37, 'champlin.art_783', 'zoconner_329@yahoo.com', '$2y$11$F1/KiFPhBS1f/V8I4NTBO.V61p71Hrz3k7/jiALpVu/7nuilDLKD6', 'Diamond Jacobi', 'Crona', 'upload/photos/2024/06/EGi6T86VYyvI8F2499Fr_avatar.jpg', '8136 Golda Mission\nEast Zoeyburgh, GA 09036-3527', '4526', 'Miller, Schowalter and Cummings', 'Beahan, Harber and Mueller', 'Sauer-Borer', 'Moore Group', '', '', '', '', '', 'Hyatt-O\\&#039;Connell', 'Deckow-Bahringer', '', 'english', '1361', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(918) 378-3094 x495', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'SZ', 1718096919, 1718096919, 3690, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(38, 'vrenner_966', 'ziemann_friedrich_433@yahoo.com', '$2y$11$spRdNnWZOLhh.3wylcjuaOodIkOftTIzXpxORgkFHfZvFYsoNWfme', 'Lincoln Dickens', 'Gutmann', 'upload/photos/2024/06/Rpnt5Kg88QySczW1wYns_avatar.jpg', '12577 Lavon Forks\nLake Alexieview, WI 43137', '4526', 'Wintheiser-Mayert', 'McKenzie Inc', 'Kreiger-DuBuque', 'Balistreri-Adams', '', '', '', '', '', 'Schowalter Ltd', 'Corwin, Abshire and Marvin', '', 'english', '8432', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '265.790.2647 x9478', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PA', 1718096919, 1718096919, 4949, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL);
INSERT INTO `users` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `avater`, `address`, `gender`, `facebook`, `google`, `twitter`, `linkedin`, `okru`, `mailru`, `discord`, `wechat`, `qq`, `website`, `instagram`, `web_device_id`, `language`, `email_code`, `src`, `ip_address`, `type`, `phone_number`, `timezone`, `lat`, `lng`, `about`, `birthday`, `country`, `registered`, `lastseen`, `smscode`, `pro_time`, `last_location_update`, `balance`, `verified`, `status`, `active`, `admin`, `start_up`, `is_pro`, `pro_type`, `social_login`, `created_at`, `updated_at`, `deleted_at`, `mobile_device_id`, `web_token`, `mobile_token`, `height`, `hair_color`, `web_token_created_at`, `mobile_token_created_at`, `web_device`, `mobile_device`, `interest`, `location`, `cc_phone_number`, `zip`, `state`, `relationship`, `work_status`, `education`, `ethnicity`, `body`, `character`, `children`, `friends`, `pets`, `live_with`, `car`, `religion`, `smoke`, `drink`, `travel`, `music`, `dish`, `song`, `hobby`, `city`, `sport`, `book`, `movie`, `colour`, `tv`, `privacy_show_profile_on_google`, `privacy_show_profile_random_users`, `privacy_show_profile_match_profiles`, `email_on_profile_view`, `email_on_new_message`, `email_on_profile_like`, `email_on_purchase_notifications`, `email_on_special_offers`, `email_on_announcements`, `phone_verified`, `online`, `is_boosted`, `boosted_time`, `is_buy_stickers`, `user_buy_xvisits`, `xvisits_created_at`, `user_buy_xmatches`, `xmatches_created_at`, `user_buy_xlikes`, `xlikes_created_at`, `show_me_to`, `email_on_get_gift`, `email_on_got_new_match`, `email_on_chat_request`, `last_email_sent`, `approved_at`, `snapshot`, `hot_count`, `spam_warning`, `activation_request_count`, `last_activation_request`, `two_factor`, `two_factor_verified`, `two_factor_email_code`, `new_email`, `new_phone`, `permission`, `referrer`, `aff_balance`, `paypal_email`, `confirm_followers`, `reward_daily_credit`, `lock_pro_video`, `lock_private_photo`, `conversation_id`, `info_file`, `paystack_ref`, `securionpay_key`, `coinbase_hash`, `coinbase_code`, `yoomoney_hash`, `coinpayments_txn_id`, `fortumo_hash`, `ngenius_ref`, `aamarpay_tran_id`, `find_match_data`, `telegram_id`, `telegram_auth_date`) VALUES
(39, 'dangelo.adams_788', 'sasha_cartwright_452@yahoo.com', '$2y$11$iARDkyTm5D9qU/.3GcTeK.Ene3ltM.o31D1g4ukiOnrivpytSU9Xy', 'Isac Koss', 'Torphy', 'upload/photos/2024/06/d5Ed2kTHV8YKbqPpUROS_avatar.jpg', '711 McCullough Glens Suite 176\nSouth Kiana, IA 47144-2521', '4525', 'Kuhn, Reilly and Kovacek', 'Jakubowski-Stehr', 'Carter, Smitham and Witting', 'Rogahn, Lebsack and Williamson', '', '', '', '', '', 'Nienow-Lindgren', 'Nader and Sons', '', 'english', '4205', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(481) 320-2360', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BI', 1718096919, 1718096919, 1331, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(40, 'lucy.schumm_664', 'treva79_700@yahoo.com', '$2y$11$hLOoSPr3fqB9ExI0IviSve1xmf1I8l9L9V6KHIqWmHiwM3idZWbsm', 'Dr. Jamal Boehm PhD', 'Berge', 'upload/photos/2024/06/RnT3CVwo4nKikqsUJjFi_avatar.jpg', '2258 Princess Forks Apt. 090\nWest Luciomouth, VT 82844', '4525', 'Lebsack-McKenzie', 'Schneider LLC', 'Rau, Jones and Doyle', 'Hansen, Rau and Bartell', '', '', '', '', '', 'Brekke Ltd', 'Rowe, Moen and Rodriguez', '', 'english', '7022', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1 (226) 745-5566', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'SA', 1718096919, 1718096919, 8197, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(41, 'windler.kamron_958', 'jwillms_681@yahoo.com', '$2y$11$0PZgE5KhAuuMvaBZbuMV8uvYjcS8DJ/Mv71j0tud0xYRLePsEJxmW', 'Lesley Maggio', 'Gaylord', 'upload/photos/2024/06/9R1yc45w4DkQSQ5M4lHi_avatar.jpg', '785 Jake Terrace\nWest Arlene, OH 50861', '4526', 'Fadel-Mitchell', 'Parker PLC', 'Brekke Inc', 'Cassin LLC', '', '', '', '', '', 'Murphy LLC', 'Hill, Ortiz and Altenwerth', '', 'english', '3100', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '635-957-1400', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'NZ', 1718096919, 1718096919, 1177, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(42, 'vivianne06_545', 'istokes_972@yahoo.com', '$2y$11$EGv12.mqyjEQ1Q9.yZntme0sadS2/q4gp2DIV9ImAk0E2L1eCKL2q', 'Roberto Daugherty', 'Cormier', 'upload/photos/2024/06/M6YPLJFYplDGtglBYJrU_avatar.jpg', '303 Jessyca Grove Apt. 721\nTorrancebury, ME 98801', '4526', 'Hartmann Inc', 'Gleason and Sons', 'Cole PLC', 'Bailey, Moore and Huel', '', '', '', '', '', 'Zulauf, Rau and Swaniawski', 'Flatley, Jerde and Emard', '', 'english', '9012', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-271-203-4465', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'EC', 1718096919, 1718096919, 2700, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(43, 'murphy.joana_365', 'schuster_skyla_192@yahoo.com', '$2y$11$vYllqC/OlBS0rblu4jlzEOrqwZcu0Wixn3wju/dq/zlKSGGd37dx6', 'Eileen Dach Jr.', 'Reinger', 'upload/photos/2024/06/4xxJgHXTmcIq7JefX6Sy_avatar.jpg', '977 Tremblay Point\nOlsonfurt, ME 54471-4881', '4525', 'Legros-Davis', 'Schimmel-Funk', 'Labadie, Bashirian and Maggio', 'Hermann-Jenkins', '', '', '', '', '', 'Herzog PLC', 'Corwin-Yundt', '', 'english', '1687', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '979.947.7571', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PN', 1718096919, 1718096919, 3574, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:39', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(44, 'jane20_573', 'ritchie_aliza_393@yahoo.com', '$2y$11$.EJr9HtRcw4Xp6fb0KJ2h.woWuCx9At05vKb5HiBVQRiUYfGdTaIy', 'Tyrique Smith', 'Abshire', 'upload/photos/2024/06/axhhp8hvtwjdUkgeRG56_avatar.jpg', '175 Eden Road\nEast Oswaldomouth, TN 27065-4395', '4525', 'Zemlak Group', 'Ratke Inc', 'Barton LLC', 'Muller and Sons', '', '', '', '', '', 'Nolan Group', 'Bayer-Ryan', '', 'english', '1191', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '505.644.4394 x4462', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'ZW', 1718096920, 1718096920, 3727, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(45, 'leannon.eric_482', 'margarete06_732@yahoo.com', '$2y$11$9yv.zAlMI8CFyZfzt38VgeBnHWE0ycy0hEGMA4gurf3GqnXc/q.Jm', 'Prof. Blaise Metz I', 'Turcotte', 'upload/photos/2024/06/TRKzyNYX5FCXU1B1pVjj_avatar.jpg', '20782 Ethel Crescent\nLake Garth, OR 40134', '4525', 'McDermott, Ryan and Hackett', 'Wuckert LLC', 'Corkery-Baumbach', 'Hill, McKenzie and Simonis', '', '', '', '', '', 'Hudson PLC', 'Barton LLC', '', 'english', '8051', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-994-488-0205 x563', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BV', 1718096920, 1718096920, 3833, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(46, 'schulist.brett_759', 'west_evie_398@yahoo.com', '$2y$11$FrJfhnM8LVsF6607xAmvIOSy2hLfrhbdTUTtY1PTSOUx6mucnDC6C', 'Guillermo Casper', 'Donnelly', 'upload/photos/2024/06/k5ytcGUK4r4uE5lK9wiy_avatar.jpg', '29462 Veum Road Suite 975\nLake Tracey, ME 51350-1619', '4526', 'Stracke-Corkery', 'Hilpert Group', 'Gleichner Inc', 'Walter and Sons', '', '', '', '', '', 'Torp, Bosco and Ledner', 'Pouros, Wiza and Hills', '', 'english', '9804', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-648-316-3353', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'CG', 1718096920, 1718096920, 6492, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(47, 'toni96_246', 'adan83_142@yahoo.com', '$2y$11$2EhCUV0m9gsw3IcfnCC3jeDs4b4XlPTyxEpvPqcvtuFQGEXw79s/a', 'Keanu Buckridge', 'Walsh', 'upload/photos/2024/06/on8NE5CNlDtU1sZLvIFq_avatar.jpg', '56847 Koss Spring\nSchowalterland, GA 04013', '4526', 'Kreiger, Mann and Sipes', 'Lubowitz Inc', 'Rau-Pacocha', 'Fahey, Simonis and Crona', '', '', '', '', '', 'Ebert Group', 'Marks Ltd', '', 'english', '3603', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(313) 798-6444 x7106', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PG', 1718096920, 1718096920, 6273, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(48, 'stroman.aileen_978', 'chelsea80_765@yahoo.com', '$2y$11$7Vq5o.Lwo2NTVljeALPHYeh/QcHlM1ECnBiMnRFSSj/LMlZnSrdqW', 'Lula Fritsch', 'Gerlach', 'upload/photos/2024/06/QlVwqBIcW4p8Vx4Wwnrd_avatar.jpg', '211 Emard Keys Suite 517\nSouth Dixie, ID 88678', '4526', 'Barrows, Dare and Abbott', 'Weber-Hane', 'Rogahn-Waelchi', 'Hermann-Monahan', '', '', '', '', '', 'O\\&#039;Kon, Waelchi and White', 'Hirthe Group', '', 'english', '9237', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '719.919.5780 x792', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PN', 1718096920, 1718096920, 2013, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(49, 'dooley.aimee_385', 'maximillia35_276@yahoo.com', '$2y$11$L1uCQ/3EXjzB6JJLgp0/guL3qa1ks.//L2IHZyYLZSuoac4d7bwEW', 'Andreane Hoppe', 'Reichel', 'upload/photos/2024/06/FXPQZKEp4wjkQrDvazrN_avatar.jpg', '5753 Flatley Center\nSouth Jazmin, NM 27556-8981', '4526', 'Keeling-Zemlak', 'Abernathy PLC', 'Christiansen Inc', 'Kautzer, Cassin and Hudson', '', '', '', '', '', 'Smitham, Quitzon and Pagac', 'Hackett-Fay', '', 'english', '1295', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(285) 480-6348 x656', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'VN', 1718096920, 1718096920, 2930, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(50, 'erika58_758', 'gkutch_403@yahoo.com', '$2y$11$g.Tzs0Dr2enqq1MG0uJfK.QzvyrReCjxQb2YyQseAJUNy7T/dPNO6', 'Shanna Gutkowski', 'Hodkiewicz', 'upload/photos/2024/06/TzD4jfUVX9aAmQ5aCVPz_avatar.jpg', '17460 Zaria Ford\nChethaven, PA 41969', '4526', 'Cummerata Ltd', 'Jacobson, Littel and Hudson', 'Tillman LLC', 'Orn, Koss and Von', '', '', '', '', '', 'O\\&#039;Conner LLC', 'Satterfield, Kovacek and Sanford', '', 'english', '8052', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '401.739.0592', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'LK', 1718096920, 1718096920, 7472, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(51, 'mason11_784', 'max_douglas_544@yahoo.com', '$2y$11$9QLGuNXWrJTFRvjcwGH74OIeHiUhgtBK3DGoAFV0VFf.mm8jbgE2u', 'Jannie Roberts', 'Kertzmann', 'upload/photos/2024/06/7P4WdauEmBvK3C9aVZFU_avatar.jpg', '596 Jordi Rest\nSouth Lelaland, NV 78894-3840', '4525', 'Douglas-Jacobs', 'Beatty, Parisian and Kassulke', 'O\\&#039;Keefe LLC', 'Reinger-Goodwin', '', '', '', '', '', 'Pacocha, Swift and Johnston', 'Sporer LLC', '', 'english', '5142', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '696-864-0605', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GA', 1718096920, 1718096920, 5775, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(52, 'rowe.khalil_701', 'gregorio59_527@yahoo.com', '$2y$11$JruFs3oYdz9Gi8FT9i6rEeczNxMydqXi/ejAxfelSvy2VcFl5n4He', 'Jeff Schmidt', 'Stamm', 'upload/photos/2024/06/BX1QVqhwFMcWjDUZObHX_avatar.jpg', '435 Dallas Station\nEast Marilie, AL 46496-7303', '4525', 'Ledner, Schimmel and Smith', 'Ledner-Gottlieb', 'Olson-Will', 'O\\&#039;Connell-Larkin', '', '', '', '', '', 'Schaden and Sons', 'Lang Ltd', '', 'english', '3242', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '231.348.1140', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'SB', 1718096920, 1718096920, 2046, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:40', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(53, 'fermin78_654', 'fanny_willms_209@yahoo.com', '$2y$11$g7euKQwogcZNIoTvCQ9XjOm8Ylg7m5XNFzNCfNGYMxFPAbAERL/m2', 'Mrs. Carmela Witting IV', 'Rolfson', 'upload/photos/2024/06/6pHNeDSO2lWZKtj5cC8g_avatar.jpg', '394 Bergnaum Lane Suite 847\nRodborough, MO 51880', '4525', 'Mante-Cole', 'Ferry and Sons', 'Hagenes-Cassin', 'Macejkovic Inc', '', '', '', '', '', 'Balistreri PLC', 'Feeney PLC', '', 'english', '9494', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1.282.466.1997', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'VN', 1718096921, 1718096921, 3132, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(54, 'ledner.llewellyn_268', 'hbins_640@yahoo.com', '$2y$11$CNrbfWZdfPzJfsA9.XPh.OfTFbO2iDyxe4ILKC.SLacZxrBRHxBBa', 'Dr. Helene Tillman', 'Hegmann', 'upload/photos/2024/06/8NZPj6oGzeJaYwLos2CR_avatar.jpg', '832 Myrtie Cliffs\nPollichport, GA 89445-9464', '4525', 'Bosco-Hahn', 'Goyette and Sons', 'Friesen Ltd', 'White, Kassulke and Hammes', '', '', '', '', '', 'Schumm, Ward and Herman', 'Hessel, O\\&#039;Keefe and Crooks', '', 'english', '9065', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(450) 425-3416 x768', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GU', 1718096921, 1718096921, 4708, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(55, 'khoeger_450', 'jemmerich_672@yahoo.com', '$2y$11$SC.Uoi2YvQYjlmG0upv72OXWieBUs8X5kCqJ08jXf3MAIVhBHR9pe', 'Dr. Nathan Bergnaum', 'Hayes', 'upload/photos/2024/06/N5a7UAKYcM4VdD7Jtrjn_avatar.jpg', '6933 Giovanni Forks\nLake Nia, SC 95565', '4526', 'Tremblay Ltd', 'Bechtelar, Fay and Lowe', 'Okuneva Ltd', 'Thiel, Hintz and Wilkinson', '', '', '', '', '', 'Greenfelder LLC', 'Corwin, Corwin and Wehner', '', 'english', '4705', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '590.256.1399', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MQ', 1718096921, 1718096921, 1240, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(56, 'freichel_720', 'jedidiah45_576@yahoo.com', '$2y$11$tOd0gnYZ5qoAzEcW3Tdd7ek/fjpKcVpitQ8S//7JWwEuo7g.UGyxe', 'Mr. Adolphus Renner', 'Farrell', 'upload/photos/2024/06/vuBIs57cjb1YYw8dezKf_avatar.jpg', '58043 Lind Loaf Suite 424\nBlandaport, KY 40899-6397', '4526', 'Ratke, Streich and Bernier', 'Torphy-Veum', 'Jakubowski-Cruickshank', 'Leffler LLC', '', '', '', '', '', 'Waters-Kreiger', 'O\\&#039;Kon, Willms and Howe', '', 'english', '2930', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-509-720-7201', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'ZW', 1718096921, 1718096921, 4838, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(57, 'ofranecki_803', 'walsh_madie_362@yahoo.com', '$2y$11$Tifp7Ir9DPdd38EBvasCee.nl2.6/lhPqMXG56JUqHdvYxC/UBUR.', 'Mckenna Vandervort I', 'O\\&#039;Keefe', 'upload/photos/2024/06/BEpWbgp9lSgtIP2Tmj67_avatar.jpg', '477 Dell Course\nHillstown, DE 43164-0769', '4526', 'O\\&#039;Reilly-Bruen', 'Stehr Ltd', 'Donnelly Group', 'Stanton-Rosenbaum', '', '', '', '', '', 'Baumbach-Waters', 'Windler, Murray and Blanda', '', 'english', '3000', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(512) 318-4244 x52183', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'TW', 1718096921, 1718096921, 7188, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(58, 'wbatz_697', 'cwest_937@yahoo.com', '$2y$11$n0D0T/NiWpX8bRPDeBDWR.kOVUdzqMS6dkKCygz0.MEQ4s52OEbb.', 'Major Parker', 'Medhurst', 'upload/photos/2024/06/8EJmR6Wic3MEiazx3xGT_avatar.jpg', '9268 Blanda Park Suite 917\nHarleyshire, UT 74071', '4526', 'Denesik Ltd', 'Quigley LLC', 'Buckridge Inc', 'Vandervort-Blanda', '', '', '', '', '', 'Zemlak, Jones and Willms', 'Hirthe-DuBuque', '', 'english', '6769', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(309) 758-2924', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'UM', 1718096921, 1718096921, 4955, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(59, 'terrence24_824', 'atreutel_726@yahoo.com', '$2y$11$AXqzvAuo3VW3miSH50WS1.webe3RIqhK4eFYGcUuxFcKLabCxUOtm', 'Dr. Francis Miller MD', 'Wilderman', 'upload/photos/2024/06/fU7jQcFq8UMhSoDhlTVq_avatar.jpg', '7494 Boyle Wall\nEast Mable, TN 16908-2932', '4525', 'McKenzie-Kunde', 'Ebert-Hoeger', 'McCullough-Goyette', 'Boehm Ltd', '', '', '', '', '', 'Reilly Inc', 'Wunsch, Conroy and Tillman', '', 'english', '4430', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(857) 430-6054 x891', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AO', 1718096921, 1718096921, 5775, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(60, 'jamil30_850', 'ytorp_157@yahoo.com', '$2y$11$KZJbFSBlImv8KUUxfvcxEeOV6h6Mgxz6wi.gOVw4gdS7Zau.y1LNy', 'Maxwell Treutel', 'Cormier', 'upload/photos/2024/06/rd1wMlZwVjg7FvFfY223_avatar.jpg', '20419 Ryann Mount Suite 304\nRaquelborough, NM 71648-8268', '4525', 'Balistreri LLC', 'Hodkiewicz Group', 'Lesch PLC', 'Marquardt LLC', '', '', '', '', '', 'Pacocha, Rath and Armstrong', 'Champlin, Graham and Jenkins', '', 'english', '8264', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-481-755-5835 x880', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'CH', 1718096921, 1718096921, 8210, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:41', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(61, 'otho71_498', 'green_velma_185@yahoo.com', '$2y$11$X/CHFQMwFB09BRkVf1bKFO7dTSxVg1uT7IwU.fuh2R0rv1U7II11m', 'Ms. Alivia Kuhic', 'Wolf', 'upload/photos/2024/06/enJ2ywaCwHl6yh3DFK73_avatar.jpg', '922 Felipe Spring\nSouth Makenzie, MO 85680-2622', '4526', 'McClure-Feest', 'Kemmer Ltd', 'Beahan-Koch', 'Senger LLC', '', '', '', '', '', 'Jakubowski-Sawayn', 'Goodwin Group', '', 'english', '4423', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '552-361-5847 x0458', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'SV', 1718096922, 1718096922, 3466, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(62, 'gchamplin_835', 'rstamm_423@yahoo.com', '$2y$11$jUs1IFJnmpS0HNp2men5IuH7iWF5SNm5yy8wAE2uxibVw1kkj0Q1m', 'Prof. Ricardo Kuhlman', 'Jacobi', 'upload/photos/2024/06/xulV1W5rdTVkUoB3KNWO_avatar.jpg', '7184 Dino Trafficway\nMakennaville, MA 40831-4726', '4525', 'Wiegand and Sons', 'King-Conroy', 'Nienow Group', 'Goyette Inc', '', '', '', '', '', 'Brekke-Trantow', 'McLaughlin, Keebler and Leuschke', '', 'english', '7421', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+15382636311', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AQ', 1718096922, 1718096922, 6401, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(63, 'cody72_392', 'koepp_lera_183@yahoo.com', '$2y$11$iBIVHtdvgtoHok3ODEiIbOZVdHtoX1Z9YO5n/nfwQXpGRj3dAfaym', 'Zaria Walter', 'Batz', 'upload/photos/2024/06/lROqEdXUYfT6ridaOfOV_avatar.jpg', '4796 Grimes Mission Apt. 245\nNew Callie, AZ 76235', '4525', 'Mosciski-Schmitt', 'Boyer, Cole and Leuschke', 'Buckridge PLC', 'Will PLC', '', '', '', '', '', 'Marvin PLC', 'Fritsch PLC', '', 'english', '4489', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '810-346-4131 x621', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'CM', 1718096922, 1718096922, 8046, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(64, 'lcarter_255', 'lhettinger_581@yahoo.com', '$2y$11$5S/g33yKu5F97BqC3GAabu2J0KBCAcF.ixH.C3.Vg9OvLRONVfKoe', 'Bryon Jast', 'Boyle', 'upload/photos/2024/06/aMLzQaZxB2R6HbTOXfOS_avatar.jpg', '333 Brian Ports\nLake Hattie, RI 55592-0368', '4525', 'O\\&#039;Keefe-Anderson', 'Toy, Douglas and Prohaska', 'Pfannerstill, Walker and Breitenberg', 'Cole-Renner', '', '', '', '', '', 'Thiel-King', 'Stehr-Labadie', '', 'english', '3864', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-516-785-0655 x47453', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PS', 1718096922, 1718096922, 9959, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(65, 'aracely09_606', 'euna_stamm_559@yahoo.com', '$2y$11$U.gyoXrz5MwhfWl57eEjiOh30u676TyUI4jTzyOunrFx.yAPA6SoW', 'Miss Aiyana Bins DVM', 'Herman', 'upload/photos/2024/06/gPfwkUfq5679IVyMAZQk_avatar.jpg', '249 Glennie Square Apt. 478\nWizashire, CO 28061', '4526', 'Wehner-Nader', 'Halvorson PLC', 'Balistreri-Herman', 'Tromp-Cruickshank', '', '', '', '', '', 'Hoeger Group', 'Bailey, Connelly and Rosenbaum', '', 'english', '6562', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '604.727.9819 x47587', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'HN', 1718096922, 1718096922, 1529, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(66, 'reichert.francisca_857', 'gladyce00_333@yahoo.com', '$2y$11$OAa.ZY3klv9NjVCoDfuDfeiAGA0SI5h03YvN7XIuNKturfA0TYcGa', 'Mr. Adrien Rempel', 'Pacocha', 'upload/photos/2024/06/qJNQwyEXqNthoPpBBvaC_avatar.jpg', '133 Ahmad Cliff Suite 050\nSchusterstad, NM 29913-2968', '4526', 'Terry, Jacobi and Deckow', 'Konopelski-Prosacco', 'Bashirian-Treutel', 'O\\&#039;Kon Inc', '', '', '', '', '', 'Herman, Little and Daniel', 'Sipes-Corwin', '', 'english', '7544', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(336) 515-6960', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'ID', 1718096922, 1718096922, 6947, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(67, 'katelynn56_951', 'travon92_373@yahoo.com', '$2y$11$7PDrBkZS59NbF04AaP1Nj.BB8AGODm53SnLeKFpxAFnnr0EfLctp2', 'Prof. Bessie Jacobs Sr.', 'Kuvalis', 'upload/photos/2024/06/scOPc3JxsvO3Jcn5jIiq_avatar.jpg', '19032 Buckridge Skyway\nLake Elfriedatown, AL 82838-4274', '4526', 'Sporer Ltd', 'Von, Crona and Bosco', 'Miller Ltd', 'Lind-Skiles', '', '', '', '', '', 'Wiza-Rice', 'Kirlin Ltd', '', 'english', '2523', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-384-516-4295', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GG', 1718096922, 1718096922, 5942, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(68, 'eladio28_565', 'rebecca55_331@yahoo.com', '$2y$11$FEhDjqd4WWOlteINBnS6fuaK7CfRGWM.0L3G6LgIzCaQ04osRzRny', 'Dakota Klocko', 'Oberbrunner', 'upload/photos/2024/06/aGerLQUZWrZNq8HEXRzs_avatar.jpg', '2427 Heaney Groves\nNorth Marguerite, OH 36834', '4526', 'Mueller, Dare and Kunze', 'Trantow-Gulgowski', 'Greenholt Ltd', 'Bergstrom-Swift', '', '', '', '', '', 'McDermott-Botsford', 'Hirthe, Lemke and Stark', '', 'english', '3305', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-564-364-8863 x4406', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'VE', 1718096922, 1718096922, 4398, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:42', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(69, 'ecorkery_611', 'aniya_lynch_617@yahoo.com', '$2y$11$Zs9Oxf8Mn9GJmBx42NZjtuNneS4BoigZOkAB.BsY9Ckopqqne7zuu', 'Ramon Tromp', 'Shields', 'upload/photos/2024/06/XhGk4u3NempmOeFbH4vU_avatar.jpg', '97039 Feest Garden Suite 199\nAldenmouth, WA 00654', '4525', 'Heller-Gleason', 'Rutherford-Adams', 'Lakin, King and Turner', 'Upton, Fadel and Hansen', '', '', '', '', '', 'Schmeler-Wisoky', 'Ullrich-Batz', '', 'english', '3485', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-356-501-5304', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'RO', 1718096923, 1718096923, 9342, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(70, 'yfarrell_265', 'macie_roob_933@yahoo.com', '$2y$11$lAasSfp9gllTh0eze3QD0.aTx35Ik5DYmkJPTlV2eI8KQPyBilLkS', 'Ernie Lueilwitz', 'Mante', 'upload/photos/2024/06/gSOzmHOCe4FjtmG72bcC_avatar.jpg', '82066 Bertrand Hills\nKuhlmanfort, PA 18100', '4526', 'Bauch-Koss', 'Leffler, Bogan and McDermott', 'McGlynn PLC', 'Upton-Carter', '', '', '', '', '', 'Osinski and Sons', 'Lubowitz, Hagenes and Kertzmann', '', 'english', '9378', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(939) 942-2740 x0146', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AR', 1718096923, 1718096923, 6864, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(71, 'qnienow_146', 'harris_martin_897@yahoo.com', '$2y$11$0VaAkbjp.VdMfORiAvRI0uJME/ci6unHgOEg0tn5VzId96iQHXFly', 'Viva Schaefer', 'Kohler', 'upload/photos/2024/06/JVHzmIZ3RbWLE16Pf1JP_avatar.jpg', '6168 Lucinda Square\nMollieshire, NY 90671-1419', '4526', 'Strosin-Quitzon', 'Monahan LLC', 'Flatley-Walter', 'Rowe, Wolf and Lockman', '', '', '', '', '', 'Rempel LLC', 'Armstrong, Osinski and Heathcote', '', 'english', '5124', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(339) 592-5641', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'SY', 1718096923, 1718096923, 4378, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(72, 'alvina93_948', 'sabrina26_450@yahoo.com', '$2y$11$k6fsdjpG0gE5vbOOG4GGrezSxzPHp4xL7T3PLFK14v0waKjvkSD8O', 'Dr. Enrico Nolan Sr.', 'Bayer', 'upload/photos/2024/06/tY6aQhYCYZHWC8PkAoxP_avatar.jpg', '20718 Stamm Glens\nSouth Zackery, IL 96342-6052', '4525', 'Glover Ltd', 'Schroeder-Hartmann', 'Leffler, Pacocha and Kuvalis', 'Haley, Wiza and Johnson', '', '', '', '', '', 'D\\&#039;Amore-Bechtelar', 'Jakubowski-Towne', '', 'english', '8709', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-603-481-8207', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'LA', 1718096923, 1718096923, 6475, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(73, 'caterina02_422', 'jyundt_437@yahoo.com', '$2y$11$MQwi9MvIuEHJDX5JOswevukIL414ve7eCv9eh/eI3BmfgjHzB.sVK', 'Neil Marvin', 'Corwin', 'upload/photos/2024/06/Wu4eRBztvVfbdOEci34f_avatar.jpg', '983 Kirk Junction\nMaiyafurt, LA 18665-4003', '4526', 'Bradtke Inc', 'Denesik-Macejkovic', 'Koss Inc', 'Schmitt-Daniel', '', '', '', '', '', 'Wolff LLC', 'Beer Inc', '', 'english', '9276', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(872) 904-8137 x4903', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BL', 1718096923, 1718096923, 6867, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(74, 'rauer_474', 'cheyenne_streich_914@yahoo.com', '$2y$11$thqL6SqbPIg5y/446cH3A.RHacgIGvcfeQ6EqnLXfKa.w28u2o006', 'Justen Franecki', 'Fritsch', 'upload/photos/2024/06/RBSLVrN9IbjOin3MMWTk_avatar.jpg', '78163 Georgette Points Suite 104\nWest Asashire, NJ 70637-0589', '4526', 'Flatley, Gerhold and Heller', 'Leuschke LLC', 'Kessler Group', 'Cole-Carroll', '', '', '', '', '', 'Willms-Von', 'Abbott-Hahn', '', 'english', '6468', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-667-335-6900', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'RU', 1718096923, 1718096923, 9499, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(75, 'macejkovic.raoul_573', 'kaitlyn_kuvalis_819@yahoo.com', '$2y$11$Xt0aqm58Iwg2aXdhsHJTVeopmc.wk5.6oW3nhstZnspi4gUaD8B6m', 'Ruthie Ritchie', 'Steuber', 'upload/photos/2024/06/XspyurrHYKy6raBKEBCF_avatar.jpg', '5520 Constance Cape Apt. 905\nTrompfurt, NE 48221', '4525', 'Zemlak-Robel', 'Graham Group', 'Heidenreich Inc', 'Ortiz Group', '', '', '', '', '', 'Fahey, Fisher and Kirlin', 'Dickens, Nienow and Marquardt', '', 'english', '6531', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '981-338-6532 x03343', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BY', 1718096923, 1718096923, 2444, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(76, 'ava67_979', 'moen_daron_221@yahoo.com', '$2y$11$RO2CnuB/WJiGyYRPsKyZFe8vE/gK2aU3HHIaEaMHJdhhbuq62O47u', 'Dr. Damion Bergstrom', 'Kihn', 'upload/photos/2024/06/JcWTSaRySCV59lPeJKfB_avatar.jpg', '1370 Kaelyn Pike Suite 462\nRaphaelside, OR 08904-2002', '4525', 'Gusikowski, Swift and Leuschke', 'Fadel, Rippin and Jacobs', 'Schneider, Effertz and Dooley', 'VonRueden, Padberg and Schaden', '', '', '', '', '', 'Hamill Inc', 'Mosciski, Buckridge and Nikolaus', '', 'english', '3863', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-360-643-7696', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GG', 1718096923, 1718096923, 9766, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:43', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(77, 'lwyman_259', 'franecki_amiya_188@yahoo.com', '$2y$11$EXVaIlIqv61v/HH7ikQQn.87WtDnCdsO1ZY7REe.w0bzHE5CG8Sgm', 'Kaylie O\\&#039;Connell PhD', 'Gerlach', 'upload/photos/2024/06/yw4Zt48Whulw3iTSZkQA_avatar.jpg', '386 Abner Square Suite 342\nHaagton, CT 47685', '4525', 'Kozey, Schimmel and Huels', 'Mante LLC', 'Towne-Mitchell', 'Frami, McLaughlin and Donnelly', '', '', '', '', '', 'Hills-McClure', 'Rempel LLC', '', 'english', '2429', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-851-620-1437 x5754', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'OM', 1718096924, 1718096924, 8316, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL);
INSERT INTO `users` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `avater`, `address`, `gender`, `facebook`, `google`, `twitter`, `linkedin`, `okru`, `mailru`, `discord`, `wechat`, `qq`, `website`, `instagram`, `web_device_id`, `language`, `email_code`, `src`, `ip_address`, `type`, `phone_number`, `timezone`, `lat`, `lng`, `about`, `birthday`, `country`, `registered`, `lastseen`, `smscode`, `pro_time`, `last_location_update`, `balance`, `verified`, `status`, `active`, `admin`, `start_up`, `is_pro`, `pro_type`, `social_login`, `created_at`, `updated_at`, `deleted_at`, `mobile_device_id`, `web_token`, `mobile_token`, `height`, `hair_color`, `web_token_created_at`, `mobile_token_created_at`, `web_device`, `mobile_device`, `interest`, `location`, `cc_phone_number`, `zip`, `state`, `relationship`, `work_status`, `education`, `ethnicity`, `body`, `character`, `children`, `friends`, `pets`, `live_with`, `car`, `religion`, `smoke`, `drink`, `travel`, `music`, `dish`, `song`, `hobby`, `city`, `sport`, `book`, `movie`, `colour`, `tv`, `privacy_show_profile_on_google`, `privacy_show_profile_random_users`, `privacy_show_profile_match_profiles`, `email_on_profile_view`, `email_on_new_message`, `email_on_profile_like`, `email_on_purchase_notifications`, `email_on_special_offers`, `email_on_announcements`, `phone_verified`, `online`, `is_boosted`, `boosted_time`, `is_buy_stickers`, `user_buy_xvisits`, `xvisits_created_at`, `user_buy_xmatches`, `xmatches_created_at`, `user_buy_xlikes`, `xlikes_created_at`, `show_me_to`, `email_on_get_gift`, `email_on_got_new_match`, `email_on_chat_request`, `last_email_sent`, `approved_at`, `snapshot`, `hot_count`, `spam_warning`, `activation_request_count`, `last_activation_request`, `two_factor`, `two_factor_verified`, `two_factor_email_code`, `new_email`, `new_phone`, `permission`, `referrer`, `aff_balance`, `paypal_email`, `confirm_followers`, `reward_daily_credit`, `lock_pro_video`, `lock_private_photo`, `conversation_id`, `info_file`, `paystack_ref`, `securionpay_key`, `coinbase_hash`, `coinbase_code`, `yoomoney_hash`, `coinpayments_txn_id`, `fortumo_hash`, `ngenius_ref`, `aamarpay_tran_id`, `find_match_data`, `telegram_id`, `telegram_auth_date`) VALUES
(78, 'hahn.leonard_268', 'kaia_graham_949@yahoo.com', '$2y$11$hQniDn1h12/a4Z/vTHwx/eMWLDpgHSs3qyoeKY7DJEA40eidiYNXK', 'Ms. Bonnie McLaughlin Sr.', 'Blick', 'upload/photos/2024/06/Zzy7kJfFlYmWTmhfmPsZ_avatar.jpg', '45987 Kling Canyon Apt. 887\nMannland, IN 14939-3463', '4526', 'Cartwright-Gutmann', 'Heaney PLC', 'Jenkins PLC', 'Dicki, Hilpert and Fadel', '', '', '', '', '', 'Bahringer Group', 'Sanford, Wilkinson and Trantow', '', 'english', '4273', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-459-480-5577 x46455', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AN', 1718096924, 1718096924, 6268, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(79, 'hegmann.marshall_789', 'sporer_carlotta_818@yahoo.com', '$2y$11$T77KYIBDRa1V9vMN6n8SouK.hcOY9NrpdScNUbxnCly/us4RCwO9.', 'Marielle Sauer', 'Bode', 'upload/photos/2024/06/amCpFH3PqpjMeVoeRk8g_avatar.jpg', '96594 Jones Knoll Suite 835\nEast Antone, IL 75369', '4525', 'Lakin-Herman', 'Pouros, Grady and Volkman', 'Considine-Hickle', 'Dickens, Gusikowski and Bruen', '', '', '', '', '', 'Champlin, Rice and O\\&#039;Keefe', 'Funk LLC', '', 'english', '1343', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '401.957.5184', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'FO', 1718096924, 1718096924, 4993, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(80, 'duane28_111', 'bhansen_490@yahoo.com', '$2y$11$NUWrU6ibURDCeAaz3LxqEuDICmnI4QBHE4Sv2/O8f2Y3rYG1t5gOu', 'Mr. Malcolm Mayer', 'Monahan', 'upload/photos/2024/06/qrCr4ho6mz1BhpEtA3dw_avatar.jpg', '629 Effertz Harbor Suite 192\nEast Shanon, IL 40955', '4526', 'Skiles, Waters and West', 'McKenzie, Jones and Oberbrunner', 'Sauer, Mann and Pagac', 'Schmeler, Treutel and Walter', '', '', '', '', '', 'Stroman, Johnson and Wiza', 'Pagac and Sons', '', 'english', '8857', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-858-921-7252 x913', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'GP', 1718096924, 1718096924, 9881, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(81, 'bernice.stanton_486', 'yoshiko76_422@yahoo.com', '$2y$11$FlxirDJiukoJ74uJixycsey8S1bBZrxTZtH59DXLupr3.SK6k.8Li', 'Skylar Kohler', 'Bechtelar', 'upload/photos/2024/06/jVTcx5lyFwYyLJUpZl75_avatar.jpg', '447 Kenton Spring\nEast Timothyport, NH 70934', '4526', 'Dicki Group', 'Nitzsche, Skiles and Bradtke', 'Bergnaum Inc', 'Bailey-Tillman', '', '', '', '', '', 'Hickle Ltd', 'Schuster LLC', '', 'english', '4585', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '715.871.2646', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MM', 1718096924, 1718096924, 1208, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(82, 'gflatley_839', 'davis_narciso_209@yahoo.com', '$2y$11$gJHLT2MmKhdXmQCD1b4H/.eePmKficpeDagcNjYJbjZJF6qvfIhTC', 'Mr. Grover Runolfsdottir', 'Schoen', 'upload/photos/2024/06/6oL81rqq9kchOgzDKVjL_avatar.jpg', '3708 Kuhic Fort Apt. 734\nLake Demetrius, MD 50177-5934', '4526', 'Hills and Sons', 'Gibson, Gottlieb and Koepp', 'Nitzsche, Olson and Nicolas', 'Lockman and Sons', '', '', '', '', '', 'Kuvalis Group', 'Nader and Sons', '', 'english', '1904', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+12847512671', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BW', 1718096924, 1718096924, 1334, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(83, 'margarette50_894', 'pfranecki_763@yahoo.com', '$2y$11$BSoGAVIpdzA5Wbhf6Egmn.i.44RUZKpG4MuTWzUrPPE6Iven0zKfq', 'Loma Waters PhD', 'Friesen', 'upload/photos/2024/06/HKwRBV6Ty3T957BdEtrH_avatar.jpg', '30339 Ola Park Suite 332\nRitchieton, MA 62410', '4525', 'Ruecker, Erdman and Jenkins', 'Klocko-Larson', 'Schmidt Inc', 'Hodkiewicz-Satterfield', '', '', '', '', '', 'Mertz-Wilkinson', 'O\\&#039;Conner and Sons', '', 'english', '6031', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(409) 672-7694', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MZ', 1718096924, 1718096924, 3506, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(84, 'pasquale99_425', 'kgislason_301@yahoo.com', '$2y$11$bnfcHiFIIw8y86JkpDxo7evcPpEdVM5acHuGYV7BIvhbs1ZQZfIFK', 'Luigi Wintheiser PhD', 'Herzog', 'upload/photos/2024/06/aWOVFWPqjwu8u3xRZbKv_avatar.jpg', '56556 Vincenza Oval\nBartellside, WI 67726-7377', '4526', 'DuBuque, Hettinger and Padberg', 'Harvey Group', 'Raynor PLC', 'Kuphal-Schumm', '', '', '', '', '', 'Donnelly, Roberts and Kohler', 'Bosco Inc', '', 'english', '9307', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '850-535-4520 x0693', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'BR', 1718096924, 1718096924, 7649, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:44', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(85, 'green97_501', 'vsmith_854@yahoo.com', '$2y$11$BIIavKggvhao1Mp6CEA6M.0In.u0eHtaIRfElwJHCHUYAffOMEzeC', 'Jett Veum DVM', 'O\\&#039;Keefe', 'upload/photos/2024/06/SZUij2FnDjJQzwxmRwOt_avatar.jpg', '849 Santino Roads Apt. 220\nPort Estellfort, CA 32341-0351', '4525', 'Buckridge Ltd', 'Senger-Bechtelar', 'Emard LLC', 'Keeling, Wolff and Feeney', '', '', '', '', '', 'Altenwerth Ltd', 'Pollich PLC', '', 'english', '9024', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+14276431531', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AU', 1718096925, 1718096925, 3121, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(86, 'klocko.austen_239', 'kerluke_sherman_986@yahoo.com', '$2y$11$vCXdga4n9UZZ9L4UvzDwqeCxaNoZwvsJnzMCTJtKSHLREk/Wt7dP6', 'Osvaldo Moore MD', 'Koepp', 'upload/photos/2024/06/4RLUt4yJ9hmiVnmXGPeq_avatar.jpg', '83893 Boyle Ranch Suite 533\nWest Edgardochester, WV 81672', '4526', 'Hammes-Gislason', 'Wisoky, Nader and Emmerich', 'Jacobs Inc', 'Jast LLC', '', '', '', '', '', 'Kovacek-Bartell', 'Mann, Kuphal and Lueilwitz', '', 'english', '3621', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1.309.706.6412', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PK', 1718096925, 1718096925, 9222, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(87, 'mozelle.wilderman_690', 'peyton49_236@yahoo.com', '$2y$11$Ns4GatwoVRf1y6DmkcQQ7uvxHe5xDi...HZXygC3OM/LP8HqBcd/i', 'Alicia Oberbrunner', 'O\\&#039;Keefe', 'upload/photos/2024/06/NMGKyoAbfZRZjMRi82Uc_avatar.jpg', '1065 Josiane Cape\nEast Caitlyn, NC 74799-2874', '4526', 'Walsh, Okuneva and Satterfield', 'Shields-Schuppe', 'Tremblay and Sons', 'Gutkowski PLC', '', '', '', '', '', 'Bahringer LLC', 'Walter Ltd', '', 'english', '7388', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '583.372.2357 x05720', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'TM', 1718096925, 1718096925, 4432, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(88, 'schaden.edgar_264', 'vada56_309@yahoo.com', '$2y$11$9tkZjqWD/vCo7iVHCG9UquLh4aByM6Jz7lF7RApytWGWJlTz/MF1K', 'Ewald Robel', 'Kiehn', 'upload/photos/2024/06/uH9s2vL9UcVM5jB6PJlu_avatar.jpg', '628 Eldridge Tunnel\nNew Darren, ND 93869-7726', '4526', 'Lockman, Bechtelar and Senger', 'Baumbach, Bergnaum and Wolf', 'Grimes LLC', 'Macejkovic, Feeney and Carroll', '', '', '', '', '', 'Christiansen Group', 'Mitchell, Wilderman and Tillman', '', 'english', '9366', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '(757) 700-9033 x176', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'FM', 1718096925, 1718096925, 2146, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(89, 'cwaters_906', 'schmidt_kelvin_338@yahoo.com', '$2y$11$eVyuqNt78AQ3Cc.ldiOdJORuCXVwnqf6Ik9tsNhTJHJC0awWVKbv2', 'Prof. Samantha Littel Jr.', 'Lynch', 'upload/photos/2024/06/pOTvrNUJUn7UktBeysTT_avatar.jpg', '49460 Weber Parkway\nWest Evelynbury, UT 45851-2088', '4525', 'Stark-Hagenes', 'Upton-Runolfsson', 'Schowalter PLC', 'Gleichner-Leannon', '', '', '', '', '', 'Schiller-Waters', 'Bauch, Wyman and Pacocha', '', 'english', '9504', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-354-506-3812 x929', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'CC', 1718096925, 1718096925, 6732, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(90, 'hans64_532', 'reanna42_233@yahoo.com', '$2y$11$AfpKJeM7WPtCNemqfEjcLuU2VFOaRXZocJc/TG9z.8Y4cGY2TjNpO', 'Rowena Lubowitz', 'D\\&#039;Amore', 'upload/photos/2024/06/Six1PzwiWGUVF7nRsEj3_avatar.jpg', '174 Sedrick Estates\nSchmittmouth, MN 32348', '4526', 'Mitchell-Schaden', 'Langworth-Hyatt', 'Kassulke LLC', 'Runte, Metz and McLaughlin', '', '', '', '', '', 'Corwin-Lowe', 'Hills, Glover and Stokes', '', 'english', '5180', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '447.324.1929 x9376', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'KW', 1718096925, 1718096925, 3899, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(91, 'jacky.frami_247', 'icummerata_667@yahoo.com', '$2y$11$rJRaQmeAyRJJ59DmN1GazuH1k5ILSGYd.UKch71X9PboEK5y2v4N2', 'Lamont Roob', 'Parker', 'upload/photos/2024/06/wTG4Xm836xUGIq2Cxsi8_avatar.jpg', '651 Alessia Throughway\nNorth Alene, ME 12320-3038', '4526', 'Halvorson-Kreiger', 'Schinner LLC', 'Brown, Johnson and Stoltenberg', 'Hettinger Inc', '', '', '', '', '', 'Grady Ltd', 'Bogan-Cummings', '', 'english', '1627', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '306-349-0967 x985', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PS', 1718096925, 1718096925, 7794, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(92, 'saul.osinski_230', 'bauch_emmy_710@yahoo.com', '$2y$11$zmvA6ni6o5IVi8Yw2RR7UO0nXjBVhg/vvS.Y7WVJDGnMH8kJiD0fW', 'Miss Hilda Bosco', 'Treutel', 'upload/photos/2024/06/yCfWPLgmMWAWrnTBTyvP_avatar.jpg', '18723 Anderson Underpass Apt. 883\nNorth Candida, IN 31843', '4525', 'Bogisich, Buckridge and Turner', 'Tremblay PLC', 'Shields, Herman and Langworth', 'Leuschke, Deckow and Okuneva', '', '', '', '', '', 'Smith, Stokes and Walker', 'Murphy, Feil and Raynor', '', 'english', '1521', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+13196798245', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'FM', 1718096925, 1718096925, 3979, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:45', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(93, 'xconn_715', 'loren63_456@yahoo.com', '$2y$11$9qFt1ulf60OE4qJMawriHu7EOlcgX/qZjEOLyOLmmDrPhzouPqFrq', 'Candido Bernier', 'Stanton', 'upload/photos/2024/06/YLij3hEaUCDE9jWezXBY_avatar.jpg', '60131 Baron Road\nSouth Edwardoport, ND 12279', '4526', 'Simonis-Herman', 'Sauer-Rippin', 'Bins and Sons', 'Hoeger, Rice and Windler', '', '', '', '', '', 'Quitzon, Hodkiewicz and Bauch', 'Feest, Hodkiewicz and Hauck', '', 'english', '1727', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '873-646-2517', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'ER', 1718096926, 1718096926, 5818, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(94, 'wkoss_683', 'schuster_salvador_518@yahoo.com', '$2y$11$T2udE88Xh4RVnmQtUFJWLeffe5d5GtUKODLguJV7AJ7QsJaymH5ly', 'Stefanie Wisoky', 'Hill', 'upload/photos/2025/01/cj6D96jm4OOifgbRyszq_avater.jpg', '72847 Lila Road Apt. 792\nWest Uliceschester, OK 95616-0534', '4525', 'O\\&#039;Conner-Schmidt', 'Pfannerstill Group', 'Emard-Hermann', 'Kub and Sons', '', '', '', '', '', 'King, Lebsack and Rutherford', 'Gibson-Fisher', '', 'english', '7821', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '339.588.7525', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'NI', 1718096926, 1718096926, 9847, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(95, 'vernie21_505', 'joe_kutch_887@yahoo.com', '$2y$11$chi3R0e6VaYmactl5JO.MOUzjy84fy/hPw16JO7KvdmX167HLQYBC', 'Gunnar Spinka', 'Vandervort', 'upload/photos/2024/06/IpJYoAqbWEJggxgan5Ml_avatar.jpg', '51814 Cali Pine Suite 653\nNew Imogene, ME 88203', '4526', 'Kunze-Schamberger', 'Nikolaus-O\\&#039;Conner', 'Conroy-Hartmann', 'Schaefer, Jakubowski and Mitchell', '', '', '', '', '', 'Kassulke-Fadel', 'Grimes, Heller and Gutmann', '', 'english', '5602', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-241-875-7475', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'SV', 1718096926, 1718096926, 7875, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(96, 'wbalistreri_576', 'adella22_439@yahoo.com', '$2y$11$49XRJV4xTpKuq/9XXI/yWOlQuhg2FkG8rHeUPAZ9QAptyYhoSyqoi', 'Geovanni Lesch', 'Kohler', 'upload/photos/2024/06/umYQkhDKhL3zOntkwEVp_avatar.jpg', '168 Elenor Corner Apt. 937\nLake Pietrotown, ND 33849', '4525', 'Goldner, Wilkinson and Howe', 'Miller-Cole', 'Kessler-Schmitt', 'Harvey Group', '', '', '', '', '', 'Stracke, Lind and Greenfelder', 'Zemlak Inc', '', 'english', '2669', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '394-820-2661 x49279', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'YT', 1718096926, 1718096926, 6965, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(97, 'jody.cassin_799', 'kmorar_749@yahoo.com', '$2y$11$72AaLd9tg/XChHUkWdb/nOCJ5JEMdgWcjkd3WNbbnIj52YPsZ0fAe', 'Ms. Rossie Hagenes', 'McDermott', 'upload/photos/2024/06/gg6z67JuVUfJdFUla2Lo_avatar.jpg', '5670 Rolfson Meadow Suite 563\nPort Furman, MA 79059', '4526', 'Stracke, Erdman and Farrell', 'Cassin PLC', 'Sawayn-Lehner', 'Hermann, Reichel and Kutch', '', '', '', '', '', 'Mills-Ledner', 'Reichert Inc', '', 'english', '5247', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '663-777-2464 x1028', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'AF', 1718096926, 1718096926, 5613, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(98, 'geovanni.bosco_821', 'bhuels_557@yahoo.com', '$2y$11$cNudYDVpl8D3vrDBJSHG8uVr.pAWZmU6KkIptzVOB8RsEgNgVdVpK', 'Juliana Boyer', 'Cole', 'upload/photos/2024/06/Uas2U2VZZpAXBlUZVjnZ_avatar.jpg', '8919 Blick Spring\nBlickview, TN 46344', '4525', 'Schamberger Inc', 'Schiller and Sons', 'Botsford, Reinger and Satterfield', 'Tremblay-Grimes', '', '', '', '', '', 'Hayes, Lowe and Mosciski', 'Johnston PLC', '', 'english', '3311', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '590-871-4489', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'SY', 1718096926, 1718096926, 1402, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(99, 'ldare_684', 'vmohr_805@yahoo.com', '$2y$11$nNfpT832.I3.pg4fTYoSDeefJ7O5r10e4slXDVrG0kKYB/r/ckWxu', 'Savannah Pagac', 'Quigley', 'upload/photos/2024/06/iq4Z5ZhU62tAlg16STGo_avatar.jpg', '4358 Mohr Parkways\nSouth Beverly, AL 23022', '4526', 'Deckow, Stracke and Ondricka', 'Koepp Inc', 'Balistreri PLC', 'Kozey LLC', '', '', '', '', '', 'Beahan-Feeney', 'Block-Rohan', '', 'english', '1509', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '1-367-991-9497', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'PS', 1718096926, 1718096926, 4686, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(100, 'irau_629', 'zbeier_568@yahoo.com', '$2y$11$61w0WKdPhUfcZyc26GYLEOq/u7s/zKEWCf98efy7.ZlUBvEM3y1gS', 'Joanie Metz', 'Zulauf', 'upload/photos/2024/06/7tYDreROURqIbmn9xXOO_avatar.jpg', '30017 Antonina Unions Apt. 043\nEast Keshawnfurt, NM 27502', '4525', 'Moen PLC', 'Abernathy LLC', 'Weissnat-Reilly', 'Stroman-Stanton', '', '', '', '', '', 'Hessel-Runolfsson', 'Gulgowski LLC', '', 'english', '9001', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-739-992-9160', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'CZ', 1718096926, 1718096926, 6225, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:46', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(101, 'barry.mosciski_749', 'ariane11_382@yahoo.com', '$2y$11$VXpX5WasdBgDkKxgvUIOO.BhGl4zK09uCZAt0LkTuJoOfJq8CoQ6O', 'Dr. Lavada Cummerata DDS', 'Cassin', 'upload/photos/2024/06/AHQcZPc1LxXxrTSCSqRk_avatar.jpg', '72336 Jakayla Tunnel\nJohnpaulport, KY 55408', '4525', 'Rohan-Schneider', 'Batz-Toy', 'Rosenbaum, O\\&#039;Conner and Ryan', 'Roberts-Kuvalis', '', '', '', '', '', 'Collier-Olson', 'Thiel, Ebert and Witting', '', 'english', '9711', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '545-999-8505 x716', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'LT', 1718096927, 1718096927, 9620, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:47', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(102, 'nella.schiller_959', 'zola10_382@yahoo.com', '$2y$11$B3pv0UCf7soUqu/Az6UmW.98G4.dXSm/p9vTF/XnotTKUUUzFUKvu', 'Dr. Grant Bayer DVM', 'Dicki', 'upload/photos/2024/06/h7bHRfQVvGeYHLONPYha_avatar.jpg', '74587 Reinger Grove\nProhaskastad, IA 23705', '4526', 'Pfeffer-McLaughlin', 'Feest-Littel', 'Collier-Lebsack', 'Gleason, Mills and Herzog', '', '', '', '', '', 'Satterfield Group', 'Gleason Group', '', 'english', '4423', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+1-821-842-9283', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'EG', 1718096927, 1718096927, 3711, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:47', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(103, 'nicole31_192', 'mac_ondricka_974@yahoo.com', '$2y$11$wkvb4GlKkYijgXsM/37wK.tT41.hejRCKJ.CQNAB6/iQXrhMxy8hi', 'Elza Lynch', 'Tremblay', 'upload/photos/2024/06/76pDj2sbaZnvEZnZde11_avatar.jpg', '8120 Jones Island\nSouth Cooper, RI 21378', '4526', 'Simonis LLC', 'Walter Inc', 'Zulauf Group', 'Von-Williamson', '', '', '', '', '', 'Powlowski Inc', 'Fay, Boyle and Koch', '', 'english', '5658', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '719-461-5135 x6234', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'MZ', 1718096927, 1718096927, 6558, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:47', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(104, 'reese.johnson_704', 'herbert42_861@yahoo.com', '$2y$11$j3SUg/dUyxyogE28NwQQu.zQw08Nk9oq4AtWh4Q7Tnx9AnEYxnCxW', 'Mrs. Samara Marquardt', 'VonRueden', 'upload/photos/2024/06/oUX2HTs4OxVrCl7D7bIw_avatar.jpg', '46600 Oberbrunner Tunnel\nPort Rafaelborough, MD 38002-9182', '4526', 'Casper, Schoen and Kling', 'Fritsch-Gottlieb', 'Casper, Marks and Herman', 'Bashirian-Goyette', '', '', '', '', '', 'Ernser, Rowe and Armstrong', 'Lynch-Stoltenberg', '', 'english', '3728', 'Fake', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '+16105408136', 'UTC', '0', '0', 'Ut ab voluptas sed a nam. Sint autem inventore aut officia aut aut blanditiis. Ducimus eos odit amet et est ut eum.', '2005-06-11', 'EC', 1718096927, 1718096927, 5237, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 09:08:47', NULL, NULL, '', '', '', '152', '1', 0, 0, '', '', 'Sint autem inventore aut officia', 'Ducimus', '', 0, '', 1, 2, 3, 3, 3, 13, 2, 3, 0, 3, 2, 1, 2, 2, 2, 'pop', 'meat', 'song', 'hobby', 'city', 'sport', 'book', 'movie', 'red', 'tv', 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(105, 'Chris', 'jamiekingsto@gmail.com', '$2y$11$s/Z9d/hCIqQ23TRNOt2uUe9X8mzzkePLC3QrhrqycJwfWLWW3b32S', 'Chris', 'Stefan', 'upload/photos/2024/06/cyhJaGoLmjK351YjPhhV_avater.jpg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '6344', 'site', '105.112.221.174', 'user', '+2349136735947', 'UTC', '0', '0', '', '1975-08-16', 'BR', 1718123376, 1718123606, 1162, 0, 1718123625, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 16:29:36', NULL, NULL, '', '59147eaa022b486037c204d731ae806d2a3b4d00cac8859cab3b713ad96991090aff88a8732186808ef897e468650c19f3f31529712fc500', '', '198', '3', 1718123376, 0, 'a:4:{s:2:\"ip\";s:15:\"105.112.221.174\";s:7:\"browser\";s:17:\"Google Chrome 4.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(106, 'Kolomoyskiy', 'kolomoyskiy@gmail.com', '$2y$11$XjocCeechh1WWQNJ5lBlWOmTdup.7LQRbBakC31us4m9IW6Y6gp/S', 'Юджин', 'Коломойский', 'upload/photos/2024/06/v5XQvwoCuyu6kP2eatXW_avater.jpg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '7299', 'site', '2a03:7380:156:6fae:ad56:2bea:7', 'user', '097777777', 'UTC', '0', '0', '', '1963-02-13', 'DE', 1718125442, 1718691696, 7068, 0, 1718691256, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-11 17:04:02', NULL, NULL, '', '13a799f18b87159b8bd268950bb42244a89d4cd978dafabd8138c78cee6ac8141874c7b879658762e61eaa38aed621dd776d0e67cfeee366', '', '175', '5', 1718455901, 0, 'a:4:{s:2:\"ip\";s:22:\"2a02:2378:11e2:376d::1\";s:7:\"browser\";s:23:\"Google Chrome 125.0.0.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '{\"lat\":\"0\",\"lng\":\"0\",\"located\":125}', NULL, NULL),
(108, 'Qwerty', 'qq417048@gmail.com', '$2y$11$afpjBYHkr1unC0SPf6E0WeceS/OqXIUWEuZJr1glFjFushQg9kbtS', 'Qwerty', 'Qwerty', 'upload/photos/2024/06/rXJLu4QvIt1CPcBrUpDx_avater.jpeg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '5614', 'site', '103.155.33.219', 'user', '9876543210', 'UTC', '11.165323792967168', '77.34522923834375', '', '1996-03-18', 'IN', 1718178765, 1718180126, 3924, 0, 1718179699, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-12 07:52:45', NULL, NULL, '', 'fd28d527799bccc11056bd7480ff4a84b9fb349f1bcd4127bc52ab9baf6357c8fc761f10614471212f2cd5c753d3cee48e47dbb5bbaed331', '', '175', '1', 1718178765, 0, 'a:4:{s:2:\"ip\";s:14:\"103.155.33.219\";s:7:\"browser\";s:17:\"Apple Safari 17.5\";s:2:\"os\";s:3:\"mac\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '{\"lat\":\"11.165323792967168\",\"lng\":\"77.34522923834375\",\"located\":125}', NULL, NULL),
(109, 'Ghostrider1974', 'p01555277@gmail.com', '$2y$11$7cUO.ZEMX.Za3pC.5nFo5ODWpwIc7xPXd0kVkxSyTYVIrBgpsBXEC', 'Willem', '', 'upload/photos/2024/06/uRTAz1AxgxUoatpkfcje_avater.jpg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '5317', 'site', '41.4.18.150', 'user', '0840542268', 'UTC', '0', '0', '', '1974-12-20', 'ZA', 1718277871, 1718284305, 6590, 0, 1718284011, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-13 11:24:31', NULL, NULL, '', '14faea5a2cbe8df3fc465445ae58bc74779ea7d207978cb8b9623b576952c7dbda37a372557444309e6adb1432c4a75a33d48693328e4159', '', '182', '1', 1718277871, 0, 'a:4:{s:2:\"ip\";s:11:\"41.4.18.150\";s:7:\"browser\";s:23:\"Google Chrome 125.0.0.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '{\"gender\":[\"4526\"],\"age_from\":\"18\",\"age_to\":\"65\",\"lat\":\"-26.1625983\",\"lng\":\"28.2144024\",\"located\":\"125\",\"rand_lat\":\"-26.1625983\",\"rand_lng\":\"28.2144024\",\"rand_located\":\"125\",\"height_from\":\"139\",\"height_to\":\"220\",\"language\":[\"english\",\"russian\",\"ukrainian\"],\"ethnicity\":[\"1\"],\"religion\":[\"5\"],\"relationship\":[\"2\"],\"smoke\":[\"1\"],\"drink\":[\"2\"],\"country\":\"\",\"city\":\"\"}', NULL, NULL),
(110, 'rosesarered', 'rosemaryjane23@gmail.com', '$2y$11$hdu3PiCLKMmsNTJL75mgJe9qIw6i/BUZR2zW8QN.xHdsRBxlusJIO', 'rose', 'flood', 'upload/photos/2024/06/dfaVaRA1fHQXIrDsgPaU_avater.jpg', '', '4526', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '1906', 'site', '2404:440c:2a4e:2100:cd8:e1a6:9', 'user', '0210699985', 'UTC', '0', '0', '', '1984-12-23', 'NZ', 1718359478, 1718359753, 8653, 0, 1718359833, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-14 10:04:38', NULL, NULL, '', '866804dbc53a4e9d4dec8b197b86b31e3230e594378abcdee4bddc536a92b59cf3374caa633537882adafb1b5d684e6c15a2d063367be012', '', '165', '7', 1718359478, 0, 'a:4:{s:2:\"ip\";s:38:\"2404:440c:2a4e:2100:cd8:e1a6:9922:379a\";s:7:\"browser\";s:23:\"Google Chrome 119.0.0.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 'upper hutt', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(111, 'Demonxyz', 'sarahi6945@kernuo.com', '$2y$11$w5ZNo5.Q4mf9SU/4sr7gRe4O91prUeE8AdaNHLaOkYt/LqsIlJEHa', 'demon', 'Jaiswal', 'upload/photos/2024/06/6EJPxxeIQdwfnagnevDZ_avater.jpg', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '7863', 'site', '103.107.199.90', 'user', '', 'UTC', '0', '0', '', '0000-00-00', '', 1718391103, 1718391207, 2937, 0, 1718391266, 0.00, '0', '0', '1', '0', '2', '0', '0', '0', '2024-06-14 18:51:43', NULL, NULL, '', 'f6b9e584a505ed7faad9e16d31adfcb2131a10b998e541e35b67dcc5f453f42e322d9fcb258976897beadac50e1ce55dc31343cc1a89ac5c', '', '', '', 1718391103, 0, 'a:4:{s:2:\"ip\";s:14:\"103.107.199.90\";s:7:\"browser\";s:27:\"Google Chrome 109.0.5414.85\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(112, 'AjayBansode', 'ajaybansode76@gmail.com', '$2y$11$aGu1lf8wV7ou8OsKwYpZr.8IKAi.Ooev2gi.Ycjy2aQEqUQtpxrtW', 'Ajay', 'Bansode', 'upload/photos/2024/06/XWDPcnyyz2pf1CvjRB4X_avater.jpg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '3247', 'site', '2409:40c2:102d:26a6:8000::', 'user', '9654331678', 'UTC', '0', '0', '', '9thsug', 'LK', 1718699691, 1718699760, 3118, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-18 08:34:51', NULL, NULL, '', '1c6e34e6b6d1b575bf109e202f941b706aabc1f0703739cb3b1129dcb9b0dfc6653b9ef592472790948f847055c6bf156997ce9fb59919be', '', '139', '2', 1718699691, 0, 'a:4:{s:2:\"ip\";s:26:\"2409:40c2:102d:26a6:8000::\";s:7:\"browser\";s:23:\"Google Chrome 125.0.0.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:6:\"Mobile\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(114, 'pedrojoolima17', 'pedrojoo_lima62@jornaldoestado.top', '$2y$11$Ah50MJdnZvu/8MVzTl5ituAKPOUZItmNwue95AVgH.WAM3goBIlTO', 'Pedro João', 'Lima', 'upload/photos/d-avatar.jpg', '', '4525', '', '', '', '', '', '', '', '', '', 'https://Seoservices.Com.br/', '', '', 'english', '9359', 'site', '196.240.105.128', 'user', '', 'UTC', '0', '0', 'Escrevo com autenticidade e paixão. Creio que essa autenticidade ressoa com os leitores e torna o conteúdo mais envolvente e valioso.', '2006-02-12', 'DZ', 1718738442, 1718738443, 8368, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2024-06-18 19:20:42', NULL, NULL, '', '173117b82dc11f38e1044f50810e1c044493b4594573b75dd8748ed854cda0667233cc9863011880fc1a36821b02abbd2503fd949bfc9131', '', '183', '2', 1718738443, 0, 'a:4:{s:2:\"ip\";s:15:\"196.240.105.128\";s:7:\"browser\";s:21:\"Mozilla Firefox 114.0\";s:2:\"os\";s:7:\"windows\";s:10:\"deviceType\";s:8:\"Computer\";}', '', '', '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(115, 'flirthub', 'flirthub@flirthub.flirthub', '$2y$11$lxyuvjkqaJZqDpjMU9H2OuHFrwNWg0Vof28mDED7BtgqO4.ABiKci', 'flirthub', 'flirthub', 'upload/photos/2025/01/HqrStEJhWATS4Rr9K4UN_avater.png', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '6975', 'site', '37.57.176.205', 'user', '986905448', 'UTC', '50.43773112738816', '30.623866655646886', '', '2007-01-11', 'UA', 1736713978, 1737114192, 5999, 0, 1737109750, 99999620.00, '1', '0', '1', '1', '3', '1', '0', '0', '2025-01-12 20:32:58', NULL, NULL, '', '428e825356823fe141ac9b511c06c1f91d2655350ad7f0925a810ba1fa68ad123c8a5b0a8793615246384036044a604b6b3316fc167fc15f', '', '175', '2', 1737107455, 0, 'a:4:{s:2:\"ip\";s:12:\"93.170.44.38\";s:7:\"browser\";s:23:\"Google Chrome 131.0.0.0\";s:2:\"os\";s:7:\"windows\";s:10:\"deviceType\";s:8:\"Computer\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1736973752, 0, 1, 1736722719, 0, 0, 1, 1736722711, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '{\"lat\":\"0\",\"lng\":\"0\",\"located\":125}', NULL, NULL),
(116, 'Yevhen', 'vilmjajjkin@gmail.com', '$2y$11$q07AIXgeqid1ijmgY1QD7OLWZI6ks1N/XaHFz4FW5z9G9aRva0Jr2', 'Yevhen', 'Vilmiaikin', 'upload/photos/d-avatar.jpg', '', '4525', '', '', '', '', '', '', '', '', '', '', '', '', 'English', '6285', 'site', '37.57.176.205', 'user', '986905468', 'UTC', '0', '0', '', '2007-01-03', 'AL', 1736802844, 1737114222, 5481, 0, 1737114215, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2025-01-13 21:14:04', NULL, NULL, '', '48776d4bee430b76a2844c4e85c6aae1cd746443a0f28a082807b9f01e2be44170695b5855738286a14185bf0c82b3369f86efb3cac5ad28', '', '220', '2', 1737108279, 0, 'a:4:{s:2:\"ip\";s:13:\"37.57.176.205\";s:7:\"browser\";s:23:\"Google Chrome 131.0.0.0\";s:2:\"os\";s:7:\"windows\";s:10:\"deviceType\";s:8:\"Computer\";}', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(117, 'sonyarichards9', 'o.xi.mu.s.777.pz.a.h.fz.7.ggf@gmail.com', '$2y$11$Lj/F1xlGBQujMpJsSfNkTO2JZ8cL9owRAFoJsIG40aE5ND92ODHxe', 'Sonya', 'Richards', 'upload/photos/d-avatar.jpg', '', '4525', '', '', '', '', '', '', '', '', '', 'https://pornozasos.ru/user/PattyAlba935/', '', '', 'english', '8585', 'site', '95.182.125.36', 'user', '', 'UTC', '0', '0', 'I&#039;m Sonya (27) from Leiden, Netherlands.  <br>I&#039;m learning Hindi literature at a local college and I&#039;m just about to graduate. <br>I have a part time job in a post office.', '2006-02-12', 'DZ', 1736890326, 1736890326, 4217, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2025-01-14 21:32:06', NULL, NULL, '', '2c7296f957fb64062ba9eada5113e0be6ed2c0a14dcca5cabb865027096b168bddd16b8e1207341103573b32b2746e6e8ca98b9123f2249b', '', '183', '2', 1736890326, 0, 'a:4:{s:2:\"ip\";s:13:\"95.182.125.36\";s:7:\"browser\";s:23:\"Google Chrome 114.0.0.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:8:\"Computer\";}', '', '', '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL),
(118, 'heqflora255955', 'o.x.im.u.s.7.7.7r.j.fmz7t6.dp@gmail.com', '$2y$11$dSOK8hY0XDe2GIHlJ4x5s.WzkxupWRzHkv5X3v.DK8QwMD8c9i5ES', 'Flora', 'Brazenor', 'upload/photos/d-avatar.jpg', '', '4525', '', '', '', '', '', '', '', '', '', 'http://rt.chat-ruletka-18.com/male/%D0%B3%D0%B5%D0%B9', '', '', 'english', '3289', 'site', '5.183.130.53', 'user', '', 'UTC', '0', '0', 'Hello! My name is Flora.  <br>It is a little about myself: I live in Netherlands, my city of Leeuwarden.  <br>It&#039;s called often Eastern or cultural capital of FRANCE. I&#039;ve married 4 years ago. <br>I have 2 children - a son (Hope) and the daughter (Juanita). We all like Tour skating.', '2006-02-12', 'DZ', 1736891636, 1736891637, 7697, 0, 0, 0.00, '1', '0', '1', '0', '3', '0', '0', '0', '2025-01-14 21:53:56', NULL, NULL, '', 'eb080f03b7a83518cd27a8b00802a0b090d2cf8b64d1dbd0a4adeb8c3ae16a8cebabe3ad36481038515b9d40500ef7d05007b5668991fc7c', '', '183', '2', 1736891637, 0, 'a:4:{s:2:\"ip\";s:12:\"5.183.130.53\";s:7:\"browser\";s:21:\"Mozilla Firefox 114.0\";s:2:\"os\";s:5:\"linux\";s:10:\"deviceType\";s:8:\"Computer\";}', '', '', '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', NULL, NULL);
INSERT INTO `users` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `avater`, `address`, `gender`, `facebook`, `google`, `twitter`, `linkedin`, `okru`, `mailru`, `discord`, `wechat`, `qq`, `website`, `instagram`, `web_device_id`, `language`, `email_code`, `src`, `ip_address`, `type`, `phone_number`, `timezone`, `lat`, `lng`, `about`, `birthday`, `country`, `registered`, `lastseen`, `smscode`, `pro_time`, `last_location_update`, `balance`, `verified`, `status`, `active`, `admin`, `start_up`, `is_pro`, `pro_type`, `social_login`, `created_at`, `updated_at`, `deleted_at`, `mobile_device_id`, `web_token`, `mobile_token`, `height`, `hair_color`, `web_token_created_at`, `mobile_token_created_at`, `web_device`, `mobile_device`, `interest`, `location`, `cc_phone_number`, `zip`, `state`, `relationship`, `work_status`, `education`, `ethnicity`, `body`, `character`, `children`, `friends`, `pets`, `live_with`, `car`, `religion`, `smoke`, `drink`, `travel`, `music`, `dish`, `song`, `hobby`, `city`, `sport`, `book`, `movie`, `colour`, `tv`, `privacy_show_profile_on_google`, `privacy_show_profile_random_users`, `privacy_show_profile_match_profiles`, `email_on_profile_view`, `email_on_new_message`, `email_on_profile_like`, `email_on_purchase_notifications`, `email_on_special_offers`, `email_on_announcements`, `phone_verified`, `online`, `is_boosted`, `boosted_time`, `is_buy_stickers`, `user_buy_xvisits`, `xvisits_created_at`, `user_buy_xmatches`, `xmatches_created_at`, `user_buy_xlikes`, `xlikes_created_at`, `show_me_to`, `email_on_get_gift`, `email_on_got_new_match`, `email_on_chat_request`, `last_email_sent`, `approved_at`, `snapshot`, `hot_count`, `spam_warning`, `activation_request_count`, `last_activation_request`, `two_factor`, `two_factor_verified`, `two_factor_email_code`, `new_email`, `new_phone`, `permission`, `referrer`, `aff_balance`, `paypal_email`, `confirm_followers`, `reward_daily_credit`, `lock_pro_video`, `lock_private_photo`, `conversation_id`, `info_file`, `paystack_ref`, `securionpay_key`, `coinbase_hash`, `coinbase_code`, `yoomoney_hash`, `coinpayments_txn_id`, `fortumo_hash`, `ngenius_ref`, `aamarpay_tran_id`, `find_match_data`, `telegram_id`, `telegram_auth_date`) VALUES
(119, 'oumall', '', '$2y$11$arxT8ymSS6nGZzSXqRMikuHhJnHKQ/VJmg8QyG2GDYCsCf/V3uqaW', '', '', 'https://t.me/i/userpic/320/7GrSpFJ3h0o42h3_uHzeff_VnPxzzy1e_NbM3O20fBw.svg', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', 'english', '4841', 'telegram', '37.57.176.205', 'user', '', 'UTC', '0', '0', '', '0000-00-00', '', 1736979058, 1736979058, 8166, 0, 0, 0.00, '0', '0', '1', '0', '0', '0', '0', '1', '2025-01-15 22:10:58', NULL, NULL, '', '', '', '', '', 0, 0, '', '', NULL, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', '', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', '', '', NULL, 0, '0', '', '1', 0, 1, 1, NULL, '', NULL, 0, '', '', '', '', '', '', '', '', 582110151, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `user_chat_buy`
--

CREATE TABLE `user_chat_buy` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `chat_user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_gifts`
--

CREATE TABLE `user_gifts` (
  `id` int NOT NULL,
  `from` int NOT NULL DEFAULT '0',
  `to` int NOT NULL DEFAULT '0',
  `gift_id` int NOT NULL DEFAULT '0',
  `time` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `verification_requests`
--

CREATE TABLE `verification_requests` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `message` text,
  `user_name` varchar(150) NOT NULL DEFAULT '',
  `passport` varchar(3000) NOT NULL DEFAULT '',
  `photo` varchar(3000) NOT NULL DEFAULT '',
  `seen` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `videocalles`
--

CREATE TABLE `videocalles` (
  `id` int NOT NULL,
  `access_token` text,
  `access_token_2` text,
  `from_id` int NOT NULL DEFAULT '0',
  `to_id` int NOT NULL DEFAULT '0',
  `room_name` varchar(50) NOT NULL DEFAULT '',
  `active` int NOT NULL DEFAULT '0',
  `called` int NOT NULL DEFAULT '0',
  `time` int NOT NULL DEFAULT '0',
  `declined` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `views`
--

CREATE TABLE `views` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `view_userid` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `views`
--

INSERT INTO `views` (`id`, `user_id`, `view_userid`, `created_at`) VALUES
(1, 1, 94, '2024-06-11 09:09:40'),
(2, 1, 3, '2024-06-11 09:33:34'),
(3, 2, 103, '2024-06-11 15:42:29'),
(4, 1, 55, '2024-06-11 17:02:16'),
(5, 1, 84, '2024-06-11 17:02:28'),
(6, 1, 83, '2024-06-11 17:02:41'),
(7, 106, 92, '2024-06-11 17:19:56'),
(11, 108, 93, '2024-06-12 08:07:42'),
(12, 108, 82, '2024-06-12 08:08:24'),
(24, 1, 97, '2024-06-13 10:19:25'),
(25, 1, 103, '2024-06-13 10:19:38'),
(33, 106, 110, '2024-06-14 17:45:36'),
(37, 2, 105, '2024-06-15 13:39:25'),
(38, 2, 104, '2024-06-15 13:39:34'),
(40, 106, 95, '2024-06-15 13:42:28'),
(42, 2, 108, '2024-06-16 17:22:52'),
(43, 106, 103, '2024-06-17 11:00:36'),
(44, 106, 108, '2024-06-17 11:00:56'),
(45, 106, 104, '2024-06-17 11:01:53'),
(47, 106, 102, '2024-06-17 11:03:14'),
(51, 1, 105, '2024-06-17 13:31:52'),
(53, 106, 93, '2024-06-17 13:47:22'),
(63, 106, 105, '2024-06-17 20:04:10'),
(64, 1, 108, '2024-06-18 05:46:17'),
(66, 2, 1, '2024-06-18 06:07:28'),
(67, 2, 110, '2024-06-18 06:09:17'),
(68, 106, 1, '2024-06-18 06:12:44'),
(69, 106, 2, '2024-06-18 06:13:01'),
(70, 2, 106, '2024-06-18 06:13:55'),
(71, 1, 2, '2024-06-18 06:22:36'),
(72, 1, 110, '2024-06-19 10:02:20'),
(74, 115, 1, '2025-01-12 21:31:01'),
(75, 115, 102, '2025-01-13 17:24:52'),
(76, 115, 94, '2025-01-13 17:26:40'),
(80, 115, 110, '2025-01-15 02:25:56'),
(81, 115, 111, '2025-01-15 22:01:14'),
(83, 115, 116, '2025-01-17 10:06:06'),
(84, 116, 115, '2025-01-17 10:06:19'),
(85, 115, 97, '2025-01-17 10:27:58'),
(86, 115, 91, '2025-01-17 10:28:54');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `admininvitations`
--
ALTER TABLE `admininvitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`);

--
-- Индексы таблицы `affiliates_requests`
--
ALTER TABLE `affiliates_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `time` (`time`),
  ADD KEY `status` (`status`),
  ADD KEY `transfer_info` (`transfer_info`),
  ADD KEY `type` (`type`),
  ADD KEY `amount` (`amount`),
  ADD KEY `full_amount` (`full_amount`);

--
-- Индексы таблицы `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `active` (`active`);

--
-- Индексы таблицы `announcement_views`
--
ALTER TABLE `announcement_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `announcement_id` (`announcement_id`);

--
-- Индексы таблицы `apps`
--
ALTER TABLE `apps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_user_id` (`app_user_id`),
  ADD KEY `active` (`active`);

--
-- Индексы таблицы `apps_permission`
--
ALTER TABLE `apps_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `app_id` (`app_id`);

--
-- Индексы таблицы `audiocalls`
--
ALTER TABLE `audiocalls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `call_id` (`call_id`),
  ADD KEY `called` (`called`),
  ADD KEY `declined` (`declined`);

--
-- Индексы таблицы `bad_login`
--
ALTER TABLE `bad_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip` (`ip`);

--
-- Индексы таблицы `bank_receipts`
--
ALTER TABLE `bank_receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `approved` (`approved`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `banned_ip`
--
ALTER TABLE `banned_ip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip_address` (`ip_address`);

--
-- Индексы таблицы `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `block_userid` (`block_userid`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `title` (`title`),
  ADD KEY `category` (`category`),
  ADD KEY `tags` (`tags`(255)),
  ADD KEY `posted` (`posted`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `codes`
--
ALTER TABLE `codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`),
  ADD KEY `app_id` (`app_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Индексы таблицы `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `receiver_id_2` (`receiver_id`),
  ADD KEY `sender_id_2` (`sender_id`),
  ADD KEY `from_delete` (`from_delete`),
  ADD KEY `to_delete` (`to_delete`);

--
-- Индексы таблицы `custom_pages`
--
ALTER TABLE `custom_pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_name` (`page_name`),
  ADD KEY `page_type` (`page_type`);

--
-- Индексы таблицы `daily_credits`
--
ALTER TABLE `daily_credits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `added` (`added`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `email_subscribers`
--
ALTER TABLE `email_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`),
  ADD KEY `time` (`time`);

--
-- Индексы таблицы `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fav_user_id` (`fav_user_id`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `followers`
--
ALTER TABLE `followers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `following_id` (`following_id`),
  ADD KEY `follower_id` (`follower_id`),
  ADD KEY `active` (`active`),
  ADD KEY `order1` (`following_id`,`id`),
  ADD KEY `order2` (`follower_id`,`id`);

--
-- Индексы таблицы `gifts`
--
ALTER TABLE `gifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Индексы таблицы `hot`
--
ALTER TABLE `hot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `hot_userid` (`hot_userid`),
  ADD KEY `val` (`hot_userid`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `invitation_links`
--
ALTER TABLE `invitation_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `invited_id` (`invited_id`),
  ADD KEY `code` (`code`),
  ADD KEY `time` (`time`);

--
-- Индексы таблицы `langs`
--
ALTER TABLE `langs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ref` (`ref`(191)),
  ADD KEY `langs_lang_key_unique` (`lang_key`) USING BTREE;

--
-- Индексы таблицы `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `like_userid` (`like_userid`),
  ADD KEY `is_like` (`is_like`),
  ADD KEY `is_dislike` (`is_dislike`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `live_sub_users`
--
ALTER TABLE `live_sub_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `is_watching` (`is_watching`),
  ADD KEY `time` (`time`);

--
-- Индексы таблицы `mediafiles`
--
ALTER TABLE `mediafiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `file` (`file`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `is_private` (`is_private`),
  ADD KEY `instagram_post_id` (`instagram_post_id`),
  ADD KEY `private_file` (`private_file`),
  ADD KEY `is_video` (`is_video`),
  ADD KEY `is_confirmed` (`is_confirmed`),
  ADD KEY `is_approved` (`is_approved`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from` (`from`),
  ADD KEY `to` (`to`),
  ADD KEY `seen` (`seen`),
  ADD KEY `order1` (`from`,`id`),
  ADD KEY `order3` (`to`,`id`),
  ADD KEY `order7` (`seen`,`id`),
  ADD KEY `order8` (`id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `messages_from_delete_index` (`from_delete`),
  ADD KEY `messages_to_delete_index` (`to_delete`);
ALTER TABLE `messages` ADD FULLTEXT KEY `text` (`text`);

--
-- Индексы таблицы `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifier_id` (`notifier_id`),
  ADD KEY `recipient_id` (`recipient_id`),
  ADD KEY `type` (`type`),
  ADD KEY `push_sent` (`push_sent`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `seen` (`seen`),
  ADD KEY `admin` (`admin`);

--
-- Индексы таблицы `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `options_option_name_unique` (`option_name`);

--
-- Индексы таблицы `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `amount` (`amount`),
  ADD KEY `pro_plan` (`pro_plan`),
  ADD KEY `credit_amount` (`credit_amount`),
  ADD KEY `via` (`via`),
  ADD KEY `type` (`type`),
  ADD KEY `date` (`date`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `live_time` (`live_time`),
  ADD KEY `live_ended` (`live_ended`),
  ADD KEY `time` (`time`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `profilefields`
--
ALTER TABLE `profilefields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registration_page` (`registration_page`),
  ADD KEY `active` (`active`),
  ADD KEY `profile_page` (`profile_page`);

--
-- Индексы таблицы `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `report_userid` (`report_userid`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `seen` (`seen`);

--
-- Индексы таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_id` (`session_id`(191)),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `platform` (`platform`),
  ADD KEY `time` (`time`);

--
-- Индексы таблицы `site_ads`
--
ALTER TABLE `site_ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `placement` (`placement`);

--
-- Индексы таблицы `stickers`
--
ALTER TABLE `stickers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file` (`file`),
  ADD KEY `is_pro` (`is_pro`);

--
-- Индексы таблицы `success_stories`
--
ALTER TABLE `success_stories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `story_user_id` (`story_user_id`),
  ADD KEY `status` (`status`);

--
-- Индексы таблицы `userfields`
--
ALTER TABLE `userfields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `telegram_id` (`telegram_id`),
  ADD UNIQUE KEY `telegram_id_2` (`telegram_id`),
  ADD KEY `users_first_name_index` (`first_name`),
  ADD KEY `users_web_token` (`web_token`) USING BTREE,
  ADD KEY `users_mobile_token` (`mobile_token`) USING BTREE,
  ADD KEY `users_hair_color` (`hair_color`) USING BTREE,
  ADD KEY `is_boosted` (`is_boosted`),
  ADD KEY `is_buy_stickers` (`is_buy_stickers`),
  ADD KEY `ethnicity` (`ethnicity`),
  ADD KEY `last_name` (`last_name`),
  ADD KEY `address` (`address`),
  ADD KEY `language` (`language`),
  ADD KEY `lat` (`lat`),
  ADD KEY `lng` (`lng`),
  ADD KEY `birthday` (`birthday`(191)),
  ADD KEY `lastseen` (`lastseen`),
  ADD KEY `start_up` (`start_up`),
  ADD KEY `height` (`height`),
  ADD KEY `location` (`location`),
  ADD KEY `relationship` (`relationship`),
  ADD KEY `work_status` (`work_status`),
  ADD KEY `education` (`education`),
  ADD KEY `body` (`body`),
  ADD KEY `character` (`character`),
  ADD KEY `children` (`children`),
  ADD KEY `friends` (`friends`),
  ADD KEY `pets` (`pets`),
  ADD KEY `live_with` (`live_with`),
  ADD KEY `religion` (`religion`),
  ADD KEY `smoke` (`smoke`),
  ADD KEY `drink` (`drink`),
  ADD KEY `online` (`online`),
  ADD KEY `xvisits_created_at` (`xvisits_created_at`),
  ADD KEY `show_me_to` (`show_me_to`),
  ADD KEY `verified` (`verified`),
  ADD KEY `xmatches_created_at` (`xmatches_created_at`),
  ADD KEY `smscode` (`smscode`),
  ADD KEY `password` (`password`),
  ADD KEY `gender` (`gender`),
  ADD KEY `email_code` (`email_code`),
  ADD KEY `type` (`type`),
  ADD KEY `country` (`country`),
  ADD KEY `balance` (`balance`),
  ADD KEY `active` (`active`),
  ADD KEY `status` (`status`),
  ADD KEY `admin` (`admin`),
  ADD KEY `character_2` (`character`,`children`,`friends`,`pets`,`live_with`,`car`,`religion`),
  ADD KEY `xlikes_created_at` (`xlikes_created_at`,`xvisits_created_at`,`xmatches_created_at`,`is_pro`,`gender`,`hot_count`),
  ADD KEY `web_device_id` (`web_device_id`),
  ADD KEY `registered` (`registered`),
  ADD KEY `is_pro` (`is_pro`),
  ADD KEY `pro_type` (`pro_type`),
  ADD KEY `web_token_created_at` (`web_token_created_at`),
  ADD KEY `approved_at` (`approved_at`),
  ADD KEY `conversation_id` (`conversation_id`),
  ADD KEY `find_match_data` (`find_match_data`(1024)),
  ADD KEY `hot_count` (`hot_count`);

--
-- Индексы таблицы `user_chat_buy`
--
ALTER TABLE `user_chat_buy`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `chat_user_id` (`chat_user_id`),
  ADD KEY `created_at` (`created_at`);

--
-- Индексы таблицы `user_gifts`
--
ALTER TABLE `user_gifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from` (`from`),
  ADD KEY `to` (`to`),
  ADD KEY `gift_id` (`gift_id`);

--
-- Индексы таблицы `verification_requests`
--
ALTER TABLE `verification_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `videocalles`
--
ALTER TABLE `videocalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `called` (`called`),
  ADD KEY `declined` (`declined`);

--
-- Индексы таблицы `views`
--
ALTER TABLE `views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `view_userid` (`view_userid`),
  ADD KEY `created_at` (`created_at`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `admininvitations`
--
ALTER TABLE `admininvitations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `affiliates_requests`
--
ALTER TABLE `affiliates_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `announcement`
--
ALTER TABLE `announcement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `announcement_views`
--
ALTER TABLE `announcement_views`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `apps`
--
ALTER TABLE `apps`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `apps_permission`
--
ALTER TABLE `apps_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `audiocalls`
--
ALTER TABLE `audiocalls`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `bad_login`
--
ALTER TABLE `bad_login`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `bank_receipts`
--
ALTER TABLE `bank_receipts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `banned_ip`
--
ALTER TABLE `banned_ip`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `blocks`
--
ALTER TABLE `blocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `codes`
--
ALTER TABLE `codes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `custom_pages`
--
ALTER TABLE `custom_pages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `daily_credits`
--
ALTER TABLE `daily_credits`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT для таблицы `emails`
--
ALTER TABLE `emails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `email_subscribers`
--
ALTER TABLE `email_subscribers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `followers`
--
ALTER TABLE `followers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `gifts`
--
ALTER TABLE `gifts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `hot`
--
ALTER TABLE `hot`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `invitation_links`
--
ALTER TABLE `invitation_links`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `langs`
--
ALTER TABLE `langs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1972;

--
-- AUTO_INCREMENT для таблицы `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT для таблицы `live_sub_users`
--
ALTER TABLE `live_sub_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `mediafiles`
--
ALTER TABLE `mediafiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT для таблицы `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=382;

--
-- AUTO_INCREMENT для таблицы `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `profilefields`
--
ALTER TABLE `profilefields`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT для таблицы `site_ads`
--
ALTER TABLE `site_ads`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `stickers`
--
ALTER TABLE `stickers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `success_stories`
--
ALTER TABLE `success_stories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `userfields`
--
ALTER TABLE `userfields`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT для таблицы `user_chat_buy`
--
ALTER TABLE `user_chat_buy`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `user_gifts`
--
ALTER TABLE `user_gifts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `verification_requests`
--
ALTER TABLE `verification_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `videocalles`
--
ALTER TABLE `videocalles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `views`
--
ALTER TABLE `views`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
