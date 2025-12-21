.data
    .align 2
node_size: .word 124             # Size of Patient Record Node (4*4 + 52 + 52)
head: .word 0                    # Head pointer of Linked List
no_of_nodes: .word 0             # Current count of registered patients
name_input_buf: .space 53        # Buffer for name input (Max 52 chars + null)
disease_input_buf: .space 53     # Buffer for disease input (Max 52 chars + null)

presc_fever:      .asciiz "Paracetamol 500mg - 3 times a day for 3 days. Plenty of fluids and rest.\n"
presc_cough:      .asciiz "Cough syrup (e.g., Benadryl) - 10ml thrice daily. Steam inhalation recommended.\n"
presc_headache:   .asciiz "Ibuprofen 400mg as needed. Avoid triggers and stay hydrated.\n"
presc_flu:        .asciiz "Rest, fluids, Paracetamol for fever/pain. Antiviral if prescribed.\n"
presc_default:    .asciiz "General Advice: Consult doctor for proper medication. Take rest and monitor symptoms.\n"

cmp_fever:        .asciiz "fever\n"
cmp_cough:        .asciiz "cough\n"
cmp_headache:     .asciiz "headache\n"
cmp_flu:          .asciiz "flu\n"

prescription_header: .asciiz "\n--- SUGGESTED PRESCRIPTION ---\n"
 
    .align 2
reservation_struct_size: .word 20 # 5 words * 4 bytes = 20 bytes
reservations:
    .align 2
    # Reservation Structure (5 words, 20 bytes):
    # Word 0 (0): Time Start (Hour)
    # Word 1 (4): Time End (Hour)
    # Word 2 (8): Patient ID (-1 for Free)
    # Word 3 (12): Ref Number (1-10)
    # Word 4 (16): Type (0=Physical, 1=Online)

    # Physical Slots (Type 0) - Ref 1 to 5
    .word 9, 10, -1, 1, 0    # Ref 1: 9:00 to 10:00, Type: Physical
    .word 10, 11, -1, 2, 0   # Ref 2: 10:00 to 11:00, Type: Physical
    .word 11, 12, -1, 3, 0   # Ref 3: 11:00 to 12:00, Type: Physical
    .word 12, 13, -1, 4, 0   # Ref 4: 12:00 to 13:00, Type: Physical
    .word 13, 14, -1, 5, 0   # Ref 5: 13:00 to 14:00, Type: Physical

    # Online Slots (Type 1) - Ref 6 to 10
    .word 14, 15, -1, 6, 1   # Ref 6: 14:00 to 15:00, Type: Online
    .word 15, 16, -1, 7, 1   # Ref 7: 15:00 to 16:00, Type: Online
    .word 16, 17, -1, 8, 1   # Ref 8: 16:00 to 17:00, Type: Online
    .word 17, 18, -1, 9, 1   # Ref 9: 17:00 to 18:00, Type: Online
    .word 18, 19, -1, 10, 1  # Ref 10: 18:00 to 19:00, Type: Online

    .align 2
auth_options: .asciiz "--- ACCESS AUTHENTICATION ---\nPress (0) for Administration Mode\nPress (1) for Patient/User Inquiry\nPress (2) for Pharmacy Mode\nPress (3) to Exit System\nSelection: "
password_prompt: .asciiz "Please enter security code: "
admin_menu_options: .asciiz "\n--- ADMINISTRATION MENU ---\n1: Register New Patient\n2: Modify Patient Record\n3: Book Appointment Slot\n4: Cancel Reservation\n5: Delete Patient Record\n6: Return to Access Menu\n7: View Patient Record (Admin View)\nSelection: "
user_menu_options: .asciiz "\n--- PATIENT/USER INQUIRY ---\n1: View Patient Record (Search by ID)\n2: View Appointment Slot Availability\n3: Return to Access Menu\nSelection: "
pharmacy_menu_options: .asciiz "\n--- PHARMACY MANAGEMENT MENU ---\n1: Search Patient Diagnosis & Prescribe\n2: Enter All Patient Diagnoses\n3: Return to Access Menu\nSelection: "

add_patient_msg: .asciiz "--- Initiating New Patient Registration ---\n"
edit_patient_msg: .asciiz "--- Initiating Patient Record Modification ---\n"
reserve_slot_msg: .asciiz "--- Initiating Appointment Booking ---\n"
cancel_reservation_msg: .asciiz "--- Initiating Reservation Cancellation ---\n"
pharmacy_search_msg: .asciiz "--- Initiating Patient Search for Prescribing ---\n"
pharmacy_all_msg: .asciiz "--- Viewing All Patient Diagnoses ---\n"

    .align 2
data_not_found_msg: .asciiz "Error: Record not found in the database.\n"
id_prompt: .asciiz "Please enter Patient ID (Positive Integer Required): "
age_prompt: .asciiz "Please enter patient age (1-120): "
gender_prompt: .asciiz "Please enter gender (1 for Male, 0 for Female): "
name_prompt: .asciiz "Please enter patient's full name (Max 50 characters): "
disease_prompt: .asciiz "Please enter initial Disease/Diagnosis (Max 50 characters): "
gender_error: .asciiz "Error: Invalid selection/input. Please try again.\n"
id_used_msg: .asciiz "Error: Patient ID is already registered.\n"
id_not_found_msg: .asciiz "Error: Patient ID not located in the system database.\n"
no_patients_msg: .asciiz "Alert: No patients are currently registered in the system.\n"
wrong_pass_msg: .asciiz "Error: Incorrect security code. Attempts remaining: "
patient_deleted_msg: .asciiz "Success: Patient record successfully deleted from the system.\n"
delete_prompt_msg: .asciiz "\n>>> DELETE PATIENT RECORD <<<\n"

    .align 2
edit_id_prompt: .asciiz "Enter the ID of the patient record to modify: "
edit_menu: .asciiz "\n--- RECORD MODIFICATION MENU ---\n1: Update ID\n2: Update Age\n3: Update Gender\n4: Update Name\n5: Update Disease/Diagnosis\n6: Save Changes and Return\nSelection: "
new_id_prompt: .asciiz "Please enter the new Patient ID: "
new_age_prompt: .asciiz "Please enter the new age: "
new_gender_prompt: .asciiz "Please enter the new gender (1/0): "
new_name_prompt: .asciiz "Please enter the new full name: "
new_disease_prompt: .asciiz "Please enter the new Disease/Diagnosis (Max 50 characters): "
edit_id_not_found: .asciiz "Error: Target ID not found! Modification aborted.\n"

    .align 2
