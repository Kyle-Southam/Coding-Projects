#pragma once

#include "Candy.h"
#include "Drinks.h"
#include "Chips.h"

class Vending {
public:
	Vending(int, double, double, double); //Our vending machine starts with the same stock of every item. They all have different prices, though.
	~Vending(); //Incase we want to destroy the vending machine
	
	void dispenseCandy();	//These will dispense the various items
	void dispenseChips();	
	void dispenseDrinks();
	
	void addDime(); //These will count the coins that are input (Only accepts dimes, quarters, and dollars)
	void addQuarter();
	void addDollar();

	void addCandy(int); //These are for restocking
	void addChips(int);
	void addDrinks(int);

	void printTotal(); //These are to print the amounts of total money, current money, stock and prices.
	void printCurrent();
	void printStock();
	void printPrices();

	void setCandyPrice(double); //These are to change the prices of the various items (For secret use only!)
	void setChipsPrice(double);
	void setDrinksPrice(double);

	double getTotal(); //These will allow us to get specific values from the vending machine (basically getters)
	double getDollars();
	double getQuarters();
	double getDimes();

private:
	double totalMoney;
	double currentMoney;
	Candy* vcandy;
	Chips* vchips;
	Drinks* vdrinks;
	double dime;
	double quarter;
	double dollar;
};