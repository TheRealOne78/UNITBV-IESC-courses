// src/main.rs

mod token_logos;

use logos::Logos;
use token_logos::TokenL;

fn lex_and_print(label: &str, source: &str) {
    println!("=== {} ===", label);
    println!("Input: {:?}", source);
    let mut lexer = TokenL::lexer(source);
    while let Some(result) = lexer.next() {
        match result {
            Ok(tok) => println!("  {:?}", tok),
            Err(_)  => eprintln!("  [LEX] error at: {:?}", lexer.slice()),
        }
    }
    println!();
}

fn main() {
    // Exercise 5a: block comment skipping
    lex_and_print(
        "Ex 5a – block comment skipped",
        "let x /* this is a block comment */ = 42;",
    );
    lex_and_print(
        "Ex 5a – multi-line block comment",
        "let y = /* first line\n   second line */ 99;",
    );
    lex_and_print(
        "Ex 5a – block comment adjacent to tokens",
        "1+/*comment*/2",
    );

    // Exercise 5b: char literals
    lex_and_print("Ex 5b – plain char", "'a'");
    lex_and_print("Ex 5b – escape sequences", r"'\n' '\t' '\\' '\''");
    lex_and_print("Ex 5b – char in expression", "let c = 'z';");

    // Base smoke test from lab section 4.4
    lex_and_print("Lab base – original example", "let x: i32 = 42 + 0xFF;");
    lex_and_print(
        "Line comment skipped",
        "let a = 1; // this is ignored\nlet b = 2;",
    );
}