reservation_type_prompt: .asciiz "\n--- APPOINTMENT TYPE SELECTION ---\n1: Physical (In-Office)\n2: Online (Tele-Consultation)\nSelection: "
invalid_type_error: .asciiz "Error: Invalid selection. Please choose 1 or 2.\n"
available_slots_msg: .asciiz "\n--- APPOINTMENT SLOT AVAILABILITY ---\n"
type_physical_msg: .asciiz "Type: Physical"
type_online_msg: .asciiz "Type: Online"
to_msg: .asciiz " to "
time_separator: .asciiz ":"
zero_minute: .asciiz "00"
time_ampm_pm: .asciiz " PM"
time_ampm_am: .asciiz " AM"

reservation_num_msg: .asciiz " | Slot Ref #: "
res_num_prompt: .asciiz "Please enter Appointment Slot Reference Number (Physical: 1-5 = 9AM-2PM, Online: 6-10 = 2PM-7PM): "
slot_reserved_msg: .asciiz "Success: Appointment slot confirmed and booked successfully.\n"
res_num_out_of_range_msg: .asciiz "Error: Invalid slot number, slot is already booked, or does not match type.\n"
newline_msg: .asciiz "\n"
slot_canceled_msg: .asciiz "Success: Appointment slot successfully canceled and released.\n"
no_reservations_msg: .asciiz "Alert: This patient currently has no active appointments scheduled.\n"
patient_already_reserved: .asciiz "Error: Patient already holds an active reservation. Please cancel first.\n"
res_not_found_msg: .asciiz "Error: No reservation found for this patient ID.\n"
no_reservation_msg: .asciiz "Reservation not found. Please try again.\n"

    .align 2
patient_info_msg: .asciiz "\n--- PATIENT RECORD DETAILS ---\nID: "
age_msg: .asciiz "\nAge: "
gender_msg: .asciiz "\nGender: "
name_msg: .asciiz "\nName: "
disease_msg: .asciiz "\nDisease/Diagnosis: "
male_str: .asciiz "Male"
female_str: .asciiz "Female"
reservation_info_msg: .asciiz "Slot Time: "
reservation_to_msg: .asciiz " - Reserved by Patient ID: "
pharmacy_prescribe_msg: .asciiz "Patient ID: "
pharmacy_end_msg: .asciiz "Diagnosis Confirmed: "

patient_added_msg: .asciiz "Success: New patient registered successfully!\n"
malloc_error_msg: .asciiz "Error: Memory allocation failed. System is full.\n"
patient_updated_msg: .asciiz "Success: Patient record updated successfully!\n"

    .align 2
sys_mode: .word 0
sys_password: .word 1234
wrong_pass_count: .word 0
auth_max_tries: .word 3
temp_node_ptr: .word 0
temp_id: .word 0
input_buffer: .space 12
max_slots: .word 10

.text
.globl main

main:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    la $s0, head            # $s0 = &head
    la $s1, reservations    # $s1 = &reservations

main_auth_input:
    li $v0, 4
    la $a0, auth_options
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    beq $t0, 0, main_admin_auth
    nop
    beq $t0, 1, main_user_mode
    nop
    beq $t0, 2, main_pharmacy_mode
    nop
    beq $t0, 3, main_exit_program
    nop
    j main_auth_input
    nop

main_admin_auth:
    sw $zero, wrong_pass_count
    lw $t1, auth_max_tries
main_password_loop:
    li $v0, 4
    la $a0, password_prompt
    syscall
    li $v0, 5
    syscall
    move $t2, $v0
    lw $t3, sys_password
    beq $t2, $t3, main_admin_menu
    nop
    
    lw $t4, wrong_pass_count
    addi $t4, $t4, 1
    sw $t4, wrong_pass_count
    
    li $v0, 4
    la $a0, wrong_pass_msg
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, newline_msg
    syscall
    
    addi $t1, $t1, -1
    bgtz $t1, main_password_loop
    nop
    j main_exit_program
    nop

main_admin_menu:
main_menu_loop:
    li $v0, 4
    la $a0, admin_menu_options
    syscall
    li $v0, 5
    syscall
    move $t4, $v0

    beq $t4, 1, call_add_patient
    nop
    beq $t4, 2, call_edit_patient
    nop
    beq $t4, 3, call_reserve_slot
    nop
    beq $t4, 4, call_cancel_reservation
    nop
    beq $t4, 5, call_delete_patient
    nop
    beq $t4, 6, main_auth_input          # Ab 6 = Return to Access Menu
    nop
    beq $t4, 7, call_view_patient_admin  # Ab 7 = View Patient Record
    nop

    # Invalid option ke liye message (optional lekin good)
    li $v0, 4
    la $a0, gender_error                 # ya koi "Invalid selection" message
    syscall
    j main_menu_loop
    nop

call_add_patient:
    li $v0, 4
    la $a0, add_patient_msg
    syscall
    move $a0, $s0         # &head
    la $a1, name_input_buf
    la $a2, disease_input_buf
    jal add_patient
    nop
    j main_menu_loop
    nop

call_edit_patient:
    li $v0, 4
    la $a0, edit_patient_msg
    syscall
    move $a0, $s0         # &head
    la $a1, name_input_buf
    la $a2, disease_input_buf
    jal edit_patient
    nop
    j main_menu_loop
    nop

call_reserve_slot:
    li $v0, 4
    la $a0, reserve_slot_msg
    syscall
    move $a0, $s1         # reservations_array
    move $a1, $s0         # &head
    jal reserve
    nop
    j main_menu_loop
    nop

call_cancel_reservation:
    li $v0, 4
    la $a0, cancel_reservation_msg
    syscall
    move $a0, $s1         # reservations_array
    move $a1, $s0         # &head
    jal cancel_reservation
    nop
    j main_menu_loop
    nop

call_delete_patient:
    li $v0, 4
    la $a0, delete_prompt_msg
    syscall
delete_input_loop:
    li $v0, 4
    la $a0, id_prompt
    syscall
    li $v0, 5
    syscall
    move $a1, $v0        # A1 = ID to delete
    
    blez $a1, delete_invalid
    nop
    move $a0, $s0        # A0 = &head
    move $a2, $s1        # A2 = reservations_array
    jal delete_node
    nop
    j main_menu_loop
    nop
delete_invalid:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j delete_input_loop
    nop

