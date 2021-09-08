/*
Programmer: Kyle Southam
Description: This project simulates a vending machine.
The 3rd party program used is BOOST filesystem to check the size of the log file. Link to the software: https://www.boost.org/doc/libs/1_72_0/libs/filesystem/doc/index.htm
*/

#include "Vending.h"
#include <iostream>
#include <vector>
#include <fstream>
#include <string>
//#include <boost/filesystem.hpp> //Keep this line commented if you choose not to use BOOST

using namespace std;

void transaction(Vending&, vector<string>&);
void addMoney(Vending&);
void restock(Vending&);
void changePrice(Vending&);

int main()
{
	//Here we will be declaring variables (original stock and prices, creating a vector for a log of purchases and the vending machine itself)
	int a = 10;
	double b = 0.50, c = 0.75, d = 1.00;
	vector<string> log;
	log.push_back("Beginning of Log:");
	Vending v1(a, b, c, d);

	cout << "Welcome to the Vending Machine!" << endl;

	//Here is the main loop for the vending machine. It ask what you would like to do and you make a choice. The secret code for restocking is 3,
	//the secret code for changing prices is 4, and the secret code to print the log is 5.
	int choice = 1, i = 1;
	while (choice != 0)
	{
		cout << endl;
		cout << "What would you like to do?" << endl << "1: Select item" << endl << "2: Add money" << endl;
		cout << "(Secret Code): Restock Machine" << endl << "(Secret Code): Change prices" <<  endl << "(Secret Code): Print transaction log and show money in machine" << endl << "0: Exit machine" << endl;
		cout << "What is your choice?: ";
		cin >> choice;
		if (choice == 1)
		{
			transaction(v1, log);
			i += 1;
		}

		else if (choice == 2)
		{
			addMoney(v1);
		}

		else if (choice == 3)
		{
			restock(v1);
		}

		else if (choice == 4)
		{
			changePrice(v1);
		}

		else if (choice == 5)
		{
			std::ofstream file;
			v1.printTotal();
			file.open("log.txt");
			for (vector<string>::const_iterator i = log.begin(); i != log.end(); ++i)
			{
				file << *i << endl;
			}
			//cout << "The file size of the log.txt file is: " << file_size(file) << endl; //if you don't feel like downloading boost keep this line commented
			file.close();																			//wouldn't work. I'm not sure if I set it up properly. 
		}

		else if (choice == 0)
		{
			cout << "Goodbye!" << endl;
			return 0;
		}

		else
		{
			cout << "Sorry, what you input was not an option! Please re-enter your choice: ";
			cin >> choice;
			cout << endl;
		}
	}
	return 0;
}

//This is the transaction function if someone chooses to buy something.
void transaction(Vending& a, vector<string>& b)
{
	int c;
	cout << endl;
	cout << "What would you like to order?" << endl << "1: Candy" << endl << "2: Chips" << endl << "3: Drink" << endl << "0: Go back" << endl;
	cout << "What is your choice?: ";
	cin >> c;
	cout << endl;

	if (c == 1) 
	{
		a.dispenseCandy();
		b.push_back("Candy");
		cout << "Dispensing candy and returning the main menu..." << endl;
	}

	else if (c == 2)
	{
		a.dispenseChips();
		b.push_back("Chips");
		cout << "Dispensing chips and returning to main menu..." << endl;
	}

	else if (c == 3)
	{
		a.dispenseDrinks();
		b.push_back("Drink");
		cout << "Dispensing a drink and returning to main menu..." << endl;
	}

	else if (c == 0)
	{
		cout << "Returning to main menu..." << endl;
		return;
	}

	else
	{
		cout << "Invalid code. Returning to main menu." << endl;
		return;
	}
	return;
}

//This is to add money to the machine to make a transaction
void addMoney(Vending& a)
{
	int c;
	cout << endl;
	cout << "What would you like to input into the machine?" << endl << "1: Dollar" << endl << "2: Quarter" << endl << "3: Dime" << endl << "0: Go back" << endl;
	cout << "What is your choice?: ";
	cin >> c;
	cout << endl;

	if (c == 1)
	{
		a.addDollar();
	}

	else if (c == 2)
	{
		a.addQuarter();
	}

	else if (c == 3)
	{
		a.addDime();
	}

	else if (c == 0)
	{
		cout << "Returning to main menu..." << endl;
		return;
	}

	else
	{
		cout << "Invalid code. Returning to main menu." << endl;
		return;
	}
	return;
}

//This is to restock the machine. The secret code for this is 3.
void restock(Vending& a)
{
	int c, b;
	cout << endl;
	cout << "What would you like to restock?" << endl << "1: Candy" << endl << "2: Chips" << endl << "3: Drinks" << endl << "0: Go back" << endl;
	cout << "What is your choice?: ";
	cin >> c;
	cout << endl;
	cout << "And how many would you like to stock?: ";
	cin >> b;
	cout << endl;

	if (c == 1)
	{
		a.addCandy(b);
	}

	else if (c == 2)
	{
		a.addChips(b);
	}

	else if (c == 3)
	{
		a.addDrinks(b);
	}

	else if (c == 0)
	{
		cout << "Returning to main menu..." << endl;
		return;
	}

	else
	{
		cout << "Invalid code. Returning to main menu." << endl;
		return;
	}
	return;
}

//This is the secret menu to change the prices of the items. Secret code is 4 to access this one.
void changePrice(Vending& a)
{
	int c;
	double p;
	cout << endl;
	cout << "What would you like change the price of?" << endl << "1: Candy" << endl << "2: Chips" << endl << "3: Drink" << endl << "0: Go back" << endl;
	cout << "What is your choice?: ";
	cin >> c;
	cout << endl;

	cout << "How much would you like to make this item?: ";
	cin >> p;
	cout << endl;

	if (c == 1)
	{
		a.setCandyPrice(p);
	}

	else if (c == 2)
	{
		a.setChipsPrice(p);
	}

	else if (c == 3)
	{
		a.setDrinksPrice(p);
	}

	else if (c == 0)
	{
		cout << "Returning to main menu..." << endl;
		return;
	}

	else
	{
		cout << "Invalid code. Returning to main menu." << endl;
		return;
	}
	return;
}

