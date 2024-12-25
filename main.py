import requests
from bs4 import BeautifulSoup
import mysql.connector
import uuid

db = mysql.connector.connect(
    host="localhost",
    user="root",  # Replace with your MySQL username
    password="144558",  # Replace with your MySQL password
    database="dbtest"  # Ensure this matches the database name you created
)

cursor = db.cursor()

brand_mapping = {
    'HP': 1,
    'Apple': 2,
    'Lenovo': 3,
    'Razor': 4
}


# Function to determine BrandID based on product name
def get_brand_id(product_name):
    for brand_name, brand_id in brand_mapping.items():
        if brand_name in product_name:
            return brand_id
    return 5  # Assign 5 for other brands


category_data = [
    (1, 'Laptops', 'Category for laptops'),
    (2, 'Desktops', 'Category for desktop computers'),
    (3, 'Tablets', 'Category for tablets'),
    (4, 'Monitors', 'Category for computer monitors'),
    (5, 'Accessories', 'Category for computer accessories')
]
# add brands
sql = "INSERT INTO brand (BrandID, BrandName) VALUES (%s, %s)"

# add categories
sql = "INSERT INTO category (CategoryID, CategoryName, CategoryDescription) VALUES (%s, %s, %s)"

try:
    # Insert multiple rows of data
    cursor.executemany(sql, category_data)

    # Commit the transaction
    db.commit()
    print(cursor.rowcount, "records inserted into category table")
except mysql.connector.Error as err:
    print("Error inserting data:", err)

# insert first user data
# sql = "INSERT INTO user (UserID, Address, Name, ContactNumber, Email) VALUES (%s, %s, %s, %s, %s)"
# values = ('376b1d20-0993-4209-9cff-8013f24cb375', '4314 Deercove Drive,Dallas,TXS', 'John Doe', '708-993-6076',
#           'johndo@yahoo.com')
# # Execute the SQL query
# cursor.execute(sql, values)
# # insert second user data
# sql = "INSERT INTO user (UserID, Address, Name, ContactNumber, Email) VALUES (%s, %s, %s, %s, %s)"
# values = ('047c9a62-21df-45f9-80db-4efd6dea110c', '4380 Reynolds Alley,Los Angeles,CA', 'Mary Bon', '323-620-1985',
#           'maryB12@gmail.com')
# cursor.execute(sql, values)
# # insert third user data
# sql = "INSERT INTO user (UserID, Address, Name, ContactNumber, Email) VALUES (%s, %s, %s, %s, %s)"
# values = ('35212f16-1121-488f-8cb1-66d61bfe8246', '2605 Rosebud Avenue,Holly Grove,AR', 'Helene Jonnes', '870-842-3646',
#           'joneshelena@gmail.com')
# cursor.execute(sql, values)

# insert admin data
# sql = "INSERT INTO admin (AdminID, AdminEmail) VALUES (%s, %s)"
# values = ('6746237', 'Antonio Moreno@gmail.com')
# cursor.execute(sql, values)


# Making a GET request
r = requests.get('https://www.laptopsdirect.co.uk/ct/laptops-and-netbooks/laptops?fts=laptops', verify=False)
w = requests.get('https://www.laptopsdirect.co.uk/ct/monitors-and-projectors/monitors', verify=False)
# check status code for response received
# success code - 200
print(r.status_code)
print(w.status_code)

soup = BeautifulSoup(r.content, 'html.parser')

soup1 = BeautifulSoup(w.content, 'html.parser')

results = soup.find_all('div', {'class': 'OfferBox'})
results1 = soup.find_all('div', {'class': 'OfferBox'})


brand_dict = {}
next_brand_id = 1
#for the first site
for product in results:
    ProductID = str(uuid.uuid4())
    ProductName = product.find('a', {'class': 'offerboxtitle'}).get_text().strip()
    ProductName = ' '.join(ProductName.split()[:3])
    Description = product.find('div', {'class': 'productInfo'}).get_text().strip().replace('\n', ', ')
    Price1 = product.find('span', {'class': 'offerprice'}).get_text().replace('$', '').replace(',', '').replace('£',
                                                                                                                '').strip()
    Price = float(Price1)
    StockQuantity = 100
    BrandID = get_brand_id(ProductName)

    CategoryID = 1

    sql = ("INSERT INTO product (ProductID, ProductName, Description, Price, StockQuantity, BrandID, CategoryID) "
           "VALUES (%s, %s, %s, %s, %s, %s, %s)")
    values = (ProductID, ProductName, Description, Price, StockQuantity, BrandID, CategoryID)

    # Execute the SQL query
    cursor.execute(sql, values)
#for the second site
for product1 in results1:
    ProductID1 = str(uuid.uuid4())
    ProductName1 = product1.find('a', {'class': 'offerboxtitle'}).get_text().strip()
    ProductName1 = ' '.join(ProductName1.split()[:3])
    Description1 = product1.find('div', {'class': 'productInfo'}).get_text().strip().replace('\n', ', ')
    Price11 = product1.find('span', {'class': 'offerprice'}).get_text().replace('$', '').replace(',', '').replace('£',
                                                                                                                '').strip()
    Price1 = float(Price11)
    StockQuantity1 = 50
    BrandID1 = get_brand_id(ProductName1)

    CategoryID1 = 4

    sql = ("INSERT INTO product (ProductID, ProductName, Description, Price, StockQuantity, BrandID, CategoryID) "
           "VALUES (%s, %s, %s, %s, %s, %s, %s)")
    values = (ProductID1, ProductName1, Description1, Price11, StockQuantity1, BrandID1, CategoryID1)

    # Execute the SQL query
    cursor.execute(sql, values)
# Commit the transaction
db.commit()


# Close the connection
cursor.close()
db.close()
