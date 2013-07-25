Feature: View entries

  Background:
		Given a user with email "team@nanny.com" and password "password"
		And the following memory boxes:
			| title  |
			| Ben    |
		And a memory box with the following entries:
			|       description             |
			| Billy taking his first steps  |
			| Johanna playing with the ball |

	Scenario: View all of a albums entries
		Given I request all of the entries
	  And the JSON at "1/description" should be "Billy taking his first steps"
	  And the JSON at "0/description" should be "Johanna playing with the ball"

	 Scenario: View a entry from a album
		Given I request a entry
		And the JSON at "description" should be "Johanna playing with the ball"