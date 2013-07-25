Feature: Create entries
	Background:
		Given a user with email "team@nanny.com" and password "password"
		And the following memory boxes:
			| title  |
			| Jenna  |
			
	Scenario: Create a entry
		Given I create an entry with the following fields:
		| description | media_url           | media_identifier | media_format | media_type |
		|   desc      | http://google.com/1 | 1								 |   png        | image      |
		
		Then the memory box should have 1 entries