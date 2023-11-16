#![feature(asm_const)]
#![no_std]
#![no_main]

const SYS_PUTCHAR: usize = 2;
static mut ABI_ENTRY: usize = 0;

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

#[no_mangle]
#[link_section = ".text.entry"]
unsafe extern "C" fn _start(abi_entry: usize) {
    ABI_ENTRY = abi_entry;
    putchar(b'D');
}

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}