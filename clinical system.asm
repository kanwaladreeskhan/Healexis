.data
node_size:      .space   72          # Size of 'node' structure in bytes

# Define the 'node' structure
node:
    .word 0                 # age
    .word 0                 # id
    .word 0                 # gender
    .word 0                 # reservation
    .word 0                 # next pointer
    .space 52               # name (maximum size)
no_of_nodes:    .word   0

data_not_found_msg: .asciiz "Data not found\n"

reservation_struct_size:   .word 4     # Size of 'reservation' structure in words

# Structure for reservation
reservation:
    .word 0                     # start_time
    .word 0                     # finish_time
    .word 0                     # id
    .word 0                     # reservation_number
    
id_prompt:          .asciiz "please enter ID: "
age_prompt:         .asciiz "please enter age: "
gender_prompt:      .asciiz "please enter gender(1 for male or 0 for female): "
name_prompt:        .asciiz "please enter name: "
gender_error:       .asciiz "number out of range choose a valid number\n"
id_used_msg:        .asciiz "used ID!\n"

edit_id_prompt: .asciiz "please enter ID: "
edit_menu: .asciiz "\nto edit:\nid press (1)\nage press (2)\ngender press (3)\nname press (4)\nto finish editing press (5)"
new_id_prompt: .asciiz "please enter new ID: "
new_age_prompt: .asciiz "please enter age: "
new_gender_prompt: .asciiz "please enter gender(1 for male or 0 for female): "
edit_gender_error: .asciiz "number out of range choose a valid number\n"
new_name_prompt: .asciiz "please enter name: "
edit_id_not_found: .asciiz "ID not found!"

available_slots_msg: .asciiz "\nAvailable slots :"
to_msg: .asciiz " to "
comma_space_msg: .asciiz ", "
reservation_num_msg: .asciiz " reservation number : "
res_num_prompt: .asciiz "please enter reservation number :"
slot_reserved_msg: .asciiz "slot reserved successfully :)\n"
id_not_found_msg: .asciiz "ID not found!\n"
res_num_out_of_range_msg: .asciiz "reservation number out of range!\n"
newline_msg: .asciiz "\n"

slot_canceled_msg: .asciiz "slot canceled successfully :)\n"
no_reservations_msg: .asciiz "there is no reservations for this id\n"

patient_info_msg: .asciiz "Patient:-\nID: "
age_msg: .asciiz "\nAge: "
gender_msg: .asciiz "\nGender: "
name_msg: .asciiz "\nName: "
male_str: .asciiz "male"
female_str: .asciiz "female"

reservation_info_msg: .asciiz "from "
reservation_to_msg: .asciiz " there is a reservation to patient with ID: "

reservations:
    .word 2, 3, -1, 1           # Reservation 1: start_time = "2", finish_time = "3", id = -1, reservation_number = 1
    .word 3, 4, -1, 2           # Reservation 2: start_time = "3", finish_time = "4", id = -1, reservation_number = 2
    .word 4, 5, -1, 3           # Reservation 3: start_time = "4", finish_time = "5", id = -1, reservation_number = 3
    .word 5, 6, -1, 4           # Reservation 4: start_time = "5", finish_time = "6", id = -1, reservation_number = 4
    .word 6, 7, -1, 5           # Reservation 5: start_time = "6", finish_time = "7", id = -1, reservation_number = 5
auth_options: .asciiz "\nFor Admin mode press (0)\nFor user mode press (1)\nTo exit press (2)\n"
password_prompt: .asciiz "Please enter password: "
admin_menu_options: .asciiz "\nTo add a new patient press (1)\nTo edit a patient info press (2)\nTo reserve a slot with the doctor press (3)\nTo cancel a reservation press (4)\nTo exit press (5)\n"
add_patient_msg: .asciiz "Adding a new patient...\n"
edit_patient_msg: .asciiz "Editing patient information...\n"
reserve_slot_msg: .asciiz "Reserving a slot with the doctor...\n"
cancel_reservation_msg: .asciiz "Canceling a reservation...\n"
user_menu_options: .asciiz "\nTo view patient record press (1)\nTo view today's reservations press (2)\nTo exit press (3)\n"
no_reservation_msg: .asciiz "there is no reservations for todat :)\n"

mode:   .word 0                    # Mode variable initialized to 0
pass:   .word 0                    # Password variable initialized to 0
wrong_pass: .word 0                # Wrong password attempts initialized to 0
auth:   .word 3                    # Authentication mode initialized to 3
name:   .space 52                  # Name buffer initialized to 52 bytes
head:   .word 0                    # Head pointer initialized to NULL
created: .word 0                   # Created pointer initialized to NULL

.text
.globl main