call_view_patient_admin:
    move $a0, $s0
    jal view_patient
    nop
    j main_menu_loop
    nop

main_user_mode:
main_user_menu_loop:
    li $v0, 4
    la $a0, user_menu_options
    syscall
    li $v0, 5
    syscall
    move $t4, $v0
    beq $t4, 1, call_view_patient
    nop
    beq $t4, 2, call_view_reservations
    nop
    beq $t4, 3, main_auth_input
    nop
    j main_user_menu_loop
    nop

call_view_patient:
    move $a0, $s0
    jal view_patient
    nop
    j main_user_menu_loop
    nop

call_view_reservations:
    move $a0, $s1
    jal view_reservations
    nop
    j main_user_menu_loop
    nop

# =====================================================================
# NEW MODULE: PHARMACY MANAGEMENT MODE
# =====================================================================
main_pharmacy_mode:
main_pharmacy_menu_loop:
    li $v0, 4
    la $a0, pharmacy_menu_options
    syscall
    li $v0, 5
    syscall
    move $t4, $v0
    beq $t4, 1, call_pharmacy_search
    nop
    beq $t4, 2, call_pharmacy_view_all
    nop
    beq $t4, 3, main_auth_input
    nop
    j main_pharmacy_menu_loop
    nop

call_pharmacy_search:
    li $v0, 4
    la $a0, pharmacy_search_msg
    syscall
    move $a0, $s0 # &head
    jal pharmacy_view_diagnosis
    nop
    j main_pharmacy_menu_loop
    nop

call_pharmacy_view_all:
    li $v0, 4
    la $a0, pharmacy_all_msg
    syscall
    move $a0, $s0 # &head
    jal pharmacy_view_all_diagnosis
    nop
    j main_pharmacy_menu_loop
    nop
# =====================================================================

main_exit_program:
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    li $v0, 10
    syscall

# ---------------------------------------------------------------------
# HELPER FUNCTION: print_time
# A0 = Hour (e.g., 9, 14, 18)
# Prints: "HH:00 AM/PM" (e.g., "09:00 AM", "02:00 PM")
# ---------------------------------------------------------------------
print_time:
    # Input: $a0 = hour in 24-hour format (9 to 19)
    # Output: Prints time like "9:00 AM", "1:00 PM", etc.

    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)           # Save original hour (for AM/PM decision)

    # Convert to 12-hour format
    li $t0, 12
    ble $a0, $t0, check_midnight_or_noon
    nop
    subi $a0, $a0, 12       # 13→1, 14→2, ..., 19→7
    j print_the_hour
    nop

check_midnight_or_noon:
    beq $a0, 0, set_to_12
    nop
    beq $a0, 12, print_the_hour   # 12 stays 12
    nop
    j print_the_hour
    nop

set_to_12:
    li $a0, 12

print_the_hour:
    # Print the hour number
    li $v0, 1
    syscall

    # Print ":00"
    li $v0, 4
    la $a0, time_separator   # ":"
    syscall
    la $a0, zero_minute      # "00"
    syscall

    # Decide AM or PM based on original hour
    lw $t1, 0($sp)           # Original hour
    li $t2, 12
    blt $t1, $t2, print_am
    nop
    beq $t1, $t2, print_am   # 12:00 is AM (noon is PM, but we have no 12 PM start)
    nop

print_pm:
    la $a0, time_ampm_pm
    j print_am_pm_done
    nop

print_am:
    la $a0, time_ampm_am

print_am_pm_done:
    li $v0, 4
    syscall

    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
    nop

pt_exit:
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    jr $ra
    nop

# ---------------------------------------------------------------------
# NODE UTILITIES (search_node, create_node, append_node, delete_node)
# ---------------------------------------------------------------------
search_node:
    # A0 = &head
    # A1 = ID (key)
    # V0 = Node pointer or 0 (NULL)
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    move $s0, $a0
    lw $s1, 0($a0) # Load head pointer
    beqz $s1, snf
    nop
sl: 
    lw $t0, 4($s1) # Load 'id' (offset 4)
    beq $t0, $a1, sf
    nop
    lw $s1, 16($s1) # Load 'next' pointer (offset 16)
    bnez $s1, sl
    nop
snf:
    li $v0, 0
    j se
    nop
sf: 
    move $v0, $s1
se: 
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    jr $ra
    nop

create_node:
    # A0 = Age (important: isko mat overwrite karna!)
    # A1 = ID
    # A2 = Gender
    # A3 = Name Buffer Address
    # Stack pe pushed: Disease Buffer Address (5th arg)

    addi $sp, $sp, -32          # Extra space for safety
    sw $ra, 28($sp)
    sw $s0, 24($sp)             # New Node Ptr
    sw $s1, 20($sp)             # Source Ptr (Name)
    sw $s2, 16($sp)             # Dest Ptr (Name)
    sw $s3, 12($sp)             # Source Ptr (Disease)
    sw $s4, 8($sp)              # Dest Ptr (Disease)
    sw $a0, 4($sp)              # Save original age here (important!)

    # === Load 5th arg (disease buffer) from stack ===
    lw $t0, 32($sp)             # Stack pe 5th arg 32 bytes down (addi $sp,-32 ke baad)

    # === Save name buffer safely ===
    move $s1, $a3               # $s1 = name source (original $a3)

    # === Disease source ===
    move $s3, $t0               # $s3 = disease source (5th arg)

    # Malloc node
    lw $a0, node_size           # Load size into $a0 (age abhi safe hai $sp+4 pe)
    li $v0, 9
    syscall
    move $s0, $v0
    beqz $s0, cfail
    nop

    # Restore original age from stack
    lw $a0, 4($sp)              # Age wapas load karo

    # Store fields
    sw $a0, 0($s0)              # Age (sahi value!)
    sw $a1, 4($s0)              # ID
    sw $a2, 8($s0)              # Gender
    li $t0, -1
    sw $t0, 12($s0)             # res_slot = -1
    sw $zero, 16($s0)           # next = NULL

    # Copy name
    addi $s2, $s0, 20           # dest = name field
    li $t9, 52
cn:
    lb $t0, 0($s1)
    sb $t0, 0($s2)
    beqz $t0, cnd_name
    nop
    addi $t9, $t9, -1
    beqz $t9, cnd_name
    nop
    addi $s1, $s1, 1
    addi $s2, $s2, 1
    j cn
    nop
cnd_name:

    # Copy disease (ab sahi source se!)
    addi $s4, $s0, 72           # dest = disease field
    li $t9, 52
