CS 169 Sp 2015 Project

PeerTracker (Kevin's dogs who code… LOL)
#

Overview

Ã¢ÂÂ.Peer evals are always done as google forms. While google forms are useful at collecting data it is VERY difficult to display the data to the teaching staff in a way that makes sense.ÃÂ
Ã¢ÂÂ.Even though we have rosters (CSV) of who is on each team we generally leave it up to the student to type in the names...variations of names destroy attempting to parse the results.ÃÂ
Ã¢ÂÂ.There is realistically no way to look at the status of a team across multiple iterations. We can't tell improvement. We're lucky if we can even identify problem teams to be able to talk to themÃÂ
(Failed?) Attempts

Ã¢ÂÂ. CS169 this semester - Simple, but can't do much. I highly doubt that we will be able to intervene on behalf of any team, likely we will only be able to piece everything together from what information we get from the students and just being able to back it up with the raw data.ÃÂ
Ã¢ÂÂ. CS160 This semester - I am not in the class, but my friend says that they use a shared google document to do their peer evals. Yes, completely shared by the team so that everyone can see anything that is said about them and can tell exactly who wrote what.ÃÂ
Ã¢ÂÂ. CS162 Last Semester - My team submitted google forms similar to the google forms from this semester. The team had pretty intensive issues based on the form results, but wasn't even acknowledged till after the semester was over. ÃÂ
Ã¢ÂÂ. CS169 Last Semester - A very clunky process. All the data in Necula's class in is in google spreadsheets, and I was in charge of making the form. ÃÂ I managed to create google scripts that generate a form based on a list of names/teams in a google spreadsheet. Each page in the google form is for a specific team, so each student only has to fill out the first page and then their "team" page which lists their teammates based on what team they selected in the first page. Then I used google scripts again to basically parse the spreadsheet of responses. The questions looks like - "How many points would you give Kevin Casey?" so then each column in the spreadsheet results in data about a single person. I was then able to parse said spreadsheet so that a single peer eval is organized by team...in about 1k lines of unreadable google scripts. The problem is: this isn't scalable. I ran into a brick wall when I realized that spreadsheets have a maximum number of columns, I got lucky Necula's class was capped at 110 students (if it was 150 this strategy would not work). In Necula's class we used the result to change student's project grades, such that your project score would actually be your team score * scaled avg peer eval.ÃÂ
Proposed Product
Ã¢ÂÂ.CoreÃÂ

Ã¢ÂÂ.Admin loginÃÂ
Ã¢ÂÂ.Teacher create/loginÃÂ

Ã¢ÂÂ .Admin basically needs to approve that the teaching staff information is correct...Can't have just anybody creating arbitrary forms.ÃÂ
Ã¢ÂÂ.Teacher can upload roster (Probably just name, teamname CSV so we don't have to deal with FERPA)ÃÂ

Ã¢ÂÂ.Teacher create form with a title/descriptionÃÂ

Ã¢ÂÂ .Form would automatically have fields to give points to each teammate and give comments (either as a whole, or to each each teammate)ÃÂ
Ã¢ÂÂ.Anyone can fill out form (ideally would somehow verifyÃ¢ÂÂ¦)ÃÂ

Ã¢ÂÂ.Teacher can see results organized by teamÃÂ
Ã¢ÂÂ.HighÃÂ

Ã¢ÂÂ.Have students log in to view form and somehow authorize who they are taking the form as. Website would know who they are and thus what team they are in.ÃÂ
Ã¢ÂÂ.See data from past forms, all organized from team.ÃÂ
Ã¢ÂÂ.Show dashboard of teams, can identify "problem" teams from dashboardÃÂ
Ã¢ÂÂ .Problem team loosely defined as having 15% differences from mean in scores.ÃÂ
Ã¢ÂÂ.MediumÃÂ

Ã¢ÂÂ.Export - Should be able to pull out all the form data (hopefully nicely organized)ÃÂ
Ã¢ÂÂ.Scalable - Can do multiple separate courses at onceÃÂ
Ã¢ÂÂ.Edit the roster - Change team assignments, handle drop/add studentsÃÂ
Ã¢ÂÂ.Somehow link teachers to groups. If a teacher (GSI) is logged in they can optionally view only their teams.ÃÂ
Ã¢ÂÂ.LowÃÂ

Ã¢ÂÂ.Teacher can add other teachers to their courseÃÂ
Ã¢ÂÂ.Admin has a dashboard to manage teachers to courses(/semesters)ÃÂ
Ã¢ÂÂ.Past semester managementÃÂ

Ã¢ÂÂ .This could be handled just by asking everyone to export and then resetting the database, but ideally only the teachers associated with a course/semester combo would be able to see that course/semesterÃÂ
Ã¢ÂÂ.Be able to customize the formÃÂ

Ã¢ÂÂ .Restrict the point value rangeÃÂ
Ã¢ÂÂ .Choose whether to have comment boxes on each student or just as a wholeÃÂ

Ã¢ÂÂ.Choose whether comments are required on student submissions or notÃÂ
Ã¢ÂÂ .Being able to have an optional question that can alert the GSIs if a student feels like their team is having problemsÃÂ

Client Contact
Kevin Casey

CS 169 TA with Prof. Necula last semester

Current TA for CS169

kacasey@berkeley.edu