# Main function
main:
    # Function prologue
    addi $sp, $sp, -72          # Adjust stack pointer
    sw $ra, 68($sp)             # Save return address
    sw $s0, 64($sp)             # Save $s0
    sw $s1, 60($sp)             # Save $s1
    sw $s2, 56($sp)             # Save $s2
    sw $s3, 52($sp)             # Save $s3
    sw $s4, 48($sp)             # Save $s4
    sw $s5, 44($sp)             # Save $s5
    sw $s6, 40($sp)             # Save $s6
    sw $s7, 36($sp)             # Save $s7
    
    # Load variables
    lw $s0, mode                # Load mode
    lw $s1, pass                # Load pass
    lw $s2, wrong_pass          # Load wrong_pass
    lw $s3, auth                # Load auth
    la $s4, name                # Load address of name buffer
    lw $s5, head                # Load head pointer
    lw $s6, created             # Load created pointer

main_auth_input:
    # Input authentication mode
    li $t0, 3                   # Initialize authentication mode
main_auth_loop:
    # Print authentication options
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, auth_options        # Load address of authentication options
    syscall                     # Print authentication options

    # Get user input for authentication mode
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer input
    move $t0, $v0               # Move input to $t0

    # Admin mode
    beq $t0, 0, main_admin_mode
    # User mode
    beq $t0, 1, main_user_mode
    # Exit program
    beq $t0, 2, main_exit_program
    # Invalid input, retry
    j main_auth_loop

main_admin_mode:
    # Admin mode
    # Password authentication
    li $t1, 3                   # Initialize password attempts
    li $t2, 0                   # Initialize password
    li $t3, 1234                # Set correct password

main_password_auth:
    # Print password prompt
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, password_prompt     # Load address of password prompt
    syscall                     # Print password prompt

    # Get user input for password
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer input
    move $t2, $v0               # Move input to $t2

    # Check password
    beq $t2, $t3, main_admin_menu    # Correct password, proceed to admin menu
    # Incorrect password
    addi $t1, $t1, -1           # Decrement password attempts
    bnez $t1, main_password_auth     # Retry password if attempts remain

    # Maximum password attempts reached, exit program
    j main_exit_program

main_admin_menu:
    # Admin menu
    li $t4, 6                   # Initialize menu choice

main_menu_loop:
    # Print menu options
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, admin_menu_options  # Load address of admin menu options
    syscall                     # Print admin menu options

    # Get user input for menu choice
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer input
    move $t4, $v0               # Move input to $t4

    # Process menu choice
    beq $t4, 1, main_add_patient     	 # Add new patient
    beq $t4, 2, main_edit_patient   	 # Edit patient info
    beq $t4, 3, main_reserve_slot   	 # Reserve slot with the doctor
    beq $t4, 4, main_cancel_reservation  # Cancel reservation
    beq $t4, 5, main_auth_loop    	 # Exit program
    # Invalid choice, retry
    j main_menu_loop

main_add_patient:
    # Add a new patient
    la $a0, head                # Load address of head pointer
    la $a1, created             # Load address of created node
    la $a2, name                # Load address of name buffer
    jal add_patient             # Call add_patient function
    j main_menu_loop            # Return to admin menu

main_edit_patient:
    # Edit patient info
    la $a0, head                # Load address of head pointer
    la $a1, name                # Load address of name buffer
    jal edit_patient            # Call edit_patient function
    j main_menu_loop            # Return to admin menu

main_reserve_slot:
    # Reserve slot with the doctor
    la $a0, reservations        # Load address of reservations array
    la $a1, head                # Load address of head pointer
    jal reserve                 # Call reserve function
    j main_menu_loop            # Return to admin menu

main_cancel_reservation:
    # Cancel reservation
    la $a0, reservations        # Load address of reservations array
    la $a1, head                # Load address of head pointer
    jal cancel_reservation      # Call cancel_reservation function
    j main_menu_loop            # Return to admin menu

main_user_mode:
    # User mode
    li $t4, 4                   # Initialize menu choice

main_user_menu_loop:
    # Print menu options
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, user_menu_options   # Load address of user menu options
    syscall                     # Print user menu options

    # Get user input for menu choice
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer input
    move $t4, $v0               # Move input to $t4

    # Process menu choice
    beq $t4, 1, main_view_patient        # View patient record
    beq $t4, 2, main_view_reservations   # View today's reservations
    beq $t4, 3, main_auth_loop           # Exit program
    # Invalid choice, retry
    j main_user_menu_loop

main_view_patient:
    # View patient record
    la $a0, head                # Load address of head pointer
    jal view_patient            # Call view_patient function
    j main_user_menu_loop       # Return to user menu

main_view_reservations:
    # View today's reservations
    la $a0, reservations       # Load address of reservations array
    jal view_reservations      # Call view_reservations function
    j main_user_menu_loop      # Return to user menu

