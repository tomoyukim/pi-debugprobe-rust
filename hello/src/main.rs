#![no_main]
#![no_std]

use defmt_rtt as _;
use panic_probe as _;
use rp_pico as _;

pub fn exit() -> ! {
    loop {
        cortex_m::asm::bkpt();
    }
}

#[cortex_m_rt::entry]
fn main() -> ! {
    defmt::println!("Hello, world!");

    exit()
}