cd:
    lb $t0, 0($s3)
    sb $t0, 0($s4)
    beqz $t0, cnd_disease
    nop
    addi $t9, $t9, -1
    beqz $t9, cnd_disease
    nop
    addi $s3, $s3, 1
    addi $s4, $s4, 1
    j cd
    nop
cnd_disease:

    move $v0, $s0
    j cexit
    nop

cfail:
    li $v0, 0

cexit:
    lw $ra, 28($sp)
    lw $s0, 24($sp)
    lw $s1, 20($sp)
    lw $s2, 16($sp)
    lw $s3, 12($sp)
    lw $s4, 8($sp)
    addi $sp, $sp, 32           # Match addi -32
    jr $ra
    nop

append_node:
    # A0 = Node pointer (new node)
    # A1 = &head (head pointer address)
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s0, 12($sp)
    sw $s1, 8($sp)
    sw $s2, 4($sp)
    move $s1, $a1 # $s1 = &head
    move $s2, $a0 # $s2 = new node address
    
    sw $zero, 16($s2) # Ensure new node next is NULL
    lw $s0, 0($s1) # $s0 = head pointer
    
    beqz $s0, ael # If list is empty
    nop
at: 
    lw $t0, 16($s0) # Load next pointer
    beqz $t0, afl # If next is NULL, found last node
    nop
    move $s0, $t0 # Move to next node
    j at
    nop
afl:
    sw $s2, 16($s0) # Append new node
    j ad
    nop
ael:
    sw $s2, 0($s1) # Set new node as head
ad:
    # Increment no_of_nodes
    la $t0, no_of_nodes
    lw $t1, 0($t0)
    addi $t1, $t1, 1
    sw $t1, 0($t0)
    
    lw $ra, 16($sp)
    lw $s0, 12($sp)
    lw $s1, 8($sp)
    lw $s2, 4($sp)
    addi $sp, $sp, 20
    jr $ra
    nop

delete_node:
    # A0 = &head
    # A1 = ID (key)
    # A2 = reservations_array
    # V0 = 1 (Success) or 0 (Failure)
    addi $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s0, 24($sp) # Current Node
    sw $s1, 20($sp) # Previous Node
    sw $s2, 16($sp) # &head
    sw $s3, 12($sp) # ID
    sw $s4, 8($sp)  # reservations_array
    
    move $s2, $a0
    move $s3, $a1
    move $s4, $a2
    lw $s0, 0($s2) # Current Node = Head
    li $s1, 0      # Previous Node = NULL
    
    beqz $s0, dnf
    nop
dl: 
    lw $t0, 4($s0) # Load current node ID
    beq $t0, $s3, df # Found the node
    nop
    move $s1, $s0 # Set previous to current
    lw $s0, 16($s0) # Move to next node
    bnez $s0, dl
    nop
dnf:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    li $v0, 0
    j de
    nop
df:
    # --- Check and Cancel Reservation ---
    lw $t0, 12($s0) # Load reservation slot number (Ref Num, 1-10)
    li $t1, -1
    beq $t0, $t1, nsc # If reservation slot is -1, no slot to cancel
    nop
    
    addi $t0, $t0, -1 # Convert Slot Ref (1-10) to Index (0-9)
    # Calculate Index * 20 bytes
    sll $t2, $t0, 2 # Index * 4
    sll $t3, $t0, 4 # Index * 16
    add $t0, $t2, $t3 # Index * 20
    
    add $t1, $s4, $t0 # $t1 = Address of reservation slot
    
    li $t9, -1
    sw $t9, 8($t1) # Clear the reservation ID in the slot struct (Offset 8)
    li $t9, -1
    sw $t9, 12($s0) # Clear reservation slot in Patient Node (Offset 12)
    
    li $v0, 4
    la $a0, slot_canceled_msg
    syscall
nsc:
    # --- Delete Node from List ---
    beqz $s1, dhn # If Previous Node is NULL, deleting Head Node
    nop
    lw $t0, 16($s0) # Next of current node
    sw $t0, 16($s1) # Previous node's next = Current node's next
    j du
    nop
dhn:
    lw $t0, 16($s0) # Next of head node
    sw $t0, 0($s2) # &head = Next of head
du:
    # Decrement no_of_nodes
    la $t0, no_of_nodes
    lw $t1, 0($t0)
    addi $t1, $t1, -1
    sw $t1, 0($t0)
    
    # Print success message
    li $v0, 4
    la $a0, patient_deleted_msg
    syscall
    li $v0, 1
    
de:
    lw $ra, 28($sp)
    lw $s0, 24($sp)
    lw $s1, 20($sp)
    lw $s2, 16($sp)
    lw $s3, 12($sp)
    lw $s4, 8($sp)
    addi $sp, $sp, 32
    jr $ra
    nop

# ---------------------------------------------------------------------
# ARRAY SEARCH UTILITIES (Reservation Search)
# ---------------------------------------------------------------------
array_search_rn:
    # A0 = reservations_array
    # A1 = Reservation Ref Number (1-10)
    # V0 = Array Index (0-9) or -1 (Not Found)
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    move $s0, $a0
    move $s1, $a1
    li $t0, 0 # Counter i (Index)
    lw $t1, max_slots # Max Reservations (10)
search_rn_loop:
    bge $t0, $t1, rn_not_found
    nop
    
    # Calculate Index * 20 bytes
    sll $t2, $t0, 2 # Index * 4
    sll $t3, $t0, 4 # Index * 16
    add $t2, $t2, $t3 # Index * 20
    
    add $t3, $s0, $t2 # Address of current slot
    lw $t4, 12($t3) # Load Reservation Ref Number (Offset 12)
    beq $t4, $s1, rn_found
    nop
    addi $t0, $t0, 1
    j search_rn_loop
    nop
rn_not_found:
    li $v0, -1
    j rn_exit
    nop
rn_found:
    move $v0, $t0
rn_exit:
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    jr $ra
    nop

array_search_id:
    # A0 = reservations_array
    # A1 = Patient ID
    # V0 = Array Index (0-9) or -1 (Not Found)
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    move $s0, $a0
    move $s1, $a1
    li $t0, 0
    lw $t1, max_slots # Max Reservations (10)
