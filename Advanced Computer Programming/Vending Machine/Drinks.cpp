#include "Drinks.h"

Drinks::Drinks(int a, double b) {
	stock = a;
	price = b;
}

void Drinks::add(int a) { //Add stock
	stock += a;
}

void Drinks::subtract() { //Subtract stock 
	stock = stock - 1;
}

void Drinks::setStock(int a) { // Setters
	stock = a;
}

void Drinks::setPrice(double b) {
	price = b;
}

int Drinks::printStock() { //Getters
	return stock;
}

double Drinks::printPrice() {
	return price;
}