main_exit_program:
    # Function epilogue
    lw $ra, 68($sp)             # Restore return address
    lw $s0, 64($sp)             # Restore $s0
    lw $s1, 60($sp)             # Restore $s1
    lw $s2, 56($sp)             # Restore $s2
    lw $s3, 52($sp)             # Restore $s3
    lw $s4, 48($sp)             # Restore $s4
    lw $s5, 44($sp)             # Restore $s5
    lw $s6, 40($sp)             # Restore $s6
    lw $s7, 36($sp)             # Restore $s7
    addi $sp, $sp, 72           # Restore stack pointer
    jr $ra                      # Return
    
    # Exit program
    li $v0, 10                  # Load system call code for 'exit'
    syscall                     # Exit program


#.........................................................................................................#

# Function to search for a node by key
search_nde:
    # Function prologue
    addi $sp, $sp, -12          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0

    # Load parameters
    lw $a0, 0($a0)              # Load 'head' pointer'
    
    # Initialize variables
    li $t0, 0                  		  # Initialize 'i'
    la $t2, no_of_nodes                   # Initialize 'no_of_nodes'
    lw $t1,($t2)
    
    # Check if only one node exists
    beq $t1, $zero, not_found   # Skip if no nodes

check_key:                  
    lw $t2, 4($a0)             #load "id" in $t2
    bne $t2, $a1, loop         # If id doesn't match, continue looping
    move $v0, $a0              # return with the pointer as the result
    jr $ra                     # Return 

loop:
    # Iterate through linked list
    lw $a0, 16($a0)             # Load 'next' pointer
    addi $t0, $t0, 1            # Increment 'i'
    blt $t0, $t1, check_key     # Check if 'i' < 'no_of_nodes'

not_found:
    # Node not found, set 'temp' to NULL
    li $v0, 0                   # Load NULL pointer to $v0

    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    addi $sp, $sp, 12           # Restore stack pointer
    jr $ra                      # Return

# Function to create a new node
create_nde:
    # Function prologue
    addi $sp, $sp, -24          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0
    sw $s1, 8($sp)              # Save $s1
    sw $s2, 12($sp)             # Save $s2
    sw $s3, 16($sp)             # Save $s3

    # Allocate memory for the node
    li $v0, 9                   # Load system call code for 'malloc'
    lw $a0, node_size           # Load 'node_size'
    syscall                     # Call 'malloc' to allocate memory
    move $s0, $v0               # Save address of allocated memory in $s0

    # Check if memory allocation was successful
    beq $s0, $zero, allocation_failed

    # Copy 'name' to the node
    move $s1, $a3               # Copy 'name' pointer to $s1
    li $s2, 0                   # Initialize loop counter
copy_name_loop:
    lb $s3, 0($s1)              # Load character from 'name'
    sb $s3, 20($v0)             # Store character in 'name' field of node
    addi $v0, $v0, 1            # Move to next character in node
    addi $s1, $s1, 1            # Move to next character in 'name'
    bnez $s3, copy_name_loop    # Continue loop if character is not null
    sb $zero, 20($v0)           # Null-terminate 'name' field of node

    # Store other fields in the node
    sw $a0, 0($s0)              # Store 'age'
    sw $a1, 4($s0)              # Store 'id'
    sw $a2, 8($s0)              # Store 'gender'
    li $t0, 0                   # Initialize 'reservation' to 0
    sw $t0, 12($s0)             # Store 'reservation'
    sw $t0, 16($s0)             # Store NULL in 'next'

    # Function epilogue
    move $v0, $s0               # Move address of node to $v0
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)              # Restore $s1
    lw $s2, 12($sp)             # Restore $s2
    lw $s3, 16($sp)             # Restore $s3
    addi $sp, $sp, 24           # Restore stack pointer
    jr $ra                      # Return

allocation_failed:
    # Memory allocation failed, return NULL
    li $v0, 0                   # Load NULL pointer to $v0

    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)              # Restore $s1
    lw $s2, 12($sp)             # Restore $s2
    lw $s3, 16($sp)             # Restore $s3
    addi $sp, $sp, 24           # Restore stack pointer
    jr $ra                      # Return

# Function to append a node to the end of the linked list
append_nde:
    # Function prologue
    addi $sp, $sp, -12          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0

    # Increment 'no_of_nodes'
    lw $t0, no_of_nodes         # Load 'no_of_nodes'
    addi $t0, $t0, 1            # Increment 'no_of_nodes'
    sw $t0, no_of_nodes         # Store updated value of 'no_of_nodes'
                      
    # Check if the list is empty
    beq $t0, 1, list_empty     # If 'h_ptr' is NULL, list is empty

    # Traverse the list to find the last node
