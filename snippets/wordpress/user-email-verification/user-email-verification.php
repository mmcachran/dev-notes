<?php declare(strict_types=1);

\add_filter(
    'registration_errors',
    function ($errors, $sanitized_user_login, $user_email) {
        $blacklisted_domains_path = WPMU_PLUGIN_DIR . '/blacklisted-domains.txt';

        if (!file_exists($blacklisted_domains_path)) {
            return $errors;
        }

        if (strpos(file_get_contents($blacklisted_domains_path), $user_email) !== false) {
            $errors->add(
                'unauthorized_email',
                'Unauthorized email used for signup!'
            );
        }

        return $errors;
    },
    PHP_INT_MAX,
    3
);

\add_action(
    'bp_signup_validate',
    function () {
        $blacklisted_domains_path = WPMU_PLUGIN_DIR . '/blacklisted-domains.txt';

        error_log(print_r([$blacklisted_domains_path, @file_get_contents($blacklisted_domains_path)], true));

        if (!file_exists($blacklisted_domains_path)) {
            return;
        }

        global $bp;

        $user_email = $bp->signup->email ?? '';

        if (strpos(@file_get_contents($blacklisted_domains_path), $user_email) !== false) {
            $bp->signup->errors['signup_unauthorized_email'] = 'Please register with a valid email address.';
        }
    },
    PHP_INT_MAX,
    0
);
