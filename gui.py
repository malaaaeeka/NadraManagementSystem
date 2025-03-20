import tkinter as tk
from tkinter import ttk, messagebox
import pymysql

# Database connection
def connect_to_database():
    try:
        connection = pymysql.connect(
            host="localhost",  # Replace with your MySQL host
            user="root",  # Replace with your MySQL username
            password="youyouyou",  # Replace with your MySQL password
            database="NadraManagementSystem"  # Ensure this matches your database name
        )
        return connection
    except pymysql.MySQLError as e:
        messagebox.showerror("Database Error", f"Error connecting to database: {e}")
        return None

# Fetch citizens from the database
def fetch_citizens():
    connection = connect_to_database()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM citizens")
            rows = cursor.fetchall()
            tree.delete(*tree.get_children())  # Clear existing data
            for row in rows:
                tree.insert("", tk.END, values=row)
        except pymysql.MySQLError as e:
            messagebox.showerror("Database Error", f"Error fetching data: {e}")
        finally:
            connection.close()

# Add a new citizen to the database
def add_citizen():
    # Get input values
    citizen_data = {
        "firstname": firstname_var.get(),
        "lastname": lastname_var.get(),
        "dob": dob_var.get(),
        "gender": gender_var.get(),
        "cnic": cnic_var.get(),
        "fathername": fathername_var.get(),
        "mothername": mothername_var.get(),
        "address": address_var.get(),
        "fingerprintdata": fingerprintdata_var.get(),
        "marital_status": marital_status_var.get(),
        "spouse_name": spouse_name_var.get(),
        "spouse_cnic": spouse_cnic_var.get(),
        "religion": religion_var.get(),
        "nationality": nationality_var.get()
    }

    # Validate required fields
    if not (citizen_data["firstname"] and citizen_data["lastname"] and citizen_data["cnic"] and citizen_data["dob"]):
        messagebox.showerror("Input Error", "First Name, Last name, CNIC, and DOB are required fields!")
        return

    connection = connect_to_database()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.execute("""
                INSERT INTO Citizens (firstname, lastname, dateOfBirth, gender, NicNumber, fathername, mothername, currentaddress, fingerprintdata, maritalstatus, spousename, spousenic, religion, nationality)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, tuple(citizen_data.values()))
            connection.commit()
            messagebox.showinfo("Success", "Citizen added successfully!")
            fetch_citizens()
            clear_form()
        except pymysql.MySQLError as e:
            messagebox.showerror("Database Error", f"Error adding citizen: {e}")
        finally:
            connection.close()

# Delete a selected citizen
def delete_citizen():
    selected_item = tree.selection()
    if not selected_item:
        messagebox.showerror("Selection Error", "Please select a citizen to delete.")
        return

    citizen_id = tree.item(selected_item)["values"][0]

    connection = connect_to_database()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.execute("SELECT COUNT(*) FROM citizens WHERE citizenid = %s", (citizen_id,))
            if cursor.fetchone()[0] == 0:
                messagebox.showerror("Deletion Error", "Citizen ID does not exist.")
                return
            
            # delete all records related to the citizen
            cursor.execute("DELETE FROM BirthRecords WHERE CitizenId = %s", (citizen_id,))
            cursor.execute("DELETE FROM DeathRecords WHERE CitizenId = %s", (citizen_id,))
            cursor.execute("DELETE FROM FamilyDetails WHERE CitizenId = %s", (citizen_id,))
            cursor.execute("DELETE FROM AddressRecords WHERE CitizenId = %s", (citizen_id,))
            cursor.execute("DELETE FROM MarriageRecords WHERE Spouse1Id = %s OR Spouse2Id = %s", (citizen_id, citizen_id))
            cursor.execute("DELETE FROM DivorceRecords WHERE Spouse1Id = %s OR Spouse2Id = %s", (citizen_id, citizen_id))
            cursor.execute("DELETE FROM EmploymentRecords WHERE CitizenId = %s", (citizen_id,))
             
             
             # delete the citizen
            cursor.execute("DELETE FROM citizens WHERE citizenid = %s", (citizen_id,))
            connection.commit()
            messagebox.showinfo("Success", "Citizen deleted successfully!")
            fetch_citizens()
        except pymysql.MySQLError as e:
            messagebox.showerror("Database Error", f"Error deleting citizen: {e}")
        finally:
            connection.close()

# Clear form fields
def clear_form():
    for var in form_vars:
        var.set("")

# GUI Application
root = tk.Tk()
root.title("NADRA Management System")
root.geometry("1200x700")
root.configure(bg="#ecf4ec")

# Title label
title_label = tk.Label(root, text="NADRA Management System", font=("Arial", 28, "bold"), bg="#ecf4ec", fg="#145A32", pady=10)
title_label.pack(fill=tk.X)

# Form frame
form_frame = tk.Frame(root, bg="#ecf4ec", padx=20, pady=20)
form_frame.pack(fill=tk.X)

# Form variables
form_vars = [
    tk.StringVar(), tk.StringVar(), tk.StringVar(), tk.StringVar(), tk.StringVar(),
    tk.StringVar(), tk.StringVar(), tk.StringVar(), tk.StringVar(), tk.StringVar(),
    tk.StringVar(), tk.StringVar(), tk.StringVar(), tk.StringVar()
]

firstname_var, lastname_var, dob_var, gender_var, cnic_var, fathername_var, mothername_var, address_var, fingerprintdata_var, marital_status_var, spouse_name_var, spouse_cnic_var, nationality_var, religion_var = form_vars

# Form layout
fields = [
    ("First Name", firstname_var), ("Last Name", lastname_var), ("DOB", dob_var),
    ("Gender", gender_var), ("CNIC", cnic_var), ("Father's Name", fathername_var),
    ("Mother's Name", mothername_var), ("Address", address_var), ("Finger Print Data", fingerprintdata_var),
    ("Marital Status", marital_status_var), ("Spouse Name", spouse_name_var), ("Spouse CNIC", spouse_cnic_var),
    ("Religion", religion_var), ("Nationality", nationality_var)
]

for idx, (label, var) in enumerate(fields):
    tk.Label(form_frame, text=label, font=("Arial", 12, "bold"), bg="#f0f4f7").grid(row=idx // 2, column=(idx % 2) * 2, sticky=tk.W, padx=10, pady=5)
    ttk.Entry(form_frame, textvariable=var, font=("Arial", 12), width=30).grid(row=idx // 2, column=(idx % 2) * 2 + 1, padx=10, pady=5)

# Button frame
button_frame = tk.Frame(root, bg="#f0f4f7")
button_frame.pack(pady=10)

buttons = [
    ("Add Citizen", add_citizen, "#196F3D"),
    ("Delete Citizen", delete_citizen, "#E74C3C"),
    ("Clear Form", clear_form, "#196F3D"),
    ("Load Citizens", fetch_citizens, "#196F3D")
]

for idx, (text, command, color) in enumerate(buttons):
    tk.Button(button_frame, text=text, command=command, bg=color, fg="white", font=("Arial", 12, "bold"), width=15).grid(row=0, column=idx, padx=10)

# Table frame
table_frame = tk.Frame(root, bg="#f0f4f7", pady=10)
table_frame.pack(fill=tk.BOTH, expand=True)

columns = ("ID", "First Name", "Last Name", "DOB", "Gender", "CNIC", "Father's Name", "Mother's Name", "Address", "Finger Print Data", "Marital Status", "Spouse Name", "Spouse CNIC", "Religion", "Nationality")
tree = ttk.Treeview(table_frame, columns=columns, show="headings", height=15)
tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

# Configure columns
for col in columns:
    tree.heading(col, text=col)
    tree.column(col, width=120, anchor=tk.W)

# Add scrollbars
scroll_y = ttk.Scrollbar(table_frame, orient=tk.VERTICAL, command=tree.yview)
scroll_x = ttk.Scrollbar(table_frame, orient=tk.HORIZONTAL, command=tree.xview)
tree.configure(yscroll=scroll_y.set, xscroll=scroll_x.set)
scroll_y.pack(side=tk.RIGHT, fill=tk.Y)
scroll_x.pack(side=tk.BOTTOM, fill=tk.X)

# Load citizens on startup
fetch_citizens()

root.mainloop()