traverse_loop:
    lw $t1, 16($a1)              # Load 'next' pointer of current node
    beq $t1, 0, found_last_node  # If 'next' is NULL, this is the last node
    lw $a1, 16($a1)              # Move to next node
    j traverse_loop              # Continue loop

found_last_node:
    # Append 'nde' to the end of the list
    sw $a0, 16($a1)             # Store 'nde' in 'next' field of last node

    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    addi $sp, $sp, 12           # Restore stack pointer
    jr $ra                      # Return

list_empty:
    # List is empty, set 'h_ptr' to 'nde'
    sw $a0, 0($a1)

    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    addi $sp, $sp, 12           # Restore stack pointer
    jr $ra                      # Return
    
# Function to delete a node with the given key
delete_nde:
    # Function prologue
    addi $sp, $sp, -12          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0
    sw $s1, 8($sp)              # Save $s1

    # Load parameters
    lw $a0, 0($a0)              # Load 'head' pointer

    # Search for the node to delete
    jal search_nde               # Call 'search_nde' function
    move $s1, $v0                # Move result (deleted node) to $s1

    # Check if node was found
    beq $s1, $zero, data_not_found  # If deleted node is NULL, data not found

    # Initialize 'temp' to 'head'
    move $s0, $a0                  # Move 'head' pointer to $s0

    # Check if the node to delete is the head of the list
    beq $s1, $a0, delete_head     # If deleted node is the head, delete head

    # Find the node before the deleted node
find_previous:
    lw $t0, 16($s0)             # Load 'next' pointer of current node
    beq $t0, $s1, delete_node   # If 'next' is the deleted node, delete node
    move $s0, $t0               # Move to next node
    j find_previous             # Continue loop

delete_head:
    # Update 'head' to point to the next node
    lw $t0, 16($a0)             # Load 'next' pointer of head
    move $a0, $t0               # Move 'next' to 'head'

delete_node:
    # Update pointers to delete node
    lw $t0, 16($s1)             # Load 'next' pointer of deleted node
    sw $t0, 16($s0)             # Update 'next' pointer of previous node

    # Free memory allocated for deleted node
    li $v0, 9                   # Load system call code for 'free'
    move $a0, $s1               # Move address of deleted node to $a0
    syscall                     # Call 'free' to deallocate memory

    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)              # Restore $s1
    addi $sp, $sp, 12           # Restore stack pointer
    jr $ra                      # Return

data_not_found:
    # Data not found, print error message
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, data_not_found_msg  # Load address of error message
    syscall                     # Print error message

    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)              # Restore $s1
    addi $sp, $sp, 12           # Restore stack pointer
    jr $ra                      # Return

#..........................................................................................................#

# Function to search for a reservation by reservation number
array_search_rn:
    # Function prologue
    addi $sp, $sp, -12          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0

    # Initialize loop counter
    li $t0, 0                   # Initialize 'i'

search_rn_loop:
    # Load 'reservation_number' of current reservation
    lw $t1, 12($a0)             # Load 'reservation_number' field
    

    # Compare with 'reservation_number'
    beq $t1, $a1, found_rn      # If match, exit loop

    # Move to next reservation
    addi $a0, $a0, 16           # Move to next 'reservation' structure
    addi $t0, $t0, 1            # Increment loop counter
    j search_rn_loop            # Continue loop

found_rn:
    # Function epilogue
    move $v0, $t0               # Return loop counter
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    addi $sp, $sp, 12           # Restore stack pointer
    jr $ra                      # Return

# Function to search for a reservation by ID
array_search_id:
    # Function prologue
    addi $sp, $sp, -12          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0

    # Initialize loop counter
    li $t0, 0                   # Initialize 'i'

search_id_loop:
    # Load 'id' of current reservation
    lw $t1, 8($a0)             # Load 'id' field

    # Compare with 'id'
    beq $t1, $a1, found_id     # If match, exit loop

    # Move to next reservation
    addi $a0, $a0, 16           # Move to next 'reservation' structure
    addi $t0, $t0, 1            # Increment loop counter
    j search_id_loop            # Continue loop

found_id:
    # Function epilogue
    move $v0, $t0               # Return loop counter
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    addi $sp, $sp, 12           # Restore stack pointer
    jr $ra                      # Return

   #.............................................................................................#
   