search_id_loop:
    bge $t0, $t1, id_not_found
    nop
    
    # Calculate Index * 20 bytes
    sll $t2, $t0, 2 # Index * 4
    sll $t3, $t0, 4 # Index * 16
    add $t2, $t2, $t3 # Index * 20
    
    add $t3, $s0, $t2
    lw $t4, 8($t3) # Load Patient ID (Offset 8)
    beq $t4, $s1, id_found
    nop
    addi $t0, $t0, 1
    j search_id_loop
    nop
id_not_found:
    li $v0, -1
    j id_exit
    nop
id_found:
    move $v0, $t0
id_exit:
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    jr $ra
    nop

# ---------------------------------------------------------------------
# CORE MODULES (add_patient, edit_patient, reserve, cancel_reservation, view_patient)
# ---------------------------------------------------------------------
add_patient:
    # A0 = &head
    # A1 = name_input_buf
    # A2 = disease_input_buf
    addi $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s0, 24($sp) # &head
    sw $s1, 20($sp) # Age
    sw $s2, 16($sp) # Gender
    sw $s3, 12($sp) # ID
    sw $s4, 8($sp)  # name_input_buf
    sw $s5, 4($sp)  # disease_input_buf

    move $s0, $a0
    move $s4, $a1
    move $s5, $a2

# Get ID
get_id_loop:
    li $v0, 4
    la $a0, id_prompt
    syscall
    li $v0, 5
    syscall
    move $s3, $v0
    blez $s3, get_id_loop  # Retry if ID <= 0

    move $a0, $s0
    move $a1, $s3
    jal search_node
    move $s6, $v0
    bnez $s6, get_id_loop # Retry if ID exists

# Get Age
get_age_loop:
    li $v0, 4
    la $a0, age_prompt
    syscall
    li $v0, 5
    syscall
    move $s1, $v0
    blt $s1, 1, get_age_loop
    bgt $s1, 120, get_age_loop

# Get Gender
get_gender_loop:
    li $v0, 4
    la $a0, gender_prompt
    syscall
    li $v0, 5
    syscall
    move $s2, $v0
    blt $s2, 0, get_gender_loop
    bgt $s2, 1, get_gender_loop

# Get Name
    li $v0, 4
    la $a0, name_prompt
    syscall
    move $a0, $s4
    li $v0, 8
    li $a1, 52
    syscall

# Get Disease
    li $v0, 4
    la $a0, disease_prompt
    syscall
    move $a0, $s5
    li $v0, 8
    li $a1, 52
    syscall

# Create Node
move $a0, $s1   # patient ID
move $a1, $s3   # patient name
move $a2, $s2   # age
move $a3, $s4   # gender

# Push 5th argument onto stack
addi $sp, $sp, -4
sw $s5, 0($sp)   # disease buffer

jal create_node
nop
addi $sp, $sp, 4    # Pop the disease buffer argument we pushed

 

move $s6, $v0
beqz $s6, add_patient_fail

# Append Node
    move $a0, $s6
    move $a1, $s0
    jal append_node

    li $v0, 4
    la $a0, patient_added_msg
    syscall

    j add_patient_end
add_patient_fail:
    li $v0, 4
    la $a0, malloc_error_msg
    syscall

add_patient_end:
    lw $ra, 28($sp)
    lw $s0, 24($sp)
    lw $s1, 20($sp)
    lw $s2, 16($sp)
    lw $s3, 12($sp)
    lw $s4, 8($sp)
    lw $s5, 4($sp)
    addi $sp, $sp, 32
    jr $ra
    nop
edit_patient:
    # A0 = &head
    # A1 = name_input_buf
    # A2 = disease_input_buf
    addi $sp, $sp, -36
    sw $ra, 32($sp)
    sw $s0, 28($sp) # &head
    sw $s1, 24($sp) # name_input_buf
    sw $s2, 20($sp) # disease_input_buf
    sw $s3, 16($sp) # Node pointer to edit
    sw $s4, 12($sp) # Menu choice
    sw $s5, 8($sp)  # New data value
    sw $s6, 4($sp)  # ID to edit
    
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2 # Load disease buffer address
edit_find_id_loop:
    li $v0, 4
    la $a0, edit_id_prompt
    syscall
    li $v0, 5
    syscall
    move $s6, $v0
    
    blez $s6, edit_invalid_id
    nop
    
    move $a0, $s0
    move $a1, $s6
    jal search_node
    nop
    move $s3, $v0
    
    bnez $s3, edit_found
    nop
    
    li $v0, 4
    la $a0, edit_id_not_found
    syscall
    j edit_find_id_loop
    nop
edit_invalid_id:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j edit_find_id_loop
    nop
edit_found:
edit_menu_loop:
    li $v0, 4
    la $a0, edit_menu
    syscall
    li $v0, 5
    syscall
    move $s4, $v0
    
    beq $s4, 1, edit_id_option
    nop
    beq $s4, 2, edit_age_option
    nop
    beq $s4, 3, edit_gender_option
    nop
    beq $s4, 4, edit_name_option
    nop
    beq $s4, 5, edit_disease_option
    nop
    beq $s4, 6, edit_save_exit
    nop
    j edit_menu_loop
    nop

edit_id_option:
    li $v0, 4
    la $a0, new_id_prompt
    syscall
    li $v0, 5
    syscall
    move $s5, $v0
    
    blez $s5, invalid_new_id
    nop
    
    move $a0, $s0
    move $a1, $s5
    jal search_node
    nop
    
    beqz $v0, id_available
    nop
    
    # If the found node is the same node being edited, it's also available
    beq $v0, $s3, id_available
    nop
    
    li $v0, 4
    la $a0, id_used_msg
    syscall
    j edit_menu_loop
    nop
id_available:
    sw $s5, 4($s3) # Store new ID (Offset 4)
    move $s6, $s5 # Update ID being edited
    j edit_menu_loop
    nop
invalid_new_id:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j edit_menu_loop
    nop
edit_age_option:
    li $v0, 4
    la $a0, new_age_prompt
    syscall
    li $v0, 5
    syscall
    move $s5, $v0
    
    li $t0, 1
    blt $s5, $t0, invalid_age_edit
    li $t0, 120
    bgt $s5, $t0, invalid_age_edit
    nop
    
    sw $s5, 0($s3) # Store new age (Offset 0)
    j edit_menu_loop
    nop
invalid_age_edit:
    li $v0, 4
    la $a0, gender_error
    syscall
    j edit_menu_loop
    nop
edit_gender_option:
    li $v0, 4
    la $a0, new_gender_prompt
    syscall
