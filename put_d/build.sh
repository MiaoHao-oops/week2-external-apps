#!/bin/bash
cargo build --target riscv64gc-unknown-none-elf --release
rust-objcopy --binary-architecture=riscv64 --strip-all -O binary target/riscv64gc-unknown-none-elf/release/put_d ./put_d.bin
