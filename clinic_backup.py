import json
import os

os.system('cls' if os.name == 'nt' else 'clear')

JSON_FILE = "clinic_data.json"

# Load existing data
patients = []
reservations = []

if os.path.exists(JSON_FILE):
    try:
        with open(JSON_FILE, "r", encoding="utf-8") as file:
            data = json.load(file)
            patients = data.get("patients", [])
            reservations = data.get("reserved_slots", [])
        print(f"Previous data loaded: {len(patients)} patients, {len(reservations)} appointments\n")
    except:
        print("Old file corrupted, starting fresh...\n")
else:
    print("No previous data found. Starting fresh...\n")

print("======================================")
print("   CLINIC FULL BACKUP TOOL (with Delete & Update)")
print("======================================")

while True:
    print("\n" + "=" * 60)
    print("Choose an action:")
    print("1. Add new patient")
    print("2. Update existing patient (by ID)")
    print("3. Delete patient (by ID)")
    print("4. Add new reserved appointment")
    print("5. Delete reserved appointment (by Ref)")
    print("6. View current data")
    print("7. Save and Exit")
    print("=" * 60)
    choice = input("Enter your choice (1-7): ").strip()

    if choice == "1":
        # Add patient
        print("\n--- Add New Patient ---")
        try:
            patient_id = int(input("Patient ID: "))
            if any(p["id"] == patient_id for p in patients):
                print("Error: Patient ID already exists!")
                continue
        except:
            print("Invalid ID!")
            continue

        name = input("Full Name: ").strip()
        age = input("Age: ").strip()
        gender_choice = input("Gender (1 = Male, 0 = Female): ").strip()
        gender = "Male" if gender_choice == "1" else "Female"
        disease = input("Disease/Diagnosis: ").strip()

        patients.append({
            "id": patient_id,
            "name": name,
            "age": age,
            "gender": gender,
            "disease": disease
        })
        print("Patient added successfully!\n")

    elif choice == "2":
        # Update patient
        print("\n--- Update Patient ---")
        try:
            pid = int(input("Enter Patient ID to update: "))
            patient = next((p for p in patients if p["id"] == pid), None)
            if not patient:
                print("Patient not found!")
                continue
        except:
            print("Invalid ID!")
            continue

        print(f"Current: {patient}")
        name = input(f"New Name (leave blank to keep '{patient['name']}'): ").strip()
        if name: patient["name"] = name
        age = input(f"New Age (leave blank to keep '{patient['age']}'): ").strip()
        if age: patient["age"] = age
        gender_choice = input(f"New Gender (1=Male, 0=Female) (leave blank to keep '{patient['gender']}'): ").strip()
        if gender_choice in ["1", "0"]:
            patient["gender"] = "Male" if gender_choice == "1" else "Female"
        disease = input(f"New Disease (leave blank to keep '{patient['disease']}'): ").strip()
        if disease: patient["disease"] = disease

        print("Patient updated successfully!\n")

    elif choice == "3":
        # Delete patient
        print("\n--- Delete Patient ---")
        try:
            pid = int(input("Enter Patient ID to delete: "))
            patient = next((p for p in patients if p["id"] == pid), None)
            if not patient:
                print("Patient not found!")
                continue
            patients.remove(patient)
            # Also remove any reservations for this patient
            reservations = [r for r in reservations if r["patient_id"] != pid]
            print("Patient and related appointments deleted!\n")
        except:
            print("Invalid ID!")

    elif choice == "4":
        # Add reservation
        print("\n--- Add Reserved Appointment ---")
        try:
            ref = int(input("Slot Reference Number (1-10): "))
            if ref < 1 or ref > 10:
                print("Invalid ref!")
                continue
            if any(r["ref"] == ref for r in reservations):
                print("Slot already reserved!")
                continue
        except:
            print("Invalid ref!")
            continue

        try:
            patient_id = int(input("Reserved by Patient ID: "))
            if not any(p["id"] == patient_id for p in patients):
                print("Patient ID not found!")
                continue
        except:
            print("Invalid Patient ID!")
            continue

        slot_type = input("Type (Physical or Online): ").strip()
        if slot_type not in ["Physical", "Online"]:
            print("Invalid type!")
            continue

        timings = [
            "9:00 AM to 10:00 AM", "10:00 AM to 11:00 AM", "11:00 AM to 12:00 PM",
            "12:00 PM to 1:00 PM", "1:00 PM to 2:00 PM", "2:00 PM to 3:00 PM",
            "3:00 PM to 4:00 PM", "4:00 PM to 5:00 PM", "5:00 PM to 6:00 PM",
            "6:00 PM to 7:00 PM"
        ]
        timing = timings[ref - 1]

        reservations.append({
            "ref": ref,
            "patient_id": patient_id,
            "type": slot_type,
            "timing": timing
        })
        print("Appointment reserved successfully!\n")

    elif choice == "5":
        # Delete reservation
        print("\n--- Delete Reserved Appointment ---")
        try:
            ref = int(input("Enter Slot Reference Number to cancel (1-10): "))
            reservation = next((r for r in reservations if r["ref"] == ref), None)
            if not reservation:
                print("Slot not reserved!")
                continue
            reservations.remove(reservation)
            print("Appointment cancelled!\n")
        except:
            print("Invalid ref!")

    elif choice == "6":
        # View current data
        print("\n=== CURRENT DATA ===")
        print(f"Patients ({len(patients)}):")
        for p in patients:
            print(f"  ID: {p['id']} | {p['name']} | Age: {p['age']} | {p['gender']} | Disease: {p['disease']}")
        print(f"\nReserved Slots ({len(reservations)}):")
        for r in reservations:
            print(f"  Ref {r['ref']}: {r['timing']} | {r['type']} | Patient ID: {r['patient_id']}")
        print()

    elif choice == "7":
        # Save and exit
        data = {
            "patients": patients,
            "reserved_slots": reservations
        }
        with open(JSON_FILE, "w", encoding="utf-8") as file:
            json.dump(data, file, indent=4)
        print("\nALL CHANGES SAVED PERMANENTLY!")
        print(f"Total: {len(patients)} patients, {len(reservations)} appointments")
        break

    else:
        print("Invalid choice! Try again.")

input("\nPress Enter to close...")