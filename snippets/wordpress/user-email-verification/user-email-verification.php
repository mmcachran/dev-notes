<?php

declare(strict_types=1);

function appp_is_user_email_domain_valid(string $user_email): bool
{
    $blacklisted_domains_path = WPMU_PLUGIN_DIR . '/blacklisted-domains.txt';

    // error_log(print_r([$blacklisted_domains_path, @file_get_contents($blacklisted_domains_path)], true));

    if (!file_exists($blacklisted_domains_path)) {
        return true;
    }

    $blacklisted_user_email_domains = @file_get_contents($blacklisted_domains_path);

    if (empty($blacklisted_user_email_domains))  {
        return true;
    }

    $user_email_parts = explode('@', $user_email);

    if (empty($user_email_parts[1])) {
        return false;
    }

    return (strpos($blacklisted_user_email_domains, trim($user_email_parts[1])) === false);
}

\add_filter(
    'registration_errors',
    function ($errors, $sanitized_user_login, $user_email) {
        if (!appp_is_user_email_domain_valid($user_email)) {
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
    function (): void {
        global $bp;

        $user_email = $bp->signup->email ?? '';

        if (empty($user_email)) {
            return;
        }

        if (!appp_is_user_email_domain_valid($user_email)) {
            $bp->signup->errors['signup_unauthorized_email'] = 'Please register with a valid email address.';
        }
    },
    PHP_INT_MAX,
    0
);

add_filter(
    'bp_core_validate_user_signup',
    function ($result) {
        if (!appp_is_user_email_domain_valid($result['user_email'])) {
            $result['errors']->add(
                'unauthorized_email',
                'Unauthorized email used for signup!'
            );
        }

        error_log(print_r(['appp_is_user_email_domain_valid', $result], true));

        return $result;
    },
    PHP_INT_MAX,
    1
);
