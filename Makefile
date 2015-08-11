
.PHONY: clean

java: add_person_java list_people_java

clean:
	rm -f add_person_java list_people_java
	rm -f javac_middleman AddPerson*.class ListPeople*.class com/example/tutorial/*.class
	rm -f protoc_middleman com/example/tutorial/AddressBookProtos.java
	rmdir com/example/tutorial 2>/dev/null || true
	rmdir com/example 2>/dev/null || true
	rmdir com 2>/dev/null || true

add_person_java: javac_middleman
	@echo "Writing shortcut script add_person_java..."
	@echo '#! /bin/sh' > add_person_java
	@echo 'java -classpath .:$$CLASSPATH AddPerson "$$@"' >> add_person_java
	@chmod +x add_person_java

list_people_java: javac_middleman
	@echo "Writing shortcut script list_people_java..."
	@echo '#! /bin/sh' > list_people_java
	@echo 'java -classpath .:$$CLASSPATH ListPeople "$$@"' >> list_people_java
	@chmod +x list_people_java

javac_middleman: AddPerson.java ListPeople.java protoc_middleman
	javac AddPerson.java ListPeople.java com/example/tutorial/AddressBookProtos.java -cp ~/protobuf-2.6.1/java/target/protobuf-java-2.6.1.jar
	@touch javac_middleman

protoc_middleman: addressbook.proto
	protoc --java_out=. addressbook.proto
	@touch protoc_middleman