# Function to add a new patient to the linked list
add_patient:
    # Function prologue
    addi $sp, $sp, -32          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0
    sw $s1, 8($sp)              # Save $s1
    sw $s2, 12($sp)             # Save $s2
    sw $s3, 16($sp)             # Save $s3
    sw $s4, 20($sp)		# Save $s4

    # Load parameters
    lw $a1, 0($a1)              # Load 'created' pointer
    move $s4, $a0               # save 'head' pointer
    # Print prompt for ID
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, id_prompt           # Load address of prompt
    syscall                     # Print prompt

    # Read ID from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $s3, $v0               # Move ID to $s3

    # Search for existing patient with the same ID
    move $a0, $s4               # Copy 'head' to $a0 (no need to reload)
    move $a1, $s3               # Move ID to $a1
    jal search_nde              # Call 'search_nde' function
    move $s0, $v0               # Move result (found node) to $s0

    # Check if patient with same ID already exists
    bnez $s0, id_used           # Branch if patient with same ID exists

    # Print prompt for age
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, age_prompt          # Load address of prompt
    syscall                     # Print prompt

    # Read age from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $s1, $v0               # Move age to $s1 

    # Loop to ensure valid gender input
gender_input_loop:
    # Print prompt for gender
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, gender_prompt       # Load address of prompt
    syscall                     # Print prompt

    # Read gender from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $s2, $v0               # Move gender to $s2

    # Check if gender is valid (0 or 1)
    bnez $s2, gender_valid     # Branch if gender is 1
    beqz $s2, gender_valid     # Branch if gender is 0

    # Print error message for invalid gender
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, gender_error        # Load address of error message
    syscall                     # Print error message
    j gender_input_loop         # Repeat loop for gender input

gender_valid:

    # Print prompt for name
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, name_prompt         # Load address of prompt
    syscall                     # Print prompt

    # Read name from user
    li $v0, 8                   # Load system call code for 'read_string'
    move $a0, $a2               # Load address of 'name' buffer
    li $a1, 50                  # Load maximum length of input
    syscall                     # Read string from user
    move $a2, $v0               # Move address of 'name' buffer to $a2

    # Create a new node for the patient
    move $a3, $a0               # Move name to $a3
    move $a0, $s1               # Move age to $a0
    move $a1, $s3               # Move ID to $a1
    move $a2, $s2               # Move gender to $a2
    jal create_nde              # Call 'create_nde' function
    move $s3, $v0               # Move address of created node to $s3

    # Append the new node to the linked list
    move $a0, $s3               # Move address of created node to $a0
    move $a1, $s4               # Move address of 'head' to $a1
    jal append_nde              # Call 'append_nde' function

    # Function epilogue
    j end_add_patient           # Jump to epilogue

id_used:
    # Print error message for used ID
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, id_used_msg         # Load address of error message
    syscall                     # Print error message

end_add_patient:
    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)              # Restore $s1
    lw $s2, 12($sp)             # Restore $s2
    lw $s3, 16($sp)             # Restore $s3
    lw $s4, 20($sp)		# Restore $s4
    addi $sp, $sp, 32           # Restore stack pointer
    j main_menu_loop            # Return
   
# Function to edit patient information
edit_patient:
    # Function prologue
    addi $sp, $sp, -32          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0
    sw $s1, 8($sp)              # Save $s1
    sw $s2, 12($sp)             # Save $s2
    sw $s3, 16($sp)             # Save $s3
    sw $s4, 20($sp)             # Save $s4
    sw $s5, 24($sp)             # Save $s5
    
    # Load parameters
    move $s0, $a0              # save 'head' pointer
    move $s1, $a1              # save 'name' pointer

    # Initialize choice to 6
    li $s5, 6                   # Initialize choice to 6

edit_patient_input_loop:
    # Print prompt for ID
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, edit_id_prompt      # Load address of prompt
    syscall                     # Print prompt

    # Read ID from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $s2, $v0               # Move ID to $s2

    # Search for patient with the given ID
    move $a0, $s0               # Move 'head' to $a0
    move $a1, $s2               # Move ID to $a1
    jal search_nde              # Call 'search_nde' function
    move $s3, $v0               # Move result to $s3

    # Check if patient with the given ID exists
    beqz $s3, edit_id_not_found # Branch if patient with the given ID is not found

edit_patient_edit_loop:
    # Print menu for editing options
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, edit_menu           # Load address of menu
    syscall                     # Print menu

    # Read choice from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $s4, $v0               # Move choice to $s4

    # Perform respective editing based on choice
    beq $s4, 1, edit_id         # Edit ID if choice is 1
    beq $s4, 2, edit_age        # Edit age if choice is 2
    beq $s4, 3, edit_gender     # Edit gender if choice is 3
    beq $s4, 4, edit_name       # Edit name if choice is 4
    beq $s4, 5, edit_exit       # Exit editing if choice is 5
    j edit_patient_edit_loop    # Repeat loop if choice is invalid

edit_id:
    # Print prompt for new ID
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, new_id_prompt       # Load address of prompt
    syscall                     # Print prompt

    # Read new ID from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    sw $v0, 4($s3)              # Store new ID in the node
    j edit_patient_edit_loop    # Repeat loop

