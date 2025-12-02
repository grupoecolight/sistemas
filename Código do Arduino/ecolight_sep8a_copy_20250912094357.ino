float valorLDR;
int LDR;

void setup ()
{
    Serial.begin(9600);
    pinMode(A0, INPUT); 
}

void loop ()
{
    valorLDR = analogRead(A0);
    LDR = map(valorLDR, 0, 1023, 0, 100);
    Serial.print(LDR);
    
    delay(1000);

    if(LDR <= 30){
      Serial.println("% Iluminação baixa");

    }else if(LDR <= 65){
         Serial.println("% Iluminação média");
    }else{
      Serial.println("% Iluminação alta");
    }
}
