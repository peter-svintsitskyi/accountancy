Feature: Create Category
    In order to have possibility to group transactions by categories
    As User
    I want to be able create categories

    Scenario: I create Category
        Given I have Categories:
            | id | name |

        When I create Category "Foo"
        Then My Categories should be:
            | name  |
            | "Foo" |

    Scenario Outline: I create invalid Category
        Given I have Categories:
            | id  | name  |
            | "1" | "Zoo" |
        When I create Category <category-name>
        Then I should receive <error-message> error
        And My Categories should be:
            | id  | name  |
            | "1" | "Zoo" |

    Examples:
        | category-name | error-message                    |
        | "Zoo"         | "Category 'Zoo' already exists"  |
        | ""            | "Category name can not be empty" |
        | "  "          | "Category name can not be empty" |
