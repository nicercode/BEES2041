# Setup

The lessons in this repository use a custom script to change styling and add functionality to Moodle quizzes. This script was a collaboration between Faculty of Science and BEES2041 staff and inserted into to the course through a Moodle HTML block. The steps in this guide only apply to UNSW's Moodle instance and may not apply in other contexts.

## Moodle Course Setup
1. Go to More > Filters and turn off the filter for GeSHi. This filter replaces `<code>` blocks to allow for displaying formatted PHP, but it breaks the display of code samples for this course.
2. Navigate to a quiz page, preferably a preview page for a quiz. Add a new HTML (per role) block to the side of your course. Name it however you'd like, then copy and paste the script into the content section.
3. At the bottom of the block settings, there should be an option to show on all quiz pages.
4. Save the block.

After following these steps, the block should be enabled for all quizzes in your course. This should be adequate for editing, however you'll need to follow additional steps to enable the script to run for students:

## Moodle Quiz Setup
As a precaution, UNSW's Moodle instance has extra security protections to avoid student cheating during exams. To run the code blocks however, we'll need to turn off these protections so our scripts can run.
1. Go to your Quiz settings.
2. Navigate to Extra restrictions on attempts > More > Browser security. Set it to None.
3. Navigate to Appearance > More > Show blocks during quiz attempts. Tick the checkbox.
4. Save the quiz.
5. Verify the quiz works by logging in as a student and previewing the quiz. You may need to set the quiz to show but not available.

You'll need to follow these steps for all quizes you create.

## Adding a Code Block
To add an interactive R code block to your Moodle quiz, add an element with an id of "r-editor-{number}" with {number} being any random number. This number allows the code block to have a unique section on the page and avoid overwriting other code blocks. An example:

```html
<div id="r-editor-2144">Insert code here</div>
```
