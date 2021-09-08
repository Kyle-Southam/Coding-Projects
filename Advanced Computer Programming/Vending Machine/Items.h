#pragma once

class Items {
public:
	virtual int printStock() = 0; //The items class is a fully virtual class. It only serves to make sure all the items within the vending machine
	virtual double printPrice() = 0; //have the necessary components to them.
};