edit_age:
    # Print prompt for new age
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, new_age_prompt      # Load address of prompt
    syscall                     # Print prompt

    # Read new age from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    sw $v0, 0($s3)              # Store new age in the node
    j edit_patient_edit_loop    # Repeat loop

edit_gender:
    # Print prompt for new gender
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, new_gender_prompt   # Load address of prompt
    syscall                     # Print prompt

    edit_gender_loop:
    # Read new gender from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $s4, $v0               # Move gender to $s4

    # Check if gender is valid
    beq $s4, 0, edit_gender_valid # Branch if gender is 0 (female)
    beq $s4, 1, edit_gender_valid # Branch if gender is 1 (male)
    j edit_gender_loop            # Repeat loop for invalid gender

edit_gender_error_1:
    # Print error message for invalid gender
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, edit_gender_error_1 # Load address of error message
    syscall                     # Print error message
    j edit_gender               # Repeat loop for gender input

edit_gender_valid:
    sw $s4, 8($s3)              # Store new gender in the node
    j edit_patient_edit_loop    # Repeat loop

edit_name:
    # Print prompt for new name
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, new_name_prompt     # Load address of prompt
    syscall                     # Print prompt

    # Read name from user
    li $v0, 8                   # Load system call code for 'read_string'
    move $a0, $s1               # Move 'name' pointer to $a0
    li $a1, 50                  # Load maximum length of input
    syscall                     # Read string from user
    
    # Store new name in the node    
    move $t8,$s3		# copy the node pointer to $t8
copy_name_loop_1:
    lb $t9, 0($s1)              # Load character from 'name'
    sb $t9, 20($t8)             # Store character in 'name' field of node
    addi $t8, $t8, 1            # Move to next character in node
    addi $s1, $s1, 1            # Move to next character in 'name'
    bnez $t9, copy_name_loop_1  # Continue loop if character is not null
    sb $zero, 20($t8)           # Null-terminate 'name' field of node

    j edit_patient_edit_loop    # Repeat loop

edit_exit:
    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)              # Restore $s1
    lw $s2, 12($sp)             # Restore $s2
    lw $s3, 16($sp)             # Restore $s3
    lw $s4, 20($sp)             # Restore $s4
    lw $s5, 24($sp)             # Restore $s5
    addi $sp, $sp, 32           # Restore stack pointer
    j main_menu_loop            # Return

# Function to reserve a slot
reserve:
    # Function prologue
    addi $sp, $sp, -20          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0
    sw $s1, 8($sp)		# Save $s1
    sw $s2, 12($sp)		# Save $s2
    sw $s3, 16($sp)		# Save $s3

    # Load parameters
    move $s0, $a0               # Save 'r' pointer
    move $s1, $a0		# Save 'r' pointer

    # Print available slots
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, available_slots_msg # Load address of message
    syscall                     # Print available slots

    # Loop through reservations
    li $t0, 0                   # Initialize counter i to 0
reserve_loop:
    bge $t0, 5, reserve_input   # If i >= 5, exit loop
    lh $t1, 8($s0)              # Load r[i].id
    beq $t1,-1, reserve_print   # If r[i].id == -1, print slot
    addi $s0, $s0, 16           # Move to next reservation
    addi $t0, $t0, 1            # Increment counter i
    j reserve_loop              # Repeat loop

reserve_print:
    li $v0, 4                    # Load system call code for 'print_string'
    la $a0, reservation_info_msg # Load address of "from" message
    syscall                      # Print "from"
    lw $a0, 0($s0)               # Load address of start_time
    li $v0, 1                    # Load system call code for 'print_string'
    syscall                      # Print start_time
    li $v0, 4                    # Load system call code for 'print_string'
    la $a0, to_msg               # Load address of "to" message
    syscall                      # Print "to"
    lw $a0, 4($s0)               # Load address of finish_time
    li $v0, 1                    # Load system call code for 'print_string'
    syscall                      # Print finish_time
    la $a0, comma_space_msg      # Load address of ", " message
    li $v0, 4                    # Load system call code for 'print_string'
    syscall                      # Print ", "
    la $a0, reservation_num_msg  # Load address of "reservation number : " message
    li $v0, 4                    # Load system call code for 'print_string'
    syscall                      # Print "reservation number :"
    lw $a0, 12($s0)              # Load r[i].reservation_number
    li $v0, 1                    # Load system call code for 'print_integer'
    syscall                      # Print reservation_number
    la $a0, newline_msg          # Load address of newline message
    li $v0, 4                    # Load system call code for 'print_string'
    syscall                      # Print newline
    j reserve_next_slot          # Continue to next slot

