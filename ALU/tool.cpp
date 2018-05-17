#include <bits/stdc++.h>

using namespace std;
ifstream f("code.txt");
ofstream g("Memorie_ROM.txt");

const int NMax = 30;
const int NR_BITS = 8;
const int INSTRUCTION_SIZE = 16;

void instructionToMachineCode(char *instruction, char *machineCodeResult);
void processInformation(char *command, char *firstOp, char *secondOp, char *result);
void registerHexaToMachine(char *registerr, char *result);
void addressHexaToMachine(char *address, char *result);

int main(){
    char inputInstruction[NMax];
    while(f.getline(inputInstruction,NMax)){

        if(strlen(inputInstruction) <= 1){
            continue;
        }
        char machineCodeResult[NMax];
        memset(machineCodeResult,0,sizeof(machineCodeResult));
        instructionToMachineCode(inputInstruction, machineCodeResult);

        g << "\"";
        for(int i = INSTRUCTION_SIZE - 1; i >= 0; --i){
            g << (int)machineCodeResult[i];
        }
        g << "\",\n";
//        for(int i = INSTRUCTION_SIZE - 1; i >= 0; --i){
//            g << (int)machineCodeResult[i];
//        }
//        g << '\n';
    }
    return 0;
}

void instructionToMachineCode(char *instruction, char *machineCodeResult){
    int instructionSize = strlen(instruction);

    char command[NMax];
    memset(command,0,sizeof(command));
    char firstOperand[NMax];
    memset(firstOperand,0,sizeof(firstOperand));
    char secondOperand[NMax];
    memset(secondOperand,0,sizeof(secondOperand));


    int instructionIndex = 0;
    int commandIndex = 0;
    while(!(instruction[instructionIndex] != ',' && instruction[instructionIndex] != ' ')){
        instructionIndex++;
    }
    while(instructionIndex < instructionSize && instruction[instructionIndex] != ' '){
        command[commandIndex] = instruction[instructionIndex];
        ++commandIndex;
        ++instructionIndex;
    }

    command[commandIndex] = 0;
    int firstOperandIndex = 0;
    while(!(instruction[instructionIndex] != ',' && instruction[instructionIndex] != ' ')){
        instructionIndex++;
    }
    while(instructionIndex < instructionSize && instruction[instructionIndex] != ',' && instruction[instructionIndex] != ' '){
        firstOperand[firstOperandIndex] = instruction[instructionIndex];
        ++firstOperandIndex;
        ++instructionIndex;
    }

    firstOperand[firstOperandIndex] = 0;

    int secondOperandIndex = 0;
    while(!(instruction[instructionIndex] != ',' && instruction[instructionIndex] != ' ')){
        instructionIndex++;
    }
    while(instructionIndex < instructionSize && instruction[instructionIndex] != ',' && instruction[instructionIndex] != ' '){
        secondOperand[secondOperandIndex] = instruction[instructionIndex];
        ++secondOperandIndex;
        ++instructionIndex;
    }
    secondOperand[secondOperandIndex] = 0;


    char result[NMax];
    memset(result,0,sizeof(result));

    processInformation(command, firstOperand, secondOperand, result);

    //strcpy(machineCodeResult,result);
    //cout << command << ' ' << firstOperand << ' ' << secondOperand << "\n\n";
    for(int i = INSTRUCTION_SIZE - 1; i >= 0; --i){
        machineCodeResult[i] = result[i];
    }
    //cout << '\n';
    return;
}

void registerHexaToMachine(char *registerr, char *result){
    for(int i = 3; i >= 0; --i){
        result[i] = 0;
    }
    int firstNumber = 0;

    int addressSize = strlen(registerr);

    int i = addressSize - 1;
    if(registerr[i] >= '0' && registerr[i] <= '9'){
        firstNumber = registerr[i] - '0';
    }else{
        firstNumber = registerr[i] - 'A' + 10;
    }
    int index = 0;
    while(firstNumber){
        result[index] = firstNumber % 2;
        firstNumber /= 2;
        ++index;
    }
}
void addressHexaToMachine(char *address, char *result){
    for(int i = NR_BITS - 1; i >= 0; --i){
        result[i] = 0;
    }
    int firstNumber = 0;
    int secondNumber = 0;

    int addressSize = strlen(address);

    int i = addressSize - 1;
    if(address[i] >= '0' && address[i] <= '9'){
        secondNumber = address[i] - '0';
    }else{
        secondNumber = address[i] - 'A' + 10;
    }
    int index = 0;
    while(secondNumber){
        result[index] = secondNumber % 2;
        secondNumber /= 2;
        ++index;
    }

    index = 4;
    i--;
    if(i < 0){
        return;
    }
    if(address[i] >= '0' && address[i] <= '9'){
        firstNumber = address[i] - '0';
    }else{
        firstNumber = address[i] - 'A' + 10;
    }
    index = 4;
    while(firstNumber){
        result[index] = firstNumber % 2;
        firstNumber /= 2;
        ++index;
    }
}

