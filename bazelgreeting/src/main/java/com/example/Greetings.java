package com.example;
import com.example.App1;
public class Greetings {
    App1 app1 = new App1();

    public String greet(String name) {
        return "Hello ".concat(name);
    }
    public static void main(String[]args){
        System.out.println("Hello, this is from Greeting ...");
    }
}
