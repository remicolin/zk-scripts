#!/bin/bash

# Change directory to the build folder where the compiled circuit and other necessary files are located
echo -e "\033[0;32mEntering build directory...\033[0m"
cd build

# Calculate the witness using the compiled wasm file and input.json, then output the witness in binary format
echo -e "\033[0;32mCalculating witness from input data...\033[0m"
snarkjs wtns calculate circuit_js/circuit.wasm ../input.json witness.wtns

# Export the witness to a JSON file for easier inspection or use in other applications
echo -e "\033[0;32mExporting witness to JSON format...\033[0m"
snarkjs wtns export json witness.wtns witness.json

# Generate a zk-SNARK proof using the final zkey and the calculated witness, outputting the proof and public signals
echo -e "\033[0;32mGenerating zk-SNARK proof...\033[0m"
snarkjs groth16 prove circuit_final.zkey witness.wtns proof.json public.json

# Verify the generated zk-SNARK proof against the public signals and the verification key
echo -e "\033[0;32mVerifying zk-SNARK proof...\033[0m"
snarkjs groth16 verify verification_key.json public.json proof.json

# Notify the user that the proof verification is complete
echo -e "\033[0;32mProof verification complete.\033[0m"