edit_gender_input:
    li $v0, 5
    syscall
    move $s5, $v0
    
    beq $s5, $zero, gender_valid_edit
    nop
    li $t0, 1
    beq $s5, $t0, gender_valid_edit
    nop
    
    li $v0, 4
    la $a0, gender_error
    syscall
    j edit_gender_input
    nop
gender_valid_edit:
    sw $s5, 8($s3) # Store new gender (Offset 8)
    j edit_menu_loop
    nop
edit_name_option:
    li $v0, 4
    la $a0, new_name_prompt
    syscall
    
    li $v0, 8
    move $a0, $s1 # Use name_input_buf
    li $a1, 53
    syscall
    
    move $t8, $s3
    addi $t8, $t8, 20 # $t8 = Destination pointer (Node address + 20)
    move $t9, $s1 # $t9 = Source pointer (Buffer address)
copy_name_safe:
    lb $t0, 0($t9)
    sb $t0, 0($t8)
    
    beqz $t0, copy_done_name # Copy stops on null terminator
    nop
    
    addi $t8, $t8, 1
    addi $t9, $t9, 1
    j copy_name_safe
    nop
copy_done_name:
    j edit_menu_loop
    nop

edit_disease_option:
    li $v0, 4
    la $a0, new_disease_prompt
    syscall
    
    li $v0, 8
    move $a0, $s2 # Use disease_input_buf
    li $a1, 53
    syscall
    
    move $t8, $s3
    addi $t8, $t8, 72 # $t8 = Destination pointer (Node address + 72)
    move $t9, $s2 # $t9 = Source pointer (Buffer address)
copy_disease_safe:
    lb $t0, 0($t9)
    sb $t0, 0($t8)
    
    beqz $t0, copy_done_disease # Copy stops on null terminator
    nop
    
    addi $t8, $t8, 1
    addi $t9, $t9, 1
    j copy_disease_safe
    nop
copy_done_disease:
    j edit_menu_loop
    nop

edit_save_exit:
    li $v0, 4
    la $a0, patient_updated_msg
    syscall
edit_patient_exit:
    lw $ra, 32($sp)
    lw $s0, 28($sp)
    lw $s1, 24($sp)
    lw $s2, 20($sp)
    lw $s3, 16($sp)
    lw $s4, 12($sp)
    lw $s5, 8($sp)
    lw $s6, 4($sp)
    addi $sp, $sp, 36
    jr $ra
    nop

reserve:
    # A0 = reservations_array
    # A1 = &head
    addi $sp, $sp, -40
    sw $ra, 36($sp)
    sw $s0, 32($sp) # reservations_array
    sw $s1, 28($sp) # &head
    sw $s2, 24($sp) # Patient ID
    sw $s3, 20($sp) # Patient Node
    sw $s4, 16($sp) # Slot Ref Num
    sw $s5, 12($sp) # Slot Index
    sw $s6, 8($sp)  # Slot Type selection (0=Physical, 1=Online)
    
    move $s0, $a0
    move $s1, $a1

    # --- 1. Get Appointment Type ---
get_type_loop:
    li $v0, 4
    la $a0, reservation_type_prompt
    syscall
    li $v0, 5
    syscall
    move $s6, $v0
    
    li $t0, 1
    li $t1, 2
    bge $s6, $t0, check_type_max
    nop
    j invalid_type_selection
check_type_max:
    ble $s6, $t1, type_ok
    nop
invalid_type_selection:
    li $v0, 4
    la $a0, invalid_type_error
    syscall
    j get_type_loop
    nop
type_ok:
    addi $s6, $s6, -1 # Convert (1=Physical, 2=Online) to (0=Physical, 1=Online)

    # --- 2. Print Available Slots of Selected Type (Simplified in this function) ---
    # NOTE: The view_reservations function is available for full view.
    
    # --- 3. Get Patient ID and Node ---
get_patient_id:
    li $v0, 4
    la $a0, id_prompt
    syscall
    li $v0, 5
    syscall
    move $s2, $v0
    
    blez $s2, invalid_patient_id
    nop
    
    move $a0, $s1
    move $a1, $s2
    jal search_node
    nop
    move $s3, $v0
    
    beqz $s3, id_search_failed
    nop
    
    # Check if patient already has a reservation
    lw $t0, 12($s3)
    li $t1, -1
    bne $t0, $t1, patient_has_res
    nop
    
    j get_ref_num
    nop
    
patient_has_res:
    li $v0, 4
    la $a0, patient_already_reserved
    syscall
    j reserve_exit
    nop
    
id_search_failed:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j get_patient_id
    nop
    
invalid_patient_id:
    li $v0, 4
    la $a0, gender_error
    syscall
    j get_patient_id
    nop
    
get_ref_num:
    # --- 4. Get Slot Reference Number ---
    li $v0, 4
    la $a0, res_num_prompt
    syscall
    li $v0, 5
    syscall
    move $s4, $v0 # Slot Ref Num (1-10)
    
    # Check Ref Num range
    li $t0, 1
    li $t1, 10
    blt $s4, $t0, invalid_res_num
    nop
    bgt $s4, $t1, invalid_res_num
    nop
    
    # Calculate Index: Ref Num - 1
    addi $s5, $s4, -1
    
    # Calculate Slot Address
    move $a0, $s0
    move $a1, $s4
    jal array_search_rn # V0 returns the Index
    nop
    
    move $s5, $v0
    li $t9, -1
    beq $s5, $t9, invalid_res_num
    nop # Should not happen since ref numbers are fixed, but safer.
    
    # Calculate Index * 20 bytes
    sll $t2, $s5, 2 # Index * 4
    sll $t3, $s5, 4 # Index * 16
    add $t1, $t2, $t3 # Index * 20
    
    add $t2, $s0, $t1 # Address of current slot
    
    # Check if slot is available (ID = -1)
    lw $t3, 8($t2) # Slot Patient ID (Offset 8)
    li $t4, -1
    bne $t3, $t4, invalid_res_num
    nop
    
    # Check if slot type matches user selection ($s6)
    lw $t5, 16($t2) # Slot Type (Offset 16)
    bne $t5, $s6, invalid_res_num
    nop
    
    # --- 5. Update Record and Array ---
    sw $s2, 8($t2) # Update Reservation Array with Patient ID
    sw $s4, 12($s3) # Update Patient Node with Slot Ref Num (Offset 12)
    
    li $v0, 4
    la $a0, slot_reserved_msg
    syscall
    j reserve_exit
    nop
    
