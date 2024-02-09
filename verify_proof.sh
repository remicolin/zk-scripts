#!/bin/bash

# Verify the generated zk-SNARK proof against the public signals and the verification key
echo -e "\033[0;32mVerifying zk-SNARK proof...\033[0m"
snarkjs groth16 verify verification_key.json public.json proof.json

# Notify the user that the proof verification is complete
echo -e "\033[0;32mProof verification complete.\033[0m"