# Full Stack Solo [Section 1]

## Team Members
| Student ID | Name                         | Github Username | Role |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| 5730106921 | Chanatip Kriengkraipetch     | [Microph](https://github.com/Microph) | Front-end Developer |
| 5730271721 | Teerachod Boonprapakorn      | [ptheera](https://github.com/ptheera) | Developer |
| 5730282621 | Nonthiwat Visuthikraisee     | [5730282621-NV](https://github.com/5730282621-NV) | Database Developer & Back-end Developer|
| 5731001821 | Kanokpon Thongchaijareonsiri | [npingnk](https://github.com/npingnk) | Software Tester|
| 5731036821 | Nattapat Boonprakong         | [nattapatboon](https://github.com/nattapatboon) | System Analyst |
| 5731083221 | Peerawut Luengruengroj       | [peerawutgaga](https://github.com/peerawutgaga) | Project Manager & System Analyst|
| 5731087821 | Pakpoom Thaweesitthichat     | [phakphumi](https://github.com/phakphumi) | Technical Lead & Back-end Developer|
| 5731111121 | Athip Intaraphirom           | [athip-int](https://github.com/athip-int) | Designer & Front-end Developer |

## Build & Run Project with Docker 
* Install Docker & Docker-Compose first
* These command must run in the root directory (run in 'mms-full-stack-solo' folder)
### One Time Command (run this command at the first time)
> `docker rm $(docker ps -a -q) --force`<br>
> `docker rmi $(docker images -a -q) --force`<br>
> `docker volume rm $(docker volume ls -q) --force`<br>
> `docker-compose build`<br>
* Run these command in order
* If some warning or error occurs, ignores them and continue run following command
* Run these command only at first time or when you want to format the docker and rebuild everything

### Start Command
* Run in foreground `docker-compose up`
* Run in background `docker-compose up -d`
### Shutdown Command
* `docker-compose down`
* Very important to shutdown with this command or your PC will has a lot of docker-container

## Database Details
> Configuration
> * database: tutorium
> * user: tutorium
> * password: 123
> * port: 3306
* Setup config in '/backend/config/config.js'
* SHA256 algorithm used to hash 'password' field on 'admin' table

## API Reference
<a name="tableOfContent"></a>
### Table of Contents
* Authneticate
  1. [Admin Authen](#adminAuth)<br>
  2. [Current Login Session Data](#currLog)<br>
  3. [Delete Account](#deleteAccount)<br>
  4. [Facebook Authen](#faceAuth)<br>
  5. [Line Authen](#lineAuth)<br>
  6. [Logout](#logout)<br>
  7. [Reigster](#regist)<br>
* Payment
  1. [Add Credit Card](#addCreditCard)<br>
  2. [Delete Credit Card](#deleteCreditCard)<br>
  3. [Get Credit Card](#getCreditCard)<br>
  4. [Update Credit Card](#updateCreditCard)<br>
* Matching
  1. [Delete Student Request for a Tutor](#delTutorRequest)<br>
  2. [Get Course Offer By a Student](#getCourseStudent)<br>
  3. [Get Course Offer By a Tutor](#getCourseTutor)<br>
  4. [Student Accep Course Offer](#accepCourse)<br>
  5. [Student Request for a Tutor](#tutorRequest)<br>
  6. [Tutor Offer Course to a Student](#offerCourse)<br>
* Search
  1. [Student Search](#stSearch)<br>
  2. [Tutor Search](#tutorSearch)<br>
* Student
  1. [Update Student Comforatble place](#upStudentPlace)<br>
  2. [Update Student Comforatble Time](#upStudentTime)<br>
  3. [Update Student Profile](#upStudentPro)<br>
  4. [Update Student Want List](#upStudentWant)<br>
* Tutor
  1. [Request For Tutor Account](#registTutor)<br>
  2. [Update Tutor Comforatble place](#upTutorPlace)<br>
  3. [Update Tutor Comforatble Time](#upTutorTime)<br>
  4. [Update Tutor Want List](#upTutorTeach)<br>
[user write report](#userWriteReport)<br>
[Admin search all tutor requests](#adminTutorRequestManagement)<br>

<a name="adminAuth"></a>

### Admin Authentication ( Access via POST method on '/api/auth/admin' )
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| username | String | username is 'tutorium' on demo database | Yes |
| password | String | username is 'tutorium' on demo database| Yes |

* On success saving SESSION to cookies and redirect to admin homepage
* Access session data on '/api/current-login-session'

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="currLog"></a> 

### Current Login Session Data ( Access via GET method on '/api/current-login-session' )
#### Return value if user already login (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | |
| user | Object | { "registStatus": Bool,<br> "studentID": Integer,<br> "isTutor": Bool,<br> "accountType": String,<br> "accountID": String,<br> "displayName": String,<br> "profilePic": String } | current login user info |

#### Possible value inside user field
| Field Name | Type | Value | Description |
| :--------: | :--: | :---: | :---------: |
| registStatus | Bool | true,<br> false | return 'false' if the account is not register |
| studentID | Integer | 1...2147483648 | return 'null' if the account is not register |
| isTutor | Bool | true,<br> false | return 'true' if the account is tutor |
| accountType | String | 'admin',<br> 'line',<br> 'facebook' |  |
| accountID | String |  | ID provided by Facebook or Line API (username if accountType is admin ) |
| displayName | String |  | name provided by Facebook or Line API (username if accountType is admin) |
| profilePic | String |  | URL to profile's picture provided by Facebook or Line API 

#### Return value if user did not login, yet (HTTP 400 Bad Request)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | |
| msg | String | 'User is not login, yet' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="deleteAccount"></a>

### Delete Account ( Access via DELETE method on '/api/account/delete' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| confirm | Bool | true or false for confirm to delete | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | deleted account complete |
| msg | String | 'Delete Account Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | delete account incomplete |
| msg | String | 'Account hasn\'t been delete or already been delete, please correct your input',<br> 'You need to confirm for delete account',<br> 'You need to authenticate before delete account' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="faceAuth"></a>

### Facebook Authentication ( Access via GET method on '/api/auth/facebook' )
* On success saving SESSION to cookies and redirect to homepage
* Access session data on '/api/current-login-session'
<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="lineAuth"></a>

### Line Authentication ( Access via GET method on '/api/auth/line' )
* On success saving SESSION to cookies and redirect to homepage
* Access session data on '/api/current-login-session'
<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="logout"></a>

### Logout ( Access via GET method on '/api/logout' )
* Performs logout will clear all session then redirect to the home page

<p align="center">.................................................</p>
<a name="regist"></a>

### Register ( Access via POST method on '/api/register' )
#### Pre-required
* Authentication
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| agree | Bool | true on accept our condition or false on otherwise | Yes |
| name | String | | Yes |
| surname | String | | Yes |
| gender | String | 'male',<br> 'female',<br> 'others' | Yes|
| educationLevel | String | 'pratom',<br> 'matthayomton',<br> 'matthayomplai',<br> 'bachelor',<br> 'master',<br> 'doctor' | Yes |
| facebookUrl | String | | Optional |
| lineID | String | | Optional |
| email | String | | Yes |
| mobile | String | | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | register successful |
| msg | String | 'Register complete',<br> 'Account is already register' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | register unsuccessful |
| msg | String | 'Registration incomplete',<br> 'Authenticate and condition accept need for register' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="addCreditCard"></a>

### Add New Credit Card Time ( Access via POST method on '/api/payment/card/add' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| cardNO | String(16) | Credit card number | Yes |
| cardHolder | String(200) | Name of card holder | Yes |
| CVV | String(3) | Secure Code | Yes |
| expireMonth | String(2) |  | Yes |
| expireYear | String(2) |  | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | Add credit card complete |
| msg | String | 'Add Credit Card Complete',<br> 'Credit Card had already added' |  |
#### Return value on incomplete (HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | Add credit card incomplete |
| msg | String | 'You should login before add your credit card'   |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="deleteCreditCard"></a>

### Remove Credit Card Time ( Access via DELETE method on '/api/payment/card/delete' )
#### Pre-required
* Authentication
* Has StudentID (already register)
* Has Credit Card
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| cardNO | String(16) | Card Number | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | deleted credite card complete |
| msg | String | 'Delete Credit Card Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated credit card incomplete |
| msg | String | 'Credit card hasn\'t been delete, please correct your input',<br> 'You should login before delete your credit card' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="getCreditCard"></a>

### Get Credit Card ( Access via GET method on '/api/payment/card' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | Get credit card complete |
| cards | Objects | [{ cardNO: String(16), <br>cardHolder: String(200), <br>CVV: String(3), <br>expireMonth: String(2), <br>expireYear: String(2)}] | found cards |
| count | Number |  | Amount of card related to authenticate student |
#### Return value on incomplete (HTTP 200 Success, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | Get card incomplete |
| msg | String | 'Credit Card not found', 'You should login before get your credit card' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="updateCreditCard"></a>

### Update New Credit Card Time ( Access via PUT method on '/api/payment/card/update' )
#### Pre-required
* Authentication
* Has StudentID (already register)
* Has Credit Card
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| cardNO | String(16) | Fix values (Can't Change) | Yes |
| cardHolder | String(200) | Name of card holder | Yes |
| CVV | String(3) | Secure Code | Yes |
| expireMonth | String(2) |  | Yes |
| expireYear | String(2) |  | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated credite card complete |
| msg | String | 'Update Credit Card Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated credit card incomplete |
| msg | String | 'Credit card hasn\'t been update, please correct your input',<br> 'You should login before update your credit card' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="stSearch"></a>

### Student Search ( Access via GET method on '/api/search/student' )
#### Pre-required
* Authentication
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| studentID | String | filter by studentID | Optional |
* If there is some field has no data inside. You must not include the field
* Sending `studentID=undefined` means return the student who has undefined on studentID field
* Not Send the filter to get all student
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true |  |
| students | Objects | [{ studentID: String, <br>name: String, <br> surname: String, <br>gender: String, <br>educationLevel: String, <br>facebookUrl: String, <br>lineID: String, <br>email:String, <br>mobile: String, <br> wantList: Object, <br> place: Object, <br> time: Object}] | found student |
| count | Number |  | Amount of student |
#### Return value on incomplete (HTTP 403 Forbidden, HTTP 200 No Content)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | search incomplete |
| msg | String | 'You should be a tutor to searching',<br> 'Student not found' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="tutorSearch"></a>

### Tutor Search ( Access via GET method on '/api/search/tutor' )
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| studentID | String | filter by studentID | Optional |
* If there is some field has no data inside. You must not include the field
* Sending `studentID=undefined` means return the tutor who has undefined on studentID field
* Not Send the filter to get all tutor
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true |  |
| tutors | Objects | [{ studentID: String, <br>education: Objects, <br>teachList: Objects, <br>place: List, <br>time: Objects, <br>uploadEvidence: Objects, <br>isApproved: Bool, <br>student: {<br>name: String,<br> surname: String,<br> gender: String}}] | found tutors |
| count | Number |  | Amount of tutor |
#### Return value on incomplete (HTTP 200 No Content)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | search incomplete |
| msg | String | 'Tutor not found' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="upStudentPro"></a>

### Update Student Profile ( Access via PUT method on '/api/student/profile/update' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| name | String | Send old value or updated value | Yes |
| surname | String | Send old value or updated value | Yes |
| gender | String | 'male',<br> 'female',<br> 'others' | Yes|
| educationLevel | String | 'pratom',<br> 'matthayomton',<br> 'matthayomplai',<br> 'bachelor',<br> 'master',<br> 'doctor' | Yes |
| facebookUrl | String | Send old value or updated value | Yes |
| lineID | String | Send old value or updated value | Yes |
| email | String | Send old value or updated value | Yes |
| mobile | String | Send old value or updated value | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Updated Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Profile hasn't been update, please correct your input',<br> 'You should login before update your profile'  |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="upStudentWant"></a>

### Update Student Want List ( Access via PUT method on '/api/student/wantList/update' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| wantList | Objects | User want list | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Updated Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Want list hasn\'t been update, please correct your input',<br> 'You should login before update your profile'  |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="upStudentPlace"></a>

### Update Student Comfort Place ( Access via PUT method on '/api/student/place/update' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| place | Objects | User comfortable place | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Updated Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Place hasn\'t been update, please correct your input',<br> 'You should login before update your profile'  |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="upStudentTime"></a>

### Update Student Comfort Time ( Access via PUT method on '/api/student/time/update' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| time | Objects | User comfortable time | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Updated Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Place hasn't been update, please correct your input',<br> 'You should login before update your profile'  |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="registTutor"></a>

### Request for a Tutor Account ( Access via POST method on '/api/tutor/register' )
#### Pre-required
* Authentication
* Is a student (Already register)

#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| education | Objects | Education history | Yes |
| teachList | Objects | Teach list that you want to teach | Yes |
| place | Objects | Convinience place you want to teach | Yes |
| time | Objects | Covinience time you want to teach | Yes |
| UploadEvidence | Objects | Evidence for everything | Optional |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Register complete',<br> 'Account is already register' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Registration incomplete',<br> 'You should be a student, or login first' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="upTutorTeach"></a>

### Update Tutor Teach List ( Access via PUT method on '/api/tutor/teachList/update' )
#### Pre-required
* Authentication
* Is tutor (Already approved)

#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| teachList | Objects | Tutor teach list | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Updated Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Teacn list hasn\'t been update, please correct your input',<br> 'You should be a tutor to update your teach list' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="upTutorPlace"></a>

### Update Tutor Comfort Place ( Access via PUT method on '/api/tutor/place/update' )
#### Pre-required
* Authentication
* Is tutor (Already approved)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| place | Objects | User comfortable place | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Updated Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Place hasn\'t been update, please correct your input',<br> 'You should be a tutor to update your place' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="upTutorTime"></a>

### Update Tutor Comfort Time ( Access via PUT method on '/api/tutor/time/update' )
#### Pre-required
* Authentication
* Is tutor (Already approved)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| time | Objects | User comfortable time | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | updated complete |
| msg | String | 'Updated Complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | updated incomplete |
| msg | String | 'Place hasn't been update, please correct your input',<br> 'You should login before update your place'  |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="tutorRequest"></a>

### Student request for a Tutor ( Access via POST method on '/api/match/request' )
#### Pre-required
* Authentication
* Has StudentID (already register)
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| tutorID | Integer | student id of a tutor is tutorID | Yes |
| subject | String(100) | subject that you want to study | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | deleted account complete |
| msg | String | 'Request for a tutor complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | delete account incomplete |
| msg | String | 'You used to send a request to this tutor',<br> 'You should login to request tutor' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="delTutorRequest"></a>

### Delete Tutor Request ( Access via DELETE method on '/api/match/request/delete' )
#### Pre-required
* Authentication
* Is a tutor
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| studentID | Integer | student id you want to delete the request | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | deleted account complete |
| msg | String | 'The request has already been delete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | delete account incomplete |
| msg | String | 'There is no row affected',<br> 'You should be a tutor to delete the request' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="offerCourse"></a>

### Offer Course to a Student ( Access via POST method on '/api/match/offer' )
#### Pre-required
* Authentication
* Is tutor
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| studentID | Integer | send offer to whose student | Yes |
| subject | String(100) | subject that you want to teach | Yes |
| price | Integer |  | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true |  |
| msg | String | 'Offer to a student complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false |  |
| msg | String | 'You used to send an offer to this student',<br> 'You should be a tutor to send offer to student' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="accepCourse"></a>

### Offer Course to a Student ( Access via POST method on '/api/match/offer/accept' )
#### Pre-required
* Authentication
* Is student
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| tutorID | Integer | whose tutor do you want to accept offer | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true |  |
| msg | String | 'Confirm complete' |  |
#### Return value on incomplete (HTTP 400 Bad Request, HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false |  |
| msg | String | 'There is no any offers',<br> 'You should be a student to accept course offer' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="getCourseStudent"></a>

### Get Course Offer by Student ( Access via GET method on '/api/match/bystudent' )
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true |  |
| offers | Objects | [{ studentID: Int, <br>tutorID: Int, <br>subject: String, <br>price: Int, <br>studentConfirm: Bool}] | found offers |
| count | Number |  | Amount of offer |
#### Return value on incomplete (HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | search incomplete |
| msg | String | 'You should login to get the match' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="getCourseTutor"></a>

### Get Course Offer by Tutor ( Access via GET method on '/api/match/bytutor' )
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true |  |
| offers | Objects | [{ studentID: Int, <br>tutorID: Int, <br>subject: String, <br>price: Int, <br>studentConfirm: Bool}] | found offers |
| count | Number |  | Amount of offer |
#### Return value on incomplete (HTTP 403 Forbidden)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | search incomplete |
| msg | String | 'You should be a tutor to get tutor offer' |  |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="userWriteReport"></a>

### User write report ( Access via POST method on '/api/user-write-report' )
#### Pre-required
* Authentication
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| reporterStudentID | Int |  | Yes |
| reportedStudentID | Int |  | No |
| topic | String(200) |  | Yes |
| detail | String(2000) |  | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | insert report completed |
#### Return value on incomplete (HTTP 500 Internal server error)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | insert report incompleted<br> reporterStudentID, topic, detail cannot be null |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="adminTutorRequestManagement"></a>

### Admin search all tutor requests ( Access via GET method on '/api/admin/tutor-request-management' )
#### Pre-required
* Authentication
#### Return value on hit (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | query success |
| student | Object | {"studentID":INT,<br>"education":String,<br>"teachList":String,<br>"place":String,<br>"time":String,<br>"uploadEvidence":String,<br>"isApproved":BOOL,<br>"createdAt":DATETIME,<br>"updatedAt":DATETIME,<br>"student":{<br>  "name":String,<br>  "surname":Sstring<br>}<br>} |  |
#### Return value on Not found (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | no tutor request found |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
<a name="adminResponseToATutorRequest"></a>

### Admin response to a tutor request ( Access via POST method on '/api/admin/tutor-request-management' )
#### Pre-required
* Authentication
#### Input Parameters
| Field Name | Type | Description | Required? |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| id | Int | the student's id | Yes |
| accept | string | 'true' for accept and<br>any other for reject | Yes |
#### Return value on complete (HTTP 200 Success)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | true | the tutor request has been accepted<br>or rejected based on the button clicked |
#### Return value on incomplete (HTTP 500 Internal server error)
| Field Name | Type | Value | Description |
| :------------: | --------------------------------- | ------------------ | ------------------ |
| success | Bool | false | the id doesn't existed |

<br>[Back To Table Of Content](#tableOfContent)
<p align="center">.................................................</p>
