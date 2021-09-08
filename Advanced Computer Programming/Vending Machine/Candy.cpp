#include "Candy.h"

Candy::Candy(int a, double b) {
	stock = a;
	price = b;
}

void Candy::add(int a) { //Add stock
	stock += a;
}

void Candy::subtract() { //Subtract stock 
	stock = stock - 1;
}

void Candy::setStock(int a) { // Setters
	stock = a;
}

void Candy::setPrice(double b) {
	price = b;
}

int Candy::printStock() { //Getters
	return stock;
}

double Candy::printPrice() {
	return price;
}