invalid_res_num:
    li $v0, 4
    la $a0, res_num_out_of_range_msg
    syscall
    j get_ref_num
    nop

reserve_exit:
    lw $ra, 36($sp)
    lw $s0, 32($sp)
    lw $s1, 28($sp)
    lw $s2, 24($sp)
    lw $s3, 20($sp)
    lw $s4, 16($sp)
    lw $s5, 12($sp)
    lw $s6, 8($sp)
    addi $sp, $sp, 40
    jr $ra
    nop

cancel_reservation:
    # A0 = reservations_array
    # A1 = &head
    addi $sp, $sp, -28
    sw $ra, 24($sp)
    sw $s0, 20($sp) # reservations_array
    sw $s1, 16($sp) # &head
    sw $s2, 12($sp) # Patient ID
    sw $s3, 8($sp)  # Patient Node
    sw $s4, 4($sp)  # Reservation Index
    
    move $s0, $a0
    move $s1, $a1

get_cancel_id:
    li $v0, 4
    la $a0, id_prompt
    syscall
    li $v0, 5
    syscall
    move $s2, $v0
    
    blez $s2, invalid_cancel_id
    nop
    
    move $a0, $s1
    move $a1, $s2
    jal search_node
    nop
    move $s3, $v0
    
    beqz $s3, id_not_found_cancel
    nop
    
    # Check if patient actually has a reservation
    lw $t0, 12($s3) # Node's Res Slot Ref Num
    li $t1, -1
    beq $t0, $t1, no_res_to_cancel
    nop
    
    # Find reservation slot in array by patient ID
    move $a0, $s0
    move $a1, $s2
    jal array_search_id
    nop
    move $s4, $v0 # Index of reservation slot
    
    li $t9, -1
    beq $s4, $t9, no_res_found_in_array # Should be impossible if node has ref, but safe
    nop

    # Calculate Slot Address
    move $t0, $s4 # Index
    sll $t2, $t0, 2 # Index * 4
    sll $t3, $t0, 4 # Index * 16
    add $t1, $t2, $t3 # Index * 20
    add $t2, $s0, $t1 # Address of reservation slot
    
    # Clear reservation: Array and Node
    li $t9, -1
    sw $t9, 8($t2)  # Clear Patient ID in Reservation Array (Offset 8)
    li $t9, -1
    sw $t9, 12($s3) # Clear Slot Ref Num in Patient Node (Offset 12)
    
    li $v0, 4
    la $a0, slot_canceled_msg
    syscall
    j cancel_exit
    nop
    
invalid_cancel_id:
    li $v0, 4
    la $a0, gender_error
    syscall
    j get_cancel_id
    nop
    
id_not_found_cancel:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j cancel_exit
    nop
    
no_res_to_cancel:
    li $v0, 4
    la $a0, no_reservations_msg
    syscall
    j cancel_exit
    nop

no_res_found_in_array:
    li $v0, 4
    la $a0, res_not_found_msg
    syscall
    j cancel_exit
    nop
    
cancel_exit:
    lw $ra, 24($sp)
    lw $s0, 20($sp)
    lw $s1, 16($sp)
    lw $s2, 12($sp)
    lw $s3, 8($sp)
    lw $s4, 4($sp)
    addi $sp, $sp, 28
    jr $ra
    nop

view_patient:
    # A0 = &head
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp) # &head
    sw $s1, 4($sp) # Patient Node
    
    move $s0, $a0
view_id_prompt:
    li $v0, 4
    la $a0, id_prompt
    syscall
    li $v0, 5
    syscall
    move $a1, $v0 # ID to search
    
    blez $a1, view_invalid_id
    nop
    
    move $a0, $s0
    jal search_node
    nop
    move $s1, $v0 # Patient Node
    
    beqz $s1, view_id_not_found
    nop
    
    # Print Patient Details
    li $v0, 4
    la $a0, patient_info_msg
    syscall
    
    lw $a0, 4($s1) # ID
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, age_msg
    syscall
    lw $a0, 0($s1) # Age
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, gender_msg
    syscall
    lw $t0, 8($s1) # Gender (0 or 1)
    beqz $t0, print_female
    nop
    li $v0, 4
    la $a0, male_str
    syscall
    j print_name
print_female:
    li $v0, 4
    la $a0, female_str
    syscall
    
print_name:
    li $v0, 4
    la $a0, name_msg
    syscall
    addi $a0, $s1, 20 # Name (Offset 20)
    li $v0, 4
    syscall
    
    li $v0, 4
    la $a0, disease_msg
    syscall
    addi $a0, $s1, 72 # Disease (Offset 72)
    li $v0, 4
    syscall
    
    li $v0, 4
    la $a0, newline_msg
    syscall
    j view_exit
    nop
    
view_invalid_id:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j view_id_prompt
    nop
    
view_id_not_found:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j view_exit
    nop
    
view_exit:
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    jr $ra
    nop

view_reservations:
    # A0 = reservations_array
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp) # reservations_array
    sw $s1, 4($sp) # Flag: found at least one reservation
    
    move $s0, $a0
    li $s1, 0 # Flag = 0
    li $v0, 4
    la $a0, available_slots_msg
    syscall
    
    li $t0, 0 # Counter i (Index)
    lw $t1, max_slots # Max Reservations (10)
view_res_loop:
    bge $t0, $t1, view_res_done
    nop
    
    # Calculate Slot Address
    sll $t2, $t0, 2 # Index * 4
    sll $t3, $t0, 4 # Index * 16
    add $t4, $t2, $t3 # Index * 20
    add $t5, $s0, $t4 # Address of current slot
    
    # Load Slot Patient ID and Type
    lw $t6, 8($t5)  # Patient ID (Offset 8)
    lw $t7, 16($t5) # Type (Offset 16)
    
    # Print Type
    li $v0, 4
    beqz $t7, view_type_physical
    nop
    la $a0, type_online_msg
    syscall
    j view_print_ref
view_type_physical:
    la $a0, type_physical_msg
    syscall
    
view_print_ref:
    li $v0, 4
    la $a0, reservation_num_msg
    syscall
    lw $a0, 12($t5) # Slot Ref Num
    li $v0, 1
    syscall
    
    # Print Time Start
    li $v0, 4
    la $a0, reservation_info_msg
    syscall
    lw $a0, 0($t5)
    jal print_time
    nop
    
    # Print Time End
    li $v0, 4
    la $a0, to_msg
    syscall
    lw $a0, 4($t5)
    jal print_time
    nop

    # Print Status
    li $t8, -1
    bne $t6, $t8, view_res_reserved
    nop
    
    li $v0, 4
    la $a0, newline_msg # Free Slot
    syscall
    j view_res_continue
    
