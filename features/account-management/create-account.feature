Feature: Create Account
    In order to track different sources of income and expense in several currencies
    As a User
    I want to be able to create Accounts

    Scenario: I create Account
        Given I have Accounts:
            | id | name | balance | currency_id |

        And There are Currencies:
            | id  |
            | "1" |
            | "2" |

        When I create Account with Name "Foo" and Currency "1"

        Then My Accounts should be:
            | name  | balance | currency_id |
            | "Foo" | "0.00"  | "1"         |

    Scenario Outline: I create Account with invalid input
        Given I have Accounts:
            | id  | name  | balance | currency_id |
            | "1" | "Foo" | "0.00"  | "1"         |

        And There are Currencies:
            | id  |
            | "1" |
            | "2" |

        When I create Account with Name <account-name> and Currency <currency-id>

        Then I should receive <error-message> error
        And My Accounts should be:
            | name  | balance | currency_id |
            | "Foo" | "0.00"  | "1"         |

        Examples:
            | account-name | currency-id | error-message                      |
            | "Bar"        | "3"         | "Invalid currency provided"        |
            | "Foo"        | "1"         | "Account 'Foo' already exists"     |
            | ""           | "2"         | "Name of Account can not be empty" |
            | "   "        | "2"         | "Name of Account can not be empty" |

