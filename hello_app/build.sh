#!/bin/bash
cargo build --target riscv64gc-unknown-linux-gnu --release
# rust-objcopy --binary-architecture=riscv64 --strip-all -O binary target/riscv64gc-unknown-none-elf/release/hello_app ./hello_app.bin
