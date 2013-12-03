#!/bin/bash

set -m

postFunction() {
 curl --connect-timeout 30 --data "surveyID=7891&encodedCampaignID=2kkj5cnzus3u&encodedMeetingID=aldpnrnhz5oj&questions%5B0%5D.questionID=2&questions%5B0%5D.questionText=First+Name&questions%5B0%5D.questionAnswer=Chris&questions%5B1%5D.questionID=1&questions%5B1%5D.questionText=Last+Name&questions%5B1%5D.questionAnswer=Weaver&questions%5B2%5D.questionID=13&questions%5B2%5D.questionText=Email&questions%5B2%5D.questionAnswer=chris.weaver%40readytalk.com&questions%5B3%5D.questionID=-1&questions%5B3%5D.questionText=Email+Confirmation&questions%5B3%5D.questionAnswer=chris.weaver%40readytalk.com&questions%5B4%5D.questionID=15&questions%5B4%5D.questionText=Job+Title&questions%5B4%5D.questionAnswer=Software&questions%5B5%5D.questionID=10&questions%5B5%5D.questionText=Company&questions%5B5%5D.questionAnswer=ReadyTalk&questions%5B6%5D.questionID=103&questions%5B6%5D.questionText=Industry&questions%5B6%5D.questionAnswer=Meetings&questions%5B7%5D.questionID=8&questions%5B7%5D.questionText=City&questions%5B7%5D.questionAnswer=Denver&questions%5B8%5D.questionID=26&questions%5B8%5D.questionText=State&questions%5B8%5D.questionAnswer=CO&questions%5B9%5D.questionID=28&questions%5B9%5D.questionText=Zip&questions%5B9%5D.questionAnswer=80202&questions%5B10%5D.questionID=7898&questions%5B10%5D.questionText=Favorite+Color%3F&questions%5B10%5D.questionAnswer=It%27s+so+hard+to+pick+a+favorite+color%2C+that%27s+why+this+is+a+textbox.&_countryAgreementCheckbox=on" https://dobra.ecovate.com/cc/s/registrations &
}


for i in {1..2000}; do 
  postFunction
done

