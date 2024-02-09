#!/bin/bash

# Check for a command-line argument specifying the batch size for the Powers of Tau ceremony
if [ -z "$1" ]; then
    # Notify the user about the default batch size being used due to no input
    echo -e "\033[0;33mBatch size not specified. Defaulting to 12.\033[0m"
    BATCH_SIZE=12
else
    # Use the provided batch size
    echo -e "\033[0;32mUsing provided batch size of $1.\033[0m"
    BATCH_SIZE=$1
fi

# Ensure the 'build' directory is present and accessible
if [ ! -r build ]; then
    # Create the 'build' directory if it doesn't exist or isn't readable
    echo -e "\033[0;32mCreating 'build' directory...\033[0m"
    mkdir build
fi

# Move into the 'build' directory
echo -e "\033[0;32mEntering 'build' directory...\033[0m"
cd build

# Initialize the Powers of Tau ceremony with the specified or default batch size
echo -e "\033[0;32mInitializing new Powers of Tau ceremony with batch size $BATCH_SIZE...\033[0m"
snarkjs powersoftau new bn128 $BATCH_SIZE powersoftau_0000.ptau

# Prompt user action for the ceremony contribution
echo -e "\033[0;32mPlease contribute to the ceremony and press enter when done...\033[0m"
snarkjs powersoftau contribute powersoftau_0000.ptau powersoftau_0001.ptau

# Prepare the phase 2 file using the contributed file
echo -e "\033[0;32mPreparing phase 2 file from the contribution...\033[0m"
snarkjs powersoftau prepare phase2 powersoftau_0001.ptau powersoftau_final.ptau

# Advise cleanup of initial and intermediate files
echo -e "\033[0;32mCleaning up initial and intermediate files...\033[0m"
rm powersoftau_0000.ptau powersoftau_0001.ptau

# Final notification for user
echo -e "\033[0;32mSetup complete. 'build' directory is ready for further actions.\033[0m"
