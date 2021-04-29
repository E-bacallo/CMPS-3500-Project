/******************** 
 *
 * Name: Edgar Bacallo
 * ASGT: Activity 1
 * ORGN: CSUB - CMPS 3500 
 * FILE: good.cpp
 * DATE: 02/09/2021 
 *
 *
 ********************/ 
#include <bits/stdc++.h> 
#include <iostream>
#include <string>

using namespace std;

int main(int argc, char **argv) 
{ 
    string inp; //variable of type string houses input from user.
    cout << "Type any string "; 
    cin >> inp; 
    /* removed a redundant cast to string
     * std::string s(S);
     */
    cout << inp << endl; // displays the current input before the sort.
	sort(inp.begin(), inp.end()); // sorts the char with the highest value to the front and the 
                                   // lowest value to the rear which is computing with ASCII values
	while (next_permutation(inp.begin(), inp.end())) // loops per iteration of the sort
	{
        cout << inp << endl; // for every iteration the resultant per is displayed. 
    } 
    
    return 0; 
} 