reserve_input:
    # Print prompt for ID
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, id_prompt           # Load address of prompt
    syscall                     # Print prompt

    # Read ID from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $s2, $v0               # Move ID to $t2

    # Search for patient with the given ID
    move $a0, $a1               # Move 'head' to $a0
    move $a1, $s2               # Move ID to $a1
    jal search_nde              # Call 'search_nde' function
    move $s3, $v0               # Move result to $s3

    # Check if patient with the given ID exists
    beqz $s3, id_not_found      # Branch if patient with the given ID is not found

    # Print prompt for reservation number
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, res_num_prompt      # Load address of prompt
    syscall                     # Print prompt

    # Read reservation number from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $t4, $v0               # Move reservation number to $t4

    # Check if reservation number is available
    move $a0, $s1               # Move 'r' to $a0
    move $a1, $t4               # Move reservation number to $a1
    jal array_search_rn         # Call 'array_search_rn' function
    move $t5, $v0               # Move index to $t5
    
    # Calculate the next pointer
    mul $t6,$t5,16
    add $t6,$t6,$s1
    
    lw $t7, 8($t6)                   # Load r[i].id
    beq $t7, -1, slot_available      # If r[i].id == -1, slot is available
    li $v0, 4                        # Load system call code for 'print_string'
    la $a0, res_num_out_of_range_msg # Load address of message
    syscall                          # Print message
    j reserve_end                    # Exit function

slot_available:
    sw $t4, 12($s3)             # Store reservation number in the node
    sw $s2, 8($t6)              # Store ID in r[i].id
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, slot_reserved_msg   # Load address of message
    syscall                     # Print message
    j reserve_end               # Exit function

id_not_found:
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, id_not_found_msg    # Load address of message
    syscall                     # Print message
    j reserve_end               # Exit function

reserve_next_slot:
    addi $s0, $s0, 16           # Move to next reservation
    j reserve_loop              # Repeat loop

reserve_end:
    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)		# Restore $s1
    lw $s2, 12($sp)		# Restore $s2
    lw $s3, 16($sp)		# Restore $s3
    addi $sp, $sp, 20           # Restore stack pointer
    j main_menu_loop            # Return

# Function to cancel a reservation
cancel_reservation:
    # Function prologue
    addi $sp, $sp, -20              # Adjust stack pointer
    sw $ra, 0($sp)                  # Save return address
    sw $s0, 4($sp)                  # Save $s0
    sw $s1, 8($sp)		    # Save $s1
    sw $s2, 12($sp)		    # Save $s2

    # Load parameters
    move $s0, $a0                  # Save 'r' pointer

    # Print prompt for ID
    li $v0, 4                       # Load system call code for 'print_string'
    la $a0, id_prompt               # Load address of prompt
    syscall                         # Print prompt

    # Read ID from user
    li $v0, 5                       # Load system call code for 'read_integer'
    syscall                         # Read integer from user
    move $s1, $v0                   # Move ID to $s1

    # Search for patient with the given ID
    move $a0, $a1                   # Move 'head' to $a0
    move $a1, $s1                   # Move ID to $a1
    jal search_nde                  # Call 'search_nde' function
    move $s2, $v0                   # Move result to $s2

    # Check if patient with the given ID exists
    beqz $t1, id_not_found_cancel   # Branch if patient with the given ID is not found

    # Check if reservation exists for the patient
    lw $t2, 12($s2)                  # Load reservation number from node
    beqz $t2, no_reservations        # If reservation number is 0, no reservations exist

    # Cancel reservation
    move $a0, $s0                   # Move 'r' to $a0
    move $a1, $s1                   # Move ID to $a1
    jal array_search_id             # Call 'array_search_id' function
    move $t3, $v0                   # Move index to $t3
    
    # Calculate the next pointer
    mul $t3, $t3, 16
    add $t3, $t3, $s0
    
    li $t4, -1                      # Load -1
    sw $t4, 8($t3)                  # Store -1 in r[i].id
    li $t4, 0                       # Load 0
    sw $t4, 12($s2)                 # Store 0 in reservation number
    li $v0, 4                       # Load system call code for 'print_string'
    la $a0, slot_canceled_msg       # Load address of message
    syscall                         # Print message
    j cancel_reservation_end        # Exit function

no_reservations:
    # Print message for no reservations
    li $v0, 4                       # Load system call code for 'print_string'
    la $a0, no_reservations_msg     # Load address of message
    syscall                         # Print message
    j cancel_reservation_end        # Exit function

id_not_found_cancel:
    # Print message for ID not found
    li $v0, 4                       # Load system call code for 'print_string'
    la $a0, id_not_found_msg        # Load address of message
    syscall                         # Print message

