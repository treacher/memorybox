Feature: View memory boxes

	Background:
		Given a user with email "team@nanny.com" and password "password"
		And the following memory boxes:
			| title    |
			| Jenna    |

	Scenario: show all albums
		Given I request all of the user's memory boxes
		Then the JSON at "0/title" should be "Jenna"

	Scenario: Show memory boxes
		Given I request a memory box
		Then the JSON at "title" should be "Jenna"