view_res_reserved:
    li $s1, 1 # Found at least one reservation
    li $v0, 4
    la $a0, reservation_to_msg
    syscall
    li $v0, 1
    move $a0, $t6 # Print Reserved Patient ID
    syscall
    li $v0, 4
    la $a0, newline_msg
    syscall
    
view_res_continue:
    addi $t0, $t0, 1
    j view_res_loop
    nop
    
view_res_done:
    li $v0, 4
    la $a0, newline_msg
    syscall
    j view_res_exit
    nop

view_res_exit:
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    jr $ra
    nop

# ---------------------------------------------------------------------
# PHARMACY MODULES
# ---------------------------------------------------------------------
# Simple case-sensitive contains check
# A0 = haystack (disease string), T0 = needle (e.g. "fever")
# Returns V0 = 1 if found, 0 if not
# strcmp: A0 = str1, A1 = str2
# Returns V0 = 0 if equal, else 1
strcmp:
strcmp_loop:
    lb $t1, 0($a0)
    lb $t2, 0($a1)
    bne $t1, $t2, strcmp_not_equal
    nop
    beqz $t1, strcmp_equal      # both end
    nop
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    j strcmp_loop
strcmp_not_equal:
    li $v0, 1
    jr $ra
strcmp_equal:
    li $v0, 0
    jr $ra
    nop
string_contains:
    move $t1, $a0          # haystack ptr
    move $t2, $t0          # needle ptr
    lb $t3, 0($t2)         # first char of needle
    beqz $t3, sc_found     # empty needle = found

sc_loop:
    lb $t4, 0($t1)
    beqz $t4, sc_not_found # end of haystack
    bne $t4, $t3, sc_next
    nop
    move $a0, $t1
    move $a1, $t2
    jal strcmp_simple
    nop
    beqz $v0, sc_found

sc_next:
    addi $t1, $t1, 1
    j sc_loop
sc_not_found:
    li $v0, 0
    jr $ra
sc_found:
    li $v0, 1
    jr $ra

strcmp_simple:
    lb $t5, 0($a0)
    lb $t6, 0($a1)
    bne $t5, $t6, ss_diff
    nop
    beqz $t5, ss_equal
    nop
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    j strcmp_simple
ss_diff:
    li $v0, 1
    jr $ra
ss_equal:
    li $v0, 0
    jr $ra
pharmacy_view_diagnosis:
    addi $sp, $sp, -20          # Extra space for safety
    sw $ra, 16($sp)
    sw $s0, 12($sp)              # &head
    sw $s1, 8($sp)               # Patient Node
    sw $s2, 4($sp)               # Disease address save

    move $s0, $a0

pharmacy_id_prompt:
    li $v0, 4
    la $a0, id_prompt
    syscall
    li $v0, 5
    syscall
    move $a1, $v0

    blez $a1, pharmacy_invalid_id
    nop

    move $a0, $s0
    jal search_node
    nop
    move $s1, $v0               # $s1 = patient node

    beqz $s1, pharmacy_id_not_found
    nop
   
    # Print header (assume aapne pharmacy_prescribe_msg use kiya hai pehle)
    li $v0, 4
    la $a0, pharmacy_prescribe_msg
    syscall
    lw $a0, 4($s1)              # Patient ID
    li $v0, 1
    syscall
     li $v0, 4
    la $a0,newline_msg
    syscall
    li $v0, 4
    la $a0,pharmacy_end_msg
    syscall

    # Print actual disease
    addi $a0, $s1, 72
    li $v0, 4
    syscall

      # After printing disease string
    li $v0, 4
     la $a0,prescription_header
       syscall

    li $v0, 4
    la $a0, newline_msg
    syscall

    # Load disease address
    addi $a1, $s1, 72           # $a1 = disease string (for comparison)

    # Check fever
    la $a0, cmp_fever
    jal strcmp
    nop
    beqz $v0, print_fever_presc

    # Check cough
    la $a0, cmp_cough
    jal strcmp
    nop
    beqz $v0, print_cough_presc

    # Check headache
    la $a0, cmp_headache
    jal strcmp
    nop
    beqz $v0, print_headache_presc

    # Check flu
    la $a0, cmp_flu
    jal strcmp
    nop
    beqz $v0, print_flu_presc

    # Default prescription
    li $v0, 4
    la $a0, presc_default
    syscall
    j presc_done

print_fever_presc:
    li $v0, 4
    la $a0, presc_fever
    syscall
    j presc_done

print_cough_presc:
    li $v0, 4
    la $a0, presc_cough
    syscall
    j presc_done

print_headache_presc:
    li $v0, 4
    la $a0, presc_headache
    syscall
    j presc_done

print_flu_presc:
    li $v0, 4
    la $a0, presc_flu
    syscall
    j presc_done

presc_done:
  #  li $v0, 4
   # la $a0, newline_msg
    #syscall
    j pharmacy_search_exit
    nop


pharmacy_invalid_id:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j pharmacy_id_prompt

pharmacy_id_not_found:
    li $v0, 4
    la $a0, id_not_found_msg
    syscall
    j pharmacy_search_exit

pharmacy_search_exit:
    lw $ra, 16($sp)
    lw $s0, 12($sp)
    lw $s1, 8($sp)
    lw $s2, 4($sp)
    addi $sp, $sp, 20
    jr $ra
    nop
pharmacy_view_all_diagnosis:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)     # Current node
    sw $s1, 4($sp)     # &head

    move $s1, $a0
    lw $s0, 0($s1)     # $s0 = head

    beqz $s0, pva_no_patients
    nop

pva_loop:
    beqz $s0, pva_exit

    li $v0, 4
    la $a0, patient_info_msg
    syscall

    lw $a0, 4($s0)     # ID
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, name_msg
    syscall
    addi $a0, $s0, 20  # Name
    li $v0, 4
    syscall

    li $v0, 4
    la $a0, disease_msg
    syscall
    addi $a0, $s0, 72  # Disease
    li $v0, 4
    syscall

    li $v0, 4
    la $a0, newline_msg
    syscall

    lw $s0, 16($s0)     # next node
    j pva_loop
    nop

pva_no_patients:
    li $v0, 4
    la $a0, no_patients_msg
    syscall

pva_exit:
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 16
    jr $ra
    nop
