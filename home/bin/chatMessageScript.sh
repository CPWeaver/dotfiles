#!/bin/bash

set -m 

postFunction() {
   local refId="${1}"
java -jar ~/dev/chatws/cli/target/chat-cli-1.3-SNAPSHOT-jar-with-dependencies.jar --action=publish --url=https://dobra-api.ecovate.com/chatws/ --conferenceUUID=037877f4-e7c7-4407-bb2f-1b43f86e247e  --message="This is a test" --referenceId=$refId --senderId=3 --senderRole=CHAIRPERSON --recipientId=5 --recipientRole=PARTICIPANT
java -jar ~/dev/chatws/cli/target/chat-cli-1.3-SNAPSHOT-jar-with-dependencies.jar --action=add_tag --url=https://dobra-api.ecovate.com/chatws/ --conferenceUUID=037877f4-e7c7-4407-bb2f-1b43f86e247e --referenceId=$refId --tag=question
}

for i in {0..1}; do
    postFunction "msg${i}"
done

