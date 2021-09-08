Programmer: Kyle Southam
Description: This project basically emulates a vending machine. You need to input money, you can get stuff from the machine, manage stock, reprice stuff, and print a log.
The log uses a vector to store whenever an item is bought. The secret codes are: 3 for restock, 4 for price changing, and 5 for a transaction history print to a file.

I tried to use boost to display the file size of the transaction log, but I don't think I set up BOOST correctly, and could not figure it out. 

The Items class is purely virtual and used to set up the other items that are input into the machine. 