cancel_reservation_end:
    # Function epilogue
    lw $ra, 0($sp)                  # Restore return address
    lw $s0, 4($sp)                  # Restore $s0
    lw $s1, 8($sp)		    # Restore $s1
    lw $s2, 12($sp)		    # Restore $s2
    addi $sp, $sp, 20               # Restore stack pointer
    j main_menu_loop           	    # Return

#...................................................................................................................#

# Function to view patient record
view_patient:
    # Function prologue
    addi $sp, $sp, -16          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0
    sw $s1, 8($sp)		# Save $s1
    
    # Load 'head' pointer
    move $s1, $a0		# Save 'head' pointer
    # Print prompt for ID
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, id_prompt           # Load address of prompt
    syscall                     # Print prompt

    # Read ID from user
    li $v0, 5                   # Load system call code for 'read_integer'
    syscall                     # Read integer from user
    move $t0, $v0               # Move ID to $t0

    # Call 'search_nde' function to find patient
    move $a0, $s1
    move $a1, $t0               # Move ID to $a1
    jal search_nde              # Call 'search_nde' function
    move $t1, $v0               # Move result to $t1
    
    # Check if patient with the given ID exists
    beqz $t1, id_not_found_view # Branch if patient with the given ID is not found

    # Print patient details
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, patient_info_msg    # Load address of message
    syscall                     # Print message
    li $v0, 1                   # Load system call code for 'print_integer'
    lw $a0, 4($t1)              # Move ID to $a0
    syscall                     # Print ID
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, age_msg             # Load address of message
    syscall                     # Print message
#    lw $a0, 0($t1)             # Load age from node
#    syscall                    # Print age
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, gender_msg          # Load address of message
    syscall                     # Print message
    lw $a0, 8($t1)              # Load gender from node
    beq $a0, 1, male_label      # Branch if gender is male
    la $a0, female_str          # Load address of female string
    j print_name                # Jump to print name
male_label:
    la $a0, male_str            # Load address of male string
print_name:
    syscall                     # Print gender
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, name_msg            # Load address of message
    syscall                     # Print message
    la $a0, 20($t1)             # Load address of name in node
    syscall                     # Print name
    j view_patient_end          # Exit function

id_not_found_view:
    # Print message for ID not found
    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, id_not_found_msg    # Load address of message
    syscall                     # Print message

view_patient_end:
    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)              # Restore $s0
    lw $s1, 8($sp)		# Restore $s1
    addi $sp, $sp, 16           # Restore stack pointer
    j main_user_mode            # Return

# Function to view reservations
view_reservations:

    # Function prologue
    addi $sp, $sp, -16          # Adjust stack pointer
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)		# Save $s0
    sw $s1, 8($sp)		# Save $s1
    
    # Load parameters
    move $s1, $a0		# Save 'r' pointer

    # Print reservations
    li $t0, 0                   # Initialize counter
    li $t3, 0			# Initialize counter

loop_1:
    bge $t0, 5, view_reservations_end   # Exit loop if counter >= 5
    
    mul $t2, $t0, 16
    add $s0, $s1, $t2

    lw $t1, 8($s0)   			# Load ID from r[i]
    beq $t1, -1, skip_reservation   	# Skip if ID is -1

    li $v0, 4                      # Load system call code for 'print_string'
    la $a0, reservation_info_msg   # Load address of message
    syscall                   	   # Print message

    lw $a0, 0($s0)   		# Load start time from r[i]
    li $v0, 1                   # Load system call code for 'print_integer'
    syscall                     # Print start time

    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, to_msg              # Load address of message
    syscall                     # Print message

    lw $a0, 4($s0)  		# Load finish time from r[i]
    li $v0, 1                   # Load system call code for 'print_integer'
    syscall                     # Print finish time

    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, reservation_to_msg  # Load address of message
    syscall                     # Print message

    lw $a0, 8($s0)      	# Load ID from r[i]
    li $v0, 1                   # Load system call code for 'print_integer'
    syscall                     # Print ID
    
    addi $t0, $t0, 1            # Increment counter

    j loop_1                    # Continue loop

skip_reservation:
    addi $t0, $t0, 1           # Increment counter
    addi $t3, $t3, 1           # Increment counter
    j loop_1                   # Continue loop

view_reservations_end:
    blt $t3, 5, end	      # Go to function epilogue

    li $v0, 4                   # Load system call code for 'print_string'
    la $a0, no_reservation_msg  # Load address of message
    syscall                     # Print message
end:
    # Function epilogue
    lw $ra, 0($sp)              # Restore return address
    lw $s0, 4($sp)		# Restore $s0
    lw $s1, 8($sp)		# Restore $s1
    addi $sp, $sp, 16           # Restore stack pointer
    
    jr $ra                      # Return

#.......................................................................................................#
