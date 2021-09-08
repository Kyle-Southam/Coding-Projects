#pragma once
#include "Items.h"

class Candy : public Items {
public:
	Candy(int, double);

	void add(int);  //Add more stock
	void subtract(); //Subtract stock
	void setStock(int); // Setters
	void setPrice(double); 
	int printStock() override; //Getters
	double printPrice() override;

private:
	int stock;
	double price;

};