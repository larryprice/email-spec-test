Feature: Signup Confirmation
  As a new user
  When I sign up
  I should receive a confirmation email

Background:
  Given a clear email queue
  When I go to the signup page
  And I fill in "email" with "prez@whitehouse.gov"
  And I fill in "password" with "bunnies"
  And I press "Sign Up"
  Then "prez@whitehouse.gov" should receive an email

Scenario: Receives email with correct contents
  When "prez@whitehouse.gov" opens the email
  Then they should see the email delivered from "MyApp Help Desk <noreply@myapp.com>"
  And they should see "MyApp Account Verification" in the email subject
  And they should see "Username: prez@whitehouse.gov" in the email body