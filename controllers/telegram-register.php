<?php
class TelegramRegister extends Theme
{
    public static function show()
    {
        global $db;

        // Получение данных initData из POST или GET
        $telegram_data_raw = $_POST['tg_init_data'] ?? $_GET['tg_init_data'] ?? null;

        if (!$telegram_data_raw) {
            die(json_encode(['error' => true, 'message' => 'No initData provided.']));
        }

        // Декодирование JSON
        $telegram_data = json_decode($telegram_data_raw, true);

        if (empty($telegram_data) || !isset($telegram_data['id'])) {
            die(json_encode(['error' => true, 'message' => 'Invalid Telegram initData.']));
        }

        // Валидация initData
        if (!self::validateTelegramData($telegram_data, 'YOUR_BOT_TOKEN')) {
            die(json_encode(['error' => true, 'message' => 'Invalid Telegram data signature.']));
        }

        $telegram_id = $telegram_data['id'];

        // Проверка пользователя в базе
        $user = $db->where('telegram_id', $telegram_id)->getOne('users');

        if ($user) {
            // Если пользователь найден, авторизуем
            $_SESSION['user_id'] = $user['id'];
            header("Location: /");
            exit();
        } else {
            // Если пользователь не найден, сохраняем данные Telegram и перенаправляем на регистрацию
            $_SESSION['telegram_data'] = $telegram_data;
            header("Location: /register");
            exit();
        }
    }

    // Валидация initData
    private static function validateTelegramData($data, $bot_token)
    {
        $check_hash = $data['hash'];
        unset($data['hash']);
        ksort($data);
        $data_check_string = http_build_query($data, '', "\n");
        $secret_key = hash('sha256', $bot_token, true);
        $hash = hash_hmac('sha256', $data_check_string, $secret_key);

        return hash_equals($hash, $check_hash);
    }
}
