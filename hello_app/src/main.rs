#![feature(asm_const)]
#![no_std]
#![no_main]

const SYS_HELLO: usize = 1;
const SYS_PUTCHAR: usize = 2;
const SYS_TERMINATE: usize = 3;
static HELLO_STRING: &str = "Hello from hello_app\n";
static mut ABI_ENTRY: usize = 0;

fn hello() {
    unsafe {
        core::arch::asm!("
            li      a0, {abi_num}
            la      t0, {abi_entry_addr}
            ld      t0, (t0)
            jalr    t0",
            abi_num = const SYS_HELLO,
            abi_entry_addr = sym ABI_ENTRY,
            clobber_abi("C"),
        )
    }
}

fn putchar(c: u8) {
    unsafe {
        core::arch::asm!("
            li      a0, {abi_num}
            la      t0, {abi_entry_addr}
            ld      t0, (t0)
            jalr    t0",
            abi_num = const SYS_PUTCHAR,
            abi_entry_addr = sym ABI_ENTRY,
            in("a1") c,
            clobber_abi("C"),
        )
    }
}

fn terminate(exit_code: u8) {
    unsafe {
        core::arch::asm!("
            li      a0, {abi_num}
            la      t0, {abi_entry_addr}
            ld      t0, (t0)
            jalr    t0",
            abi_num = const SYS_TERMINATE,
            abi_entry_addr = sym ABI_ENTRY,
            in("a1") exit_code,
            clobber_abi("C"),
        )
    }
}

fn puts(s: &str) {
    s.chars().for_each(|c| putchar(c as u8))
}

#[no_mangle]
#[link_section = ".text.entry"]
unsafe extern "C" fn _start(abi_entry: usize) -> ! {
    ABI_ENTRY = abi_entry;
    hello();
    puts(HELLO_STRING);
    terminate(0);

    unsafe {
        core::arch::asm!("
            wfi",
            options(noreturn),
        )
    }
}

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}