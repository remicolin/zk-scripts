# zk-SNARK Project Utilities

This repository contains a collection of scripts designed to facilitate the development of zero-knowledge succinct non-interactive arguments of knowledge (zk-SNARKs) projects using the Groth16 algorithm. These utilities streamline the process of writing circuits, generating Powers of Tau, building circuits, generating proofs, and verifying them.

## Overview

The Groth16 proving scheme is widely used in constructing zk-SNARKs due to its efficiency and succinct proofs. This set of scripts makes it easier to develop and test circuits for zk-SNARKs by automating the setup and execution processes involved.

## Getting Started

To use these scripts, clone this repository and ensure you have `circom` and `snarkjs` installed in your development environment. These tools are essential for compiling circuits, generating proofs, and verifying them.

### Prerequisites

- circom (v2.x or later)
- snarkjs (v0.2.x or later)

### Usage

Follow these steps to create and verify a zk-SNARK proof using the Groth16 algorithm:

#### 1. Write Your Circuit

Create your zero-knowledge circuit using the `circom` language and save it as `circuit.circom`. Refer to the `circom` documentation for syntax and examples.

#### 2. Generate Powers of Tau

Run the `init_poweroftau.sh` script to initialize the Powers of Tau ceremony, which is a crucial setup phase for zk-SNARKs:

```bash
./scripts/init_poweroftau.sh
```

#### 3. Build Circuit

Compile your circuit and generate the necessary proving and verification keys by executing the `compile_and_setup_circuit.sh` script:

```bash
./scripts/compile_and_setup_circuit.sh
```

#### 4. Generate Proof

Generate a witness for your circuit based on your inputs and create a zk-SNARK proof using the `generate_proof.sh` script:

```bash
./scripts/generate_proof.sh
```

#### 5. Verify Proof

Verify the generated zk-SNARK proof using the `verify_proof.sh` script:

```bash
./scripts/verify_proof.sh
```

## Contributing

Contributions to improve the scripts or documentation are welcome. Please submit a pull request or open an issue if you have suggestions or find a bug.

## License

This project is licensed under the MIT License
```

This `README.md` now reflects the updated script names and the additional step in the workflow for generating and verifying zk-SNARK proofs with Groth16.
