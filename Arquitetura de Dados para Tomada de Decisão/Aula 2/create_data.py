import numpy as np
from faker import Faker
import pandas as pd

fake = Faker()
currencies = ['BTC', 'USD', 'ARS', 'EUR', 'GBP', 'CHF']

# create users list
def create_users(total_users):

    users = {}

    for user_id in range(total_users):

        if np.random.random() > 0.5:
            first_name = fake.first_name_female()
            last_name = fake.last_name_female()
            gender = 'F'
        else:
            first_name = fake.first_name_male()
            last_name = fake.last_name_male()
            gender = 'M'
        
        users[user_id] = {
            'user_id': user_id,
            'first_name' : first_name,
            'last_name': last_name,
            'gender': gender,
            'country': fake.country_code(representation="alpha-2"),
            'currency': np.random.choice(currencies),
            'email': fake.email(),
            'birth_date': fake.date_of_birth(tzinfo=None, minimum_age=18, maximum_age=95)
        }

    print(len(users), 'users generated')
    print(users[0].keys())

    df_users = pd.DataFrame.from_dict(users, orient="index")
    df_users.to_csv("users.csv")

    print(len(users), 'users saves to csv')

    return users

# create transactions list
def create_transactions(total_transactions, users):

    transaction_types = ['LOAD', 'TRF', 'BUY', 'DC', 'WITHDRAW']
    total_users = len(users)

    transactions = {}

    for transaction_id in range(total_transactions):
    
        src_user = np.random.random_integers(total_users)
        dst_user = None
        
        currency = np.random.choice(currencies)
        transaction_type = np.random.choice(transaction_types)
        
        if transaction_type == 'BTC':
            amount = np.random.random() * 5000
        elif transaction_type == 'DC':
            amount = np.random.random() * 100
        elif transaction_type == 'WITHDRAW':
            amount = np.random.random() * 10000
        else:
            amount = np.random.random() * 10
            
        if transaction_type == 'TRF':
            dst_user = np.random.random_integers(total_users)
        
        transaction_date = fake.date_this_year(before_today=True, after_today=True)
        
        transactions[transaction_id] = {
            'src_user': src_user,
            'dst_user': dst_user if dst_user is not None else -1,
            'currency': currency,
            'amount': amount,
            'transaction_type': transaction_type,
            'transaction_date': transaction_date
        }

    print(len(transactions), 'transactions generated')
    print(transactions[0].keys())

    df_transactions = pd.DataFrame.from_dict(transactions, orient="index")
    df_transactions.to_csv("transactions.csv")

    print(len(transactions), 'transactions saved to csv')

# create data
users = create_users(1000)
create_transactions(100000, users)
