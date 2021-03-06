Feature: Forgot Password
    In order to be able restore my password
    As a Visitor
    I want to be able to request password reset email

    Scenario: Visitor requests password reset email
        Given there are registered Users:
            | id  | email              | name   | authentication_payload |
            | "1" | "test@example.com" | "Test" | ""                     |
            | "2" | "foo@bar.com"      | "Foo"  | ""                     |

        And  authentication payload "some-payload" is going to be created

        When I request password reset email for "test@example.com"

        Then authentication payload is created "some-payload"
        And notification email is sent to "test@example.com" with title "Password Reset" and body:
        """
        Dear Test,

        Open https://example.com/change-password/some-payload in your browser to reset your password.

        """

        And registered Users should be:
            | id  | email              | name   | authentication_payload |
            | "1" | "test@example.com" | "Test" | "some-payload"         |
            | "2" | "foo@bar.com"      | "Foo"  | ""                     |

    Scenario Outline: Visitor requests password reset email using invalid data
        Given there are registered Users:
            | id  | email              | name   | authentication_payload |
            | "1" | "test@example.com" | "Test" | ""                     |
            | "2" | "foo@bar.com"      | "Foo"  | ""                     |

        And  authentication payload "some-payload" is going to be created

        When I request password reset email for <email>
        Then I should not receive any error
        And notification email should not be sent
        And registered Users should be:
            | id  | email              | name   | authentication_payload |
            | "1" | "test@example.com" | "Test" | ""                     |
            | "2" | "foo@bar.com"      | "Foo"  | ""                     |

    Examples:
        | email  |
        | ""     |
        | "  "   |
        | "asdf" |
