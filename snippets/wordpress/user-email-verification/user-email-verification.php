<?php

declare(strict_types=1);

declare(ticks=1);

use \WP_Error;
use function \add_filter;

\add_filter(
    'registration_errors',
    function ($errors, $sanitized_user_login, $user_email) {
        $blacklisted_domains_path = basename(dirname(__FILE__)) . '/blacklisted-domains.txt';

        if ( ! file_exists($blacklisted_domains_path)) {
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
