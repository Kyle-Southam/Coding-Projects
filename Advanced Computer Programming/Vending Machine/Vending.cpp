#include "Vending.h"
#include <iostream>

using namespace std;

Vending::Vending(int a, double b, double c, double d): //Our vending machine starts with the same stock of every item. They all have different prices, though.
	vcandy{ new Candy(a,b) },
	vchips{ new Chips(a,c) },
	vdrinks{ new Drinks(a,d) }
{
	totalMoney = 0;
	currentMoney = 0;
	dime = 0;
	quarter = 0;
	dollar = 0;
}

Vending::~Vending() { //Incase we want to destroy the vending machine
	delete vcandy, vchips, vdrinks;
	vcandy = 0, vchips = 0, vdrinks = 0;
}

void Vending::dispenseCandy() {	//These will dispense the various items
	if (vcandy->printStock() > 0)
	{
		if (currentMoney > vcandy->printPrice()) 
		{
			vcandy->subtract();
			currentMoney -= vcandy->printPrice();
		}

		else 
		{
			cout << "Sorry, you do not have enough money to buy this." << endl << endl;
		}
	}
	else {
		cout << "Sorry, this item needs to be restocked!" << endl;
	}
}

void Vending::dispenseChips() {
	if (vchips->printStock() > 0)
	{
		if (currentMoney > vchips->printPrice())
		{
			vchips->subtract();
			currentMoney -= vchips->printPrice();
		}

		else
		{
			cout << "Sorry, you do not have enough money to buy this." << endl << endl;
		}
	}
	else {
		cout << "Sorry, this item needs to be restocked!" << endl;
	}
}

void Vending::dispenseDrinks() {
	if (vdrinks->printStock() > 0)
	{
		if (currentMoney > vdrinks->printPrice())
		{
			vdrinks->subtract();
			currentMoney -= vdrinks->printPrice();
		}

		else
		{
			cout << "Sorry, you do not have enough money to buy this." << endl << endl;
		}
	}
	else {
		cout << "Sorry, this item needs to be restocked!" << endl;
	}
}

void Vending::addDime() { //These will count the coins that are input (Only accepts dimes, quarters, and dollars)
	totalMoney += .10;
	currentMoney += .10;
	dime += 1;
}

void Vending::addQuarter(){
	totalMoney += .25;
	currentMoney += .25;
	quarter += 1;
}

void Vending::addDollar() {
	totalMoney += 1.00;
	currentMoney += 1.00;
	dollar += 1;
}

void Vending::addCandy(int a) { //These are for restocking
	vcandy->add(a);
}

void Vending::addChips(int a) {
	vchips->add(a);
}

void Vending::addDrinks(int a) {
	vdrinks->add(a);
}

void Vending::printTotal() { //These are to print the amounts of total money, current money, stock and prices.
	cout << "Total money in machine: $" << totalMoney << endl;
	cout << "Dollars in machine: " << dollar << endl;
	cout << "Quarters in machine: " << quarter << endl;
	cout << "Dimes in machine: " << dime << endl;
}

void Vending::printCurrent() {
	cout << "Current money for use in machine: " << currentMoney << endl;
}

void Vending::printStock() {
	cout << "Candy Stock: " << vcandy->printStock() << endl;
	cout << "Chips Stock: " << vchips->printStock() << endl;
	cout << "Drink Stock: " << vdrinks->printStock() << endl;
}

void Vending::printPrices() {
	cout << "Candy Price: " << vcandy->printPrice() << endl;
	cout << "Chips Price: " << vchips->printPrice() << endl;
	cout << "Drink Price: " << vdrinks->printPrice() << endl;
}

void Vending::setCandyPrice(double b) { //These are to change the prices of the various items (For secret use only!)
	vcandy->setPrice(b);
}

void Vending::setChipsPrice(double b) {
	vchips->setPrice(b);
}

void Vending::setDrinksPrice(double b) {
	vdrinks->setPrice(b);
}

double Vending::getTotal() { //These will allow us to get specific values from the vending machine (basically getters)
	return totalMoney;
}

double Vending::getDollars() {
	return dollar;
}

double Vending::getQuarters() {
	return quarter;
}

double Vending::getDimes() {
	return dime;
}