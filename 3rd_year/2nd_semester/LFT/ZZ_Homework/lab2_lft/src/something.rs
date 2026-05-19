#![allow(dead_code)]

use crate::imports::*;

pub fn data_types(a: i32, b: i32, c: bool, d: &str ){
            let _x:i32 = a + b;
            if c {
                print!("Ooga")
            }
            "\n";
            print!("{} and the boolean is {} & a + b = {} ", d, !c, _x)
}


pub fn circle_radius() {
    println!("Please enter a radius:");
    let mut input = String::new();

    stdin().read_line(&mut input).expect("Failed to read the line");
    let radius: Result<f64, _> = input.trim().parse();

    match radius {
        Ok(r) => {
            let area: f64 = r * r * PI;
            println!("Circle's area: {}", area);
        }
        Err(e) => {
            println!("Invalid input: {}", e);
        }
    }
        
    }

    pub fn _scopes () {
        let value = 42;
        // Like a switch but better
        match value {
            1 => {
                // This is the scope of the first arm
                let inner_value = 10;
                println!("Matched 1: inner_value = {}", inner_value);
            }
            42 => {
                // This is the scope of the second arm
                let inner_value = 20; // Shadowing the outer inner_value
                println!("Matched 42: inner_value = {}", inner_value);
            }
            _ => {
                // This is the scope of the default arm
                // inner_value from the previous arms is not accessible here
                println!("No match");
            }
        }
    }

    pub fn sum(a: i32, b: i32) -> Option<i32> {
        let (result, overflow) = a.overflowing_add(b);
        if overflow {
            None // Overflow occurred
        } else {
            Some(result)
        }
    }

    pub fn floating_point() {
            assert_eq!(0.1f32 + 0.2f32, 0.3_f32);
            println!("Success!");
    }

    pub fn factorial ( a : u32) {
        let mut counter : u32 = 1;
        let mut factorial : u32 = 1;

        for i in 1..=a{
            factorial *= i;
            counter +=i;
        }
        println!("Factorial of {}! = {}.", a,factorial);
        println!("Counter: {}.", counter);
    }

    //
    pub fn factorial_recursive ( n : u64) -> u64{
        if n == 0{
            1
        }
        else {
            n * factorial_recursive(n - 1)
        }

    }



    pub fn positive_or_negative (i: f32){
        if i > 0.0
        {
            println!("Positivo: {}", i)
        }
        else if i < 0.0
        {
            println!("Negativo: {}", i)
        }        
        else {
            println!("Cero: {}", i)
        }

    }

    pub fn leap_year(year : u32){
        if year % 4 == 0 && ( year % 100 == 0 && year % 400 == 0){
            println!("{} its a leap year!", year)
        }
        else {
            println!("{} its not a leap year :(.", year)
        }
    }
        pub fn fibonacci(n : u32){
            let mut a : u32 = 0;
            let mut  b : u32 = 1;
                let mut fibonacci_numbers: Vec<u32> = Vec::new();
            for i in 0..n{
                let c =  a + b;
                    fibonacci_numbers.push(c);
                    a = b;
                    b = c;
                
            }
            for (i, num) in fibonacci_numbers.iter().enumerate(){
                println!("Fibonacci number {} = {} ", i + 1, num);
            }
    }
    pub fn guessing_game(){

        let words:[&str;100] = get_words();
        let mut rng: ThreadRng = rand::rng();
        let random_number: u8 = rng.random_range(0..=99);
        let mut attempts: u8 = 5;

        println!("Welcome to the guessing game!");
        println!("Insert a word, you have {} attempts!", attempts);

        while attempts > 0 {
            let random_word:&str = words [random_number as usize];
            let mut input:String= String::new();
            stdin().read_line(&mut input).expect("Failed to read the line");
            let input: Result<String, _> = input.trim().parse();
            if input != random_word.parse() && attempts > 0{
                attempts -= 1;
                println!("You have {} attempts remaining!", attempts);

                match attempts {
                    4 => println!("Hint 1: The word starts with '{}'", &random_word.chars().next().unwrap()),
                    3 => println!("Hint 2: The word ends with '{}'", &random_word.chars().last().unwrap()),
                    2 => println!("Hint 3: The word has at least '{}' characters.", random_word.chars().count()),
                    1 => {
                        let index: usize = rand::rng().random_range(1..random_word.len() - 1);
                        let random_char: char = random_word.chars().nth(index).unwrap();
                        println!("Hint 4: The word contains the letter '{}'.", random_char);}
                    _ => {} 
                }
            }
            else {
                println!("You guessed right!");
                break;
            }
            println!("The word is (debugging/test): {}", random_word);
        }
    }



    pub fn sum_avg_max_min (){

        let mut input: String = String::new();
        let mut int_array: Vec<i32> = Vec::new();

        while input.trim()!=("done"){

        println!("Enter an amount of numbers (or 'done' to finish):");

        input.clear();
        stdin().read_line(&mut input).expect("Failed to read the line.");

        if input.trim() == "done" {break;}

        match input.trim().parse::<i32>(){
            Ok(input) =>{
                int_array.push(input);
            }
        Err(e) => {
            println!("Parsing error: {}", e);
            }
        }
    }
    if int_array.is_empty() {
        println!("No numbers entered.");
        return;
    }
    println!("Total value: {} ", int_array.iter().sum::<i32>());
    println!("Avg value: {} ", int_array.iter().sum::<i32>() as f64 / int_array.len() as f64);
    println!("Max value: {} ", int_array.iter().max().unwrap_or(&0));
    println!("Min value: {} ", int_array.iter().min().unwrap_or(&0));
}
        

        pub fn duplicant_remover(){

            let mut input : String = String:: new();
            let mut int_vec: Vec<i64> = Vec:: new();

            println!("Please enter integers (enter 'done' to finish): ");

            loop {
                input.clear();

                stdin().read_line(&mut input).expect("Failed to read the line.");
                input = input.trim().to_string();
                if input == "done"{break;}
                match input.trim().parse::<i64>() {
                    Ok(parsed_input) => {
                        if !int_vec.contains(&parsed_input) {
                            int_vec.push(parsed_input);
                        }
                        else 
                        {
                            println!("Duplicate value: {}", parsed_input);
                        }
                    }
                    Err(e) =>{
                        println!("Parse Integer: {}", e);
                    }
                }
            }   
            println!("Unique integers: {:?}", int_vec);
        }

        pub fn duplicant_remover_hashset() {
            let mut input: String = String::new();
            let mut int_set: HashSet<i64> = HashSet::new();
        
            println!("Please enter integers (enter 'done' to finish): ");
        
            loop {
                input.clear();
        
                stdin()
                    .read_line(&mut input)
                    .expect("Failed to read the line.");
                input = input.trim().to_string();
                if input == "done" {
                    break;
                }
                match input.trim().parse::<i64>() {
                    Ok(parsed_input) => {
                        int_set.insert(parsed_input);
                    }
                    Err(e) => {
                        println!("Parse Integer: {}", e);
                    }
                }
            }
            
            println!("Unique integers: {:?}", int_set.iter().collect::<Vec<&i64>>());
        }
    
        pub fn set_operations() {
            let mut input: String = String::new();
            let mut hash1: HashSet<i32> = HashSet::new();
            let mut hash2: HashSet<i32> = HashSet::new();
            let mut hash3: HashSet<String> = HashSet::new();
            let mut hash4: HashSet<String> = HashSet::new();
            let mut int_count: i32 = 0; // Counter for integer inputs
            let mut string_count: i32 = 0; // Counter for string inputs
        
            println!("Insert Integers into the Hash Set A ('done' to finish): ");
            loop {
                input.clear();
                stdin().read_line(&mut input).expect("Failed to read the line.");
                if input.trim() == "done" {
                    break;
                }
                match input.trim().parse::<i32>() {
                    Ok(parsed_input) => {
                        hash1.insert(parsed_input);
                        int_count += 1;
                        hash2.insert(int_count);
                    }
                    Err(e) => {
                        println!("Parse type error: {}", e);
                    }
                }
            }
        
            println!("Insert Strings into the Hash Set C ('done' to finish): ");
            loop {
                input.clear();
                stdin().read_line(&mut input).expect("Failed to read the line.");
                if input.trim() == "done" {
                    break;
                }
                hash3.insert(input.trim().to_string());
                string_count += 1;
                hash4.insert(string_count.to_string());
            }
        
            println!("The union of A and B is : {:?}", hash1.union(&hash2));
            println!("The intersection of A and B is : {:?}", hash1.intersection(&hash2));
            println!("The difference of A and B is : {:?}", hash1.difference(&hash2));
        
            println!("The union of C and D is : {:?}", hash3.union(&hash4));
            println!("The intersection of C and D is : {:?}", hash3.intersection(&hash4));
            println!("The difference of C and D is : {:?}", hash3.difference(&hash4));
        }

        pub fn word_frecuency_counter(){

            let mut unique_words: HashSet<String> = HashSet:: new();
            let mut word_frequencies: HashMap<String, u32> = HashMap:: new();

            println!("Write some text('END' to finish): ");
            loop {
                let mut input : String = String:: new();
                stdin().read_line(&mut input).expect("Failed to read input.");
                if input.trim().to_lowercase() == "end" {break;}
                let words: SplitWhitespace<'_> = input.split_whitespace();
                for word in words {
                    unique_words.insert(word.to_string());
                    let count = word_frequencies.entry(word.to_string()).or_insert(0);
                    *count += 1
                }
            }
            println!("Unique words in the text: {:?}", unique_words);
            println!("Word frequencies: {:?}", word_frequencies);
        }


        pub fn anagram_checker() {
            let mut word_frequencies: HashMap<&str, HashMap<char, u32>> = HashMap::new();
        
            println!("Please enter 2 words (comma-separated): ");
        
            let mut input = String::new();
            stdin().read_line(&mut input).expect("Failed to read line.");
            let words_input: Vec<&str> = input.trim().split(",").collect();
        
            if words_input.len() != 2 {
                println!("Please enter exactly two words separated by a comma.");
                return;
            }
        
            for word in words_input.iter() {
                let lowercase_word = word.trim().to_ascii_lowercase();
        
                let mut frequency_count: HashMap<char, u32> = HashMap::new();
                for c in lowercase_word.chars() {
                    *frequency_count.entry(c).or_insert(0) += 1;
                }
        
                word_frequencies.insert(word, frequency_count);
            }
        
            if word_frequencies.get(words_input[0]) == word_frequencies.get(words_input[1]) {
                println!("The entered words are anagrams.");
            } else {
                println!("The entered words are not anagrams.");
            }
        }
        

        pub fn password_strength_checker() {

            let mut password_chars: HashMap<char, u32> = HashMap:: new();

            println!("Please enter a password: ");

            let mut input = String::new();
            stdin().read_line(&mut input).expect("Failed to read line.");


            let clean_input = input.trim().to_ascii_lowercase();

                for c in clean_input.chars(){
                    *password_chars.entry(c).or_insert(0) +=1;
                }

                let sum: u32 = password_chars.values().sum();
                let symbols: Vec<char>= vec!['!','@','#','$','%','^','&','*','(',')','-','+','=','<','>','?'];
                let mut count: u32 = 0; 

                for i in 0..symbols.len() {
                        if password_chars.contains_key(&symbols[i]){
                        count +=1; 
                        }
                }
                if count >=4 && sum>=6 && password_chars.values().count() >= 8 {
                    println!("Very strong Password!");
                }
                else if count == 0 && sum<=6 && password_chars.values().count() <= 8{
                    println!("Weak Password!");
                }
    }


    pub fn phone_book(){
        let mut phone_book : HashMap<String, u32> = HashMap:: new();
        let mut contact_name : String = String::new();
        let mut contact_phone : String = String::new();
        let mut options: String = String:: new();
        loop{
            println!("Welcome to your phone book!");
            println!("Please select an option: ");
            println!("1- Add contact.");
            println!("2- Remove contact.");
            println!("3- Search contact.");
            println!("4- Exit.");

            stdin().read_line(&mut options).expect("Failed to read line.");
            match options.trim().parse::<u8>(){
                Ok(parsed_option) => {
                    match parsed_option {

                    1=> {
                        loop {
                            println!("Please enter a new contact name (empty to finish): ");
                            stdin().read_line(&mut contact_name).expect("Failed to read line.");
                            println!("Please enter a the contact phone number: ");
                            stdin().read_line(&mut contact_phone).expect("Failed to read line.");
                                if contact_name.trim().to_string().is_empty() || contact_phone.is_empty() {break;}
                                    match contact_phone.trim().parse::<u32>() {
                                        Ok(parsed_input) => {
                                            phone_book.insert(contact_name.trim().to_ascii_lowercase(), parsed_input);
                                            println!("Contact added.");

                                        }
                                        Err(e)=> {
                                            println!("Parse Error: {}",e)
                                        }
                                }
                                contact_name.clear();
                                contact_phone.clear();
                            }
                            options.clear();
                            
                        }
                    2 => {
                            println!("Please enter the contact name to remove: ");
                            stdin().read_line(&mut contact_name).expect("Failed to read line.");
                            phone_book.remove(&contact_name.trim().to_ascii_lowercase());
                            println!("Contact removed.");
                            options.clear();

                        }
                    3 => {
                        println!("Please enter the contact name to search: ");
                        stdin().read_line(&mut contact_name).expect("Failed to read line");
                        if let Some(contact) = phone_book.get(&contact_name.trim().to_ascii_lowercase()) {
                            println!("Contact found: {:?}", contact);
                        } else {
                            println!("Contact not found.");
                        }
                        contact_name.clear();
                        options.clear();
                    }
                    4 => {break;}
                    _ => {println!("Invalid Option. Please choose 1, 2, 3 or 4.");}
                    }
                }
                Err(e) => {
                    println!("Parse Type Error: {}", e)
                }
            }
        }
        println!("Phone book: {:?}", phone_book);
    }

    pub fn distance_points(points: (f64, f64, f64, f64)) -> f64 {
        let (x1, y1, x2, y2) = points;
        let z: f64 = (x2 - x1).powi(2) + (y2 - y1).powi(2);
        z.sqrt()
    }


    pub fn user_input() {
        let mut input: String = String::new();
        println!("Please enter an input:");
        stdin().read_line(&mut input).expect("Failed to read the line.");
        let cleaned_input: String = input.trim().to_ascii_lowercase();
        let reversed_input: String = cleaned_input.chars().rev().collect();
    
        if cleaned_input == reversed_input {
            println!("Your word is a palindrome! {:?}", cleaned_input);
        } else {
            println!("Your word is not a palindrome! {:?}", cleaned_input);
        }
        println!("The word {} : has {} characters.", cleaned_input, cleaned_input.len());
        let mut rng = rand:: rng();
        let random_word = get_words()[rng.random_range(0..get_words().len())];
        if cleaned_input ==  random_word  {
            println!("Your word got changed to: {}",cleaned_input.replace(&cleaned_input, random_word));
            println!("The word {} : has {} characters.", cleaned_input, cleaned_input.len());
        }
    }


    pub fn questions_game(){ //Keeping different scores for each player.
        let mut score: i8 = 0;
        let mut table_scores: HashMap<String, i8> = HashMap:: new();
        let mut answer: String = String::new();
        let mut options: String = String::new();
        let mut quiz: HashMap<String, Vec<(String, bool)>> = HashMap::new();

        let (questions, answers) = get_questions_and_answers();
        for (question, answer) in questions.iter().zip(answers.iter()) {
            quiz.insert(question.clone(), answer.clone());
        }
    
    let mut question_counter: u8 = 0;

    'main_loop: loop {

        let mut player: String = String:: new();
        println!("Welcome to the Pop Quiz Game!!");
        println!("Enter your name: ");
        stdin().read_line(&mut player).expect("Failed to read line.");
        if !table_scores.contains_key(&player) {
            table_scores.insert(player.clone(), score.clone());
        }
        if player.trim().to_string() == "exit" {
            break 'main_loop;
        }
        println!("1 - Quiz!");
        println!("2 - Score Table.");
        println!("3 - Exit.");
        stdin().read_line(&mut options).expect("Failed to read line.");

        match options.trim().parse::<u8>() {
            Ok(parsed_options) => {            
                match parsed_options {
                1 => {
                    for (question, answers) in &quiz {
                        println!("Question: {}", question);

                        for (index, (answer, is_correct)) in answers.iter().enumerate() {
                            println!("{}. {}", index + 1, answer);
                        }

                        println!("Choose your answer (enter the number):");
                        let mut answer_input = String::new();
                        stdin().read_line(&mut answer_input).expect("Failed to read line");
                        let answer_index: usize = match answer_input.trim().parse() {
                            Ok(num) => num,
                            Err(_) => {
                                println!("Invalid input. Taking it as an incorrect answer.");
                                continue;
                            }
                        };

                        if answer_index > 0 && answer_index <= answers.len() {
                            let selected_answer = &answers[answer_index - 1];

                            if selected_answer.1 { // Check if the answer is correct
                                score += 1;
                                println!("Correct! Your score is now: {}", score);
                            } else {
                                score -= 1;
                                println!("Incorrect! Your score is now: {}", score);
                                for (correct_answer, is_correct) in answers.iter() {
                                    if *is_correct {
                                        println!("Correct answer: {}", correct_answer);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    options.clear();
                }
                2 => {
                    println!("-------------------");
                    println!("----Score Table----");
                    println!("-------------------");
                    for (player, player_score) in &table_scores {
                        println!("Player: {}", player);
                        println!("Score: {}", player_score);
                    }
                }
                3 => { break 'main_loop; 
                }
                _ => { println!("Invalid option.");
                }
            }
        }     
        Err(e) => {
            println!("Parse Type Error:{}",e)
            }
        }
        table_scores.insert(player, score);
        options.clear();
    }

}   



    pub fn longest<'a>(s1: &'a str, s2: &'a str) -> &'a str {
        if s1.len() > s2.len() {
            s1
        } else {
            s2
        }
        
    }
    
    pub fn outer_function(){    
    let string1 = String::from("Rust");
    let string2 = "Lifetimes";
    let result;
    let string3;

    {
        string3 = String::from("Example");
        result = longest(string1.as_str(), string3.as_str());
    }
    println!("The longest string is: {}", result);
    }


    struct MyStruct{
        data: i32,
    }
    pub fn ownership_copy_moving_data() {
              // Define a string
    let s1 = String::from("Hello, ");
    
    // Transfer ownership of the string to s2
    let s2 = s1;
    //println!("s1: {}", s1); Transferred ownership to s2, will throw compile error

    let s1 = "Hello";
    let s2 = s1; // s1 is copied to s2

    println!("s1: {}, s2: {}", s1, s2); // s1: Hello, s2: Hello

    // Copy a simple data type (i32), it can copy due to being of known size on compile, String is not so you cant copy.
    let x1 = 42;
    let x2 = x1;
    println!("x1: {}, x2: {}", x1, x2); // x1: 42, x2: 42

    // Define a custom struct and borrow it
    let my_struct: MyStruct = MyStruct { data: 10 };
    let borrow = &my_struct.data;

    // Uncommenting the next line would result in a compilation error,
    // as my_struct is borrowed immutably.
    // my_struct.data = 20; // Error!

    // Modify the borrowed struct
    println!("Borrowed data: {}", borrow); // Borrowed data: 10

    }

    pub fn ownership3(){
        let original: String = String::from("Hello Jules");
        let borrowed_from_original: &String = &original;
        let u: &str = borrowed_from_original.as_str();
        let x = original.as_str();
        let struct_original = MyStruct{data: 10};
        let struct_copy = struct_original;
        println!("Original:{}", original);
        println!("Borrow from Orginal:{}", borrowed_from_original);
        println!("x:{}", x);
        println!("Struct Copy Data:{}", struct_copy.data);
        println!("{}",(0.1+0.2));
    }

    pub fn lifetimes_and_references(x: &u8) -> &u8 {
        let var:&u8 = x;
        let mut n : &u8 = &1;
        x.max(n)
    }

    pub fn passing_x(y: &u8) -> &u8 {
        lifetimes_and_references(y)

    }
    //Leet 1. Two Sum
    pub fn two_sum(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let mut answer: Vec<i32> = Vec::new();
        for(i, x) in nums.iter().enumerate() {
            for (j, y) in nums.iter().enumerate() {
                if i!=j && x + y == target {
                    answer.push(i as i32);
                    answer.push(j as i32);
                    return answer;
                }
                
            }
        }

    answer
    }

    // Definition for singly-linked list.
    #[derive(PartialEq, Eq, Clone, Debug)]
    pub struct ListNode {
        pub val: i32,
        pub next: Option<Box<ListNode>>
    }

    impl ListNode {
        
        #[inline]
        fn new(val: i32) -> Self {
        ListNode {
        next: None,
        val
            }
        }
    }



    pub fn ownership5 () {
         // Create a mutable shared data using a Mutex (mutual exclusion)
        let shared_data: Arc<_> = Arc::new(Mutex::new(vec![1, 2, 3]));

        // Create multiple threads to modify the shared data
        let mut handles: Vec<thread::JoinHandle<()>> = vec![];

        for i in 0..5 {
            let data_clone: Arc<Mutex<Vec<i32>>> = shared_data.clone(); // Clone the Arc to share among threads

            let handle: thread::JoinHandle<()> = thread::spawn(move || {
                // Lock the Mutex to gain access to the shared data
                let mut data: std::sync::MutexGuard<'_, Vec<i32>> = data_clone.lock().unwrap();

                data.push(i);
                println!("Thread {} added data: {:?}", i, *data);
            });

            handles.push(handle);
        }

        // Wait for all threads to finish
        for handle in handles {
            handle.join().unwrap();
        }

        // Lock the Mutex in the main thread to access the modified data
        let final_data: std::sync::MutexGuard<'_, Vec<i32>> = shared_data.lock().unwrap();
        println!("Final data: {:?}", *final_data);
    }


    pub fn file_create() -> io::Result<()>{
            // Open or create a CSV file
        let mut file: File = File::create("my_data.csv")?;

        // Define the column headers
        let headers: &str = "Name,Age,Location\n";
    
        // Write the headers to the CSV file
        file.write_all(headers.as_bytes())?;
    
        // Sample data rows
        let data_rows = vec![
            "Alice,25,New York\n",
            "Bob,30,Los Angeles\n",
            "Charlie,22,Chicago\n",
        ];
    
        // Write the data rows to the CSV file
        for row in data_rows {
            file.write_all(row.as_bytes())?;
        }
    
        println!("CSV file created successfully.");
    
        Ok(())
    }

    pub fn thread_basics(){

        let handle: thread::JoinHandle<()> = thread::spawn(|| {
            println!("Hello from the spawned thread 0!");
        });
    
        handle.join().unwrap(); // Wait for the thread to finish
    
        // Attempting to mutate the handle will result in a compile-time error.
        // For example, the following line will not compile:
        // handle.do_something(); // This is not allowed
        
        thread::spawn(|| {
            println!("Hello from thread 1!");
        }).join().unwrap();

        let thread_1 = thread::Builder::new().name("thread1".to_string()).spawn(move || {
            println!("Hello World from thread 2!");
        });

        // To wait for the thread to finish, you can use the `join` method.
        match thread_1 {
            Ok(handle) => {
                handle.join().unwrap(); // Wait for the thread to finish
            }
            Err(err) => {
                // Handle the case where thread creation fails
                eprintln!("Thread creation failed: {:?}", err);
            }
        }
        
        for i in 0..3 {
            thread::spawn(move || {
                println!("Thread {} is running!", i);
            });
        }

        let result = thread::spawn(|| {
            panic!("Oops, something went wrong!");
        }).join();
        
        if let Err(err) = result {
            eprintln!("Thread panicked: {:?}", err);
        }

    }

    pub fn thread_syncro() {
        // Create a Mutex to safely access and modify the counter.
        let counter: Arc<Mutex<i32>> = Arc::new(Mutex::new(0));
    
        let counter1: Arc<Mutex<i32>> = Arc::clone(&counter);
        let thread_1: thread::JoinHandle<()> = thread::spawn(move || {
            for i in 0..100 {
                // Lock the Mutex to access and modify the counter.
                let mut counter: std::sync::MutexGuard<'_, i32> = counter1.lock().unwrap();
                *counter += 1;
                println!("Counter from thread 1: {}", *counter);
            }
        });
    
        let counter2: Arc<Mutex<i32>> = Arc::clone(&counter);
        let thread_2: thread::JoinHandle<()> = thread::spawn(move || {
            for i in 0..100 {
                // Lock the Mutex to access and modify the counter.
                let mut counter: std::sync::MutexGuard<'_, i32> = counter2.lock().unwrap();
                *counter += 1;
                println!("Counter from thread 2: {}", *counter);
            }
        });
    
        // Wait for both threads to finish.
        thread_1.join().unwrap();
        thread_2.join().unwrap();
    }


    pub fn create_strange_csv() -> Result<(), Box<dyn Error>> {
        let mut strange_file = File::create("strange.csv")?;
    
        let strange_data = vec![
            "\"Hacksaw\" Jim Duggan;1987\n",
            "Bret \"Hit Man\" Hart;1984\n",
            "# We're not sure when Rafael started, so omit the year.\n",
            "Rafael Halperin\n",
            "\"Big Cat\" Ernie Ladd;1964\n",
            "\"Macho Man\" Randy Savage;1985\n",
            "Jake \"The Snake\" Roberts;1986\n",
        ];
    
        for weird in strange_data {
            strange_file.write_all(weird.as_bytes())?;
        }
        Ok(())
    }


    // Returns the first positional argument sent to this process. If there are no
    // positional arguments, then this returns an error.~
    pub fn get_first_arg() -> Result<OsString, Box<dyn Error>> {
    match env::args_os().nth(1) {
        None => Err(From::from("expected 1 argument, but got none")),
        Some(file_path) => Ok(file_path),
        }
    }
    pub fn run_0() -> Result<(), Box<dyn Error>> {
        let file_path = get_first_arg()?;
        let file = File::open(file_path)?;
        let mut rdr = Reader::from_reader(file);
        for result in rdr.records() {
            let record = result?;
            println!("{:?}", record);
        }
        Ok(())
    }
    pub fn run_basic() -> Result<(), Box<dyn Error>> {
        let file_path:  OsString  = get_first_arg()?;
        let file = File::open(file_path)?;
        let mut rdr = Reader::from_reader(file);
        for result in rdr.records() {
            let record = result?;
            println!("{:?}", record);
        }
        Ok(())
    }
    //Reading headers
    fn run_headers() -> Result<(), Box<dyn Error>> {
        let mut rdr = csv::ReaderBuilder::new()
            .has_headers(false)
            .from_reader(stdin());
        for result in rdr.records() {
            let record = result?;
            println!("{:?}", record);
        }
        Ok(())
    }
        //Delimiters, quotes and variable length records
        pub fn run_custom_builder() -> Result<(), Box<dyn Error>> {
        let mut rdr: Reader<io::Stdin> = csv::ReaderBuilder::new()
            .has_headers(false)
            .delimiter(b';')
            .double_quote(false)
            .escape(Some(b'\\'))
            .flexible(true)
            .comment(Some(b'#'))
            .from_reader(stdin());
        for result in rdr.records() {
            let record: csv::StringRecord = result?;
            println!("{:?}", record);
        }
        Ok(())
    }

    pub fn run() -> Result<(), Box<dyn Error>> {
        let mut rdr: Reader<io::Stdin> = Reader::from_reader(stdin());
        for result in rdr.records() {
            let record = result?;
    
            let city = &record[0];
            let state = &record[1];
            // Some records are missing population counts, so if we can't
            // parse a number, treat the population count as missing instead
            // of returning an error.
            let pop: Option<u64> = record[2].parse().ok();
            // Lucky us! Latitudes and longitudes are available for every record.
            // Therefore, if one couldn't be parsed, return an error.
            let latitude: f64 = record[3].parse()?;
            let longitude: f64 = record[4].parse()?;
    
            println!(
                "city: {:?}, state: {:?}, \
                pop: {:?}, latitude: {:?}, longitude: {:?}",
                city, state, pop, latitude, longitude);
        }
        Ok(())

    }
    pub fn charter(){

        let drawing_area: DrawingArea<BitMapBackend<'_>,
        plotters::coord::Shift> = BitMapBackend::
        new("./chart_builder_on.png", (300, 200)).into_drawing_area();
        drawing_area.fill(&WHITE).unwrap();

        let mut chart_builder: ChartBuilder<'_, '_, BitMapBackend<'_>> = ChartBuilder::on(&drawing_area);
        chart_builder
            .margin(5) 
            .set_left_and_bottom_label_area_size(35)
            .caption("Figure title or caption", ("Calibre", 20, FontStyle::Italic, &RED)
            .into_text_style(&drawing_area));

        let mut chart_context: ChartContext<'_, BitMapBackend<'_>, 
        Cartesian2d<plotters::coord::types::RangedCoordf64,
        plotters::coord::types::RangedCoordf64>> = chart_builder
        .build_cartesian_2d(0.0..3.8, 0.0..2.8)
        .unwrap();
        chart_context.configure_mesh().draw().unwrap();
    }




    


    
    





    
    




    

        


        