void processInformation(char *command, char *firstOp, char *secondOp, char *result){
    if(strcmp(command, "JUMP") == 0){
        result[15] = 1;
        result[14] = 0;
        result[13] = 0;
        result[9] = 0;
        result[8] = 1;

        if(strcmp(firstOp, "Z") == 0){
            result[12] = 1;
            result[11] = 0;
            result[10] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else if(strcmp(firstOp, "NZ") == 0){
            result[12] = 1;
            result[11] = 0;
            result[10] = 1;
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else if(strcmp(firstOp, "C") == 0){
            result[12] = 1;
            result[11] = 1;
            result[10] = 0;
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else if(strcmp(firstOp, "NC") == 0){
            result[12] = 1;
            result[11] = 1;
            result[10] = 1;
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else{
            result[12] = 0;
            result[11] = 1;     //nu conteaza
            result[10] = 1;     //nu conteaza
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(firstOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "CALL") == 0){
        result[15] = 1;
        result[14] = 0;
        result[13] = 0;
        result[9] = 1;
        result[8] = 1;

        if(strcmp(firstOp, "Z") == 0){
            result[12] = 1;
            result[11] = 0;
            result[10] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else if(strcmp(firstOp, "NZ") == 0){
            result[12] = 1;
            result[11] = 0;
            result[10] = 1;
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else if(strcmp(firstOp, "C") == 0){
            result[12] = 1;
            result[11] = 1;
            result[10] = 0;
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else if(strcmp(firstOp, "NC") == 0){
            result[12] = 1;
            result[11] = 1;
            result[10] = 1;
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }else{
            result[12] = 0;
            result[11] = 1;     //nu conteaza
            result[10] = 1;     //nu conteaza
            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(firstOp, auxiliarResult);
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "RETURN") == 0){
        result[15] = 1;
        result[14] = 0;
        result[13] = 0;
        result[9] = 0;
        result[8] = 0;

        if(strcmp(firstOp, "Z") == 0){
            result[12] = 1;
            result[11] = 0;
            result[10] = 0;
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = 0;
            }
            result[NR_BITS - 1] = 1;
        }else if(strcmp(firstOp, "NZ") == 0){
            result[12] = 1;
            result[11] = 0;
            result[10] = 1;
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = 0;
            }
            result[NR_BITS - 1] = 1;
        }else if(strcmp(firstOp, "C") == 0){
            result[12] = 1;
            result[11] = 1;
            result[10] = 0;
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = 0;
            }
            result[NR_BITS - 1] = 1;
        }else if(strcmp(firstOp, "NC") == 0){
            result[12] = 1;
            result[11] = 1;
            result[10] = 1;
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = 0;
            }
            result[NR_BITS - 1] = 1;
        }else{
            result[12] = 0;
            result[11] = 1;     //nu conteaza
            result[10] = 1;     //nu conteaza
            for(int i = NR_BITS - 1; i >= 0; --i){
                result[i] = 0;
            }
            result[NR_BITS - 1] = 1;
        }
    }else
    if(strcmp(command, "LOAD") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[0] = 0;
            result[1] = 0;
            result[2] = 0;
            result[3] = 0;
        }else{
            result[15] = 0;
            result[14] = 0;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "AND") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 0;
            result[1] = 0;
            result[0] = 1;
        }else{
            result[15] = 0;
            result[14] = 0;
            result[13] = 0;
            result[12] = 1;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "OR") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 0;
            result[1] = 1;
            result[0] = 0;
        }else{
            result[15] = 0;
            result[14] = 0;
            result[13] = 1;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "XOR") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 0;
            result[1] = 1;
            result[0] = 1;
        }else{
            result[15] = 0;
            result[14] = 0;
            result[13] = 1;
            result[12] = 1;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "ADD") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 1;
            result[1] = 0;
            result[0] = 0;
        }else{
            result[15] = 0;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "ADDCY") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 1;
            result[1] = 0;
            result[0] = 1;
        }else{
            result[15] = 0;
            result[14] = 1;
            result[13] = 0;
            result[12] = 1;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "SUB") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 1;
            result[1] = 1;
            result[0] = 0;
        }else{
            result[15] = 0;
            result[14] = 1;
            result[13] = 1;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "SUBCY") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 0;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 1;
            result[1] = 1;
            result[0] = 1;
        }else{
            result[15] = 0;
            result[14] = 1;
            result[13] = 1;
            result[12] = 1;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "SR0") == 0 ||
        strcmp(command, "SR1") == 0 ||
        strcmp(command, "SRX") == 0 ||
        strcmp(command, "SRA") == 0 ||
        strcmp(command, "RR") == 0){
        result[15] = 1;
        result[14] = 1;
        result[13] = 0;
        result[12] = 1;

        char auxiliarResult[NMax];
        memset(auxiliarResult,0,sizeof(auxiliarResult));
        registerHexaToMachine(firstOp, auxiliarResult);

        result[11] = auxiliarResult[3];
        result[10] = auxiliarResult[2];
        result[9] = auxiliarResult[1];
        result[8] = auxiliarResult[0];

        result[3] = 1;
        result[4] = 0;
        result[5] = 0;
        result[6] = 0;
        result[7] = 0;

        if(strcmp(command,"SR0") == 0){
            result[0] = 0;
            result[1] = 1;
            result[2] = 1;
        }else if(strcmp(command, "SR1") == 0){
            result[0] = 1;
            result[1] = 1;
            result[2] = 1;
        }else if(strcmp(command, "SRX") == 0){
            result[0] = 0;
            result[1] = 1;
            result[2] = 0;
        }else if(strcmp(command, "SRA") == 0){
            result[0] = 0;
            result[1] = 0;
            result[2] = 0;
        }else if(strcmp(command, "RR") == 0){
            result[0] = 0;
            result[1] = 0;
            result[2] = 1;
        }
    }else
    if(strcmp(command, "SL0") == 0 ||
        strcmp(command, "SL1") == 0 ||
        strcmp(command, "SLX") == 0 ||
        strcmp(command, "SLA") == 0 ||
        strcmp(command, "RL") == 0){
        result[15] = 1;
        result[14] = 1;
        result[13] = 0;
        result[12] = 1;

        char auxiliarResult[NMax];
        memset(auxiliarResult,0,sizeof(auxiliarResult));
        registerHexaToMachine(firstOp, auxiliarResult);

        result[11] = auxiliarResult[3];
        result[10] = auxiliarResult[2];
        result[9] = auxiliarResult[1];
        result[8] = auxiliarResult[0];

        result[3] = 0;
        result[4] = 0;
        result[5] = 0;
        result[6] = 0;
        result[7] = 0;

        if(strcmp(command,"SL0") == 0){
            result[0] = 0;
            result[1] = 1;
            result[2] = 1;
        }else if(strcmp(command, "SL1") == 0){
            result[0] = 1;
            result[1] = 1;
            result[2] = 1;
        }else if(strcmp(command, "SLX") == 0){
            result[0] = 1;
            result[1] = 0;
            result[2] = 0;
        }else if(strcmp(command, "SLA") == 0){
            result[0] = 0;
            result[1] = 0;
            result[2] = 0;
        }else if(strcmp(command, "RL") == 0){
            result[0] = 0;
            result[1] = 1;
            result[2] = 0;
        }
    }else
    if(strcmp(command, "INPUT") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 0;
            result[13] = 1;
            result[12] = 1;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 0;
            result[1] = 0;
            result[0] = 0;
        }else{
            result[15] = 1;
            result[14] = 0;
            result[13] = 1;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }else
    if(strcmp(command, "OUTPUT") == 0){
        if(secondOp[0] == 's'){
            result[15] = 1;
            result[14] = 1;
            result[13] = 1;
            result[12] = 1;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(secondOp, auxiliarResult);

            result[4] = auxiliarResult[0];
            result[5] = auxiliarResult[1];
            result[6] = auxiliarResult[2];
            result[7] = auxiliarResult[3];

            result[3] = 0;
            result[2] = 0;
            result[1] = 0;
            result[0] = 0;
        }else{
            result[15] = 1;
            result[14] = 1;
            result[13] = 1;
            result[12] = 0;

            char auxiliarResult[NMax];
            memset(auxiliarResult,0,sizeof(auxiliarResult));
            registerHexaToMachine(firstOp, auxiliarResult);

            result[8] = auxiliarResult[0];
            result[9] = auxiliarResult[1];
            result[10] = auxiliarResult[2];
            result[11] = auxiliarResult[3];

            memset(auxiliarResult,0,sizeof(auxiliarResult));
            addressHexaToMachine(secondOp, auxiliarResult);

            for(int i = 0; i < 8; ++i){
                result[i] = auxiliarResult[i];
            }
        }
    }
}
