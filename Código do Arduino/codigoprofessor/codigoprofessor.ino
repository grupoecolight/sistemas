int ldr_pin = A0; // pino analógico onde o LDR está ligado

int ldr_read = 0; // variável para armazenar a leitura

float vin = 5.00; // tensão de alimentação do circuito (5V do Arduino)

float valor_ADC = 0.00488758; // valor de 1 unidade do conversor ADC (~5V/1023)
float r_ohms = 10000; // resistor fixo de 10kΩ

 

void setup() {

  Serial.begin(9600);

}

 

void loop() {

  if(isnan(ldr_read)){

    Serial.println("Erro ao ler o sensor");

  }

  else{

    ldr_read = analogRead(ldr_pin); // converte a tensão entre 0 e 5V para um número de 0 a 1023.

    float vout = valor_ADC * ldr_read; // converte o valor ADC/lido para volts

    float res_ldr = (r_ohms * (vin - vout))/vout; // resistência atual do LDR

    float lux = 500/(res_ldr/1000); // estima a iluminação em lux

 
    Serial.println(lux, ";"); // printa o valor em lux para ser recebido na API

    delay(5000); // Delay de 5 segundos





















    // if(ldr_read > 750){

    //   Serial.print(ldr_read);

    //   Serial.print(" Vout: ");

    //   Serial.print(vout);

    //   Serial.print(" R_ldr: ");

    //   Serial.print(res_ldr);

    //   Serial.print(" Lux: ");

    //   Serial.print(lux);

    //   Serial.println(" Claro");

    // }

    // else{

    //   Serial.print(ldr_read);

    //   Serial.print(" Vout: ");

    //   Serial.print(vout);

    //   Serial.print(" R_ldr: ");

    //   Serial.print(res_ldr);

    //   Serial.print(" Lux: ");

    //   Serial.print(lux);

    //   Serial.println(" Escuro");

    // }

  }

}