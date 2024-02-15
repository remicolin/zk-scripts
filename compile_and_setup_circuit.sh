#!/bin/bash

# Compile the circom circuit to generate R1CS, WASM, and symbol files, placing outputs in the build directory
echo -e "\033[0;32mCompiling circuit with circom...\033[0m"
output=$(circom circuit.circom --r1cs --wasm --sym --output build 2>&1)
echo "$output"

# Check for errors in the output
if echo "$output" | grep -i "error"; then
    echo -e "\033[0;31mError found in compilation. Exiting script.\033[0m"
    exit 1
fi

# Change directory to build where the compiled files are located
cd build || exit

# Begin the setup phase for Groth16 proving system using the compiled circuit and the final Powers of Tau file
echo -e "\033[0;32mRunning snarkjs groth16 setup...\033[0m"
snarkjs groth16 setup circuit.r1cs powersoftau_final.ptau circuit_0000.zkey

# Allow user to contribute to the randomness of the proving and verification keys
echo -e "\033[0;32mContributing to the circuit's proving and verification keys...\033[0m"
snarkjs zkey contribute circuit_0000.zkey circuit_final.zkey

# Extract the verification key from the final ZKey
echo -e "\033[0;32mExtracting verification key...\033[0m"
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json

# Notify the user of completion
echo -e "\033[0;32mSetup complete. Verification key extracted.\033[0m"
