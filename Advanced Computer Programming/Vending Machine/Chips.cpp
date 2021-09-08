#include "Chips.h"

Chips::Chips(int a, double b) {
	stock = a;
	price = b;
}

void Chips::add(int a) { //Add stock
	stock += a;
}

void Chips::subtract() { //Subtract stock 
	stock = stock - 1;
}

void Chips::setStock(int a) { // Setters
	stock = a;
}

void Chips::setPrice(double b) {
	price = b;
}

int Chips::printStock() { //Getters
	return stock;
}

double Chips::printPrice() {
	return price;
}