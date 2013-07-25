Feature: Invite users

	Background:
		Given a user with email "team@nanny.com" and password "password"
		And the following memory boxes:
      |   title   |
      | Charlotte |

	Scenario: Inviting users that already exist to a memory box you have created
	  Given a user with email "bill@memoryboxapp.com" and password "password"
    And a user with email "bob@memoryboxapp.com" and password "password"
		And "team@nanny.com" posts a request to invite users to the memory box "Charlotte" with the JSON
		"""
		{
			"invitations": "bill@memoryboxapp.com, bob@memoryboxapp.com"
		}
		"""
		Then "team@nanny.com" should have 2 sent invitations
		And "bill@memoryboxapp.com" should have recieved 1 invitation
		And "bob@memoryboxapp.com" should have recieved 1 invitation