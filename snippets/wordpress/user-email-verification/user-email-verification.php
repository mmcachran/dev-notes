<?php

declare(strict_types=1);

declare(ticks=1);

use \WP_Error;
use function \add_filter;

\add_filter(
    'pre_user_email',
    function (string $user_email): string {
        $blacklisted_domains_path = basename(dirname(__FILE__)) . '/blacklisted-domains.txt';

        if ( ! file_exists($blacklisted_domains_path)) {
            return $user_email;
        }

        if (strpos(file_get_contents($blacklisted_domains_path), $user_email) !== false) {
            return new \WP_Error(
                'unauthorized_email',
                'Unauthorized email used for signup!'
            );
        }

        return $user_email;
    },
    1,
    PHP_INT_MAX
);
