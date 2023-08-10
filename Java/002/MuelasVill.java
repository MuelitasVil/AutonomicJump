/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package problem02;

import java.util.Scanner;

/**
 *
 * @author mmart
 */
public class Problem02 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Scanner sc = new Scanner(System.in);
        int Cant_inputs = sc.nextInt();
        
        int num1;
        int num2;
        String answer = "";
        
        for (int i = 0; i < Cant_inputs; i++) {
            
            num1 = sc.nextInt();
            num2 = sc.nextInt();
            
            if(num1 < num2){
                answer = answer +" "+ num1;
            }else{
                answer = answer +" "+ num2;
            }
            
        }
        
        System.out.println(answer.trim());
    
        }
    

}
